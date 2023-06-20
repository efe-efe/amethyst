modifier_vengeful_extra_thinker = class({})

OnCreated(){
    if(IsServer() ) {
        this.origin = this.parent.GetAbsOrigin()
        this.ability = this.ability
        this.radius = this.ability.GetSpecialValueFor("radius")
        this.delay_time = this.ability.GetSpecialValueFor("delay_time")
        this.duration = this.ability.GetSpecialValueFor("duration")
        this.damage_block = this.ability.GetSpecialValueFor("damage_block")

        this.StartIntervalThink(this.delay_time)
        this.PlayEffectsOnCreated()
        CreateTimedRadiusMarker(this.caster, this.origin, this.radius, this.delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
    }
}

OnDestroy(){
    if(IsServer() ) {
        DEFX(this.efx, false)
        UTIL_Remove(this.parent)
    }
}

OnIntervalThink(){
    if(IsServer() ) {
        

        const allies = CustomEntitiesLegacy:FindUnitsInRadius(
        this.caster,
            this.origin, 
            this.radius, 
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )

        for _,ally in pairs(allies) do
            ally:AddNewModifier(this.caster, this.ability, "modifier_vengeful_extra", { duration = this.duration, damage_block = this.damage_block })
            EmitSoundOn("Hero_Disruptor.KineticField", ally)
        }

        
		this.PlayEffectsOnImpact()
	    this.Destroy()
	}
}

function modifier_vengeful_extra_thinker:PlayEffectsOnCreated()
    EmitSoundOn("Hero_VengefulSpirit.Missile.Cast.TI8.Layer", thinker)
    
    this.efx = ParticleManager.CreateParticle("particles/addons_gameplay/morokai_orb_large.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
    ParticleManager.SetParticleControl(this.efx, 0, this.origin)
    ParticleManager.SetParticleControl(this.efx, 1, Vector(1, 0, 0))
    ParticleManager.SetParticleControl(this.efx, 10, Vector(2.5, 0, 0))
}

function modifier_vengeful_extra_thinker:PlayEffectsOnImpact()
    EmitSoundOn("Hero_VengefulSpirit.Missile.Target.TI8.Layer", this.parent)

    const efx = ParticleManager.CreateParticle("particles/units/heroes/hero_treant/treant_overgrowth_hero_glow.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
    ParticleManager.SetParticleControl(efx, 0, this.origin)
    ParticleManager.SetParticleControl(efx, 1, Vector(this.radius, 1, 1))
    ParticleManager.ReleaseParticleIndex(efx)

    efx = ParticleManager.CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
    ParticleManager.SetParticleControl(efx, 0, this.origin)
    ParticleManager.ReleaseParticleIndex(efx)
}

