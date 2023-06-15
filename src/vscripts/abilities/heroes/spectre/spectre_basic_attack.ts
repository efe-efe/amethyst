// spectre_basic_attack = class({})
// LinkLuaModifier("modifier_spectre_desolate_custom", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_custom/modifier_spectre_desolate_custom", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_basic_attack_cooldown", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

// function spectre_basic_attack:GetIntrinsicModifierName(){
// 	return "modifier_spectre_basic_attack_cooldown"
// }

// function spectre_basic_attack:GetCastPoint()
// 	if (IsServer()){
// 		return this.caster.GetAttackAnimationPoint()
// 	}
// }

// function spectre_basic_attack:GetCooldown(iLevel)
// 	if (IsServer()){
//         const attacks_per_second = this.caster.GetAttacksPerSecond()
//         const attack_speed = (1 / attacks_per_second)

// 		return this.BaseClass.GetCooldown(this, this.GetLevel()) + attack_speed
// 	}
// }

// function spectre_basic_attack:GetAnimation()	return GameActivity.DOTA_ATTACK }
// function spectre_basic_attack:GetPlaybackRateOverride()
// 	if (IsServer()){
// 		const slow = this.caster.FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady() and 0.3 or 0.0

// 		return 1.1 - slow
// 	}
// }
// function spectre_basic_attack:GetCastingCrawl() 		return this.GetSpecialValueFor('cast_point_speed_pct') }

// function spectre_basic_attack:OnSpellStart()
// 	const this.caster = this.caster
// 	const origin = this.caster.GetAbsOrigin()
// 	const cast_range = this.GetCastRange(Vector(0,0,0), undefined)
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), cast_range, cast_range)
// 	const radius = this.GetSpecialValueFor("radius") + CustomEntitiesLegacy:GetMeeleExtraRadius(this.caster)
// 	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
// 	const direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
// 	const max_targets = 1
// 	const is_charged = this.caster.FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady()

// 	if (is_charged){
// 		radius = radius + 50
// 		max_targets = -1
// 		ScreenShake(point, 100, 100, 0.45, 1000, 0, true)
// 	}

// 	CustomEntitiesLegacy:MeeleAttack(this.caster, {
// 		vDirection = direction,
// 		vOrigin = origin,
// 		fRadius = radius,
// 		iMaxTargets = max_targets,
// 		bIsBasicAttack = true,
// 		bShakeOnHeroes = not is_charged,
// 		Callback = function(target)
// 			CustomEntitiesLegacy:AttackWithBaseDamage(this.caster, {
// 				target = target,
// 				hAbility = this,
// 			})

// 			if (CustomEntitiesLegacy:ProvidesMana(target)){
// 				CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
// 			}

// 			this.PlayEffectsOnImpact(target, target:GetAbsOrigin(), is_charged)
// 		}
// 	})

// 	this.PlayEffectsOnFinish(direction, is_charged, radius)
// 	this.PlayEffectsOnCast(is_charged)
// }

// function spectre_basic_attack:PlayEffectsOnFinish(vDirection, bCharged, nRadius)
// 	const this.caster = this.caster
// 	const origin = this.caster.GetAbsOrigin()
// 	const color = Vector(107, 14, 103)

// 	const efx = EFX('particles/spectre/spectre_basic_attack_parent.vpcf', ParticleAttachment.WORLDORIGIN, undefined, {
// 		cp0 = origin,
// 		cp0f = vDirection,
// 		cp3 = Vector(nRadius, 0, 0),
// 	})

// 	ParticleManager.SetParticleControl(efx, 60, color)
// 	ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0))

// 	if (bCharged){
// 		ParticleManager.SetParticleControl(efx, 4, Vector(1, 0, 0))

// 		const particle_cast = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragonform_iron_dragon.vpcf"
// 		const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
// 		ParticleManager.SetParticleControl(particleId, 2, origin)
// 		ParticleManager.SetParticleControl(particleId, 4, origin)
// 		ParticleManager.ReleaseParticleIndex(particleId)

// 		particleId = ParticleManager.CreateParticle('particles/spectre/spectre_basic_attack_charged.vpcf', ParticleAttachment.WORLDORIGIN, undefined)
// 		ParticleManager.SetParticleControl(particleId, 0, origin)
// 		ParticleManager.SetParticleControl(particleId, 1, Vector(nRadius, nRadius, nRadius))
// 		ParticleManager.SetParticleControlForward(particleId, 0, vDirection)
// 		ParticleManager.ReleaseParticleIndex(particleId)
// 	}

// 	ParticleManager.ReleaseParticleIndex(efx)
// }

// function spectre_basic_attack:PlayEffectsOnCast(bCharged)
// 	EmitSoundOn("Hero_Spectre.PreAttack", this.caster)

// 	if (bCharged){
// 		EmitSoundOn('Hero_Sven.Layer.GodsStrength', this.caster)
// 	}
// }

// function spectre_basic_attack:PlayEffectsOnImpact(target, vPosition, bCharged)
// 	if (bCharged){
// 		EmitSoundOn("Hero_BountyHunter.Jinada", target)

// 		const particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
// 		const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, target)
// 		ParticleManager.ReleaseParticleIndex(particleId)
// 	else
// 		EmitSoundOn("Hero_Spectre.Attack", target)

// 		EFX('particles/phantom/phantom_basic_attack.vpcf', ParticleAttachment.ABSORIGIN, target, {
// 			release = true
// 		})

// 		const this.caster = this.caster
// 		const offset = 50
// 		const new_position = this.caster.GetAbsOrigin() + (vPosition - this.caster.GetAbsOrigin()):Normalized() * offset

// 		const particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
// 		const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, this.caster)
// 		ParticleManager.SetParticleControl(particleId, 0, vPosition)
// 		ParticleManager.SetParticleControlForward(particleId, 0, (vPosition - this.caster.GetAbsOrigin()):Normalized())
// 		ParticleManager.ReleaseParticleIndex(particleId)
// 	}
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_basic_attack)

// modifier_spectre_basic_attack_cooldown = class({})
// modifier_spectre_basic_attack_attack = class({})

// function modifier_spectre_basic_attack_cooldown:OnCreated(params)
//     this.damage_bonus_desolate = this.ability.GetSpecialValueFor("damage_bonus_desolate")
//     this.heal_desolate = this.ability.GetSpecialValueFor("heal_desolate")
// 	this.heal_charged = this.ability.GetSpecialValueFor("heal_charged")
// 	this.desolate_duration = this.ability.GetSpecialValueFor("desolate_duration")
//     this.silence_duration = this.ability.GetSpecialValueFor("silence_duration")
//     this.mana_gain_pct = this.ability.GetSpecialValueFor("mana_gain_pct")

//     if (IsServer()){
// 	    this.attack_speed_bonus = 0.2 + this.caster.GetAttackAnimationPoint()
//     }
// }

// function modifier_spectre_basic_attack_cooldown:DeclareFunctions()
//     return {
//         --MODIFIER_EVENT_ON_ATTACK,
//         ModifierFunction.PREATTACK_BONUS_DAMAGE,
//         ModifierFunction.ATTACK_POINT_CONSTANT,
//         --MODIFIER_EVENT_ON_ATTACK_LANDED,
//     }
// }

// function modifier_spectre_basic_attack_cooldown:OnEvent(params)
//     if (params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED){
//         if (this.GetRemainingTime() > 0){
//             return
//         else
//             this.StartCooldown()
//         }
//     }

//     if (params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED){
//         if (this.IsCooldownReady()){
//             params.target:AddNewModifier(this.parent, this.ability, "modifier_generic_silence", { duration = this.silence_duration })

//             if (CustomEntitiesLegacy:ProvidesMana(params.target)){
//                 params.target:AddNewModifier(this.parent, this.ability, "modifier_spectre_desolate_custom", { duration = this.desolate_duration })
//             }

//             if (not CustomEntitiesLegacy:IsObstacle(params.target) and not CustomEntitiesLegacy:IsCountering(params.target)){
//                 this.parent.Heal(this.heal_charged, this.parent)
//             }
//         }
//     }
// }

// function modifier_spectre_basic_attack_cooldown:GetModifierPreAttack_BonusDamage(params)
//     if (not this.IsCooldownReady()){
//         return 0
//     }
//     return this.ability.GetSpecialValueFor("charged_damage")
// }

// function modifier_spectre_basic_attack_cooldown:OnAttackLanded(params)
//     if (params.attacker ~= this.parent){
//         return
//     }
//     if (params.target:HasModifier("modifier_spectre_desolate_custom")){
//         if (not CustomEntitiesLegacy:IsObstacle(params.target)){
//             this.parent.Heal(this.heal_desolate, this.parent)
//             this.PlayEffectsLifeSteal()
//         }
//     }
// }

// function modifier_spectre_basic_attack_cooldown:GetModifierAttackPointConstant()
//     if (not this.IsCooldownReady()){ return 0 }
//     if (IsServer()){
//         return this.attack_speed_bonus
//     }
// }

// function modifier_spectre_basic_attack_cooldown:OnReplenish()
// 	ReplenishEFX(this.parent)
//     this.PlayEffectsWeapon()
// }

// function modifier_spectre_basic_attack_cooldown:OnCooldownStart()
//     this.StopEffectsWeapon()
// }

// function modifier_spectre_basic_attack_cooldown:PlayEffectsLifeSteal()
// 	const particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
// 	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
// 	ParticleManager.ReleaseParticleIndex(particleId)
// }

// function modifier_spectre_basic_attack_cooldown:PlayEffectsWeapon()
//     if (IsServer()){
//         const this.caster = this.parent

//         const particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_c.vpcf"
//         const origin = this.caster.GetAbsOrigin()
//         this.particleId = ParticleManager.CreateParticle(
//             particle_cast,
//             ParticleAttachment.CUSTOMORIGIN,
//             this.caster
//        )

//         ParticleManager.SetParticleControlEnt(
//             this.particleId,
//             0,
//             this.caster,
//             ParticleAttachment.POINT_FOLLOW,
//             "attach_attack1",
//             origin,
//             true
//        )
//         ParticleManager.SetParticleControlEnt(
//             this.particleId,
//             3,
//             this.caster,
//             ParticleAttachment.POINT_FOLLOW,
//             "attach_attack1",
//             origin,
//             true
//        )
//     }
// }

// function modifier_spectre_basic_attack_cooldown:StopEffectsWeapon()
//     if (IsServer()){
//         if (this.particleId){
//             ParticleManager.DestroyParticle(this.particleId, false)
//             ParticleManager.ReleaseParticleIndex(this.particleId)
//         }
//     }
// }

// function modifier_spectre_basic_attack_cooldown:GetEffectName()
// 	return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf"
// }

// function modifier_spectre_basic_attack_cooldown:GetEffectAttachType()
// 	return ParticleAttachment.ABSORIGIN_FOLLOW
// }

// function modifier_spectre_basic_attack_cooldown:GetReplenishTime()
//     return this.ability.GetSpecialValueFor("replenish_time")
// }

// function modifier_spectre_basic_attack_cooldown:GetPreAttackDamage(params)
//     if (params.victim:HasModifier("modifier_spectre_desolate_custom")){
//         return this.damage_bonus_desolate
//     }

//     return 0
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Cooldown(modifier_spectre_basic_attack_cooldown)
// Modifiers.OnEvent(modifier_spectre_basic_attack_cooldown)
// Modifiers.PreAttackDamage(modifier_spectre_basic_attack_cooldown)

// modifier_spectre_desolate_custom = class({})

// function modifier_spectre_desolate_custom:IsDebuff() return true }
// function modifier_spectre_desolate_custom:IsHidden() return false }
// function modifier_spectre_desolate_custom:IsPurgable() return true }

// function modifier_spectre_desolate_custom:GetEffectName()
// 	return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
// }

// function modifier_spectre_desolate_custom:GetEffectAttachType()
// 	return ParticleAttachment.ABSORIGIN_FOLLOW
// }

// function modifier_spectre_desolate_custom:GetTexture()
// 	return "spectre_desolate_modifier"
// }

// function modifier_spectre_desolate_custom:GetStatusLabel() return "Desolate" }
// function modifier_spectre_desolate_custom:GetStatusPriority() return 6 }
// function modifier_spectre_desolate_custom:GetStatusStyle() return "Desolate" }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_spectre_desolate_custom)
