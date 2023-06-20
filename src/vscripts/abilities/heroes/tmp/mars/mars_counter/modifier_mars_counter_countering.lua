modifier_mars_counter_countering = class({})

OnCreated(params){
    if(IsServer() ) {
        this.meele_damage = this.ability.GetSpecialValueFor('meele_damage')
        
		this.effects_cast_weapon = {}
        this.parent.StartGesture(GameActivity.DOTA_OVERRIDE_ABILITY_3)

        this.StartIntervalThink(0.03)
    }
}

OnDestroy(){
    if(IsServer() ) {
        this.StopEffects()

        const particleId = ParticleManager.CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
        ParticleManager.ReleaseParticleIndex(particleId)
    }
}

OnIntervalThink(){
    const mouse = CustomAbilitiesLegacy:GetCursorPosition(this.ability)
	const direction = (mouse - this.parent.GetAbsOrigin()):Normalized()
    this.PlayEffectsOnCast()

	CustomEntitiesLegacy:FullyFaceTowards(this.parent, Vector(direction.x, direction.y, this.parent.GetForwardVector().z))
}

function modifier_mars_counter_countering:OnTrigger(params)   
    if(IsServer() ) {
        this.PlayEffectsOnTrigger()
    }
}


DeclareFunctions(){
    return {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS
    }
}

function modifier_mars_counter_countering:GetActivityTranslationModifiers(params)
    return "bulwark"
}

function modifier_mars_counter_countering:OnAbilityExecuted(params)
    if(IsServer() ) {
        if(params.unit ~= this.parent ) {
            return
        }

        this.Destroy()
    }
}

function modifier_mars_counter_countering:GetModifierIncomingDamage_Percentage(params)
    if(IsServer() ) {
        if(params.damage_type ~= DamageTypes.PURE ) {
            const direction =  this.parent.GetAbsOrigin() - params.attacker:GetAbsOrigin()
            const projection = direction.x * this.parent.GetForwardVector().x + direction.y * this.parent.GetForwardVector().y
            
            if(projection <= -0.8 ) {
                params.attacker:AddNewModifier(this.parent, this.ability, 'modifier_mars_counter_displacement', {
                    x = direction.x * -1,
                    y = direction.y * -1,
                    r = 300,
                    speed = 150/0.1,
                    peak = 50,
                })
                    
                const damage_table = {
                    victim = params.attacker,
                    attacker = this.parent,
                    damage = this.meele_damage,
                    damage_type = DamageTypes.PURE,
                }
                ApplyDamage(damage_table)

                this.PlayEffectsMeele(params.attacker)
                this.OnTrigger(params)
                return -100
            }
        }
        return 0
    }
}

function modifier_mars_counter_countering:PlayEffectsMeele(target)
    const efx = EFX("particles/mars/mars_second_attack_light.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {})

    ParticleManager.SetParticleControlEnt(
        efx, 
        1, 
        target, 
        ParticleAttachment.POINT_FOLLOW, 
        "attach_hitloc", 
        target.GetAbsOrigin(), 
        true 
    )
    ParticleManager.ReleaseParticleIndex(efx)
}

function modifier_mars_counter_countering:OnOrder(params)
    if(params.unit == this.parent ) {
        if( params.order_type == DOTA_UNIT_ORDER_STOP or 
            params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION
        ) {
            this.Destroy()
        }
    }
}

function modifier_mars_counter_countering:StopEffects()
	for _,efx in pairs(this.effects_cast_weapon) do
		if(efx ~= undefined ) {
			ParticleManager.DestroyParticle(efx, false)
			ParticleManager.ReleaseParticleIndex(efx)
		}
    }
}

PlayEffectsOnCast(){
	const particleId =  ParticleManager.CreateParticle("particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
	ParticleManager.SetParticleControlForward(particleId, 0, this.parent.GetForwardVector())
	ParticleManager.ReleaseParticleIndex(particleId)
}

function modifier_mars_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("Hero_Mars.Shield.Block", this.parent)
    EmitSoundOn("Hero_Mars.Block_Projectile", this.parent)
    
	const particleId =  ParticleManager.CreateParticle("particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
	ParticleManager.SetParticleControlForward(particleId, 0, this.parent.GetForwardVector())
	ParticleManager.ReleaseParticleIndex(particleId)
}

function modifier_mars_counter_countering:GetStatusEffectName()
    return "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2_dire.vpcf"
}

GetMovementSpeedPercentage(){ return 50 }
function modifier_mars_counter_countering:UseDefaultVisuals() return false }
function modifier_mars_counter_countering:GetTranslation() return "bulwark" }

function modifier_mars_counter_countering:OnProjectileHitCustom(params)
	if(IsServer() ) {
		const projectile = params.hProjectile
		
        if(projectile.bIsReflectable == true ) {
            const direction = projectile:GetVelocity():Normalized() 
            const projection = direction.x * this.parent.GetForwardVector().x + direction.y * this.parent.GetForwardVector().y

            if(projection <= -0.8 ) {
                projectile:SetVelocity(this.parent.GetForwardVector() * projectile:GetVelocity():Length2D(), projectile:GetPosition())
                projectile:SetSource(this.parent)
                projectile:SetVisionTeam(this.parent.GetTeam())
                projectile:ResetDistanceTraveled()
                projectile:ResetRehit()
                this.OnTrigger({})
                return false
            }
		}

		return true
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Counter(modifier_mars_counter_countering)
Modifiers.OnProjectileHit(modifier_mars_counter_countering)