mars_ultimate = class({})
LinkLuaModifier("modifier_mars_soldier", "abilities/heroes/mars/modifier_mars_soldier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_debuff", "abilities/heroes/mars/modifier_mars_soldier_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_displacement", "abilities/heroes/mars/modifier_mars_soldier_displacement", LUA_MODIFIER_MOTION_BOTH)

LinkLuaModifier("modifier_mars_ultimate_thinker", "abilities/heroes/mars/mars_ultimate/modifier_mars_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_ultimate_area_check", "abilities/heroes/mars/mars_ultimate/modifier_mars_ultimate_area_check", LUA_MODIFIER_MOTION_NONE)

function mars_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end 
function mars_ultimate:GetPlaybackRateOverride()    return 1.0 end
function mars_ultimate:GetCastPointSpeed() 			return 0 end

function mars_ultimate:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    local delay = self:GetCastPoint()
    local duration = self:GetSpecialValueFor("duration")

    self.thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_mars_ultimate_thinker", --modifierName
        { duration = delay + duration },
        caster:GetAbsOrigin(), --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        true --bPhantomBlocker
    )      

    return true
end

function mars_ultimate:OnAbilityPhaseInterrupted()
    self.thinker:Destroy()
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_ultimate)