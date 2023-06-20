modifier_mars_mobility_thinker = class({})

OnCreated(params){
	if(IsServer() ) {
		this.radius = this.ability.GetSpecialValueFor("radius")
		this.damage_table = {
			attacker = this.caster,
			damage = this.ability.GetSpecialValueFor("ability_damage"),
			damage_type = DamageTypes.PURE,
		}
        this.PlayEffects()
        this.caster.AddNewModifier(this.caster, this.ability, "modifier_mars_mobility_banish", { duration = this.GetDuration() })
    }
}

OnDestroy(){
	if(IsServer() ) {
		this.StopEffects()
		UTIL_Remove(this.parent)
	}
}

function modifier_mars_mobility_thinker:OnDelayEnds()
	if(IsServer() ) {
		FindClearSpaceForUnit(this.caster, this.parent.GetAbsOrigin() , true)

		const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
			this.caster,
			this.parent.GetAbsOrigin(), 
			this.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			this.damage_table.victim = enemy
			ApplyDamage(this.damage_table)
		}

		this.PlayEffectsOnDraw()
		this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_4, 1.5)
	}
}

function modifier_mars_mobility_thinker:PlayEffectsOnDraw()
	EmitSoundOn("Hero_Nevermore.ROS_Flames", this.caster)

	const particle_cast = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
    
	particle_cast = "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf"
	particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)	
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
	ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, 5, 1))
    ParticleManager.ReleaseParticleIndex(particleId)

	particle_cast = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
	particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)	
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
	ParticleManager.SetParticleControl(particleId, 2, Vector(this.radius, 1, 1))
	ParticleManager.ReleaseParticleIndex(particleId)
	
	ScreenShake(this.caster.GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)
}

PlayEffects(){
    const particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
    ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin())
    ParticleManager.SetParticleControl(this.particleId, 1, this.parent.GetAbsOrigin())
    ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin())
    ParticleManager.SetParticleControl(this.particleId, 3, Vector(this.radius, 0, 0))
}

function modifier_mars_mobility_thinker:StopEffects()
	ParticleManager.DestroyParticle(this.particleId, false)
	ParticleManager.ReleaseParticleIndex(this.particleId)    
}

function modifier_mars_mobility_thinker:GetDelayTime()
    return this.ability.GetSpecialValueFor("delay_time")
}

function modifier_mars_mobility_thinker:GetAOERadius()
    return this.ability.GetSpecialValueFor("radius")
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Thinker(modifier_mars_mobility_thinker)