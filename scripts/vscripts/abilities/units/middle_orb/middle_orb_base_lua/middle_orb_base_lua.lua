middle_orb_base_lua = class ({})
LinkLuaModifier( "modifier_middle_orb_base_lua", "abilities/units/middle_orb/middle_orb_base_lua/modifier_middle_orb_base_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function middle_orb_base_lua:GetIntrinsicModifierName()
	return "modifier_middle_orb_base_lua"
end
