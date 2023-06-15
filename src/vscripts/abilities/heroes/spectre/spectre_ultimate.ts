// spectre_ultimate = class({})
// LinkLuaModifier("modifier_spectre_ultimate", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ultimate_thinker", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ultimate_helper", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_helper", LUA_MODIFIER_MOTION_NONE)

// function spectre_ultimate:GetAnimation()		return GameActivity.DOTA_CAST_ABILITY_1 }
// function spectre_ultimate:GetPlaybackRateOverride() 	return 0.6 }
// function spectre_ultimate:GetCastingCrawl() 			return 0 }

// function spectre_ultimate:OnSpellStart()
//     const this.caster = this.caster
//     const origin = this.caster.GetAbsOrigin()
//     const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)

//     CreateModifierThinker(
//         this.caster, --hCaster
//         this, --hAbility
//         "modifier_spectre_ultimate_thinker", --modifierName
//         {},
//         point, --vOrigin
//         this.caster.GetTeamNumber(), --nTeamNumber
//         false --bPhantomBlocker
//     )

//     EmitSoundOn("Hero_Spectre.HauntCast", this.caster)
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_ultimate)

// modifier_spectre_ultimate = class({})

// function modifier_spectre_ultimate:OnCreated(params)
//     this.bonus_damage = this.ability.GetSpecialValueFor("bonus_damage")

//     if (IsServer()){
//         if (this.caster == this.parent){
//             this.parent.AddNewModifier(this.parent, this.ability, 'modifier_spectre_special_attack_buff', {})
//             this.SetStackCount(1)
//         else
//             this.damage_table = {
//                 victim = this.parent,
//                 attacker = this.caster,
//                 damage = this.ability.GetSpecialValueFor("ability_damage"),
//                 damage_type = DAMAGE_TYPE_PURE
//             }
//             this.SetStackCount(2)
//         }
//     }
// }

// function modifier_spectre_ultimate:OnDestroy()
//     if (IsServer()){
//         if (this.IsDebuff()){
//             if (this.GetStackCount() == 2){
//                 EmitSoundOn("Hero_Spectre.DaggerImpact", this.parent)
//                 this.parent.AddNewModifier(this.caster, this.ability, "modifier_spectre_special_attack_debuff", {
//                     duration = 5.0
//                 })
//                 this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_fading_slow", {
//                     duration = 5.0,
//                     max_slow_pct = 50
//                 })

//                 if (IsServer()){
//                     ApplyDamage(this.damage_table)
//                 }
//             }
//         else
//             this.parent.RemoveModifierByName('modifier_spectre_special_attack_buff')
//         }
//     }
// }

// function modifier_spectre_ultimate:IsDebuff()
//     if (IsServer()){
//         return this.GetStackCount() == 2 and not CustomEntitiesLegacy:Allies(this.caster, this.parent)
//     }
// }

// function modifier_spectre_ultimate:DeclareFunctions()
// 	return {
// 		ModifierFunction.BONUS_VISION_PERCENTAGE,
//         ModifierFunction.PREATTACK_BONUS_DAMAGE,
// 	}
// }

// function modifier_spectre_ultimate:GetBonusVisionPercentage()
//     if (this.IsDebuff()){
//         return -80
//     }
//     return 0
// }

// function modifier_spectre_ultimate:GetModifierPreAttack_BonusDamage()
//     if (not this.IsDebuff()){
//         return this.bonus_damage
//     }
// }

// modifier_spectre_ultimate_thinker = class({})

// function modifier_spectre_ultimate_thinker:IsAura()
// 	return this.initialized
// }
// function modifier_spectre_ultimate_thinker:GetModifierAura()
// 	return "modifier_spectre_ultimate"
// }
// function modifier_spectre_ultimate_thinker:GetAuraRadius()
// 	return this.radius
// }
// function modifier_spectre_ultimate_thinker:GetAuraDuration()
// 	return 0.0
// }
// function modifier_spectre_ultimate_thinker:GetAuraSearchTeam()
// 	return DOTA_UNIT_TARGET_TEAM_BOTH
// }
// function modifier_spectre_ultimate_thinker:GetAuraSearchType()
// 	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
// }

// function modifier_spectre_ultimate_thinker:OnCreated()
//     if (IsServer()){
//         const delay_time = this.ability.GetSpecialValueFor("delay_time")
//         this.radius = this.ability.GetSpecialValueFor("radius")
//         this.origin = this.parent.GetAbsOrigin()
//         this.duration = this.ability.GetSpecialValueFor("duration")
//         this.initialized = false
//         CreateTimedRadiusMarker(this.caster, this.origin, this.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
//         this.StartIntervalThink(delay_time)
//     }
// }

// function modifier_spectre_ultimate_thinker:OnDestroy()
//     if (IsServer()){
//         ApplyCallbackForUnitsInArea(this.caster, this.origin, this.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)

//             const modifier = unit:FindModifierByName("modifier_spectre_ultimate")
//             if (modifier ~= undefined){
//                 if (not modifier:IsNull()){
//                     modifier:SetStackCount(1)
//                 }
//             }
//         })

//         ParticleManager.DestroyParticle(this.efx, false)
//         ParticleManager.ReleaseParticleIndex(this.efx)

//         UTIL_Remove(this.parent)
//     }
// }

// function modifier_spectre_ultimate_thinker:OnIntervalThink()
//     if (not this.initialized){
//         this.efx = ParticleManager.CreateParticle("particles/spectre/spectre_ultimate.vpcf", ParticleAttachment.WORLDORIGIN, undefined)
//         ParticleManager.SetParticleControl(this.efx, 0, this.origin)
//         ParticleManager.SetParticleControl(this.efx, 1, Vector(this.radius, this.radius, 1))

//         this.initialized = true
//         this.StartIntervalThink(this.duration)
//         EmitSoundOn("Hero_Spectre.HauntCast", this.parent)
//         EmitSoundOn("Hero_Spectre.Reality", this.parent)
//     else
//         this.Destroy()
//     }
// }
