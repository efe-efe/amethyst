modifier_phantom_special_attack_charges = class({})

if IsClient() then require("modifiers") end
Modifiers.Charges( 
	modifier_phantom_special_attack_charges,
	{ type = "unsynced"}
)
