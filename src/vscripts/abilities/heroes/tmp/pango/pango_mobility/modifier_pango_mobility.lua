modifier_pango_mobility = class({})

OnCreated(){
    this.speed_buff_pct = this.ability.GetSpecialValueFor("speed_buff_pct")
    if(IsServer() ) {
        this.radius = this.ability.GetSpecialValueFor("radius")
        this.parent = this.parent
        this.distance = this.radius * 1.5
        const origin = this.parent.GetAbsOrigin()
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

        EFX("particles/storm/storm_ex_mobility_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0 = origin,
            cp1 = origin + Vector(0, 0, 1000),
            cp2 = origin,
            release = true
        })

        EFX("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            release = true
        })

        this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_RUN, 1.0)
        EmitSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent)
        EmitSoundOn("Hero_Juggernaut.Attack", this.parent)

        this.StartIntervalThink(0.1)
        CustomEntitiesLegacy:DeactivateNonPriorityAbilities(this.parent)
    }
}

OnIntervalThink(){
    CustomEntitiesLegacy:DeactivateNonPriorityAbilities(this.parent)
    const parent_origin = this.parent.GetAbsOrigin()

    ApplyCallbackForUnitsInArea(this.parent, parent_origin, this.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        const direction = (unit:GetAbsOrigin() - parent_origin):Normalized()

        if(! unit:HasModifier("modifier_pango_mobility_displacement") and ! unit:HasModifier("modifier_pango_mobility_marker") ) {
            unit:AddNewModifier(unit, this.ability, "modifier_pango_mobility_displacement", { 
                x = direction.x,
                y = direction.y,
                r = this.distance,
                speed = this.distance/0.3,
                peak = 150,
            })
            unit:AddNewModifier(unit, this.ability, "modifier_pango_mobility_marker", { duration = 1.0 })
            
            this.damage_table.victim = unit
            ApplyDamage(this.damage_table)
            EmitSoundOn("Hero_Pangolier.Gyroshell.Stun", unit)
        }
    })
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

CheckState(){
    return {
        [ModifierState.NO_UNIT_COLLISION] = true,
    }
}

DeclareFunctions(){
	return {
		MODIFIER_EVENT_ON_ORDER,
		ModifierFunction.MOVESPEED_BONUS_PERCENTAGE,
        ModifierFunction.OVERRIDE_ANIMATION,
        ModifierFunction.MODEL_CHANGE,
    }
} 


function modifier_pango_mobility:OnOrder(params)
	if(params.unit == this.parent ) {
		if(params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION ) {
			this.Destroy()
		}
	}
}

function modifier_pango_mobility:GetModifierModelChange()
	return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
}
GetOverrideAnimation(){
	return GameActivity.DOTA_OVERRIDE_ABILITY_4
}

GetModifierMoveSpeedBonus_Percentage(){
    return this.speed_buff_pct
}

function modifier_pango_mobility:GetStatusLabel() return "Rolling Thunder" }
function modifier_pango_mobility:GetStatusPriority() return 4 }
function modifier_pango_mobility:GetStatusStyle() return "RollingThunder" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Animation(modifier_pango_mobility)
Modifiers.Status(modifier_pango_mobility)
Modifiers.MoveForced(modifier_pango_mobility)