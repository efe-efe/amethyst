modifier_nevermore_special_attack_displacement = class({})

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
	}
}

GetOverrideAnimation(){ 		        return GameActivity.DOTA_FLAIL }

CheckState(){
	return {
        [ModifierState.STUNNED] = true,
        [ModifierState.NO_HEALTH_BAR] = true,
		[ModifierState.INVULNERABLE] = true,
		[ModifierState.OUT_OF_GAME] = true,
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}


if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_nevermore_special_attack_displacement)
Modifiers.Animation(modifier_nevermore_special_attack_displacement)