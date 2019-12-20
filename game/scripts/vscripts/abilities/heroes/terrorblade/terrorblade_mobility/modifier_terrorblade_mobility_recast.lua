modifier_terrorblade_mobility_recast = class({})

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_terrorblade_mobility_recast,
	{ ability_name = "terrorblade_mobility_recast", key = "SPACE" }
)
