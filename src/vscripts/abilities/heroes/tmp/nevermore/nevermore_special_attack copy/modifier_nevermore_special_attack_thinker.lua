modifier_nevermore_special_attack_thinker = class({})

OnCreated(params){
    this.radius = this.ability.GetSpecialValueFor("radius")
    this.mana_gain_pct = this.ability.GetSpecialValueFor("mana_gain_pct")
    this.lift_duration = this.ability.GetSpecialValueFor("lift_duration")
    this.damage_table = {
        attacker = this.caster,
        damage = this.ability.GetSpecialValueFor("ability_damage"),
        damage_type = DamageTypes.PURE,
    }
    
    if(IsServer() ) {
        const particle_cast = "particles/nevermore/nevermore_special_attack.vpcf"
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
        ParticleManager.ReleaseParticleIndex(particleId)

        
        particle_cast = "particles/nevermore/nevermore_special_attack_glow.vpcf"
        particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
        ParticleManager.ReleaseParticleIndex(particleId)
    }
}

function modifier_nevermore_special_attack_thinker:OnDelayEnds(params)
    if(IsServer() ) {
        const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
            this.caster,
            this.parent.GetAbsOrigin(), 
            this.radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
       )

        const give_mana = false
        for _,enemy in pairs(enemies) do
            this.damage_table.victim = enemy
            ApplyDamage(this.damage_table)

            enemy:AddNewModifier(this.caster, this.ability, "modifier_nevermore_special_attack_displacement", {
                x = 1,
                y = 1,
                r = 1,
                speed = (1/this.lift_duration),
                peak = 400,
            })

            if(! CustomEntitiesLegacy:IsObstacle(enemy) ) {
                give_mana = true
            }
        }

        if(give_mana ) {
            CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, this.mana_gain_pct, true)    
        }
        
        const particle_cast = "particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf"
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin())
        ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, 1, 1))
        ParticleManager.ReleaseParticleIndex(particleId)

        EmitSoundOn("Hero_Nevermore.Shadowraze", this.caster)
        EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster)
    }
}

function modifier_nevermore_special_attack_thinker:GetDelayTime()
    return this.ability.GetSpecialValueFor("delay_time")
}

function modifier_nevermore_special_attack_thinker:GetAOERadius()
    return this.ability.GetSpecialValueFor("radius")
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Thinker(modifier_nevermore_special_attack_thinker)