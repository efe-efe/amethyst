modifier_pango_special_attack_displacement = class({})


OnCreated(table){
    if(IsServer() ) {
		this.radius = this.ability.GetSpecialValueFor("radius")
	}
}

OnDestroy(){
	if(IsServer() ) {
		this.ability.Crash(this.radius)

		if(this.ability.GetLevel() >= 2 ) {
			
			const origin = this.caster.GetAbsOrigin()
			const direction = this.caster.GetForwardVector()
			const pango_second_attack = this.caster.FindAbilityByName("pango_second_attack")
			const range = pango_second_attack:GetCastRange(Vector(0,0,0), undefined)/2

			pango_second_attack:Cut(origin, direction, range)
			pango_second_attack:Cut(origin, direction * -1, range)
		}
	}
}


DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){
	if(this.parent.HasModifier("modifier_pango_mobility") ) { 
		return
	}
	return GameActivity.DOTA_CAST_ABILITY_2 
}
GetOverrideAnimationRate(){ 	return 1.0 }

CheckState(){
	return {
        [ModifierState.NO_HEALTH_BAR] = true,
		[ModifierState.INVULNERABLE] = true,
		[ModifierState.OUT_OF_GAME] = true,
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_pango_special_attack_displacement)
Modifiers.Animation(modifier_pango_special_attack_displacement)