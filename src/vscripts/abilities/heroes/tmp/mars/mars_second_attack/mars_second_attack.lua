mars_second_attack = class({})
mars_ex_second_attack = class({})
LinkLuaModifier("modifier_mars_second_attack_displacement", "abilities/heroes/mars/mars_second_attack/modifier_mars_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_mars_ex_second_attack_displacement", "abilities/heroes/mars/mars_second_attack/modifier_mars_ex_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_CAST_ABILITY_4 }
GetPlaybackRateOverride(){ 	    return 1.0 }
GetCastingCrawl(){ 			return 80 }
function mars_second_attack:GetFadeGestureOnCast()		return false }

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), this.GetCastRange(Vector(0,0,0), undefined))
	const direction = (point - origin):Normalized()
	const radius = this.GetSpecialValueFor("radius")
	const multiplier = this.GetSpecialValueFor("multiplier")
	const damage = this.caster.GetAverageTrueAttackDamage(this.caster) * multiplier

	const knockback_distance = this.GetSpecialValueFor("knockback_distance")
	direction.z = 0

	const enemies = CustomEntitiesLegacy:FindUnitsInCone(
		this.caster,
		direction, 
		0.0, 
		origin, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)

	for _,enemy in pairs(enemies) do 
		const damage_table = {
			victim = enemy,
			attacker = this.caster,
			damage = damage,
			damage_type = DamageTypes.MAGICAL,
		}
		ApplyDamage(damage_table)

		enemy:AddNewModifier(this.caster, this, "modifier_mars_second_attack_displacement", { 
			x = direction.x,
			y = direction.y,
			r = knockback_distance,
			speed = (knockback_distance)/0.25,
			peak = 100,
		})
	}

	this.PlayEffectsCone(direction, radius, undefined, 'particles/units/heroes/hero_mars/mars_shield_bash.vpcf')
	LinkAbilityCooldowns(this.caster, 'mars_ex_second_attack')
}

function mars_second_attack:PlayEffectsCone(direction, radius, color, particle_cast)
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, this.caster)
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
	ParticleManager.SetParticleControl(particleId, 1, Vector(radius, radius, radius))

	if(color ) {
		ParticleManager.SetParticleControl(particleId, 60, color)
		ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0))
	}

	ParticleManager.SetParticleControlForward(particleId, 0, direction)
	ParticleManager.ReleaseParticleIndex(particleId)

	EmitSoundOnLocationWithCaster(this.caster.GetAbsOrigin(), "Hero_Mars.Shield.Cast", this.caster)
}

mars_ex_second_attack.GetCastAnimationCustom = mars_second_attack.GetCastAnimationCustom
mars_ex_second_attack.GetPlaybackRateOverride = mars_second_attack.GetPlaybackRateOverride
mars_ex_second_attack.GetCastPointSpeed = mars_second_attack.GetCastPointSpeed
mars_ex_second_attack.GetFadeGestureOnCast = mars_second_attack.GetFadeGestureOnCast
mars_ex_second_attack.PlayEffectsCone = mars_second_attack.PlayEffectsCone

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), this.GetCastRange(Vector(0,0,0), undefined))
	const direction = (point - origin):Normalized()
	const radius = this.GetSpecialValueFor("radius")
	const damage = this.GetSpecialValueFor("ability_damage")
	const knockback_distance = this.GetSpecialValueFor("knockback_distance")
	direction.z = 0

	const enemies = CustomEntitiesLegacy:FindUnitsInCone(
		this.caster,
		direction, 
		0.0, 
		origin, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)
	
	for _,enemy in pairs(enemies) do 
		const damage_table = {
			victim = enemy,
			attacker = this.caster,
			damage = damage,
			damage_type = DamageTypes.MAGICAL,
		}
		ApplyDamage(damage_table)

		const m_direction = (enemy:GetAbsOrigin() - origin):Normalized()
		const left_distance = radius - (enemy:GetAbsOrigin() - origin):Length2D()

		enemy:AddNewModifier(this.caster, this, "modifier_mars_ex_second_attack_displacement", { 
			x = m_direction.x,
			y = m_direction.y,
			r = left_distance + knockback_distance,
			speed = (left_distance + knockback_distance)/0.25,
			peak = 100,
		})
	}

    this.PlayEffectsCone(direction, radius, Vector(244, 49, 255), 'particles/econ/items/mars/mars_fall20_immortal_shield/mars_fall20_immortal_shield_bash.vpcf')
	LinkAbilityCooldowns(this.caster, 'mars_second_attack')
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(mars_second_attack)
Abilities.Castpoint(mars_ex_second_attack)
