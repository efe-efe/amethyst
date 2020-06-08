sniper_ultimate = class({})
LinkLuaModifier("modifier_sniper_ultimate_channeling", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_channeling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_ultimate_displacement", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_sniper_ultimate_hit", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_hit", LUA_MODIFIER_MOTION_BOTH)

function sniper_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function sniper_ultimate:GetPlaybackRateOverride() 	    return 2.5 end
function sniper_ultimate:GetCastPointSpeed() 			return 0 end

function sniper_ultimate:OnAbilityPhaseStart()
    self:PlayEffectsOnPhase()
    return true
end

function sniper_ultimate:OnAbilityPhaseInterrupted()
    self:StopEffectsOnPhase()
end

function sniper_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(
        caster, 
        self, 
        "modifier_sniper_ultimate_channeling", 
        { duration = duration }
   ) 
    self:PlayEffectsOnCast()
end

function sniper_ultimate:PlayEffectsOnPhase()
    EmitGlobalSound("sniper_snip_ability_assass_02")
end

function sniper_ultimate:StopEffectsOnPhase()
    StopGlobalSound("sniper_snip_ability_assass_02")
end

function sniper_ultimate:PlayEffectsOnCast()
    EmitGlobalSound("sniper_snip_laugh_08")
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_ultimate)