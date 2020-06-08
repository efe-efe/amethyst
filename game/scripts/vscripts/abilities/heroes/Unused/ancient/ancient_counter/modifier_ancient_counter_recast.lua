modifier_ancient_counter_recast = class({})

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(
	modifier_ancient_counter_recast,
	{ ability_name = "ancient_counter_recast", key = "Q" }
)
