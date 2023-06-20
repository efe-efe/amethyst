modifier_nevermore_ultimate_thinker = class({})

OnCreated(params){
    this.radius = this.ability.GetSpecialValueFor("radius")
    if(IsServer() ) {
        this.caster = this.caster
        this.origin = this.caster.GetAbsOrigin()
        this.radius_marker_modifier = CreateTimedRadiusMarker(this.caster, this.origin, this.radius, this.GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')

        this.PlayEffects()
        this.StartIntervalThink(0.03)
    }
}

OnDestroy(){
    if(IsServer() ) {
        
        if(this.radius_marker_modifier ~= undefined ) {
            if(! this.radius_marker_modifier:IsNull() ) {
                this.radius_marker_modifier:Destroy()
            }
        }
        
        this.StopEffects()

        UTIL_Remove(this.parent)
    }
}

PlayEffects(){
    const particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
	this.effect_cast_aoe = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(this.effect_cast_aoe, 0, this.parent.GetAbsOrigin())
	ParticleManager.SetParticleControl(this.effect_cast_aoe, 1, this.parent.GetAbsOrigin())
	ParticleManager.SetParticleControl(this.effect_cast_aoe, 2, this.parent.GetAbsOrigin())
    ParticleManager.SetParticleControl(this.effect_cast_aoe, 3, Vector(this.radius, 0, 0))
}

function modifier_nevermore_ultimate_thinker:StopEffects()
    ParticleManager.DestroyParticle(this.effect_cast_aoe, false)
    ParticleManager.ReleaseParticleIndex(this.effect_cast_aoe)
}


OnIntervalThink(){
    if(IsServer() ) {
        const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
            this.caster,
            this.origin, 
            this.radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
       )
        for _,enemy in pairs(enemies) do
            const direction = (this.origin - enemy:GetAbsOrigin()):Normalized()
            const point = enemy:GetAbsOrigin() + direction * 8
            enemy:SetAbsOrigin(point)
            FindClearSpaceForUnit(enemy, enemy:GetAbsOrigin(), true)
        }
    }
}