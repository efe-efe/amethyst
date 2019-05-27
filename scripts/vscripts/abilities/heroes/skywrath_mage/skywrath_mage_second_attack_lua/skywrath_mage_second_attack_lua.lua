skywrath_mage_second_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_second_attack_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_second_attack_lua/modifier_skywrath_mage_second_attack_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_second_attack_charges_lua", "abilities/heroes/skywrath_mage/skywrath_mage_second_attack_lua/modifier_skywrath_mage_second_attack_charges_lua", LUA_MODIFIER_MOTION_NONE )


-- Set AOE indicator
--------------------------------------------------------------------------------
function skywrath_mage_second_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_second_attack_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_skywrath_mage_second_attack_thinker_lua", --modifierName
        {}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
    
end

--------------------------------------------------------------------------------
-- Passive Modifier
function skywrath_mage_second_attack_lua:GetIntrinsicModifierName()
	return "modifier_skywrath_mage_second_attack_charges_lua"
end
