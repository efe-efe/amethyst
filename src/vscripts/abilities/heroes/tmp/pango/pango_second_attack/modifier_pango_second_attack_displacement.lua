modifier_pango_second_attack_displacement = class({})

OnDestroy(){
	if(IsServer() ) {
		
		const origin = this.caster.GetAbsOrigin()
		const range = this.ability.GetCastRange(Vector(0,0,0), undefined)
		const direction = (CustomAbilitiesLegacy:GetCursorPosition(this.ability) - origin):Normalized()
		this.ability.Cut(origin, direction, range)

		const trail_pfx = ParticleManager.CreateParticle("particles/phantom/mobility_trail.vpcf", ParticleAttachment.ABSORIGIN, this.parent)
		ParticleManager.SetParticleControl(trail_pfx, 0, this.origin)
		ParticleManager.SetParticleControl(trail_pfx, 1, this.parent.GetAbsOrigin())
		ParticleManager.SetParticleControl(trail_pfx, 60, Vector(188,7,229))
		ParticleManager.SetParticleControl(trail_pfx, 61, Vector(1,0,0))
		ParticleManager.ReleaseParticleIndex(trail_pfx)
	}
}

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_CAST_ABILITY_1 }
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
Modifiers.Displacement(modifier_pango_second_attack_displacement)
Modifiers.Animation(modifier_pango_second_attack_displacement)