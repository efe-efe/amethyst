modifier_phantom_mobility_charges = class({})

if IsClient() then require("modifiers") end
Modifiers.Charges( 
	modifier_phantom_mobility_charges,
	{ type = "unsynced"}
)
