storm_special_attack = class({})
storm_special_attack_recast = class({})
LinkLuaModifier("modifier_storm_special_attack_recast", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_storm_special_attack_displacement", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_special_attack_thinker", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_thinker", LUA_MODIFIER_MOTION_BOTH)

function storm_special_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function storm_special_attack:GetPlaybackRateOverride() 	    return 1.5 end
function storm_special_attack:GetCastPointSpeed() 			return 10 end
function storm_special_attack:GetAnimationTranslate() 		return "overload" end

function storm_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/storm/storm_special_attack.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
        Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		draw = true,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}
			ApplyDamage(damage_table)

			if _self.Source == caster then
                caster:GiveManaPercent(mana_gain_pct, unit)
				
				if unit:IsAlive() then
					CreateModifierThinker(
						caster, --hCaster
						self, --hAbility
						"modifier_storm_special_attack_thinker", --modifierName
						{ duration = 5.0 },
						unit:GetAbsOrigin(), --vOrigin
						caster:GetTeamNumber(), --nTeamNumber
						false --bPhantomBlocker
					)
					
					--caster:FindAbilityByName("storm_special_attack_recast"):SetTargetIndex(unit:GetEntityIndex())
					--caster:AddNewModifier(caster, self, "modifier_storm_special_attack_recast", { duration = 2.5 })
				end
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    local projectile = Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function storm_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)
	
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function storm_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
end



function storm_special_attack_recast:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function storm_special_attack_recast:GetPlaybackRateOverride() 	    return 1.5 end
function storm_special_attack_recast:GetCastPointSpeed() 			return 50 end
function storm_special_attack_recast:GetAnimationTranslate() 		return "overload" end

function storm_special_attack_recast:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
    local target_entity = EntIndexToHScript(self.target_index)
	local direction = (point - target_entity:GetAbsOrigin()):Normalized()
	local distance = (point - target_entity:GetAbsOrigin()):Length2D()

    target_entity:AddNewModifier(caster, self, 'modifier_storm_special_attack_displacement', {
        x = direction.x,
        y = direction.y,
        originX = point.x,
        originY = point.y,
        r = distance,
        speed = distance/1.0,
        peak = 1,
    })

    EmitSoundOn('Hero_StormSpirit.ElectricVortexCast', caster)
end

function storm_special_attack_recast:SetTargetIndex(target_index)
    self.target_index = target_index
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_special_attack)
Abilities.Castpoint(storm_special_attack_recast)