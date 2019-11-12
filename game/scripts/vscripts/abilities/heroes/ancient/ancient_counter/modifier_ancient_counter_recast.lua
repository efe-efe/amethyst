modifier_ancient_counter_recast = class({})

function modifier_ancient_counter_recast:OnCreated(params)
end

if IsClient() then require("modifiers") end
Modifiers.Recast( 
	modifier_ancient_counter_recast,
	{ ability_name = "ancient_counter_recast", key = "Q" }
)
