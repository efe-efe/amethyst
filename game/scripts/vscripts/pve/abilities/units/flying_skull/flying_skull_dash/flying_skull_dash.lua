flying_skull_dash = class({})
LinkLuaModifier("modifier_flying_skull_dash_displacement", "pve/abilities/units/flying_skull/flying_skull_dash/modifier_flying_skull_dash_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_flying_skull_dash", "pve/abilities/units/flying_skull/flying_skull_dash/modifier_flying_skull_dash", LUA_MODIFIER_MOTION_NONE)

function flying_skull_dash:GetCastPointSpeed() 			return 0 end

function flying_skull_dash:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
    EFX('particles/econ/items/silencer/silencer_ti10_immortal_shield/silencer_ti10_immortal_curse_cast.vpcf', PATTACH_ABSORIGIN, caster, {
        cp0 = origin + Vector(0, 0, 128),
        release = true 
    })
    return true
end

function flying_skull_dash:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
    local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), nil)
    local speed = 1200

    CustomEntitiesLegacy:FullyFaceTowards(caster, direction)
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_flying_skull_dash_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
            peak = 2,
        }
    )

    CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_ex_second_attack.vpcf",
			vSpawnOrigin = origin + Vector(direction.x * 45, direction.y * 45, 96),
			fDistance = distance,
			fStartRadius = 1,
			Source = caster,
			vVelocity = direction * speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return false end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})
end

function flying_skull_dash:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", nil)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", nil)
	
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function flying_skull_dash:OnUpgrade()
    if IsServer() then
        EFX('particles/flying_skull/burn_main.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
            release = true,
        })
    end
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(flying_skull_dash)