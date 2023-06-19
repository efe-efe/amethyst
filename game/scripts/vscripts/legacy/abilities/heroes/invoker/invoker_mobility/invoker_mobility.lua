invoker_mobility = class({})
LinkLuaModifier("modifier_invoker_mobility_banish", "abilities/heroes/invoker/invoker_mobility/modifier_invoker_mobility_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_mobility_thinker", "abilities/heroes/invoker/invoker_mobility/modifier_invoker_mobility_thinker", LUA_MODIFIER_MOTION_NONE)

function invoker_mobility:GetCastAnimationCustom()		return ACT_DOTA_SPAWN end
function invoker_mobility:GetAnimationTranslate() 		return "loadout" end
function invoker_mobility:GetPlaybackRateOverride()    return 1.5 end
function invoker_mobility:GetCastPointSpeed() 			return 0 end

function invoker_mobility:OnAbilityPhaseStart()
    local particle_cast = "particles/econ/events/ti10/fountain_regen_ti10_lvl3.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

    EmitSoundOn("invoker_invoker_spawn_01", self:GetCaster())

    return true
end

function invoker_mobility:OnAbilityPhaseInterrupted()
    self:StopEffects()
end

function invoker_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local min_range = self:GetSpecialValueFor("min_range")
    local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), min_range)

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_invoker_mobility_thinker", --modifierName
        {},
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
   )

    self:PlayEffectsOnCast()
    self:StopEffects()
end

function invoker_mobility:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function invoker_mobility:PlayEffectsOnCast()
    local particle_cast = "particles/invoker/invoker_mobility_start.vpcf"
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
Abilities.Castpoint(invoker_mobility)