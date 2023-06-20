modifier_nevermore_ultimate = class({})

IsDebuff(){
	return true
}

IsPurgable(){
	return true
}

OnCreated(){
	this.reduction_ms_pct = -this.ability.GetSpecialValueFor("reduction_ms")
}

OnRefresh(){
	this.reduction_ms_pct = -this.ability.GetSpecialValueFor("reduction_ms")
}

DeclareFunctions(){
	const funcs = {
		ModifierFunction.MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
}


GetModifierMoveSpeedBonus_Percentage(){
	return this.reduction_ms_pct
}