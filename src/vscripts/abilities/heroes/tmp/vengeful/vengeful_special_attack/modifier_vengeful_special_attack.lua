modifier_vengeful_special_attack = class({})

OnCreated(params){
    if(IsServer() ) {
        this.max_range = this.ability.GetSpecialValueFor("link_range")
        this.extra_damage = this.ability.GetSpecialValueFor("extra_damage")
        this.root_duration = this.ability.GetSpecialValueFor("root_duration")
        this.caster = this.caster
        this.parent = this.parent
        this.damage_table = {
            victim = this.parent,
            attacker = this.caster,
            damage = this.extra_damage,
            damage_type = DamageTypes.PURE,
            ability = this.ability,
        }

        this.efx = EFX("particles/vengeful/vengeful_special_attack.vpcf", ParticleAttachment.CUSTOMORIGIN, this.parent, {
            cp0 = {
                ent = this.caster,
                point = 'attach_hitloc'
            },
            cp1 = {
                ent = this.parent,
                point = 'attach_hitloc'
            },
        })

        this.StartIntervalThink(0.03)
    }
}

function modifier_vengeful_special_attack:OnRefresh(params)
    if(IsServer() ) {
        this.OnTrigger()
    }
}

OnDestroy(){
    if(IsServer() ) {
        ParticleManager.DestroyParticle(this.efx, false)
        ParticleManager.ReleaseParticleIndex(this.efx)

        if(this.GetRemainingTime() < 0.05 ) {
            this.OnTrigger()
        } else { 
            --EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", this.parent)
        }
    }
}

OnIntervalThink(){
    const target_origin = this.caster.GetAbsOrigin()
    const caster_origin = this.parent.GetAbsOrigin()
    const distance = (caster_origin - target_origin):Length2D()

    if(distance > this.max_range ) {
        this.Destroy()
    }
}

function modifier_vengeful_special_attack:OnTrigger()
    ApplyDamage(this.damage_table)
    this.parent.AddNewModifier(this.caster, this.ability , "modifier_generic_stunned", { duration = 0.1 })
    this.parent.AddNewModifier(this.caster, this.ability , "modifier_generic_root", { duration = this.root_duration })

    EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", this.parent)
    EFX("particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
        cp0 = this.parent.GetAbsOrigin(),
        cp3 = this.parent.GetAbsOrigin(),
        release = true
    })

    EFX("particles/vengeful/vengeful_special_attack_trigger.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
        cp0 = this.parent.GetAbsOrigin(),
        cp1 = this.parent.GetAbsOrigin(),
        release = true
    })
}

DeclareFunctions(){
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
}

function modifier_vengeful_special_attack:OnDeath(params)
    if(IsServer() ) { 
        if(params.unit == this.caster ) { 
            this.Destroy()
        }
    }
}

function modifier_vengeful_special_attack:GetStatusLabel() return "Soul Bond" }
function modifier_vengeful_special_attack:GetStatusPriority() return 4 }
function modifier_vengeful_special_attack:GetStatusStyle() return "SoulBond" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Status(modifier_vengeful_special_attack)