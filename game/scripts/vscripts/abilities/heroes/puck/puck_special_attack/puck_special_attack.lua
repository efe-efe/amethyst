puck_special_attack = class({})
LinkLuaModifier("modifier_puck_special_attack_thinker", "abilities/heroes/puck/puck_special_attack/modifier_puck_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_fairy_dust", "abilities/heroes/puck/modifier_puck_fairy_dust", LUA_MODIFIER_MOTION_NONE)

function puck_special_attack:GetCastAnimationCustom()       return ACT_DOTA_CAST_ABILITY_5 end 
function puck_special_attack:GetPlaybackRateOverride()      return 1.0 end
function puck_special_attack:GetCastPointSpeed()            return 0 end

function puck_special_attack:OnSpellStart()
	local caster = self:GetCaster()
    local point = ClampPosition(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_puck_special_attack_thinker", --modifierName
        {},
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    EmitSoundOn("Hero_Puck.Dream_Coil", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_special_attack)