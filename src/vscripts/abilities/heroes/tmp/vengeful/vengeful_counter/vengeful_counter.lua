vengeful_counter = class({})
vengeful_counter_ultimate = class({})
vengeful_ex_counter = class({})
vengeful_ex_counter_ultimate = class({})

GetAnimation(){			return GameActivity.DOTA_CAST_ABILITY_2 }
GetPlaybackRateOverride(){ 	    return 1.0 }
GetCastingCrawl(){ 				return 0 }
GetCastPoint(){					return 0.3 }
function vengeful_counter:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_counter:GetAbilityTextureName()			return this.GetName() }
GetCooldown(level: number){				return 8 }
function vengeful_counter:GetCastRange(vLocation, target)	return 1200 }

function vengeful_counter:IsMimicable()
    return true
}

OnSpellStart(){
	
	const damage = this.GetSpecialValueFor("ability_damage")
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const origin = this.caster.GetAbsOrigin()
	const projectile_direction = direction2D(origin, point)
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")

	this.ThrowProjectile(this.caster, damage, origin, projectile_direction, projectile_speed, true)
	this.PlayEffectsOnCast()
	LinkAbilityCooldowns(this.caster, 'vengeful_ex_counter')
}

function vengeful_counter:ThrowProjectile(hCaster, iDamage, vOrigin, vDirection, fSpeed, bReturn)
	const ability = hCaster:FindAbilityByName("vengeful_counter")
	const mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	const duration = ability:GetSpecialValueFor("duration")

	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
		tProjectile = {
			EffectName = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
			vSpawnOrigin = vOrigin + Vector(vDirection.x * 45, vDirection.y * 45, 96),
			fDistance = ability:GetCastRange(Vector(0,0,0), undefined),
			fStartRadius = ability:GetSpecialValueFor("hitbox"),
			Source = hCaster,
			vVelocity = vDirection * fSpeed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			bIsReflectable = false,
			bIsDestructible = false,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
			OnUnitHit = function(_self, unit)
				const damage_table = {
					victim = unit,
					attacker = hCaster,
					damage = iDamage,
					damage_type = DamageTypes.MAGICAL,
					ability = ability,
				}
				ApplyDamage(damage_table)
				if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(hCaster, mana_gain_pct, true)
				}
			},
			OnFinish = function(_self, position)
				ability:PlayEffectsOnFinish(position: Vector)
				if(bReturn ) {
					const origin = hCaster:GetAbsOrigin()
					const projectile_direction = (Vector(origin.x-position.x, origin.y-position.y, 0)):Normalized()
					ability:ThrowProjectile(hCaster, 10, position, projectile_direction, fSpeed * 1.25 , false)
				}
			},
		}
	})
}

PlayEffectsOnFinish(position: Vector){
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster)
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster)
	
	const particle_cast = "particles/storm/storm_basic_attack_explosion.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, position)
	ParticleManager.SetParticleControl(particleId, 3, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", this.caster)
}

GetAnimation(){			return GameActivity.DOTA_CAST_ABILITY_2 }
GetPlaybackRateOverride(){ 	    	return 1.0 }
GetCastingCrawl(){ 				return 0 }
GetCastPoint(){						return 0.3 }
function vengeful_ex_counter:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_ex_counter:GetAbilityTextureName()			return this.GetName() }
GetCooldown(level: number){				return 8 }
function vengeful_ex_counter:GetCastRange(vLocation, target)	return 2500 }
function vengeful_ex_counter:GetManaCost()						return 25 }

function vengeful_ex_counter:IsMimicable()
    return true
}

OnSpellStart(){
	
    const origin = this.caster.GetAbsOrigin()
	const damage = this.GetSpecialValueFor("ability_damage")
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
	const projectile_direction = direction2D(origin, point)
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	
	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
		bTriggerCounters = false,
		tProjectile = {
			EffectName = "particles/econ/items/vengeful/vengeful_weapon_talon/vengeful_wave_of_terror_weapon_talon.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = this.GetCastRange(Vector(0,0,0), undefined),
			fStartRadius = this.GetSpecialValueFor("hitbox"),
			Source = this.caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			bIsReflectable = false,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
			OnUnitHit = function(_self, unit)
				const damage_table = {
					victim = unit,
					attacker = this.caster,
					damage = damage,
					damage_type = DamageTypes.MAGICAL,
					ability = this,
				}
				ApplyDamage(damage_table)
			},
			OnFinish = function(_self, position)
				this.PlayEffectsOnFinish(position: Vector)
			},
		}
	})

	this.PlayEffectsOnCast()
	LinkAbilityCooldowns(this.caster, 'vengeful_counter')
}

PlayEffectsOnFinish(position: Vector){
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster)
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster)
	
	const particle_cast = "particles/storm/storm_basic_attack_explosion.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, position)
	ParticleManager.SetParticleControl(particleId, 3, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", this.caster)
}


function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    }

    hAbility.IsMimicable = function() return false }
    hAbility.GetManaCost = function() return 0 }
    hAbility.GetEnergyCost = function() return iEnergyCost }
}

MimicSpell(vengeful_counter_ultimate, vengeful_counter, 25)
MimicSpell(vengeful_ex_counter_ultimate, vengeful_ex_counter, 25)

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(vengeful_counter)
Abilities.Castpoint(vengeful_counter_ultimate)
Abilities.Castpoint(vengeful_ex_counter)
Abilities.Castpoint(vengeful_ex_counter_ultimate)