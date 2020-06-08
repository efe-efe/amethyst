juggernaut_ultimate = class({})
LinkLuaModifier("modifier_juggernaut_ultimate_displacement", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_juggernaut_ultimate_slashing", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_slashing", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_spin_animation", "abilities/heroes/juggernaut/modifier_juggernaut_spin_animation", LUA_MODIFIER_MOTION_HORIZONTAL)

function juggernaut_ultimate:GetCastAnimationCustom()		return ACT_DOTA_GENERIC_CHANNEL_1 end
function juggernaut_ultimate:GetPlaybackRateOverride() 	    return 1.0 end
function juggernaut_ultimate:GetCastPointSpeed() 			return 0 end
function juggernaut_ultimate:GetAnimationTranslate()		return "sharp_blade" end

function juggernaut_ultimate:OnAbilityPhaseStart()
    self:PlayEffectsOnPhase()
    return true
end

function juggernaut_ultimate:OnAbilityPhaseInterrupted()
	StopGlobalSound("juggernaut_jug_ability_omnislash_01")
end

function juggernaut_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
    local distance = self:GetCastRange(Vector(0,0,0), nil)
	local direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_juggernaut_ultimate_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.5),
            peak = 50,
        } -- kv
   )
    self:PlayEffectsOnCast()
end

function juggernaut_ultimate:PlayEffectsOnPhase()
    local caster = self:GetCaster()
    EmitGlobalSound("juggernaut_jug_ability_omnislash_01")

    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_death_model.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:ReleaseParticleIndex(effect_cast)

    particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_end.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 2, caster:GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, caster:GetOrigin())

    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_ultimate:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_ultimate)