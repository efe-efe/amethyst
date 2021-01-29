invoker_meteor_custom = class({})
LinkLuaModifier("modifier_invoker_meteor_custom_thinker", "abilities/heroes/invoker/invoker_extra/modifier_invoker_meteor_custom_thinker", LUA_MODIFIER_MOTION_NONE)

function invoker_meteor_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_CHAOS_METEOR end
function invoker_meteor_custom:GetPlaybackRateOverride()	    return 0.3 end
function invoker_meteor_custom:GetCastPointSpeed() 			return 0 end

function invoker_meteor_custom:OnAbilityPhaseStart()
	self.efx = ParticleManager:CreateParticle('particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.efx, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, 'attach_hitloc', self:GetCaster():GetAbsOrigin(), false)

	return true
end

function invoker_meteor_custom:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function invoker_meteor_custom:OnSpellStart()
	if self.efx then
		DEFX(self.efx, false)
	end
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local point = self:GetCursorPosition()
    local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)
    local final_point = ClampPosition(origin, point, projectile_distance, projectile_distance)
	local damage = self:GetSpecialValueFor("ability_damage")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    
    local counter = 0

	local projectile = {
		EffectName =			"particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
		vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 0),
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
            local distance = (final_point - unit:GetAbsOrigin()):Length2D()
			ApplyDamage(damage_table)
        end,
        OnIntervalThink = function(_self, pos)
            counter = counter + 1
            if counter == 5 then
                CreateModifierThinker(
                    caster, -- player source
                    self, -- ability source
                    "modifier_invoker_meteor_custom_thinker", -- modifier name
                    { duration = 3.0 }, -- kv
                    pos,
                    caster:GetTeamNumber(),
                    false --bPhantomBlocker
                )
                counter = 0
            end
		end,
        OnFinish = function(_self, pos)
            EFX("particles/units/heroes/hero_invoker/invoker_chaos_meteor_crumble.vpcf", PATTACH_WORLDORIGIN, nil, {
                cp0 = pos,
                cp3 = pos + Vector(0, 0, 32),
                release = true
            })
            EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", caster)
            StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", caster)
		end,
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function invoker_meteor_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_ABSORIGIN, caster, {
		cp0 = pos,
		cp1 = pos,
		cp2 = pos,
		release = true,
	})
end

function invoker_meteor_custom:PlayEffectsOnCast()
	EmitSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetCaster())
	EmitSoundOn("Hero_Invoker.ChaosMeteor.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_meteor_custom)
