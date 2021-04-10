invoker_tornado_custom = class({})
LinkLuaModifier("modifier_invoker_tornado_custom_displacement", "abilities/heroes/invoker/invoker_extra/modifier_invoker_tornado_custom_displacement", LUA_MODIFIER_MOTION_BOTH)

function invoker_tornado_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_TORNADO end
function invoker_tornado_custom:GetPlaybackRateOverride()	    return 1.3 end
function invoker_tornado_custom:GetCastPointSpeed() 			return 100 end

function invoker_tornado_custom:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = CustomAbilities:GetCursorPosition(self)
    local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)
    local final_point = ClampPosition(origin, point, projectile_distance, projectile_distance)
	local damage = self:GetSpecialValueFor("ability_damage")
    local damage_table = {
        damage = damage,
        damage_type = DAMAGE_TYPE_PURE,
    }

	local projectile_direction = Direction2D(origin, point)
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	CustomEntities:ProjectileAttack(caster, {
		bTriggerCounters = false,
		tProjectile = {
			EffectName =			"particles/econ/items/invoker/invoker_ti6/invoker_tornado_ti6.vpcf",
			vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = 			projectile_distance,
			fStartRadius =			self:GetSpecialValueFor("hitbox"),
			Source = 				caster,
			vVelocity = 			projectile_direction * projectile_speed,
			UnitBehavior = 			PROJECTILES_NOTHING,
			WallBehavior = 			PROJECTILES_NOTHING,
			TreeBehavior = 			PROJECTILES_NOTHING,
			GroundBehavior = 		PROJECTILES_NOTHING,
			bIsReflectable =        false,
			bIsDestructible =		false,
			fGroundOffset = 		0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				damage_table.victim = unit
				damage_table.attacker = _self.Source
				ApplyDamage(damage_table)
				EmitSoundOn("Hero_Invoker.Tornado.Target", unit)
				local distance = (final_point - unit:GetAbsOrigin()):Length2D()
				unit:AddNewModifier(
					_self.Source, -- player source
					self, -- ability source
					"modifier_invoker_tornado_custom_displacement", -- modifier name
					{
						x = projectile_direction.x,
						y = projectile_direction.y,
						r = 1,
						speed = 1/1.0,
						peak = 350,
					}
				)
			end,
			OnFinish = function(_self, pos)
				EFX("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", PATTACH_WORLDORIGIN, nil, {
					cp0 = pos,
					release = true
				})
				StopSoundOn("Hero_Invoker.Tornado", self:GetCaster())
			end,
		}
	})

	self:PlayEffectsOnCast()
end

function invoker_tornado_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_ABSORIGIN, caster, {
		cp0 = pos,
		cp1 = pos,
		cp2 = pos,
		release = true,
	})
end

function invoker_tornado_custom:PlayEffectsOnCast()
	EmitSoundOn("Hero_Invoker.Tornado", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_tornado_custom)