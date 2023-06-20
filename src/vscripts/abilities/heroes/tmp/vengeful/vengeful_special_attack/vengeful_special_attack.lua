vengeful_special_attack = class({})
vengeful_special_attack_ultimate = class({})
LinkLuaModifier("modifier_vengeful_special_attack", "abilities/heroes/vengeful/vengeful_special_attack/modifier_vengeful_special_attack", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_ATTACK }
GetPlaybackRateOverride(){ 	    return 1.2 }
GetCastingCrawl(){ 			return 10 }
GetCastPoint(){ 	                    return 0.3 }
function vengeful_special_attack:GetBehavior()                        return DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_special_attack:GetAbilityTextureName()              return this.GetName() }
GetCooldown(level: number){                  return 8 }
function vengeful_special_attack:GetCastRange(vLocation, target)     return 800 }

function vengeful_special_attack:IsMimicable()
    return true
}

OnSpellStart(){
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const origin = this.caster.GetAbsOrigin()
	const damage = this.GetSpecialValueFor("ability_damage")
	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	const duration = this.GetSpecialValueFor("link_duration")
	
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_direction = direction2D(origin, point)

	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_special_attack_proj.vpcf",
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
				
				unit:AddNewModifier(_self.Source, this, "modifier_vengeful_special_attack", { duration = duration })

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

	this.PlayEffectsOnCast()
}

PlayEffectsOnFinish(position: Vector){
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster)
	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster)
	
	EFX("particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
		cp0 = position,
		cp1 = position,
		cp3 = position,
		release = true
	})
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_StormSpirit.Attack", this.caster)
}

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    }

    hAbility.IsMimicable = function() return false }
    hAbility.GetManaCost = function() return 0 }
    hAbility.GetEnergyCost = function() return iEnergyCost }
}

MimicSpell(vengeful_special_attack_ultimate, vengeful_special_attack, 25)

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(vengeful_special_attack)
Abilities.Castpoint(vengeful_special_attack_ultimate)