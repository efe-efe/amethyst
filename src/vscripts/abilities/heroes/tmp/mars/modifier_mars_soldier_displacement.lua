modifier_mars_soldier_displacement = class({})

OnCreated(params){
	if(IsServer() ) {
	}
}

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_FLAIL }
GetOverrideAnimationRate(){ 	return 1.0 }

CheckState(){
	return {
        [ModifierState.NO_HEALTH_BAR] = true,
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_mars_soldier_displacement)
Modifiers.Animation(modifier_mars_soldier_displacement)