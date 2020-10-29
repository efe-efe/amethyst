storm_mobility = class({})
storm_ex_mobility = class({})

LinkLuaModifier("modifier_storm_mobility_thinker", "abilities/heroes/storm/storm_mobility/modifier_storm_mobility_thinker", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_ex_mobility_thinker", "abilities/heroes/storm/storm_mobility/modifier_storm_ex_mobility_thinker", LUA_MODIFIER_MOTION_BOTH)

function storm_mobility:GetCastAnimationCustom()		return ACT_DOTA_SPAWN end
function storm_mobility:GetPlaybackRateOverride()       return 1.5 end
function storm_mobility:GetCastPointSpeed() 			return 50 end

function storm_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
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


function storm_ex_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function storm_ex_mobility:GetPlaybackRateOverride()       return 1.0 end
function storm_ex_mobility:GetCastPointSpeed() 			return 10 end

function storm_ex_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local point = Clamp(caster:GetAbsOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    local thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_storm_ex_mobility_thinker", --modifierName
        { duration = duration },
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        true --bPhantomBlocker
    )      

    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", caster)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_mobility)
Abilities.Castpoint(storm_ex_mobility)
Abilities.Tie(storm_mobility, 'storm_ex_mobility')
Abilities.Tie(storm_ex_mobility, 'storm_mobility')