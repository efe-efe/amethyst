modifier_phantom_mobility_charges = class({})

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges( 
	modifier_phantom_mobility_charges,
	{ type = CHARGES_TYPE_ASYNC}
)
