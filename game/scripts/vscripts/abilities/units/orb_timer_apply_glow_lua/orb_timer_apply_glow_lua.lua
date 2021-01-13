orb_timer_apply_glow_lua = class ({})
LinkLuaModifier("modifier_orb_timer_apply_glow_lua", "abilities/units/orb_timer_apply_glow_lua/modifier_orb_timer_apply_glow_lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Passive Modifier
function orb_timer_apply_glow_lua:GetIntrinsicModifierName()
	return "modifier_orb_timer_apply_glow_lua"
end
