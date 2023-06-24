import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { ModifierThinker } from "../../../modifiers/modifier_thinker";
import { ProjectileBehavior } from "../../../projectiles";
import { clampPosition, direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierSpectreBasicAttack } from "./spectre_basic_attack";
import { ModifierSpectreUltimate } from "./spectre_ultimate";

@registerAbility("spectre_mobility")
class SpectreMobility extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierSpectreMobility.name;
    }

    GetCooldown(level: number) {
        if (ModifierSpectreUltimate.findOne(this.caster)?.caster == this.caster) {
            return 1.0;
        }
        return super.GetCooldown(level);
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined),
            minRange: this.GetSpecialValueFor("min_range")
        });
        const projectileDirection = direction2D(origin, point);
        const projetileDistance = point.__sub(origin).Length2D();
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");

        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const damage = this.GetSpecialValueFor("ability_damage");
        const cooldownReduction = this.GetSpecialValueFor("cooldown_reduction");
        const radius = this.GetSpecialValueFor("radius");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            distance: projetileDistance,
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            wallBehavior: ProjectileBehavior.NOTHING,
            // bIsReflectable = false,
            // bIsSlowable = false,
            onFinish: projectile => {
                const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                    this.caster,
                    origin,
                    radius,
                    UnitTargetTeam.ENEMY,
                    UnitTargetType.HERO + UnitTargetType.BASIC,
                    UnitTargetFlags.NONE,
                    FindOrder.ANY
                );

                for (const enemy of enemies) {
                    ApplyDamage({
                        victim: enemy,
                        attacker: projectile.getSource(),
                        damage: damage,
                        damage_type: DamageTypes.PURE,
                        ability: this
                    });
                }

                if (enemies.some(enemy => !isObstacle(enemy))) {
                    ModifierSpectreBasicAttack.findOne(this.caster)?.ReduceCooldown(cooldownReduction);
                    if (enemies.some(enemy => !isGem(enemy))) {
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }
                }
                this.PlayEffectsOnFinish(radius);
                this.caster.RemoveModifierByName(ModifierSpectreMobilityBanish.name);
                FindClearSpaceForUnit(this.caster, projectile.getPosition(), true);
            }
        });

        this.PlayEffectsOnCast();
        ModifierSpectreMobilityBanish.apply(this.caster, this.caster, this, { duration: projetileDistance / projectileSpeed });
    }

    // OnUpgrade(){
    // 	if (this.GetLevel() == 2){
    // 		this.caster.FindModifierByName("modifier_spectre_mobility_charges"):AddCharge()
    // 	}
    // }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Spectre.HauntCast", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 2, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 3, Vector(250, 0, 0));
        ParticleManager.SetParticleControl(particleId, 4, this.caster.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnFinish(radius: number) {
        EFX("particles/units/heroes/hero_spectre/spectre_death.vpcf", ParticleAttachment.WORLDORIGIN, this.caster, {
            cp0: this.caster.GetAbsOrigin(),
            cp3: this.caster.GetAbsOrigin(),
            release: true
        });
        EFX("particles/sweep_generic/sweep_3.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
        EFX("particles/spectre/spectre_mobility.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp2: Vector(radius, 1, 1),
            release: true
        });
    }
}

@registerAbility("spectre_ex_mobility")
class SpectreExMobility extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

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
}

@registerModifier({ customNameForI18n: "modifier_spectre_mobility_thinker" })
class ModifierSpectreMobilityThinker extends ModifierThinker {
    // function modifier_spectre_mobility_thinker:OnCreated(params)
    //     if (IsServer()){
    //         const this.caster = this.caster
    //         const origin = this.parent.GetAbsOrigin()
    //         this.radius = this.ability.GetSpecialValueFor('radius')
    //         this.heal = this.ability.GetSpecialValueFor('heal')
    //         this.desolate_duration = this.ability.GetSpecialValueFor('desolate_duration')
    //         this.fear_duration = this.ability.GetSpecialValueFor('fear_duration')
    //         createTimedRadiusMarker(this.caster, origin, this.radius, this.GetDuration(), 0.2, "public")
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
}

@registerModifier({ customNameForI18n: "modifier_spectre_mobility_charges" })
class ModifierSpectreMobility extends ModifierCharges {
    GetMaxCharges() {
        return this.ability.GetSpecialValueFor("max_charges");
    }

    GetReplenishTime() {
        if (IsServer()) {
            return this.ability.GetCooldown(this.ability.GetLevel());
        }

        return 0;
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_ex_mobility_fear" })
class ModifierSpectreExMobility extends CustomModifier {}
// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Fear(modifier_spectre_ex_mobility_fear)

@registerModifier({ customNameForI18n: "modifier_spectre_banish" })
class ModifierSpectreMobilityBanish extends ModifierBanish {
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
}
