invoker_blast_custom = class({})
LinkLuaModifier("modifier_invoker_blast_custom_displacement", "abilities/heroes/invoker/invoker_extra/modifier_invoker_blast_custom_displacement", LUA_MODIFIER_MOTION_BOTH)

function invoker_blast_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_DEAFENING_BLAST end
function invoker_blast_custom:GetPlaybackRateOverride()	    return 1.0 end
function invoker_blast_custom:GetCastPointSpeed() 			return 20 end

function invoker_blast_custom:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)
    local final_point = ClampPosition(origin, point, projectile_distance, projectile_distance)
	local damage = self:GetSpecialValueFor("ability_damage")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName =			"particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6.vpcf",
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
		fGroundOffset = 		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
			}

            local distance = (final_point - unit:GetAbsOrigin()):Length2D()
			unit:AddNewModifier(
				_self.Source, -- player source
				self, -- ability source
				"modifier_invoker_blast_custom_displacement", -- modifier name
				{
					x = projectile_direction.x,
					y = projectile_direction.y,
					r = distance,
					speed = projectile_speed,
					peak = 0,
				}
			)

			ApplyDamage(damage_table)
		end,
		OnFinish = function(_self, pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function invoker_blast_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_ABSORIGIN, caster, {
		cp0 = pos,
		cp1 = pos,
		cp2 = pos,
		release = true,
	})
end

function invoker_blast_custom:PlayEffectsOnCast()
	EmitSoundOn("Hero_Invoker.DeafeningBlast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_blast_custom)