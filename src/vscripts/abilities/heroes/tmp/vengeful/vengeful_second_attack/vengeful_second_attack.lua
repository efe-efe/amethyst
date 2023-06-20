vengeful_second_attack = class({})
vengeful_second_attack_ultimate = class({})
vengeful_ex_second_attack = class({})
vengeful_ex_second_attack_ultimate = class({})
LinkLuaModifier("modifier_vengeful_second_attack", "abilities/heroes/vengeful/vengeful_second_attack/modifier_vengeful_second_attack", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){			return GameActivity.DOTA_SPAWN }
GetPlaybackRateOverride(){			return 2.0 }
GetCastingCrawl(){					return 80 }
GetCastPoint(){						return 0.5 }
function vengeful_second_attack:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_second_attack:GetAbilityTextureName()				return this.GetName() }
GetCooldown(level: number){					return 8 }
function vengeful_second_attack:GetCastRange(vLocation, target)	return 850 }

OnAbilityPhaseStart(){
	this.PlayEffectsOnPhase()
	return true
}

OnAbilityPhaseInterrupted(){
	DEFX(this.efx, true)
}

function vengeful_second_attack:IsMimicable()
    return true
}

OnSpellStart(){
	if(this.efx ) {
		DEFX(this.efx, false)
	}
	this.ThrowProjectile()
	this.PlayEffectsOnCast()
	LinkAbilityCooldowns(this.caster, 'vengeful_ex_second_attack')
}

function vengeful_second_attack:ThrowProjectile(bIsBasicAttack)
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const origin = this.caster.GetAbsOrigin()
	const damage = this.GetSpecialValueFor("ability_damage")
	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	const duration = this.GetSpecialValueFor("duration")
	
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_direction = direction2D(origin, point)

	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
		bIsBasicAttack = bIsBasicAttack,
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_second_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = this.GetSpecialValueFor("projectile_distance") ~= 0 and this.GetSpecialValueFor("projectile_distance") or this.GetCastRange(Vector(0,0,0), undefined),
			fStartRadius = this.GetSpecialValueFor("hitbox"),
			Source = this.caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
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

				unit:AddNewModifier(_self.Source, this, "modifier_vengeful_second_attack", { duration = duration })

				if(_self.Source == this.caster ) {
					if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
					}
				}
			},
			OnFinish = function(_self, position)
				this.PlayEffectsOnFinish(position: Vector)
			},
		}
	})
}


function vengeful_second_attack:PlayEffectsOnPhase()
	
	this.efx = EFX('particles/spectre/spectre_second_attack_casting.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
		cp1 = {
			ent = this.caster,
			point = 'attach_hitloc'
		},
	})
}

PlayEffectsOnFinish(position: Vector){
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster)
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster)
	
	const particle_cast = "particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, position)
	ParticleManager.SetParticleControl(particleId, 3, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_VengefulSpirit.MagicMissile", this.caster)
}

GetAnimation(){				return GameActivity.DOTA_SPAWN }
GetPlaybackRateOverride(){ 	    	return 2.0 }
GetCastingCrawl(){ 					return 80 }
GetCastPoint(){ 	                    return 0.5 }
function vengeful_ex_second_attack:GetBehavior()                        return DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_ex_second_attack:GetAbilityTextureName()              return this.GetName() }
GetCooldown(level: number){                  return 8 }
function vengeful_ex_second_attack:GetCastRange(vLocation, target)     return 1600 }
function vengeful_ex_second_attack:GetManaCost()						return 25 }

OnAbilityPhaseStart(){
	this.PlayEffectsOnPhase()
	return true
}

OnAbilityPhaseInterrupted(){
	DEFX(this.efx, true)
}

function vengeful_ex_second_attack:IsMimicable()
    return true
}

OnSpellStart(){
	if(this.efx ) {
		DEFX(this.efx, false)
	}
	
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const origin = this.caster.GetAbsOrigin()
	const damage = this.GetSpecialValueFor("ability_damage")
	const heal = this.GetSpecialValueFor("heal")
	
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_direction = direction2D(origin, point)
	const damage_table = {
		damage = damage,
		damage_type = DamageTypes.MAGICAL,
		ability = this,
	}

	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_ex_second_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = this.GetSpecialValueFor("projectile_distance") ~= 0 and this.GetSpecialValueFor("projectile_distance") or this.GetCastRange(Vector(0,0,0), undefined),
			fStartRadius = this.GetSpecialValueFor("hitbox"),
			Source = this.caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
			OnUnitHit = function(_self, unit) 
				if(CustomEntitiesLegacy:Allies(_self.Source, unit) ) {
					unit:Heal(heal, _self.Source)
				} else { 
					damage_table.victim = unit
					damage_table.attacker = _self.Source

					const unit_origin = unit:GetAbsOrigin()
					const source_origin = _self.Source:GetAbsOrigin()
					
					FindClearSpaceForUnit(_self.Source, unit_origin , true)
					FindClearSpaceForUnit(unit, source_origin , true)

					this.PlayEffectsSwap(unit)
					ApplyDamage(damage_table)
				}

				_self.Source:Heal(heal, _self.Source)
			},
			OnFinish = function(_self, position)
				this.PlayEffectsOnFinish(position: Vector)
			},
		}
	})

	LinkAbilityCooldowns(this.caster, 'vengeful_second_attack')
	EmitSoundOn("Hero_Chen.Attack", this.caster)
	EmitSoundOn("Hero_Chen.HolyPersuasionEnemy", this.caster)
}

function vengeful_ex_second_attack:PlayEffectsSwap(target)
	
	EFX("particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", ParticleAttachment.CUSTOMORIGIN, undefined, {
		cp0 = {
			ent = this.caster,
			point = 'attach_hitloc'
		},
		cp1 = {
			ent = target,
			point = 'attach_hitloc'
		},
		release = true
	})

    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", this.caster)
    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", target)
}

function vengeful_ex_second_attack:PlayEffectsOnPhase()
	
	this.efx = EFX('particles/spectre/spectre_second_attack_casting.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
		cp1 = {
			ent = this.caster,
			point = 'attach_hitloc'
		},
	})
}

PlayEffectsOnFinish(position: Vector){
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster)
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster)
	
	const particle_cast = "particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
	ParticleManager.SetParticleControl(particleId, 0, position)
	ParticleManager.SetParticleControl(particleId, 3, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    }

    hAbility.IsMimicable = function() return false }
    hAbility.GetManaCost = function() return 0 }
    hAbility.GetEnergyCost = function() return iEnergyCost }
}

MimicSpell(vengeful_second_attack_ultimate, vengeful_second_attack, 25)
MimicSpell(vengeful_ex_second_attack_ultimate, vengeful_ex_second_attack, 25)

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(vengeful_second_attack)
Abilities.Castpoint(vengeful_second_attack_ultimate)
Abilities.Castpoint(vengeful_ex_second_attack)
Abilities.Castpoint(vengeful_ex_second_attack_ultimate)