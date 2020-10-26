storm_mobility = class({})
LinkLuaModifier("modifier_storm_mobility_thinker", "abilities/heroes/storm/storm_mobility/modifier_storm_mobility_thinker", LUA_MODIFIER_MOTION_BOTH)

function storm_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function storm_mobility:GetPlaybackRateOverride()       return 1.0 end
function storm_mobility:GetCastPointSpeed() 			return 0 end

function storm_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local duration = 5.0--self:GetSpecialValueFor("duration")
    
    local thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_storm_mobility_thinker", --modifierName
        { duration = duration },
        caster:GetAbsOrigin(), --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        true --bPhantomBlocker
    )      

    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_mobility)