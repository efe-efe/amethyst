// spectre_mobility = class({})
// spectre_ex_mobility = class({})

// LinkLuaModifier("modifier_spectre_banish", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_banish", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_mobility_charges", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_charges", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_mobility_thinker", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_thinker", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ex_mobility_fear", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_ex_mobility_fear", LUA_MODIFIER_MOTION_NONE)

// function spectre_mobility:GetIntrinsicModifierName(){
// 	return "modifier_spectre_mobility_charges"
// }

// function spectre_mobility:GetCooldown()
// 	if (this.caster.HasModifier("modifier_spectre_ultimate")){
// 		if (this.caster.FindModifierByName("modifier_spectre_ultimate"):GetCaster() == this.caster){
// 			return 1.0
// 		else
// 			return this.BaseClass.GetCooldown(this, this.GetLevel())
// 		}
// 	else
// 		return this.BaseClass.GetCooldown(this, this.GetLevel())
// 	}
// }

// function spectre_mobility:OnSpellStart()
// 	const this.caster = this.caster
// 	const origin = this.caster.GetAbsOrigin()
// 	const min_range = this.GetSpecialValueFor("min_range")
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), min_range)
// 	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
// 	const damage = this.GetSpecialValueFor("ability_damage")
// 	const cooldown_reduction = this.GetSpecialValueFor("cooldown_reduction")
// 	this.radius = this.GetSpecialValueFor("radius")

// 	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
// 	const projectile_direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
// 	const projetile_distance = (point - origin):Length2D()

// 	const projectile = {
// 		EffectName = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
// 		vSpawnOrigin = origin + Vector(0,0,80),
// 		fDistance = projetile_distance,
// 		fStartRadius = this.GetSpecialValueFor("hitbox"),
// 		Source = this.caster,
// 		vVelocity = projectile_direction * projectile_speed,
// 		UnitBehavior = PROJECTILES_NOTHING,
// 		TreeBehavior = PROJECTILES_NOTHING,
// 		WallBehavior = PROJECTILES_NOTHING,
//         GroundBehavior = PROJECTILES_NOTHING,
//         bIsReflectable = false,
//         bIsSlowable = false,
// 		fGroundOffset = 0,
// 		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"  and not CustomEntitiesLegacy:Allies(_self.Source, unit) },
// 		OnFinish = function(_self, pos)
// 			const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
// 			this.caster,
// 				pos,
// 				this.radius,
// 				DOTA_UNIT_TARGET_TEAM_ENEMY,
// 				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
// 				DOTA_UNIT_TARGET_FLAG_NONE,
// 				FIND_ANY_ORDER
// 			)

// 			const charge = false

// 			for _, enemy in pairs(enemies) do
// 				if (not CustomEntitiesLegacy:IsObstacle(enemy)){
// 					charge = true
// 				}

// 				const damage_table = {
// 					victim = enemy,
// 					attacker = _self.Source,
// 					damage = damage,
// 					damage_type = DAMAGE_TYPE_PURE,
// 					ability = this
// 				}
// 				ApplyDamage(damage_table)
// 			}

// 			-- if (at least 1 enemy
// 			if (charge == true){
// 				const modifier = this.caster.FindModifierByName("modifier_spectre_basic_attack_cooldown"):ReduceCooldown(cooldown_reduction)

// 				if (#enemies == 1){
// 					if (CustomEntitiesLegacy:ProvidesMana(enemies[1])){
// 						CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
// 					}
// 				else
// 					CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
// 				}
// 			}
//             this.PlayEffectsOnFinish(pos)
//             CustomEntitiesLegacy:SafeDestroyModifier(this.caster, "modifier_spectre_banish")
//             FindClearSpaceForUnit(this.caster, pos , true)
// 		},
// 	}

// 	ProjectilesManagerInstance:CreateProjectile(projectile)
// 	this.PlayEffectsOnCast()
// 	this.caster.AddNewModifier(this.caster, this, "modifier_spectre_banish", { duration = projetile_distance/projectile_speed })
// }

// function spectre_mobility:OnUpgrade()
// 	if (this.GetLevel() == 2){
// 		this.caster.FindModifierByName("modifier_spectre_mobility_charges"):AddCharge()
// 	}
// }

// function spectre_mobility:PlayEffectsOnCast()
//     EmitSoundOn("Hero_Spectre.HauntCast", this.caster)

// 	const particle_cast = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release.vpcf"
//     const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
//     ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
//     ParticleManager.SetParticleControl(particleId, 2, this.caster.GetAbsOrigin())
//     ParticleManager.SetParticleControl(particleId, 3, Vector(250,0,0))
//     ParticleManager.SetParticleControl(particleId, 4, this.caster.GetAbsOrigin())
//     ParticleManager.ReleaseParticleIndex(particleId)
// }

// function spectre_mobility:PlayEffectsOnFinish(pos)
// 	EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
// 		cp0 = this.caster.GetAbsOrigin(),
// 		cp3 = this.caster.GetAbsOrigin(),
// 		release = true,
// 	})

// 	EFX('particles/sweep_generic/sweep_3.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
// 		release = true,
// 	})
// 	EFX('particles/spectre/spectre_mobility.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
// 		cp2 = Vector(this.radius, 1, 1),
// 		release = true,
// 	})
// }

// function spectre_mobility:PlayEffectsOnImpact(target)
// 	EmitSoundOn("Hero_Spectre.Attack", target)
// }

// function spectre_ex_mobility:GetAnimation()	return GameActivity.DOTA_ATTACK }
// function spectre_ex_mobility:GetPlaybackRateOverride() return 1.0 }
// function spectre_ex_mobility:GetCastingCrawl() 		return 0 }

// function spectre_ex_mobility:OnSpellStart()
// 	const this.caster = this.caster
// 	const origin = this.caster.GetAbsOrigin()
// 	const min_range = this.GetSpecialValueFor("min_range")
// 	const delay = this.GetSpecialValueFor("delay")
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), min_range)

// 	EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
// 		cp0 = this.caster.GetAbsOrigin(),
// 		cp3 = this.caster.GetAbsOrigin(),
// 		release = true,
// 	})

// 	EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_start_gold.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
// 		cp0 = origin,
// 		cp1 = origin,
// 		release = true,
// 	})
// 	EmitSoundOn("Hero_Spectre.HauntCast", this.caster)

// 	this.caster.AddNewModifier(this.caster, this, "modifier_spectre_banish", { duration = delay })
// 	CreateModifierThinker(this.caster, this, 'modifier_spectre_mobility_thinker', { duration = delay }, point, this.caster.GetTeam(), false)

//     LinkAbilityCooldowns(this.caster, 'spectre_mobility')
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_mobility)
// Abilities.Castpoint(spectre_ex_mobility)

// modifier_spectre_mobility_thinker = class({})

// function modifier_spectre_mobility_thinker:OnCreated(params)
//     if (IsServer()){
//         const this.caster = this.caster
//         const origin = this.parent.GetAbsOrigin()
//         this.radius = this.ability.GetSpecialValueFor('radius')
//         this.heal = this.ability.GetSpecialValueFor('heal')
//         this.desolate_duration = this.ability.GetSpecialValueFor('desolate_duration')
//         this.fear_duration = this.ability.GetSpecialValueFor('fear_duration')
//         CreateTimedRadiusMarker(this.caster, origin, this.radius, this.GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
//     }
// }

// function modifier_spectre_mobility_thinker:OnDestroy()
//     if (IsServer()){
//         const this.caster = this.caster
//         const origin = this.parent.GetAbsOrigin()
//         FindClearSpaceForUnit(this.caster, origin, false)
//         CustomEntitiesLegacy:SafeDestroyModifier(this.caster, "modifier_spectre_banish")
//         const heal = false

//         const enemies = ApplyCallbackForUnitsInArea(this.caster, this.parent.GetAbsOrigin(), this.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(enemy)
//             if (CustomEntitiesLegacy:ProvidesMana(enemy)){
//                 enemy:AddNewModifier(this.caster, this, "modifier_spectre_desolate_custom", { duration = this.desolate_duration })
//                 heal = true
//             }
//             if (this.ability.GetLevel() >= 2){
//                 enemy:AddNewModifier(this.caster, this, "modifier_spectre_ex_mobility_fear", { duration = this.fear_duration })
//             }
//             EmitSoundOn("Hero_Spectre.Attack", enemy)
//         })

//         if (heal){
//             this.caster.Heal(this.heal, this.caster)
//         }

//         EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
//             cp0 = this.parent.GetAbsOrigin(),
//             release = true,
//         })
//         EFX('particles/spectre/spectre_mobility.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
//             cp0 = this.parent.GetAbsOrigin(),
//             cp2 = Vector(this.radius, 1, 1),
//             release = true,
//         })

//         UTIL_Remove(this.parent)
//     }
// }

// modifier_spectre_mobility_charges = class({})

// function modifier_spectre_mobility_charges:GetMaxCharges()
// 	return this.ability.GetSpecialValueFor("max_charges")
// }

// function modifier_spectre_mobility_charges:GetReplenishType() return CHARGES_TYPE_ASYNC }
// function modifier_spectre_mobility_charges:GetReplenishTime()
// 	if (IsServer()){
// 		this.ability.GetCooldown(this.ability.GetLevel())
// 	}
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Charges(modifier_spectre_mobility_charges)

// modifier_spectre_ex_mobility_fear = class({})

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Fear(modifier_spectre_ex_mobility_fear)

// modifier_spectre_banish = class({})

// function modifier_spectre_banish:IsHidden() return false
// }

// function modifier_spectre_banish:IsDebuff() return false
// }

// function modifier_spectre_banish:IsPurgable() return false
// }

// function modifier_spectre_banish:CheckState()
// 	const state = {
// 		[ModifierState.COMMAND_RESTRICTED] = true,
// 		[ModifierState.INVULNERABLE] = true,
// 		[ModifierState.OUT_OF_GAME] = true,
// 		[ModifierState.NO_UNIT_COLLISION] = true,
// 	}

// 	return state
// }

// function modifier_spectre_banish:OnCreated(kv)
// 	if (IsServer()){
// 		this.parent.AddNoDraw()
// 	}
// }

// function modifier_spectre_banish:OnDestroy(kv)
// 	if (IsServer()){
// 		this.parent.RemoveNoDraw()
// 	}
// }
