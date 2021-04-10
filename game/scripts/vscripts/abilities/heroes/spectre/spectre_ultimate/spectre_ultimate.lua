spectre_ultimate = class({})
LinkLuaModifier("modifier_spectre_ultimate", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ultimate_thinker", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ultimate_helper", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_helper", LUA_MODIFIER_MOTION_NONE)

function spectre_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_ultimate:GetPlaybackRateOverride() 	return 0.6 end
function spectre_ultimate:GetCastPointSpeed() 			return 0 end

function spectre_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local point = ClampPosition(origin, CustomAbilities:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
    
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_spectre_ultimate_thinker", --modifierName
        {},
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
    
    EmitSoundOn("Hero_Spectre.HauntCast", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_ultimate)