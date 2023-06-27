import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { ModifierUpgradeStormRangedRemnant } from "../../../modifiers/upgrades/modifier_favors";
import { ModifierSleep } from "../../../modifiers/modifier_sleep";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierStormExtraDisplacement } from "./storm_extra";

@registerAbility("storm_mobility")
class StormMobility extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierStormMobility.name;
    }

    GetAnimation() {
        return GameActivity.DOTA_SPAWN;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 50;
    }

    GetCastRange(location: Vector, target: CDOTA_BaseNPC | undefined) {
        if (IsServer()) {
            if (ModifierStormExtraDisplacement.findOne(this.caster)) {
                return 0;
            }

            if (ModifierUpgradeStormRangedRemnant.findOne(this.caster)) {
                return 650;
            }
        }

        return super.GetCastRange(location, target);
    }

    GetCastPoint() {
        return ModifierStormExtraDisplacement.findOne(this.caster) ? 0 : super.GetCastPoint();
    }

    OnSpellStart() {
        const duration = this.GetSpecialValueFor("duration");
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(this.caster.GetAbsOrigin(), cursor, {
            maxRange: castRange
        });

        const groundPosition = GetGroundPosition(point, this.caster);
        if (ModifierUpgradeStormRangedRemnant.findOne(this.caster)) {
            EFX("particles/spectre/spectre_illusion_warp.vpcf", ParticleAttachment.CUSTOMORIGIN, this.caster, {
                cp0: {
                    ent: this.caster,
                    point: "attach_hitloc"
                },
                cp1: groundPosition,
                cp2: {
                    ent: this.caster,
                    point: "attach_hitloc"
                },
                release: true
            });
        }
        ModifierStormMobilityThinker.createThinker(this.caster, this, groundPosition, {
            duration: duration,
            radius: this.GetSpecialValueFor("radius"),
            content: "clearout"
        });
        EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", this.caster);
        // LinkAbilityCooldowns(this.caster, 'storm_ex_mobility')
    }
}

@registerModifier("modifier_storm_mobility_charges")
class ModifierStormMobility extends ModifierCharges {
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

@registerModifier("modifier_storm_mobility_thinker")
class ModifierStormMobilityThinker extends ModifierThinker {
    particleId!: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.PlayEffectsOnCreated();
        }
    }

    OnIntervalThink() {
        super.OnIntervalThink();

        let giveMana = false;
        let destroy = false;

        this.ability.AoeAttack({
            origin: this.origin,
            radius: this.radius,
            effect: (target: CDOTA_BaseNPC) => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: this.ability.GetSpecialValueFor("ability_damage"),
                    damage_type: DamageTypes.PURE
                });

                if (!isObstacle(target) && !isGem(target)) {
                    giveMana = true;
                }

                destroy = true;
            }
        });

        if (giveMana) {
            giveManaAndEnergyPercent(this.caster, this.Value("mana_gain_pct"), true);

            if (this.caster.HasModifier("modifier_storm_ultimate")) {
                // const extraManaPct = this.Value("mana_gain_pct") * (this.caster.FindModifierByName('modifier_storm_ultimate').GetManaMultiplier() - 1)
                // giveManaPercent(this.caster, extraManaPct, true, true)
            }
        }

        if (destroy) {
            this.Destroy();
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", this.parent);
            DEFX(this.particleId, false);
            UTIL_Remove(this.parent);
        }
    }

    PlayEffectsOnCreated() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf",
            ParticleAttachment.WORLDORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(this.particleId, 0, this.origin);
        /*
        this.particleId = EFX('particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf', ParticleAttachment.WORLDORIGIN, this.caster, {
            cp0 = this.origin,
            cp2 = Vector(RandomInt(37, 52), 1, 100),
            cp11 = this.origin,
        })
        */
        ParticleManager.SetParticleControlEnt(
            this.particleId,
            1,
            this.caster,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            this.origin,
            true
        );
        ParticleManager.SetParticleControl(this.particleId, 2, Vector(RandomInt(37, 52), 1, 100));
        ParticleManager.SetParticleControl(this.particleId, 11, this.origin);
        ParticleManager.SetParticleControlForward(this.particleId, 0, this.caster.GetForwardVector());
    }
}

@registerAbility("storm_ex_mobility")
class StormExMobility extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const duration = this.GetSpecialValueFor("duration");
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange
        });

        const groundPosition = GetGroundPosition(point, this.caster);
        ModifierStormExMobilityThinker.createThinker(this.caster, this, groundPosition, {
            duration: duration,
            radius: this.GetSpecialValueFor("radius"),
            content: "clearout",
            delayTime: this.GetSpecialValueFor("delay")
        });

        const particleId = EFX("particles/storm/storm_ex_mobility_launch.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp1: point + Vector(0, 0, 2000)
        });
        ParticleManager.SetParticleControlEnt(particleId, 0, this.caster, ParticleAttachment.POINT_FOLLOW, "attach_attack1", origin, false);
        EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", this.caster);
        // LinkAbilityCooldowns(this.caster, 'storm_mobility')
    }
}

@registerModifier("modifier_storm_ex_mobility_thinker")
class ModifierStormExMobilityThinker extends ModifierThinker {
    particleId!: ParticleID;

    OnReady() {
        this.PlayEffectsOnCreated();
    }

    OnIntervalThink() {
        super.OnIntervalThink();

        if (this.initialized) {
            const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                this.caster,
                this.origin,
                this.radius,
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            );

            for (const enemy of enemies) {
                ApplyDamage({
                    victim: enemy,
                    attacker: this.caster,
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                });
                ModifierSleep.apply(enemy, this.caster, undefined, { duration: this.Value("sleep_duration") });
            }

            if (enemies.length > 0) {
                this.Destroy();
            }
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", this.parent);
            DEFX(this.particleId, false);
        }
    }

    PlayEffectsOnCreated() {
        EFX("particles/storm/storm_ex_mobility_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: this.origin + Vector(0, 0, 1000),
            cp2: this.origin,
            release: true
        });
        this.particleId = EFX("particles/storm/storm_ex_mobility.vpcf", ParticleAttachment.WORLDORIGIN, this.caster, {
            cp0: this.origin,
            cp2: Vector(RandomInt(37, 52), 1, 100),
            cp11: this.origin
        });
        ParticleManager.SetParticleControlEnt(
            this.particleId,
            1,
            this.caster,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            this.origin,
            true
        );
        EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", this.parent);
    }
}
