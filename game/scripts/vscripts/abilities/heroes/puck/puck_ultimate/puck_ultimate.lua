puck_ultimate = class({})
LinkLuaModifier("modifier_puck_ultimate_thinker", "abilities/heroes/puck/puck_ultimate/modifier_puck_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ultimate_debuff", "abilities/heroes/puck/puck_ultimate/modifier_puck_ultimate_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ultimate_area_check", "abilities/heroes/puck/puck_ultimate/modifier_puck_ultimate_area_check", LUA_MODIFIER_MOTION_NONE)

function puck_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_5 end 
function puck_ultimate:GetPlaybackRateOverride()    return 1.0 end
function puck_ultimate:GetCastPointSpeed()          return 0 end

function puck_ultimate:OnSpellStart()
	local caster = self:GetCaster()
    local point = ClampPosition(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_puck_ultimate_thinker", --modifierName
        { duration = self:GetSpecialValueFor("duration") + 0.2 },
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
   )

    EmitSoundOn("Hero_Puck.Dream_Coil", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_ultimate)