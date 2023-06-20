modifier_pango_mobility_displacement = class({})

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
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_pango_mobility_displacement)
Modifiers.Animation(modifier_pango_mobility_displacement)