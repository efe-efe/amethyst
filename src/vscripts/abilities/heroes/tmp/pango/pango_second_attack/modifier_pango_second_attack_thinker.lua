modifier_pango_second_attack_thinker = class({})

OnCreated(params){
    if(IsServer() ) {
        this.point = Vector(params.x, params.y)
        this.attacks = 4
        this.efxs = {}
        this.pango_basic_attack = this.caster.FindAbilityByName("pango_basic_attack")

        this.damage_table = {
            attacker = this.caster,
            damage = 5,
            damage_type = DamageTypes.PHYSICAL,
        }

        this.OnIntervalThink()
        this.StartIntervalThink(0.1)
        
        EmitSoundOn("Hero_Pangolier.Swashbuckle", this.caster)
    }
}

OnDestroy(){
    if(IsServer() ) {
        for _,efx in pairs(this.efxs) do
            ParticleManager.DestroyParticle(efx, false)
            ParticleManager.ReleaseParticleIndex(efx)
        }

        UTIL_Remove(this.parent)
    }
}

OnIntervalThink(){
    const enemies = CustomEntitiesLegacy:FindUnitsInLine(this.caster,
		this.parent.GetAbsOrigin(), 
		this.point, 
		150, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
    )

    for _,enemy in pairs(enemies) do
        this.pango_basic_attack:TryProc(enemy)
        if(! CustomEntitiesLegacy:IsObstacle(enemy) ) {
            this.caster.AddNewModifier(this.caster, this.pango_basic_attack, "modifier_pango_basic_attack_stacks", {}) 
        }
        this.damage_table.victim = enemy
        ApplyDamage(this.damage_table)
        EmitSoundOn("Hero_Pangolier.Swashbuckle.Attack", enemy)
        EmitSoundOn("Hero_Pangolier.Attack", enemy)
    }

    this.attacks = this.attacks - 1

    const direction = (this.point - this.parent.GetAbsOrigin()):Normalized()
    const range = (this.point - this.parent.GetAbsOrigin()):Length2D()

    this.efxs[this.attacks] = EFX("particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", ParticleAttachment.WORLDORIGIN, undefined, { 
        cp0 = this.parent.GetAbsOrigin(),
        cp1 = direction * range,
    })

    if(this.attacks <= 0 ) {
        this.Destroy()
    }
}