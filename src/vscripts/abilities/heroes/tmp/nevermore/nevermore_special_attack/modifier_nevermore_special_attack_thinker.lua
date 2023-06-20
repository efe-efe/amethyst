modifier_nevermore_special_attack_thinker = class({})

OnCreated(params){
    this.caster = this.caster
    this.radius = this.ability.GetSpecialValueFor("radius")
    const delay_time = this.ability.GetSpecialValueFor("delay_time")
    this.origin = this.parent.GetAbsOrigin()
    this.mana_gain_pct = this.ability.GetSpecialValueFor("mana_gain_pct")
    this.damage_per_stack = this.ability.GetSpecialValueFor("damage_per_stack")
    this.stacks_duration = this.ability.GetSpecialValueFor("stacks_duration")
    this.damage_table = {
        attacker = this.caster,
        damage = this.ability.GetSpecialValueFor("ability_damage"),
        damage_type = DamageTypes.PURE,
    }
    
    if(IsServer() ) {
        CreateTimedRadiusMarker(this.caster, this.origin, this.radius, this.GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
        this.StartIntervalThink(delay_time)
    }
}

OnIntervalThink(){
    const give_mana = false

    ApplyCallbackForUnitsInArea(this.caster, this.origin, this.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        const modifier = unit:FindModifierByName('modifier_nevermore_special_attack_stacks') 
        const stacks = 0

        if(modifier ) {
            stacks = modifier:GetStackCount()
        }

        this.damage_table.victim = unit
        this.damage_table.damage = this.damage_table.damage + (this.damage_per_stack * stacks)
        ApplyDamage(this.damage_table)

        unit:AddNewModifier(this.caster, this.ability, 'modifier_nevermore_special_attack_stacks', { duration = this.stacks_duration })

        if(! CustomEntitiesLegacy:IsObstacle(unit) ) {
            give_mana = true
        }
    })

    if(give_mana ) {
        CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, this.mana_gain_pct, true)
    }

    EmitSoundOnLocationWithCaster(this.origin, "Hero_Nevermore.Shadowraze", this.caster)

    EFX('particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf', ParticleAttachment.WORLDORIGIN, undefined, {
        cp0 = this.origin,
        cp1 = Vector(this.radius, 1, 1),
        release = true
    })

    this.Destroy()
}