builder_check_area_lua = class({})

LinkLuaModifier("modifier_builder_check_area_thinker_lua", "abilities/heroes/builder/builder_check_area_lua/modifier_builder_check_area_thinker_lua", LUA_MODIFIER_MOTION_NONE)

-- Set AOE indicator
--------------------------------------------------------------------------------
function builder_check_area_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

--------------------------------------------------------------------------------
-- Ability Start
function builder_check_area_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_builder_check_area_thinker_lua", --modifierName
        {}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
   )
end
