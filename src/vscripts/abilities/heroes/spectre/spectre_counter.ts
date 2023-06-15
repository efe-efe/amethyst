// spectre_counter = class({})
// spectre_ex_counter = class({})

// LinkLuaModifier("modifier_spectre_counter_countering", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_countering", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_counter_recast", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_recast", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ex_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_ex_counter", LUA_MODIFIER_MOTION_NONE)
// LinkLuaModifier("modifier_spectre_ex_counter_debuff", "abilities/heroes/spectre/spectre_counter/modifier_spectre_ex_counter_debuff", LUA_MODIFIER_MOTION_NONE)

// function spectre_counter:OnSpellStart()
//     const this.caster = this.caster
// 	const duration = this.GetSpecialValueFor("counter_duration")

//     this.caster.AddNewModifier(
// 		this.caster, -- player source
// 		this, -- ability source
//         "modifier_spectre_counter_countering",
// 		{ duration = duration } -- kv
//    )

//     EmitSoundOn("Hero_Spectre.HauntCast", this.caster)

//     const particleId = ParticleManager.CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
//     ParticleManager.ReleaseParticleIndex(particleId)

//     LinkAbilityCooldowns(this.caster, 'spectre_ex_counter')
// }

// function spectre_ex_counter:OnSpellStart()
//     const this.caster = this.caster
//     const delay_time = this.GetSpecialValueFor("delay_time")
//     this.caster.AddNewModifier(this.caster, this, "modifier_spectre_ex_counter", { duration = delay_time })
//     LinkAbilityCooldowns(this.caster, 'spectre_counter')
// 	EmitSoundOn("Hero_Spectre.HauntCast", this.caster)
// }

// spectre_counter_recast = class({})

// function spectre_counter_recast:GetAnimation()		return GameActivity.DOTA_CAST_ABILITY_1 }
// function spectre_counter_recast:GetPlaybackRateOverride()	    return 1.0 }
// function spectre_counter_recast:GetCastingCrawl() 			return 0 }
// function spectre_counter_recast:GetIgnoreActivationCycle() 		return true }

// function spectre_counter_recast:OnAbilityPhaseStart()
// 	this.PlayEffectsOnPhase()
// 	return true
// }

// function spectre_counter_recast:HasPriority()
// 	return true
// }

// function spectre_counter_recast:OnSpellStart()
// 	const this.caster = this.caster
// 	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
//     const origin = this.caster.GetAbsOrigin()
//     const ability = this.caster.FindAbilityByName('spectre_counter')

// 	const damage = ability:GetSpecialValueFor("ability_damage")

// 	const projectile_direction = Direction2D(origin, point)
// 	const projectile_speed = this.GetSpecialValueFor("projectile_speed")

// 	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
// 		tProjectile = {
// 			EffectName =			"particles/spectre/spectre_ex_second_attack.vpcf",
// 			vSpawnOrigin = 			this.caster.GetAbsOrigin() + Vector(0, 0, 80),
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

// 				this.TeleportTarget(unit, _self.Source)
// 			},
// 			OnFinish = function(_self, pos)
// 				this.PlayEffectsOnFinish(pos)
// 			}
// 		}
// 	})

// 	this.PlayEffectsOnCast()
// }

// function spectre_counter_recast:TeleportTarget(target, hCaster)
// 	const vCasterOrigin = hCaster:GetAbsOrigin()
// 	const hTargetOrigin = target:GetAbsOrigin()
// 	const vDirection = (vCasterOrigin - hTargetOrigin):Normalized()
// 	const iDistance = (vCasterOrigin - hTargetOrigin):Length2D()
// 	const vNewOrigin = vCasterOrigin + hCaster:GetForwardVector() * 150
// 	const iSpeed = 3000

// 	const projectile = {
// 		EffectName =			"particles/spectre/spectre_ex_second_attack.vpcf",
// 		vSpawnOrigin = 			target:GetAbsOrigin() + Vector(0, 0, 80),
// 		fDistance = 			iDistance,
// 		fStartRadius =			80,
// 		Source = 				hCaster,
// 		vVelocity = 			vDirection * iSpeed,
// 		UnitBehavior = 			PROJECTILES_DESTROY,
// 		WallBehavior = 			PROJECTILES_DESTROY,
// 		TreeBehavior = 			PROJECTILES_NOTHING,
// 		GroundBehavior = 		PROJECTILES_NOTHING,
// 		fGroundOffset = 		0,
// 		OnFinish = function(_self, pos)
// 			FindClearSpaceForUnit(target, vNewOrigin, true)
// 			EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', ParticleAttachment.WORLDORIGIN, target, {
// 				cp0 = hTargetOrigin,
// 				cp3 = hTargetOrigin,
// 				release = true,
// 			})
// 			EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', ParticleAttachment.WORLDORIGIN, target, {
// 				cp0 = vNewOrigin,
// 				release = true,
// 			})
// 		},
// 	}

// 	ProjectilesManagerInstance:CreateProjectile(projectile)
// }

// function spectre_counter_recast:PlayEffectsOnPhase()
// 	EmitSoundOn("Hero_Spectre.Haunt", this.caster)
// 	const particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"

// 	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
// 	ParticleManager.SetParticleControl(particleId, 15, Vector(128, 32, 108))
// 	ParticleManager.SetParticleControl(particleId, 16, Vector(1, 0, 0))

// 	ParticleManager.ReleaseParticleIndex(particleId)
// }

// function spectre_counter_recast:PlayEffectsOnFinish(pos)
// 	const this.caster = this.caster

//     const sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
// 	EmitSoundOnLocationWithCaster(pos, sound_cast, this.caster)

// 	const particle_cast = "particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf"
// 	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, this.caster)

// 	ParticleManager.SetParticleControl(particleId, 0, pos)
// 	ParticleManager.SetParticleControl(particleId, 1, pos)
// 	ParticleManager.SetParticleControl(particleId, 2, pos)

// 	ParticleManager.ReleaseParticleIndex(particleId)
// }

// function spectre_counter_recast:PlayEffectsOnCast()
// 	EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster)
// }

// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_counter_recast)

// modifier_spectre_ex_counter = class({})

// function modifier_spectre_ex_counter:OnCreated()
//     if (IsServer()){
//         this.radius = this.ability.GetSpecialValueFor("radius")
//         this.parent = this.parent
//         this.heal = this.ability.GetSpecialValueFor("heal")
// 		this.fading_slow_duration = this.ability.GetSpecialValueFor("fading_slow_duration")
// 		this.fading_slow_pct = this.ability.GetSpecialValueFor("fading_slow_pct")
//         this.damage_table = {
//             attacker = this.parent,
//             damage = this.ability.GetSpecialValueFor("ability_damage"),
//             damage_type = DAMAGE_TYPE_PURE,
//         }

//         const origin = this.parent.GetAbsOrigin()
//         const efx = ParticleManager.CreateParticle("particles/spectre/spectre_ex_counter.vpcf", ParticleAttachment.OVERHEAD_FOLLOW, this.parent)
//         ParticleManager.SetParticleControl(efx, 2, Vector(this.radius, this.radius, this.radius))
//         ParticleManager.SetParticleControlEnt(efx, 3, this.parent, ParticleAttachment.ABSORIGIN_FOLLOW, undefined, origin, true)
//         ParticleManager.SetParticleControlEnt(efx, 6, this.parent, ParticleAttachment.POINT_FOLLOW, "attach_attack2", origin, true)
//         this.AddParticle(efx, false, false, -1, false, false)
//     }
// }

// function modifier_spectre_ex_counter:OnDestroy()
//     if (IsServer()){
//         const origin = this.parent.GetAbsOrigin()
//         const give_health = false
//         ApplyCallbackForUnitsInArea(this.parent, origin, this.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
//             this.damage_table.victim = unit
//             ApplyDamage(this.damage_table)

//             unit:AddNewModifier(this.caster, this.ability, "modifier_generic_fading_slow", {
//                 duration = this.fading_slow_duration,
//                 max_slow_pct = this.fading_slow_pct
//             })

//             unit:AddNewModifier(this.caster, this.ability, "modifier_spectre_ex_counter_debuff", {
//                 duration = 0.25
//             })

//             if (CustomEntitiesLegacy:ProvidesMana(unit)){
//                 give_health = true
//             }

//             EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', ParticleAttachment.WORLDORIGIN, unit, {
//                 cp0 = unit:GetAbsOrigin(),
//                 release = true,
//             })

//             EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', ParticleAttachment.WORLDORIGIN, unit, {
//                 cp0 = unit:GetAbsOrigin(),
//                 release = true,
//             })
//         })

//         if (give_health){
//             this.parent.Heal(this.heal, this.parent)
//         }

//         EmitSoundOn("Hero_ShadowDemon.DemonicPurge.Damage", this.parent)
//         const efx = ParticleManager.CreateParticle("particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
//         ParticleManager.SetParticleControl(efx, 2, Vector(this.radius, this.radius, this.radius))

//         CreateRadiusMarker(this.parent, origin, this.radius, RADIUS_SCOPE_PUBLIC, 0.1)
//     }
// }

// function modifier_spectre_ex_counter:GetStatusLabel() return "Revenant" }
// function modifier_spectre_ex_counter:GetStatusPriority() return 2 }
// function modifier_spectre_ex_counter:GetStatusStyle() return "Revenant" }
// function modifier_spectre_ex_counter:GetStatusContentType() return STATUS_CONTENT_FILLUP }
// function modifier_spectre_ex_counter:GetStatusEffectName()
//     return "particles/status_fx/status_effect_grimstroke_ink_swell.vpcf"
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_spectre_ex_counter)

// modifier_spectre_ex_counter_debuff = class({})

// function modifier_spectre_ex_counter_debuff:OnCreated(table)
//     if (IsServer()){
//         this.StartIntervalThink(0.03)
//     }
// }

// function modifier_spectre_ex_counter_debuff:OnIntervalThink()
// 	const direction = (this.caster.GetAbsOrigin() - this.parent.GetAbsOrigin()):Normalized()
// 	const point = this.parent.GetAbsOrigin() + direction * 40
// 	this.parent.SetAbsOrigin(point)
// }
// modifier_spectre_counter = class({})

// function modifier_spectre_counter:OnCreated(params)
// 	if (IsServer()){
// 		const particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
// 		this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
// 	}
// }

// function modifier_spectre_counter:OnDestroy()
// 	if (IsServer()){
// 		ParticleManager.DestroyParticle(this.particleId, true)
// 		ParticleManager.ReleaseParticleIndex(this.particleId)
// 	}
// }

// function modifier_spectre_counter:GetEffectName()
//     return "particles/generic_gameplay/rune_haste.vpcf"
// }

// function modifier_spectre_counter:GetEffectAttachType()
// 	return ParticleAttachment.OVERHEAD_FOLLOW
// }

// function modifier_spectre_counter:GetMaxSlowPercentage()
// 	return this.ability.GetSpecialValueFor("fading_slow_pct")
// }

// function modifier_spectre_counter:GetStatusEffectName()
//     return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
// }

// function modifier_spectre_counter:GetEffectAttachType()
// 	return ParticleAttachment.ABSORIGIN_FOLLOW
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.FadingSlow(modifier_spectre_counter)

// modifier_spectre_counter_recast = class({})

// function modifier_spectre_counter_recast:GetRecastAbility()
//     if (IsServer()){
//         return this.parent.FindAbilityByName("spectre_counter_recast")
//     }
// }

// function modifier_spectre_counter_recast:GetRecastCharges()
// 	return 1
// }

// function modifier_spectre_counter_recast:GetRecastKey()
// 	return "Q"
// }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Recast(modifier_spectre_counter_recast)

// modifier_spectre_counter_countering = class({})

// function modifier_spectre_counter_countering:OnCreated(params)
//     this.fading_slow_duration = this.ability.GetSpecialValueFor("fading_slow_duration")
//     if (IsServer()){
//         this.particleId = ParticleManager.CreateParticle("particles/spectre/spectre_counter.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)

//         this.StartIntervalThink(0.03)
//     }
// }

// function modifier_spectre_counter_countering:OnIntervalThink()
//     const mouse = CustomAbilitiesLegacy:GetCursorPosition(this.ability)
// 	const direction = (mouse - this.parent.GetAbsOrigin()):Normalized()
//     this.PlayEffectsOnCast()

// 	CustomEntitiesLegacy:FullyFaceTowards(this.parent, Vector(direction.x, direction.y, this.parent.GetForwardVector().z))
// }

// function modifier_spectre_counter_countering:OnDestroy()
//     if (IsServer()){
//         EmitSoundOn("Hero_Spectre.HauntCast", this.parent)

//         ParticleManager.DestroyParticle(this.particleId, false)
//         ParticleManager.ReleaseParticleIndex(this.particleId)

//         const particleId = ParticleManager.CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
//         ParticleManager.ReleaseParticleIndex(particleId)
//     }
// }

// function modifier_spectre_counter_countering:OnTrigger()
//     if (IsServer()){
//         const modifier = this.parent.FindModifierByName("modifier_spectre_basic_attack_cooldown"):Replenish()

//         if (not this.parent.HasModifier('modifier_spectre_counter_recast')){
//             this.parent.AddNewModifier(this.parent, this.ability, "modifier_spectre_counter_recast", { duration = 5.0 })
//         }

//         if (this.ability.GetLevel() >= 2){
// 		    this.parent.FindModifierByName('modifier_spectre_mobility_charges'):RefreshCharges()
//         }

//         this.PlayEffectsOnTrigger()
//     }
// }

// function modifier_spectre_counter_countering:DeclareFunctions()
//     return {
//         MODIFIER_EVENT_ON_ABILITY_EXECUTED,
//     }
// }

// function modifier_spectre_counter_countering:OnAbilityExecuted(params)
//     if (IsServer()){
//         if (params.unit ~= this.parent){
//             return
//         }

//         if (params.ability ~= this.parent.FindAbilityByName("spectre_counter_recast")){
//             this.Destroy()
//         }
//     }
// }

// function modifier_spectre_counter_countering:OnOrder(params)
//     if (params.unit == this.parent){
//         if ( params.order_type == DOTA_UNIT_ORDER_STOP or
//             params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION
//        ){
//             this.Destroy()
//         }
//     }
// }

// function modifier_spectre_counter_countering:OnHit(params)
//     if (IsServer()){
// 		if (not params.bTriggerCounters){
// 			return true
//         }

//         const vDirection = undefined

//         if (params.iType == PROJECTILE_HIT){
//             const projectile = params.hProjectile
//             vDirection =  projectile:GetVelocity():Normalized()

//             if (projectile.bIsDestructible){
//                 projectile:ScheduleDestroy()
//             }
//         else
//             vDirection =  this.parent.GetAbsOrigin() - params.hSource:GetAbsOrigin()
//         }

//         const projection = this.GetProjection(vDirection)

//         if (projection <= -0.8){
//             this.OnTrigger()
//             return false
//         else
//             return true
//         }
// 	}
// }

// function modifier_spectre_counter_countering:GetProjection(vDirection)
//     return vDirection.x * this.parent.GetForwardVector().x + vDirection.y * this.parent.GetForwardVector().y
// }

// function modifier_spectre_counter_countering:PlayEffectsOnCast()
// 	const particleId =  ParticleManager.CreateParticle("particles/spectre/spectre_counter_shield.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
// 	ParticleManager.SetParticleControlForward(particleId, 0, this.parent.GetForwardVector())
// 	ParticleManager.ReleaseParticleIndex(particleId)
// }

// function modifier_spectre_counter_countering:PlayEffectsOnTrigger()
//     EmitSoundOn("Hero_Spectre.Reality", this.parent)
//     const particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
//     const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
//     ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin())
//     ParticleManager.SetParticleControl(particleId, 3, this.parent.GetAbsOrigin())
//     ParticleManager.ReleaseParticleIndex(particleId)
// }

// function modifier_spectre_counter_countering:GetStatusEffectName()
//     return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
// }

// function modifier_spectre_counter_countering:GetMovementSpeedPercentage() return 80 }
// function modifier_spectre_counter_countering:UseDefaultVisuals() return false }

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Counter(modifier_spectre_counter_countering)
// Modifiers.OnHit(modifier_spectre_counter_countering)
