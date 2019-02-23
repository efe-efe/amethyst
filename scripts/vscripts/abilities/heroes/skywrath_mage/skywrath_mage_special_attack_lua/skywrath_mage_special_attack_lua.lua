skywrath_mage_special_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_special_attack_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_special_attack_lua/modifier_skywrath_mage_special_attack_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function skywrath_mage_special_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------

function skywrath_mage_special_attack_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor( "duration" )

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_skywrath_mage_special_attack_thinker_lua", --modifierName
        {duration = duration}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
end
