// spectre_extra = class({})
// spectre_extra_recast = class({})
// LinkLuaModifier("modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_debuff", "abilities/heroes/spectre/spectre_extra/modifier_spectre_debuff", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_extra_recast", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra_recast", LUA_MODIFIER_MOTION_NONE)

// function spectre_extra:OnSpellStart()
//     const this.caster = this.caster
//     const duration = this.GetSpecialValueFor("duration")
// 	this.caster.FindAbilityByName('spectre_extra_recast'):ResetDamage()

//     this.caster.AddNewModifier(this.caster, this, "modifier_spectre_extra", { duration = duration })
// }

// function spectre_extra:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_extra_recast")
// }

// function spectre_extra_recast:GetAnimation()     return GameActivity.DOTA_CAST_ABILITY_1 }
// function spectre_extra_recast:GetPlaybackRateOverride()    return 1.0 }
// function spectre_extra_recast:GetCastingCrawl() 			return 80 }
// function spectre_extra_recast:GetIgnoreActivationCycle()   return true }

// function spectre_extra_recast:OnSpellStart()
// 	const this.caster = this.caster
// 	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
//     const origin = this.caster.GetAbsOrigin()

// 	const spectre_extra = this.caster.FindAbilityByName('spectre_extra')
// 	const damage = spectre_extra:GetSpecialValueFor("recast_damage")
// 	const max_damage = spectre_extra:GetSpecialValueFor("max_damage")

// 	if (this.extra_damage){
// 		damage = Clamp(damage + this.extra_damage, max_damage, 0)
// 	}

// 	const projectile_direction = Direction2D(origin, point)
// 	const projectile_speed = this.GetSpecialValueFor("projectile_speed")

// 	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
// 		tProjectile = {
// 			EffectName =			"particles/spectre/spectre_extra_recast.vpcf",
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
// 					attacker = this.caster,
// 					damage = damage,
// 					damage_type = DAMAGE_TYPE_MAGICAL,
// 				}

// 				ApplyDamage(damage_table)
// 			},
// 			OnFinish = function(_self, pos)
// 				this.PlayEffectsOnFinish(pos)
// 			}
// 		}
// 	})

// 	EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster)
// }

// function spectre_extra_recast:PlayEffectsOnFinish(vOrigin)
// 	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
// 		cp0 = vOrigin,
// 		cp1 = vOrigin,
// 		cp2 = vOrigin,
// 		release = true,
// 	})
// }

// function spectre_extra_recast:AddDamage(iDamage)
// 	if (this.extra_damage == undefined){
// 		this.extra_damage = 0
// 	}
// 	this.extra_damage = this.extra_damage + iDamage
// }

// function spectre_extra_recast:ResetDamage()
// 	this.extra_damage = 0
// }

// function spectre_extra_recast:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_extra")
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_extra_recast)

// modifier_spectre_extra = class({})

// function modifier_spectre_extra:IsHidden() return false }
// function modifier_spectre_extra:IsDebuff() return false }
// function modifier_spectre_extra:IsPurgable() return false }

// function modifier_spectre_extra:IsAura()
// 	return true
// }
// function modifier_spectre_extra:GetModifierAura()
// 	return "modifier_spectre_debuff"
// }
// function modifier_spectre_extra:GetAuraRadius()
// 	return this.radius
// }
// function modifier_spectre_extra:GetAuraDuration()
// 	return 0.0
// }
// function modifier_spectre_extra:GetAuraSearchTeam()
// 	return DOTA_UNIT_TARGET_TEAM_BOTH
// }
// function modifier_spectre_extra:GetAuraEntityReject(hEntity)
//     if (CustomEntitiesLegacy:Allies(this.caster, hEntity)){
//         return true
//     }
//     return false
// }
// function modifier_spectre_extra:GetAuraSearchType()
// 	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
// }

// function modifier_spectre_extra:OnCreated(kv)
//     this.speed_buff_pct = this.ability.GetSpecialValueFor("speed_buff_pct")
//     this.radius = this.ability.GetSpecialValueFor("radius")

//     if (IsServer()){
//         this.PlayEffectsOnCreated()
//     }
// }

// function modifier_spectre_extra:OnDestroy(kv)
//     if (IsServer()){
//         this.ability.StartCooldown(this.ability.GetCooldown(this.ability.GetLevel()))
//         this.StopEffects()

//         if (this.ability.GetLevel() >= 2){
//             this.parent.AddNewModifier(this.parent, this.ability, 'modifier_spectre_extra_recast', { duration = 5.0 })
//         }
//     }
// }

// function modifier_spectre_extra:DeclareFunctions()
// 	return { ModifierFunction.MOVESPEED_BONUS_PERCENTAGE }
// }

// function modifier_spectre_extra:GetModifierMoveSpeedBonus_Percentage()
//     return this.speed_buff_pct
// }

// function modifier_spectre_extra:PlayEffectsOnCreated()
//     const parent = this.parent
//     EmitSoundOn("Hero_Spectre.Haunt", parent)

// 	const particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf"
// 	this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, parent)
//     ParticleManager.SetParticleControl(this.particleId, 2, parent:GetAbsOrigin())

//     const particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_mist.vpcf"
// 	this.effect_cast_ring = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, parent)
//     ParticleManager.SetParticleControl(this.effect_cast_ring, 3, parent:GetAbsOrigin())
// }

// function modifier_spectre_extra:StopEffects()
//     if (this.particleId ~= undefined){
//         ParticleManager.DestroyParticle(this.particleId, false)
//         ParticleManager.ReleaseParticleIndex(this.particleId)
//     }
//     if (this.effect_cast_ring ~= undefined){
//         ParticleManager.DestroyParticle(this.effect_cast_ring, false)
//         ParticleManager.ReleaseParticleIndex(this.effect_cast_ring)
//     }
// }

// function modifier_spectre_extra:GetStatusLabel() return "Darkness" }
// function modifier_spectre_extra:GetStatusPriority() return 1 }
// function modifier_spectre_extra:GetStatusStyle() return "Darkness" }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_spectre_extra)

// modifier_spectre_extra_recast = class({})

// function modifier_spectre_extra_recast:GetRecastAbility()
//     if (IsServer()){
//         return this.parent.FindAbilityByName("spectre_extra_recast")
//     }
// }

// function modifier_spectre_extra_recast:GetRecastCharges()
// 	return 1
// }

// function modifier_spectre_extra_recast:GetRecastKey()
//     if (this.GetRecastAbility():GetAbilityIndex() == 6){
// 		return "R"
// 	}
// 	return "F"
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Recast(modifier_spectre_extra_recast)

// modifier_spectre_debuff = class({})

// function modifier_spectre_debuff:OnCreated(params)
//     const think_interval = this.ability.GetSpecialValueFor("think_interval")
//     this.damage_per_second = this.ability.GetSpecialValueFor("damage_per_second")

//     if (IsServer()){
//         this.damage_done = 0
//         this.damage_table = {
//             victim = this.parent,
//             attacker = this.caster,
//             damage = this.damage_per_second,
//             damage_type = DAMAGE_TYPE_PURE,
//         }

//         this.StartIntervalThink(think_interval)
//     }
// }

// function modifier_spectre_debuff:OnIntervalThink()
//     if (CustomEntitiesLegacy:ProvidesMana(this.parent)){
//         this.damage_done = this.damage_done + this.damage_per_second
//     }
//     ApplyDamage(this.damage_table)
//     this.PlayEffects()
// }

// function modifier_spectre_debuff:PlayEffects()
//     EmitSoundOn("Hero_Spectre.Desolate", this.caster)
//     EmitSoundOn("Hero_Spectre.Attack", this.parent)

//     EFX('particles/spectre/spectre_extra_impact.vpcf', ParticleAttachment.ABSORIGIN, this.parent, {
//         release = true
//     })
// }

// function modifier_spectre_debuff:OnDestroy()
//     if (IsServer()){
//         this.caster.Heal(this.damage_done, this.caster)
//         this.caster.FindAbilityByName('spectre_extra_recast'):AddDamage(this.damage_done)
//     }
// }
