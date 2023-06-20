pango_special_attack = class({})
LinkLuaModifier("modifier_pango_special_attack_displacement", "abilities/heroes/pango/pango_special_attack/modifier_pango_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)


GetAnimation(){		return GameActivity.DOTA_FORCESTAFF_END }
GetPlaybackRateOverride(){ 	    return 0.5 }

GetCastingCrawl(){
    return 20
}

function pango_special_attack:GetCastRange(vLocation, target)
    if(this.caster.HasModifier("modifier_pango_mobility") ) {
        return this.BaseClass.GetCastRange(this, vLocation, target) * 1.2
    }
    return this.BaseClass.GetCastRange(this, vLocation, target)
}

GetCastPoint(){
    if(this.caster.HasModifier("modifier_pango_mobility") ) {
        return 0.0
    }
    return super.GetCastPoint()
}


function pango_special_attack:HasPriority()
    return true
}

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)

	const direction = (point - origin):Normalized()
    const distance = this.GetCastRange(Vector(0,0,0), undefined)
    const air_time = 0.4

    const modifier_pango_mobility = CustomEntitiesLegacy:SafeGetModifier(this.caster, "modifier_pango_mobility")
    if(modifier_pango_mobility ) {
        modifier_pango_mobility:SetDuration(modifier_pango_mobility:GetRemainingTime() + air_time, true)
        direction = CustomEntitiesLegacy:GetDirection(this.caster)
    }

    this.caster.AddNewModifier(
        this.caster, -- player source
        this, -- ability source
        "modifier_pango_special_attack_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/air_time,
            peak = 250,
        }
    )

    EmitSoundOn("Hero_Pangolier.TailThump.Cast", this.caster)
}

function pango_special_attack:Crash(iRadius)
    
    const origin = this.caster.GetAbsOrigin()
    const damage_block = this.GetSpecialValueFor("damage_block")
    const shield_duration = this.GetSpecialValueFor("duration")
    const shield_providers = 0
    const damage_table = {
        attacker = this.caster,
        damage = this.GetSpecialValueFor("ability_damage"),
        damage_type = DamageTypes.PURE,
    }
	ApplyCallbackForUnitsInArea(this.caster, origin, iRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
		damage_table.victim = unit
		ApplyDamage(damage_table)

		if(! CustomEntitiesLegacy:IsObstacle(unit) ) {
			shield_providers = shield_providers + 1
		}
	})

	if(shield_providers ~= 0 ) {
		this.caster.AddNewModifier(this.caster, this, "modifier_shield", { duration = shield_duration, damage_block = damage_block * shield_providers })
	}

	EFX("particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
		cp0 = origin
	})
	CreateRadiusMarker(this.caster, origin, iRadius, RADIUS_SCOPE_PUBLIC, 0.1)
	EmitSoundOn("Hero_Pangolier.TailThump", this.caster)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(pango_special_attack)