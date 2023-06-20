mars_special_attack = class({})
LinkLuaModifier("modifier_mars_special_attack_displacement", "abilities/heroes/mars/mars_special_attack/modifier_mars_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_CAST_ABILITY_5 }
GetPlaybackRateOverride(){ 	    return 0.9 }
GetCastingCrawl(){ 			return 0 }

OnSpellStart(){
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const origin = this.caster.GetAbsOrigin()
	const damage = this.GetSpecialValueFor("ability_damage")
	const fading_slow_pct = this.GetSpecialValueFor("fading_slow_pct")
	const fading_slow_duration = this.GetSpecialValueFor("fading_slow_duration")
	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	const damage_per_stack = this.GetSpecialValueFor("damage_per_stack")

	const stacks = CustomEntitiesLegacy:SafeGetModifierStacks(this.caster, "modifier_mars_basic_attack_stacks")
	const final_damage = damage + (stacks * damage_per_stack)

	const projectile_particle = "particles/units/heroes/hero_mars/mars_spear.vpcf"
	const projectile_direction = direction2D(origin, point)
	const projectile_origin = this.caster.GetAbsOrigin() + projectile_direction * 80 + Vector(0,0,80)
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_hitbox = this.GetSpecialValueFor("hitbox")
	const projectile_distance = this.GetCastRange(Vector(0,0,0), undefined)

	const projectile = {
		EffectName = projectile_particle,
		vSpawnOrigin = projectile_origin,
		fDistance = projectile_distance,
		fStartRadius = projectile_hitbox,
		Source = this.caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_DESTROY,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
		OnUnitHit = function(_self, unit)
			const counter = 0
			for k, v in pairs(_self.tHitLog) do counter = counter + 1 }
			if(counter > 1 ) { return }
			
			const damage_table = {
				victim = unit,
				attacker = this.caster,
				damage = final_damage,
				damage_type = DamageTypes.MAGICAL,
			}
			ApplyDamage(damage_table)

			const current_direction = _self.current_velocity:Normalized()
			const left_distance = _self.fDistance - _self.distanceTraveled

			unit:AddNewModifier(_self.Source, this, "modifier_mars_special_attack_displacement", { 
				x = current_direction.x,
				y = current_direction.y,
				r = left_distance,
				speed = projectile_speed,
				peak = 1,
			})

			if(_self.Source == this.caster ) {
				if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
				}
			}
		},
		OnFinish = function(_self, position)
			this.PlayEffectsOnFinish(position, _self.current_velocity:Normalized())
		},
	}

    ExecuteOrderFromTable({ OrderType = DOTA_UNIT_ORDER_STOP, UnitIndex = this.caster.entindex() })
	ProjectilesManagerInstance:CreateProjectile(projectile)
	CustomEntitiesLegacy:SafeDestroyModifier(this.caster, "modifier_mars_basic_attack_stacks")

	this.PlayEffectsOnCast()
}

function mars_special_attack:PlayEffectsOnFinish(position, direction)
	EmitSoundOnLocationWithCaster(position, "Hero_Mars.Spear.Target", this.caster)
	
	const particle_cast = "particles/units/heroes/hero_mars/mars_spear_end.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, position)
    ParticleManager.SetParticleControl(particleId, 3, position)
    ParticleManager.SetParticleControlForward(particleId, 3, direction)
	ParticleManager.ReleaseParticleIndex(particleId)
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_Mars.Spear.Cast", this.caster)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(mars_special_attack)