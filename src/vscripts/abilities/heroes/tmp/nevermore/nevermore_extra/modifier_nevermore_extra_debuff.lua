modifier_nevermore_extra_debuff = class({})

IsHidden(){ 	return 	false 	}
IsDebuff(){ 	return 	true 	}
IsPurgable(){ 	return 	false 	}

OnCreated(params){
	this.slow_pct = -this.ability.GetSpecialValueFor("slow_pct")
	this.think_interval = this.ability.GetSpecialValueFor("think_interval")

    if(IsServer() ) {
        const multiplier = this.caster.FindModifierByName('modifier_nevermore_extra'):GetStackCount()
        const damage_per_think = this.ability.GetSpecialValueFor("damage_per_think")
        const damage_per_soul = this.ability.GetSpecialValueFor("damage_per_soul")
        const damage = damage_per_think + damage_per_soul * multiplier
        
		this.damage_table = {
			victim = this.parent,
			attacker = this.caster,
			damage = damage,
			damage_type = DamageTypes.PURE,
		}

		this.StartIntervalThink(this.think_interval)  
	}
}

OnIntervalThink(){
	ApplyDamage(this.damage_table)
}

DeclareFunctions(){
	return { ModifierFunction.MOVESPEED_BONUS_PERCENTAGE }
}

GetModifierMoveSpeedBonus_Percentage(){
    return this.slow_pct
}