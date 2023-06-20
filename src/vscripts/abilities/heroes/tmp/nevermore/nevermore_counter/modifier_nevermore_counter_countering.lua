modifier_nevermore_counter_countering = class({})

OnCreated(params){
    this.banish_duration = this.ability.GetSpecialValueFor("banish_duration")
    EmitSoundOn("Hero_Nevermore.RequiemOfSoulsCast", this.parent)
}

OnDestroy(){
    if(IsServer() ) {
        StopSoundOn("Hero_Nevermore.RequiemOfSoulsCast", this.caster)
		EmitSoundOn("Hero_Juggernaut.Attack", this.caster)
		const particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
		ParticleManager.ReleaseParticleIndex(particleId)
	}
}

function modifier_nevermore_counter_countering:OnTrigger(params)
    if(IsServer() ) {
        this.parent.AddNewModifier(this.parent, this.ability, "modifier_nevermore_counter_banish", { duration = this.banish_duration })
        CustomEntitiesLegacy:StrongPurge(this.parent)
        this.PlayEffectsOnTrigger()
		this.Destroy()
	}
}

function modifier_nevermore_counter_countering:OnProjectileHitCustom(params)
	if(IsServer() ) {
		this.OnTrigger({})
		if(params.hProjectile.bIsDestructible ) {
			params.hProjectile:Destroy(true)
		}
	}
}

GetMovementSpeedPercentage(){ return 0 }

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_TELEPORT }
GetOverrideAnimationRate(){ 	return 1.0 }

function modifier_nevermore_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("Hero_Nevermore.RequiemOfSouls", this.parent)

	const particle_cast = "particles/econ/events/ti9/blink_dagger_ti9_start_lvl2.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin())
    ParticleManager.ReleaseParticleIndex(particleId)
    
	const particle_cast_b = "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf"
	const effect_cast_b = ParticleManager.CreateParticle(particle_cast_b, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(effect_cast_b, 0, this.parent.GetAbsOrigin())
    ParticleManager.ReleaseParticleIndex(effect_cast_b)
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Counter(modifier_nevermore_counter_countering)
Modifiers.OnProjectileHit(modifier_nevermore_counter_countering)