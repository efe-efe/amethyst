modifier_nevermore_special_attack_charges = class({})

function modifier_nevermore_special_attack_charges:GetMaxCharges()
	return this.ability.GetSpecialValueFor("max_charges")
}

function modifier_nevermore_special_attack_charges:GetReplenishType() return CHARGES_TYPE_ASYNC }
function modifier_nevermore_special_attack_charges:GetReplenishTime()
	if(IsServer() ) {
		this.ability.GetCooldown(this.ability.GetLevel())
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Charges(modifier_nevermore_special_attack_charges)