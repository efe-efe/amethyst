modifier_ancient_special_attack_charges = class({})

if IsClient() then require("modifiers") end
Modifiers.Charges( 
	modifier_ancient_special_attack_charges,
	{ type = "unsynced"}
)
