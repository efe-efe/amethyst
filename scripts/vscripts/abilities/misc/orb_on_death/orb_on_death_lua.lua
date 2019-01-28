orb_on_death_lua = class ({})
LinkLuaModifier( "modifier_orb_on_death_lua", "abilities/misc/orb_on_death/modifier_orb_on_death_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function orb_on_death_lua:GetIntrinsicModifierName()
	return "modifier_orb_on_death_lua"
end