modifier_pango_counter_countering = class({})

OnDestroy(){
	if(IsServer() ) {
		const particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
		ParticleManager.ReleaseParticleIndex(particleId)
	}
}

function modifier_pango_counter_countering:OnTrigger(params)
	if(IsServer() ) {
		const pango_special_attack = this.parent.FindAbilityByName("pango_special_attack")
		pango_special_attack:EndCooldown()
		pango_special_attack:Crash(450)
        this.parent.AddNewModifier(this.parent, this.parent.FindAbilityByName("pango_mobility"), "modifier_pango_mobility", { duration = 1.5 })
		this.Destroy()
	}
}

function modifier_pango_counter_countering:OnHit(params)
	if(IsServer() ) {
		if(! params.bTriggerCounters ) {
			return true
		}
		
		this.OnTrigger({})
		if(projectile.bIsDestructible ) {
			projectile:ScheduleDestroy()
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

GetOverrideAnimation(){ 		return GameActivity.DOTA_CAST_ABILITY_3 }
GetOverrideAnimationRate(){ 	return 0.4 }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Counter(modifier_pango_counter_countering)
Modifiers.OnHit(modifier_pango_counter_countering)