modifier_juggernaut_extra_recast = class({})

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_juggernaut_extra_recast,
	{ ability_name = "juggernaut_extra_recast", key = "R", charges = -1 }
)
