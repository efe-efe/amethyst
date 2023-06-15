// spectre_second_attack = class({})
// LinkLuaModifier("modifier_spectre_second_attack_displacement", "abilities/heroes/spectre/spectre_second_attack/modifier_spectre_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

// function spectre_second_attack:GetAnimation()		return GameActivity.DOTA_CAST_ABILITY_1 }
// function spectre_second_attack:GetPlaybackRateOverride()	return 0.25 }
// function spectre_second_attack:GetCastingCrawl() 			return 0 }

// function spectre_second_attack:OnAbilityPhaseStart()
// 	this.PlayEffectsOnPhase()
// 	return true
// }

// function spectre_second_attack:OnAbilityPhaseInterrupted()
// 	DEFX(this.efx, true)
// }

// function spectre_second_attack:OnSpellStart()
// 	if (this.efx){
// 		DEFX(this.efx, false)
// 	}
// 	const this.caster = this.caster
// 	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
//     const origin = this.caster.GetAbsOrigin()
// 	const level = this.GetLevel()

// 	const damage = this.GetSpecialValueFor("ability_damage")
// 	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")

// 	const projectile_direction = Direction2D(origin, point)
// 	const projectile_speed = this.GetSpecialValueFor("projectile_speed")

// 	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
// 		tProjectile = {
// 			EffectName =			"particles/spectre/spectre_second_attack.vpcf",
// 			vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
// 			fDistance = 			this.GetSpecialValueFor("projectile_distance") ~= 0 and this.GetSpecialValueFor("projectile_distance") or this.GetCastRange(Vector(0,0,0), undefined),
// 			fStartRadius =			this.GetSpecialValueFor("hitbox"),
// 			Source = 				this.caster,
// 			vVelocity = 			projectile_direction * projectile_speed,
// 			UnitBehavior = 			PROJECTILES_DESTROY,
// 			WallBehavior = 			PROJECTILES_DESTROY,
// 			TreeBehavior = 			PROJECTILES_NOTHING,
// 			GroundBehavior = 		PROJECTILES_NOTHING,
// 			fGroundOffset = 		0,
// 			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) },
// 			OnUnitHit = function(_self, unit)
// 				const damage_table = {
// 					victim = unit,
// 					attacker = _self.Source,
// 					damage = damage,
// 					damage_type = DAMAGE_TYPE_MAGICAL,
// 				}

// 				const knockback_distance = 75
// 				const fading_slow_duration = 0.5
// 				const fading_slow_pct = 100

// 				if (level >= 2){
// 					knockback_distance = 100
// 					fading_slow_duration = 0.7

// 					EFX('particles/spectre/spectre_second_attack_explosion.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
// 						release = true,
// 					})
// 				else
// 					EFX('particles/spectre/spectre_second_attack_impact.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
// 						cp1 = unit:GetAbsOrigin(),
// 						release = true
// 					})
// 				}

// 				unit:AddNewModifier(
// 					_self.Source, -- player source
// 					this, -- ability source
// 					"modifier_spectre_second_attack_displacement", -- modifier name
// 					{
// 						x = _self:GetVelocity():Normalized().x,
// 						y = _self:GetVelocity():Normalized().y,
// 						r = knockback_distance,
// 						speed = (knockback_distance/0.125),
// 						peak = 0,
// 					}
// 				)

// 				unit:AddNewModifier(_self.Source, this, "modifier_generic_fading_slow", {
// 					duration = fading_slow_duration,
// 					max_slow_pct = fading_slow_pct
// 				})

// 				ApplyDamage(damage_table)

// 				ScreenShake(unit:GetAbsOrigin(), 100, 300, 0.7, 1000, 0, true)
// 				if (CustomEntitiesLegacy:ProvidesMana(unit)){
// 					CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
// 				}
// 			},
// 			OnFinish = function(_self, pos)
// 				if (level >= 2){
// 					const counter = 0
// 					for k, v in pairs(_self.tHitLog) do
// 						counter = counter + 1
// 					}

// 					if (counter == 0){
// 						EFX('particles/spectre/spectre_second_attack_explosion.vpcf', ParticleAttachment.WORLDORIGIN, undefined, {
// 							cp0 = pos,
// 							release = true,
// 						})
// 					}

// 					EmitSoundOnLocationWithCaster(pos, "Hero_Nevermore.Attack", this.caster)
// 				else
// 					this.PlayEffectsOnFinish(pos, level)
// 				}
// 			},
// 		}
// 	})

// 	this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_1, 2.0)
// 	this.PlayEffectsOnCast()
// }

// function spectre_second_attack:PlayEffectsOnPhase()
// 	const this.caster = this.caster
// 	EmitSoundOn("Hero_Spectre.Haunt", this.caster)

// 	this.efx = ParticleManager.CreateParticle('particles/spectre/spectre_second_attack_casting.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
// 	ParticleManager.SetParticleControlEnt(this.efx, 1, this.caster, ParticleAttachment.ABSORIGIN_FOLLOW, 'attach_hitloc', this.caster.GetAbsOrigin(), false)
// }

// function spectre_second_attack:PlayEffectsOnFinish(pos)
// 	const this.caster = this.caster

// 	EmitSoundOnLocationWithCaster(pos, "Hero_Nevermore.RequiemOfSouls.Damage", this.caster)
// 	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', ParticleAttachment.ABSORIGIN, this.caster, {
// 		cp0 = pos,
// 		cp1 = pos,
// 		cp2 = pos,
// 		release = true,
// 	})
// }

// function spectre_second_attack:PlayEffectsOnCast()
// 	EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster)
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_second_attack)

// modifier_spectre_second_attack_displacement = class({})

// function modifier_spectre_second_attack_displacement:DeclareFunctions()
// 	return {
// 		ModifierFunction.OVERRIDE_ANIMATION,
// 		ModifierFunction.OVERRIDE_ANIMATION_RATE,
// 	}
// }

// function modifier_spectre_second_attack_displacement:GetOverrideAnimation() 		return GameActivity.DOTA_FLAIL }
// function modifier_spectre_second_attack_displacement:GetOverrideAnimationRate() 	return 1.0 }

// function modifier_spectre_second_attack_displacement:CheckState()
// 	return {
// 		[ModifierState.NO_UNIT_COLLISION] = true,
// 	}
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Displacement(modifier_spectre_second_attack_displacement)
// Modifiers.Animation(modifier_spectre_second_attack_displacement)
