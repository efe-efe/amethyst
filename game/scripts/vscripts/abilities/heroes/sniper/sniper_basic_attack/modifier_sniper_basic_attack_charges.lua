modifier_sniper_basic_attack_charges = class({})

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges( 
	modifier_sniper_basic_attack_charges,
	{ type = "synced", show_icon = 1, replenish = "aspd" }
)