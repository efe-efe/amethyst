invoker_basic_attack = class({})

function invoker_basic_attack:GetCastPoint()
	if IsServer() then
		return self.BaseClass.GetCastPoint(self) + self:GetCaster():GetAttackAnimationPoint()
	end
end

function invoker_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function invoker_basic_attack:GetCastAnimationCustom()	    return ACT_DOTA_ATTACK end
function invoker_basic_attack:GetPlaybackRateOverride() 		return 1.5 end
function invoker_basic_attack:GetCastPointSpeed() 		    return 10 end

function invoker_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local damage = caster:GetAverageTrueAttackDamage(caster)

	local projectile = {
		EffectName = "particles/invoker/invoker_basic_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage(damage_table)

			if _self.Source == caster then
				if CustomEntities:ProvidesMana(unit) then
					CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end
			end

			CustomEntities:OnBasicAttackImpact(_self.Source, unit)				
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function invoker_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Invoker.Attack", self:GetCaster())
end

function invoker_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_Invoker.ProjectileImpact", caster)

	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_basic_attack)