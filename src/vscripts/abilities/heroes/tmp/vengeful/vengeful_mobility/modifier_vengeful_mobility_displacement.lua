modifier_vengeful_mobility_displacement = class({})

OnCreated(params){
	if(IsServer() ) {
		this.original_scale = this.parent.GetModelScale()
		this.parent.SetModelScale(this.original_scale/1.5)
		EFX("particles/econ/events/ti10/blink_dagger_start_ti10.vpcf", ParticleAttachment.WORLDORIGIN, this.parent, {
			cp0 = this.parent.GetAbsOrigin(),
			release = true,
		})
	}
}

OnDestroy(){
	if(IsServer() ) {
		this.parent.SetModelScale(this.original_scale)
		EFX("particles/econ/events/ti10/blink_dagger_end_ti10.vpcf", ParticleAttachment.WORLDORIGIN, this.parent, {
			cp0 = this.parent.GetAbsOrigin(),
			release = true,
		})
	}
}

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_SPAWN }
GetOverrideAnimationRate(){ 	return 1.0 }

CheckState(){
	return {
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_vengeful_mobility_displacement)
Modifiers.Animation(modifier_vengeful_mobility_displacement)