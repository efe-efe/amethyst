modifier_pango_roll_end_animation = class({})

IsHidden(){   return true }

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_CAST_ABILITY_4_END }
GetOverrideAnimationRate(){ 	return 1.5 }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Animation(modifier_pango_roll_end_animation)
