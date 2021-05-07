vengeful_basic_attack = class({})
LinkLuaModifier("modifier_vengeful_basic_attack", "abilities/heroes/vengeful/vengeful_basic_attack/modifier_vengeful_basic_attack", LUA_MODIFIER_MOTION_NONE)

function vengeful_basic_attack:GetCastPoint()
	if IsServer() then
		return self.BaseClass.GetCastPoint(self) + self:GetCaster():GetAttackAnimationPoint()
	end
end

function vengeful_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function vengeful_basic_attack:GetCastAnimationCustom()	    return ACT_DOTA_ATTACK end
function vengeful_basic_attack:GetPlaybackRateOverride()    return 1.5 end
function vengeful_basic_attack:GetCastPointSpeed() 		    return 10 end

function vengeful_basic_attack:OnSpellStart()
	local caster = self:GetCaster()

	local stacks = CustomEntitiesLegacy:SafeGetModifierStacks(caster, "modifier_vengeful_basic_attack")
	if stacks < 3 then
		self:ThrowProjectile()
	else
		local vengeful_second_attack = caster:FindAbilityByName("vengeful_second_attack")
		vengeful_second_attack:ThrowProjectile(true)
		CustomEntitiesLegacy:SafeDestroyModifier(caster, "modifier_vengeful_basic_attack")
	end

end

function vengeful_basic_attack:ThrowProjectile()
	local caster = self:GetCaster()
	local point = CustomAbilities:GetCursorPosition(self)
    local origin = caster:GetOrigin()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	CustomEntitiesLegacy:ProjectileAttack(caster, {
		bIsBasicAttack = true,
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_basic_attack.vpcf",
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
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
					hTarget = unit,
					hAbility = self,
				})

				if _self.Source == caster and not CustomEntitiesLegacy:IsObstacle(unit) then
					if CustomEntitiesLegacy:ProvidesMana(unit) then
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
					caster:AddNewModifier(caster, self, "modifier_vengeful_basic_attack", {})
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	self:PlayEffectsOnCast()
end

function vengeful_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
end

function vengeful_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)

	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_basic_attack)

