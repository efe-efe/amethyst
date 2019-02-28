skywrath_mage_ultimate_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_ultimate_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ultimate_lua/modifier_skywrath_mage_ultimate_thinker_lua", LUA_MODIFIER_MOTION_NONE )

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function skywrath_mage_ultimate_lua:GetRelatedName()
    return "skywrath_mage_ex_ultimate_lua"
end

--------------------------------------------------------------------------------
-- Set the aoe indicator
function skywrath_mage_ultimate_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ultimate_lua:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local point = self:GetCursorPosition()

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_skywrath_mage_ultimate_thinker_lua", --modifierName
        {duration = duration}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    self:PlayEffects()
end

function skywrath_mage_ultimate_lua:PlayEffects()
    local sound_cast = "Hero_SkywrathMage.MysticFlare.Cast"

    EmitSoundOn(sound_cast, self:GetCaster())
end