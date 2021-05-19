mars_mobility = class({})
LinkLuaModifier("modifier_mars_mobility_banish", "abilities/heroes/mars/mars_mobility/modifier_mars_mobility_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_mobility_thinker", "abilities/heroes/mars/mars_mobility/modifier_mars_mobility_thinker", LUA_MODIFIER_MOTION_NONE)

function mars_mobility:GetCastAnimationCustom()		return ACT_DOTA_GENERIC_CHANNEL_1 end
function mars_mobility:GetPlaybackRateOverride()    return 1.5 end
function mars_mobility:GetCastPointSpeed() 			return 0 end

function mars_mobility:OnAbilityPhaseStart()
    local particle_cast = "particles/econ/events/ti10/fountain_regen_ti10_lvl3.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

    EmitSoundOn("mars_mars_spawn_01", self:GetCaster())

    return true
end

function mars_mobility:OnAbilityPhaseInterrupted()
    self:StopEffects()
end

function mars_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local min_range = self:GetSpecialValueFor("min_range")

    local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), min_range)
    local delay = self:GetSpecialValueFor("delay_time")

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_mars_mobility_thinker", --modifierName
        { duration = delay + 0.2 },
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
   )

    self:PlayEffectsOnCast()
    self:StopEffects()
end

function mars_mobility:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function mars_mobility:PlayEffectsOnCast()
    local particle_cast = "particles/mars/mars_mobility_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(250, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)
    
    particle_cast = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetAbsOrigin())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_mobility)