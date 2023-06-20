modifier_mars_extra_recast = class({})

function modifier_mars_extra_recast:GetRecastAbility()
    if(IsServer() ) {
        return this.parent.FindAbilityByName("mars_extra_recast") 
    }
}

function modifier_mars_extra_recast:GetRecastCharges()
	return 1
}

function modifier_mars_extra_recast:GetRecastKey()
    if(this.GetRecastAbility():GetAbilityIndex() == 6 ) {
		return "R"
	}
	return "F"
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Recast(modifier_mars_extra_recast)