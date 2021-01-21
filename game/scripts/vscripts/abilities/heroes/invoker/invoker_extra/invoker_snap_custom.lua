invoker_snap_custom = class({})
LinkLuaModifier("modifier_invoker_snap_custom", "abilities/heroes/invoker/invoker_extra/modifier_invoker_snap_custom", LUA_MODIFIER_MOTION_BOTH)

function invoker_snap_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_GHOST_WALK end
function invoker_snap_custom:GetPlaybackRateOverride()	    return 1.5 end
function invoker_snap_custom:GetCastPointSpeed() 			return 20 end

function invoker_snap_custom:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)
    local final_point = ClampPosition(origin, point, projectile_distance, projectile_distance)
	local damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName =			"particles/orchid/orchid_proj.vpcf",
		vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
		fDistance = 			projectile_distance,
		fStartRadius =			self:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
        GroundBehavior = 		PROJECTILES_NOTHING,
        bIsReflectable =        false,
		fGroundOffset = 		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
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
				"modifier_invoker_snap_custom", -- modifier name
				{ duration = duration }
			)

			ApplyDamage(damage_table)
		end,
		OnFinish = function(_self, pos)
			EFX("particles/units/heroes/hero_invoker_kid/invoker_kid_forged_spirit_projectile_end.vpcf", PATTACH_WORLDORIGIN, nil, {
				cp0 = pos,
				cp3 = pos, 
				release = true
			})
		end,
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function invoker_snap_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_ABSORIGIN, caster, {
		cp0 = pos,
		cp1 = pos,
		cp2 = pos,
		release = true,
	})
end

function invoker_snap_custom:PlayEffectsOnCast()
	EmitSoundOn("Hero_Invoker.Attack", self:GetCaster())
	EmitSoundOn("Hero_Invoker.ColdSnap.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_snap_custom)