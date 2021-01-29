juggernaut_ultimate = class({})
LinkLuaModifier("modifier_juggernaut_ultimate_displacement", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_juggernaut_ultimate_banish", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_banish", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_juggernaut_ultimate_slashing", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_slashing", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_spin_animation", "abilities/heroes/juggernaut/modifier_juggernaut_spin_animation", LUA_MODIFIER_MOTION_HORIZONTAL)

function juggernaut_ultimate:GetCastAnimationCustom()		return ACT_DOTA_GENERIC_CHANNEL_1 end
function juggernaut_ultimate:GetPlaybackRateOverride() 	    return 2.0 end
function juggernaut_ultimate:GetCastPointSpeed() 			return 0 end
function juggernaut_ultimate:GetAnimationTranslate()		return "sharp_blade" end

function juggernaut_ultimate:OnAbilityPhaseStart()
    self:PlayEffectsOnPhase()
    return true
end

function juggernaut_ultimate:OnAbilityPhaseInterrupted()
	StopGlobalSound("juggernaut_jug_rare_17")
	StopGlobalSound("Hero_Juggernaut.PreAttack")
    StopGlobalSound("Hero_Lycan.SummonWolves")
end

function juggernaut_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
    local distance = self:GetCastRange(Vector(0,0,0), nil)
	local direction = Direction2D(origin, point)

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
    EmitGlobalSound("juggernaut_jug_rare_17")
    EmitGlobalSound("Hero_Lycan.SummonWolves")
	EmitGlobalSound("Hero_Juggernaut.PreAttack")
    
    local particle_cast = "particles/juggernaut/juggernaut_ultimate_cast.vpcf"
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