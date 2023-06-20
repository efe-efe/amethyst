modifier_nevermore_counter_thinker = class({})

OnCreated(params){
	if(IsServer() ) {
		this.radius = this.ability.GetSpecialValueFor("radius")
		this.fear_duration = this.ability.GetSpecialValueFor("fear_duration")
		this.damage_table = {
			attacker = this.caster,
			damage = this.ability.GetSpecialValueFor("ability_damage"),
			damage_type = DamageTypes.PURE,
		}
		this.PlayEffects()
    }
}

OnDestroy(){
	if(IsServer() ) {
		DEFX(this.particleId, false)
		UTIL_Remove(this.parent)
	}
}

function modifier_nevermore_counter_thinker:OnDelayEnds()
	if(IsServer() ) {
		FindClearSpaceForUnit(this.caster, this.parent.GetAbsOrigin() , true)

		const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
			this.caster,
			this.parent.GetAbsOrigin(), 
			this.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			this.damage_table.victim = enemy
			ApplyDamage(this.damage_table)

			enemy:AddNewModifier(
				this.caster, -- player source
				this.ability, -- ability source
				"modifier_nevermore_counter_fear", -- modifier name
				{ duration = this.fear_duration } -- kv
			)
		}

		this.ability.PlayEffectsFear()
		this.caster.StartGesture(GameActivity.DOTA_RAZE_2)
	}
}

PlayEffects(){
	const origin = this.parent.GetAbsOrigin()
	this.particleId = EFX('particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf', ParticleAttachment.WORLDORIGIN, undefined, {
		cp0 = origin,
		cp1 = origin,
		cp2 = origin,
		cp3 = Vector(this.radius, 0, 0),
	})
}

function modifier_nevermore_counter_thinker:GetDelayTime()
    return this.ability.GetSpecialValueFor("delay_time")
}

function modifier_nevermore_counter_thinker:GetAOERadius()
    return this.ability.GetSpecialValueFor("radius")
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Thinker(modifier_nevermore_counter_thinker)