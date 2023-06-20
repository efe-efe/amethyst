modifier_pango_ultimate_displacement = class({})

OnCreated(){
    if(IsServer() ) {
        this.parent = this.parent
        this.bounces = 5
        this.distance = 250
        this.damage_table = {
            attacker = this.parent,
            damage = this.ability.GetSpecialValueFor("ability_damage"),
            damage_type = DamageTypes.PURE,
        }

		this.efx = EFX("particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", ParticleAttachment.CUSTOMORIGIN, this.parent, {
            cp0 = {
                ent = this.parent,
                point = 'attach_hitloc'
            }
        })

        EFX("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            release = true
        })

        this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_RUN, 1.0)
        EmitSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent)
    }
}

OnDestroy(){
	if(IsServer() ) {
        ParticleManager.DestroyParticle(this.efx, false)
		ParticleManager.ReleaseParticleIndex(this.efx)
        StopSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent)
        this.parent.RemoveGesture(GameActivity.DOTA_RUN)
        this.parent.AddNewModifier(this.parent, this.ability, "modifier_pango_roll_end_animation", { duration = 0.3 })
        CustomEntitiesLegacy:SetAllAbilitiesActivated(this.parent, true)
	}
}


function modifier_pango_ultimate_displacement:OnCollide(params)
    if(IsServer() ) {
        if(params.type == UNIT_COLLISION ) {
            const parent_origin = this.parent.GetAbsOrigin()

            for _,unit in pairs(params.units) do
                const direction = (unit:GetAbsOrigin() - parent_origin):Normalized()

                if(! unit:HasModifier("modifier_pango_mobility_displacement_enemy") ) {
                    unit:AddNewModifier(unit, this.ability, "modifier_pango_mobility_displacement_enemy", { 
                        x = direction.x,
                        y = direction.y,
                        r = this.distance,
                        speed = this.distance/0.4,
                        peak = 150,
                    })
                    
                    this.damage_table.victim = unit
                    ApplyDamage(this.damage_table)
                    EmitSoundOn("Hero_Pangolier.Gyroshell.Stun", unit)
                }
			}
        }

        if(params.type == WALL_COLLISION ) {
            EmitSoundOn("Hero_Pangolier.Gyroshell.Carom", this.parent)
            if(this.origin == this.prev_origin ) {
                this.parent.SetAbsOrigin(this.origin + this.direction * 200)
            } 
            this.distance =         this.distance
            this.speed =            this.speed * 0.75
            this.peak =             this.peak
            this.direction =        Vector(this.direction.x * (-1), this.direction.y * (-1), this.direction.z)
            
            this.origin =           this.parent.GetAbsOrigin()         
            this.prev_origin =      undefined
    
            this.hVelocity =        this.speed
            this.vVelocity =        (-0.5) * this.gravity * this.duration
    
            this.elapsed_time =      0
            this.motion_tick =       {}
            this.motion_tick[0] =    0
            this.motion_tick[1] =    0
            this.motion_tick[2] =    0
            
            this.bounces = this.bounces - 1

            if(this.bounces <= 0 ) {
                this.Destroy()
            }
		}
	}
}

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
        ModifierFunction.MODEL_CHANGE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_OVERRIDE_ABILITY_4 }
GetOverrideAnimationRate(){ 	return 1.5 }

CheckState(){
	return {
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}

function modifier_pango_ultimate_displacement:GetModifierModelChange()
	return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
}

function modifier_pango_ultimate_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_pango_ultimate_displacement)
Modifiers.Animation(modifier_pango_ultimate_displacement)