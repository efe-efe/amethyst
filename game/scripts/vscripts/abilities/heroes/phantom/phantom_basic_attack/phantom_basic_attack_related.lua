
phantom_basic_attack_related = class({})
LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)

function phantom_basic_attack_related:GetCastPointOverride()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function phantom_basic_attack_related:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function phantom_basic_attack_related:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end
function phantom_basic_attack_related:GetPlaybackRateOverride() 	return 2.0 end
function phantom_basic_attack_related:GetCastPointSpeed() 			return 80 end
function phantom_basic_attack_related:GetFadeGestureOnCast()		return false end

function phantom_basic_attack_related:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local ability = caster:FindAbilityByName("phantom_extra")
	local damage = ability:GetSpecialValueFor("ability_damage")
	
	local fading_slow_pct = ability:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = ability:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance =	self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage(damage_table)

			if _self.Source == caster then
				caster:GiveManaPercent(mana_gain_pct, unit)
					
				if _self.Source == caster and not unit:IsObstacle() then 
					caster:AddNewModifier(
						caster, -- player source
						self, -- ability source
						"modifier_phantom_strike_stack", -- modifier name
						{} -- kv
					)
				end
			end

			unit:AddNewModifier(
				caster,
				self,
				"modifier_generic_fading_slow", -- modifier name
				{ duration = fading_slow_duration, max_slow_pct = fading_slow_pct } -- kv
			)

			if _self.Source.OnBasicAttackImpact then
				_self.Source:OnBasicAttackImpact(unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end


function phantom_basic_attack_related:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_PhantomAssassin.Dagger.Target", self:GetCaster())

	local particle_cast = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_basic_attack_related:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_basic_attack_related)