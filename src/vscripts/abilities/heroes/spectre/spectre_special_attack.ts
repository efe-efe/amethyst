// spectre_special_attack = class({})
// spectre_ex_special_attack = class({})
// spectre_ex_special_attack_recast = class({})
// LinkLuaModifier("modifier_spectre_special_attack_debuff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_debuff", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_special_attack_buff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_buff", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ex_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ex_special_attack_recast", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_ex_special_attack_recast", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ex_special_attack_banish", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_ex_special_attack_banish", LUA_MODIFIER_MOTION_NONE)

// function spectre_special_attack:GetAnimation()		return GameActivity.DOTA_CAST_ABILITY_1 }
// function spectre_special_attack:GetPlaybackRateOverride()		return 0.7 }
// function spectre_special_attack:GetCastingCrawl() 			return 20 }

// function spectre_special_attack:OnSpellStart()
// 	const this.caster = this.caster
// 	const damage = this.GetSpecialValueFor("ability_damage")
// 	const origin = this.caster.GetAbsOrigin()
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)

// 	const projectile_name = "particles/spectre/spectre_special_attack.vpcf"
// 	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
// 	const hitbox = this.GetSpecialValueFor("hitbox")

// 	const path_duration = this.GetSpecialValueFor("path_duration")
// 	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
// 	const debuff_duration = this.GetSpecialValueFor("debuff_duration")

// 	const projectile_direction = Direction2D(origin, point)
// 	const projectile_distance = this.GetCastRange(Vector(0,0,0), undefined)

// 	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
// 		tProjectile = {
// 			vSpawnOrigin = origin,
// 			fDistance = projectile_distance,
// 			fStartRadius = hitbox,
// 			Source = this.caster,
// 			vVelocity = projectile_direction * projectile_speed,
// 			UnitBehavior = PROJECTILES_NOTHING,
// 			TreeBehavior = PROJECTILES_NOTHING,
// 			WallBehavior = PROJECTILES_NOTHING,
// 			GroundBehavior = PROJECTILES_NOTHING,
// 			fGroundOffset = 0,
// 			bGroundLock = true,
// 			bIsDestructible = false,
// 			bIsReflectable = false,
// 			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) },
// 			OnUnitHit = function(_self, unit)
// 				const damage = {
// 					victim = unit,
// 					attacker = this.caster,
// 					damage = damage,
// 					damage_type = DAMAGE_TYPE_MAGICAL,
// 				}

// 				ApplyDamage(damage)

// 				unit:AddNewModifier(
// 					this.caster,
// 					this,
// 					"modifier_spectre_special_attack_debuff",
// 					{ duration = debuff_duration }
// 				)

// 				if (_self.Source == this.caster){
// 					if (CustomEntitiesLegacy:ProvidesMana(unit)){
// 						CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
// 					}
// 				}

// 				this.PlayEffectsOnImpact(unit)
// 			},
// 			OnIntervalThink = function(_self, pos)
// 				CreateModifierThinker(
// 					this.caster, -- player source
// 					this, -- ability source
// 					"modifier_spectre_special_attack_thinker", -- modifier name
// 					{ duration = path_duration }, -- kv
// 					pos,
// 					this.caster.GetTeamNumber(),
// 					false --bPhantomBlocker
// 				)
// 			}
// 		}
// 	})

// 	const info = {
// 		Source = this.caster,
// 		Ability = this,
// 		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128),

// 		bDeleteOnHit = false,

// 		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
// 		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
// 		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

// 		EffectName = projectile_name,
// 		fDistance = projectile_distance,
// 		fStartRadius = hitbox,
// 		fEndRadius = hitbox,
// 		vVelocity = projectile_direction * projectile_speed,

// 		bHasFrontalCone = false,
// 		bReplaceExisting = false,
// 		fExpireTime = GameRules:GetGameTime() + 8.0,

// 		bProvidesVision = true,
// 		iVisionTeamNumber = this.caster.GetTeamNumber(),
// 		iVisionRadius = hitbox,
// 	}
// 	ProjectileManager:CreateLinearProjectile(info)
// 	this.PlayEffectsOnCast()
// 	LinkAbilityCooldowns(this.caster, 'spectre_ex_special_attack')
// }

// function spectre_special_attack:PlayEffectsOnCast()
// 	EmitSoundOn("Hero_Spectre.DaggerCast", this.caster)
// }

// function spectre_special_attack:PlayEffectsOnImpact(target)
// 	EmitSoundOn("Hero_Spectre.DaggerImpact", target)

// 	const particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner_impact.vpcf"
// 	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, target)
// 	ParticleManager.ReleaseParticleIndex(particleId)
// }

// spectre_ex_special_attack.PlayEffectsOnCast = spectre_special_attack.PlayEffectsOnCast
// spectre_ex_special_attack.PlayEffectsOnFinish = spectre_special_attack.PlayEffectsOnFinish

// function spectre_ex_special_attack:GetAnimation()		return GameActivity.DOTA_FLAIL }
// function spectre_ex_special_attack:GetPlaybackRateOverride()		return 1.0 }
// function spectre_ex_special_attack:GetCastingCrawl() 			return 0 }

// function spectre_ex_special_attack:OnSpellStart()
// 	const this.caster = this.caster
//     const origin = this.caster.GetAbsOrigin()
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)

// 	EmitSoundOn("Hero_Spectre.Haunt", this.caster)
// 	EFX('particles/spectre/spectre_illusion_warp.vpcf', ParticleAttachment.CUSTOMORIGIN, this.caster, {
// 		cp0 = {
// 			ent = this.caster,
// 			point = 'attach_hitloc'
// 		},
// 		cp1 = point + Vector(0, 0, 128),
// 		cp2 = {
// 			ent = this.caster,
// 			point = 'attach_hitloc'
// 		},
//         release = true,
// 	})

// 	CreateModifierThinker(this.caster, this, 'modifier_spectre_ex_special_attack_thinker', {}, point, this.caster.GetTeam(), false)
// 	LinkAbilityCooldowns(this.caster, 'spectre_special_attack')
// }

// function spectre_ex_special_attack:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_ex_special_attack_recast")
// 	const related = this.caster.FindAbilityByName('spectre_ex_special_attack_recast')

// 	if (this.GetLevel() > related:GetLevel()){
// 		related:UpgradeAbility(true)
// 	}
// }

// function spectre_ex_special_attack_recast:OnSpellStart()
// 	const this.caster = this.caster
//     const origin = this.caster.GetAbsOrigin()
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)

// 	for _,target in ipairs(this.targets) do
// 		target:RemoveModifierByName('modifier_spectre_ex_special_attack_banish')
// 		FindClearSpaceForUnit(target, point, true)
// 	}

// 	EFX('particles/spectre/spectre_illusion_warp.vpcf', ParticleAttachment.CUSTOMORIGIN, this.caster, {
// 		cp0 = {
// 			ent = this.caster,
// 			point = 'attach_hitloc'
// 		},
// 		cp1 = point + Vector(0, 0, 128),
// 		cp2 = {
// 			ent = this.caster,
// 			point = 'attach_hitloc'
// 		},
//         release = true,
// 	})

// 	EmitSoundOnLocationWithCaster(point, "Hero_Spectre.Reality", this.caster)
// }

// function spectre_ex_special_attack_recast:AddTarget(target)
// 	if (not this.targets){
// 		this.targets = {}
// 	}
// 	table.insert(this.targets, target)
// }

// function spectre_ex_special_attack_recast:ClearTargets(target)
// 	this.targets = undefined
// }

// function spectre_ex_special_attack_recast:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_ex_special_attack")
// 	const related = this.caster.FindAbilityByName('spectre_ex_special_attack')

// 	if (this.GetLevel() > related:GetLevel()){
// 		related:UpgradeAbility(true)
// 	}
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_special_attack)
// Abilities.Castpoint(spectre_ex_special_attack)

// modifier_spectre_special_attack_thinker = class({})

// function modifier_spectre_special_attack_thinker:IsAura()
// 	return true
// }
// function modifier_spectre_special_attack_thinker:GetModifierAura()
// 	return "modifier_spectre_special_attack_buff"
// }
// function modifier_spectre_special_attack_thinker:GetAuraRadius()
// 	return this.radius
// }
// function modifier_spectre_special_attack_thinker:GetAuraDuration()
// 	return this.buff_duration
// }
// function modifier_spectre_special_attack_thinker:GetAuraSearchTeam()
// 	return DOTA_UNIT_TARGET_TEAM_BOTH
// }
// function modifier_spectre_special_attack_thinker:GetAuraEntityReject(hEntity)
//     if (not CustomEntitiesLegacy:Allies(this.caster, hEntity)){
//         return true
//     }
//     return false
// }
// function modifier_spectre_special_attack_thinker:GetAuraSearchType()
// 	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
// }

// function modifier_spectre_special_attack_thinker:OnCreated(params)
//     this.buff_duration = this.ability.GetSpecialValueFor("buff_duration")
//     this.radius = 100

//     if (IsServer()){
//         this.PlayEffects()
//     }
// }

// function modifier_spectre_special_attack_thinker:OnDestroy()
//     if (IsServer()){
//         this.StopEffects()
//         UTIL_Remove(this.parent)
//     }
// }

// function modifier_spectre_special_attack_thinker:PlayEffects()
//     const pos = this.parent.GetAbsOrigin()
//     const particle_cast = "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_steam.vpcf"
//     this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
//     ParticleManager.SetParticleControl(this.particleId, 0, pos)
//     ParticleManager.SetParticleControl(this.particleId, 1, pos)

// 	particle_cast = "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_ground.vpcf"
// 	this.effect_cast_dark = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
// 	ParticleManager.SetParticleControl(this.effect_cast_dark, 0, pos)
//     ParticleManager.SetParticleControl(this.effect_cast_dark, 5, pos)
// }

// function modifier_spectre_special_attack_thinker:StopEffects()
//     if (this.particleId){
//         ParticleManager.DestroyParticle(this.particleId, false)
//         ParticleManager.ReleaseParticleIndex(this.particleId)
//     }

//     if (this.effect_cast_dark){
//         ParticleManager.DestroyParticle(this.effect_cast_dark, false)
//         ParticleManager.ReleaseParticleIndex(this.effect_cast_dark)
//     }
// }

// modifier_spectre_special_attack_debuff = class({})
// LinkLuaModifier("modifier_spectre_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)

// function modifier_spectre_special_attack_debuff:OnCreated(kv)
// 	if (IsServer()){
// 		this.StartIntervalThink(0.2)
// 	}
// }

// function modifier_spectre_special_attack_debuff:OnIntervalThink()
// 	const origin = this.parent.GetAbsOrigin()

// 	CreateModifierThinker(
// 		this.caster, -- player source
// 		this.ability, -- ability source
// 		"modifier_spectre_special_attack_thinker", -- modifier name
// 		{ duration = this.GetRemainingTime() }, -- kv
// 		origin,
// 		this.caster.GetTeamNumber(),
// 		false --bPhantomBlocker
// 	)

// 	const particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_pounce_start_spiral.vpcf"
// 	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
// 	ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin())
// 	ParticleManager.SetParticleControl(particleId, 3, this.parent.GetAbsOrigin())
// 	ParticleManager.ReleaseParticleIndex(particleId)
// }

// function modifier_spectre_special_attack_debuff:GetEffectName()
// 	return "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
// }

// function modifier_spectre_special_attack_debuff:GetEffectAttachType()
// 	return ParticleAttachment.ABSORIGIN_FOLLOW
// }

// modifier_spectre_special_attack_buff = class({})

// function modifier_spectre_special_attack_buff:IsDebuff() return false }
// function modifier_spectre_special_attack_buff:IsHidden() return false }
// function modifier_spectre_special_attack_buff:IsPurgable() return false }

// function modifier_spectre_special_attack_buff:OnCreated(kv)
// 	this.speed_buff_pct = this.ability.GetSpecialValueFor("speed_buff_pct")

// 	if (IsServer()){
// 		this.PlayEffects()
// 	}
// }

// function modifier_spectre_special_attack_buff:OnDestroy()
// 	if (IsServer()){
// 		EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', ParticleAttachment.WORLDORIGIN, this.parent, {
// 			cp0 = this.parent.GetAbsOrigin(),
// 			cp3 = this.parent.GetAbsOrigin(),
// 			release = true,
// 		})
// 		this.StopEffects()
// 	}
// }

// function modifier_spectre_special_attack_buff:CheckState()
// 	return {
// 		[ModifierState.INVISIBLE] = this.GivesInvisibility(),
// 		[ModifierState.NO_UNIT_COLLISION] = true,
// 		[ModifierState.FLYING_FOR_PATHING_PURPOSES_ONLY] = true
// 	}
// }

// function modifier_spectre_special_attack_buff:GivesInvisibility()
// 	return this.ability.GetLevel() >=2 and not this.parent.FindModifierByName('modifier_casting') and this.parent == this.caster
// }

// function modifier_spectre_special_attack_buff:DeclareFunctions()
// 	return {
// 		ModifierFunction.INVISIBILITY_LEVEL,
// 		ModifierFunction.MOVESPEED_BONUS_PERCENTAGE,
// 	}
// }

// function modifier_spectre_special_attack_buff:GetModifierInvisibilityLevel()
// 	if (IsServer()){
// 		if (this.ability.GetLevel() >=2 and not this.parent.FindModifierByName('modifier_casting')){
// 			return 2
// 		}

// 		return 0
// 	}
// }

// function modifier_spectre_special_attack_buff:GetModifierMoveSpeedBonus_Percentage()
//     return this.speed_buff_pct
// }

// function modifier_spectre_special_attack_buff:PlayEffects()
// 	const particle_cast = "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage_swirl.vpcf"
// 	this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.CUSTOMORIGIN, this.parent)
//     ParticleManager.SetParticleControlEnt(
//         this.particleId,
//         2,
//         this.parent,
//         ParticleAttachment.POINT_FOLLOW,
//         "attach_hitloc",
//         this.parent.GetAbsOrigin(),
//         true
//    )
// }

// function modifier_spectre_special_attack_buff:StopEffects()
// 	ParticleManager.DestroyParticle(this.particleId, false)
// 	ParticleManager.ReleaseParticleIndex(this.particleId)
// }

// modifier_spectre_ex_special_attack_thinker = class({})

// function modifier_spectre_ex_special_attack_thinker:OnCreated(params)
//     if (IsServer()){
//         this.this.caster = this.caster
//         this.origin = this.parent.GetAbsOrigin()
//         this.radius = this.ability.GetSpecialValueFor('radius')
//         this.banish_duration = this.ability.GetSpecialValueFor('banish_duration')
//         const delay_time = this.ability.GetSpecialValueFor('delay_time')
//         CreateTimedRadiusMarker(this.this.caster, this.origin, this.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
//         this.StartIntervalThink(delay_time)

//         this.efx = ParticleManager.CreateParticle("particles/spectre/spectre_illusion_warp_ground.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
//         ParticleManager.SetParticleControl(this.efx, 0, this.parent.GetAbsOrigin())
//         ParticleManager.SetParticleControl(this.efx, 1, this.parent.GetAbsOrigin())
//         ParticleManager.SetParticleControl(this.efx, 2, this.parent.GetAbsOrigin())
//         ParticleManager.SetParticleControl(this.efx, 3, Vector(this.radius, 0, 0))
//     }
// }

// function modifier_spectre_ex_special_attack_thinker:OnIntervalThink()

//     EmitSoundOn("Hero_Spectre.HauntCast", this.parent)
//     const spectre_ex_basic_attack_recast = this.this.caster.FindAbilityByName('spectre_ex_special_attack_recast')
//     spectre_ex_basic_attack_recast:ClearTargets()

//     const enemies = ApplyCallbackForUnitsInArea(this.this.caster, this.origin, this.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
//         unit:AddNewModifier(this.this.caster, this.ability, 'modifier_spectre_ex_special_attack_banish', { duration = this.banish_duration })
//         spectre_ex_basic_attack_recast:AddTarget(unit)
//         const efx = ParticleManager.CreateParticle("particles/units/heroes/hero_spectre/spectre_death.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
// 		ParticleManager.SetParticleControl(efx, 0, unit:GetAbsOrigin())
// 		ParticleManager.SetParticleControl(efx, 3, unit:GetAbsOrigin())
// 		ParticleManager.ReleaseParticleIndex(efx)
//     })

//     if (#enemies > 0){
//         this.this.caster.AddNewModifier(this.this.caster, this.ability, 'modifier_spectre_ex_special_attack_recast', { duration = this.banish_duration })
//     }

//     this.Destroy()
// }

// function modifier_spectre_ex_special_attack_thinker:OnDestroy()
//     if (IsServer()){
//         UTIL_Remove(this.parent)
//         ParticleManager.DestroyParticle(this.efx, false)
//         ParticleManager.ReleaseParticleIndex(this.efx)

//         EFX('particles/spectre/spectre_illusion_warp_radius.vpcf', ParticleAttachment.WORLDORIGIN, undefined, {
//             cp0 = this.origin,
//             cp1 = this.origin,
//             cp2 = Vector(this.radius),
//             release = true
//         })
//     }
// }

// modifier_spectre_ex_special_attack_recast = class({})

// function modifier_spectre_ex_special_attack_recast:GetRecastAbility()
//     if (IsServer()){
//         return this.parent.FindAbilityByName("spectre_ex_special_attack_recast")
//     }
// }

// function modifier_spectre_ex_special_attack_recast:GetRecastCharges()
// 	return 1
// }

// function modifier_spectre_ex_special_attack_recast:GetRecastKey()
// 	return "2"
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Recast(modifier_spectre_ex_special_attack_recast)

// modifier_spectre_ex_special_attack_banish = class({})

// function modifier_spectre_ex_special_attack_banish:CheckState()
//     return {
//         [ModifierState.COMMAND_RESTRICTED] = true,
// 	}
// }

// function modifier_spectre_ex_special_attack_banish:OnCreated(params)
//     if (IsServer()){
//         this.fading_slow_duration = this.ability.GetSpecialValueFor('fading_slow_duration')
//         this.fading_slow_pct = this.ability.GetSpecialValueFor('fading_slow_pct')
//     }
// }

// function modifier_spectre_ex_special_attack_banish:OnDestroy()
//     if (IsServer()){
//         const efx = ParticleManager.CreateParticle("particles/units/heroes/hero_spectre/spectre_death.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
// 		ParticleManager.SetParticleControl(efx, 0, this.parent.GetAbsOrigin())
// 		ParticleManager.SetParticleControl(efx, 3, this.parent.GetAbsOrigin())
//         ParticleManager.ReleaseParticleIndex(efx)

//         this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_fading_slow", {
//             duration = this.fading_slow_duration,
//             max_slow_pct = this.fading_slow_pct
//         })
//     }
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Banish(modifier_spectre_ex_special_attack_banish)
