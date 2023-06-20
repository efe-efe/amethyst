modifier_vengeful_mobility_recast = class({})

GetAttributes(){
	return MODIFIER_ATTRIBUTE_MULTIPLE
}

IsHidden(){ return true }

function modifier_vengeful_mobility_recast:GetRecastAbility()
	if(IsServer() ) {
		return this.parent.FindAbilityByName(this.ability.GetName() .. "_recast")
	}
}

function modifier_vengeful_mobility_recast:GetStatusEffectName()
	return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
}

function modifier_vengeful_mobility_recast:GetRecastCharges()
	return 1
}

function modifier_vengeful_mobility_recast:GetRecastKey()
    return "SPACE"
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Recast(modifier_vengeful_mobility_recast)