modifier_mars_counter_displacement = class({})

OnCreated(params){
	if(IsServer() ) {
        this.meele_stun_duration = this.ability.GetSpecialValueFor('meele_stun_duration')
	}
}

OnDestroy(){
	if(IsServer() ) {
		this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_stunned", { duration = this.meele_stun_duration })
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
Modifiers.Displacement(modifier_mars_counter_displacement)
Modifiers.Animation(modifier_mars_counter_displacement)