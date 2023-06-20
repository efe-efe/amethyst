modifier_nevermore_mobility_displacement = class({})

OnCreated(params){
    this.mana_gain_pct = this.ability.GetSpecialValueFor("mana_gain_pct")
    this.fading_slow_duration = this.ability.GetSpecialValueFor("fading_slow_duration")
    this.fading_slow_pct = this.ability.GetSpecialValueFor("fading_slow_pct")
    
    this.counter = 0
    this.damage_table = {
        attacker = this.parent,
        damage = this.ability.GetSpecialValueFor("ability_damage"),
        damage_type = DamageTypes.PURE,
    }

    if(IsServer() ) {
        const particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_desolation_scratch.vpcf"
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin()) 
        ParticleManager.ReleaseParticleIndex(particleId)
    }
}

OnDestroy(){
    if(IsServer() ) {
        this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_TELEPORT_END, 2.0)
        this.PlayEffectsOnDestroy()


    }
}

function modifier_nevermore_mobility_displacement:OnCollide(params)
	if(IsServer() ) {
		if(params.type == UNIT_COLLISION ) {
            for _,unit in pairs(params.units) do
                if(! unit:HasModifier("modifier_nevermore_mobility_hit") ) {
                    this.counter = this.counter + 1
                    this.damage_table.victim = unit
                    
                    ApplyDamage(this.damage_table)
    
                    if(! CustomEntitiesLegacy:IsObstacle(unit) ) {
                        if(! CustomEntitiesLegacy:IsGem(unit) ) {
                            const modifier = this.parent.FindModifierByName('modifier_nevermore_souls')
                            for i = 0, 1 do
                                this.PlayEffectsOnImpact(unit)
                                modifier:IncrementStackCount()
                            }
                        }
                        if(this.counter == 1 ) {
                            if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
                                CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.parent, this.mana_gain_pct, true)
                            }
                        }
                    }
                    
                    unit:AddNewModifier(this.parent, this, "modifier_nevermore_mobility_hit", { duration = 1.0 })
                    unit:AddNewModifier(this.parent, this, "modifier_generic_fading_slow", { 
                        duration = this.fading_slow_duration,
                        maxSlowPct = this.fading_slow_pct
                    })
                }
            }
		}
	}
}

function modifier_nevermore_mobility_displacement:GetCollisionTeamFilter()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
}

function modifier_nevermore_mobility_displacement:GetOnThinkCallback()
    this.PlayEffectsOnDestroy()
}

function modifier_nevermore_mobility_displacement:PlayEffectsOnDestroy()
    const particle_cast = "particles/nevermore/nevermore_mobility.vpcf"
    const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
    ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin())
    ParticleManager.SetParticleControl(particleId, 1, Vector(250, 1, 1))
    ParticleManager.ReleaseParticleIndex(particleId)
}

function modifier_nevermore_mobility_displacement:PlayEffectsOnImpact(target)
    EmitSoundOn("Hero_Nevermore.ProjectileImpact", target)

	const info = {
		Target = this.parent,
		Source = target,
		EffectName = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		iMoveSpeed = 400,
		vSourceLoc= target.GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
}

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS
	}
}

GetOverrideAnimation(){ 		    return GameActivity.DOTA_FLAIL }
function modifier_nevermore_mobility_displacement:GetActivityTranslationModifiers() return "forcestaff_friendly" }

CheckState(){
	return {
        [ModifierState.NO_HEALTH_BAR] = true,
		[ModifierState.INVULNERABLE] = true,
		[ModifierState.OUT_OF_GAME] = true,
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_nevermore_mobility_displacement)
Modifiers.Animation(modifier_nevermore_mobility_displacement)