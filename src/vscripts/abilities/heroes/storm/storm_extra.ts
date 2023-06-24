import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { clampPosition, createRadiusMarker, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierStormExBasicAttack, StormExBasicAttack } from "./storm_basic_attack";
import { StormSecondAttack } from "./storm_second_attack";

@registerAbility("storm_extra")
class StormExtra extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_4;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            return !ModifierStormExtraDisplacement.findOne(this.caster);
        }

        return false;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const minRange = this.GetSpecialValueFor("min_range");
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined), minRange });
        const direction = point.__sub(origin).Normalized();
        const distance = point.__sub(origin).Length2D();
        const level = ModifierStormExBasicAttack.findOne(this.caster)?.GetLevel() ?? 0;

        ModifierStormExtraDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: this.GetSpecialValueFor("speed"),
            peak: 1,
            level: level,
            radius: this.GetSpecialValueFor("radius"),
            teamFilter: UnitTargetTeam.ENEMY
        });

        const randomNumber = RandomInt(1, 32);
        const soundName = `stormspirit_ss_ability_lightning_${randomNumber < 10 ? "0" : ""}${randomNumber}`;

        EmitSoundOn(soundName, this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_extra_displacement" })
export class ModifierStormExtraDisplacement extends ModifierDisplacement {
    stunDuration!: number;
    healMultiplier!: number;
    damage!: number;
    damageAoe!: number;

    OnCreated(params: DisplacementParams & { level: number }) {
        super.OnCreated(params);

        if (IsServer()) {
            const stormExBasicAttack = StormExBasicAttack.findOne(this.parent);
            const damagePerLevel = stormExBasicAttack?.GetSpecialValueFor("damage_per_level") ?? 0;
            this.stunDuration = stormExBasicAttack?.GetSpecialValueFor("stun_duration") ?? 0;
            this.healMultiplier = stormExBasicAttack?.GetSpecialValueFor("heal_multiplier") ?? 0;

            const extraDamage = damagePerLevel * this.GetStackCount();
            this.damage = this.Value("ability_damage") + extraDamage;
            this.damageAoe = this.Value("aoe_damage") + extraDamage;

            this.SetStackCount(params.level);
            this.PlayEffectsOnCreated();
        }
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer()) {
            if (event.collision != "unit") {
                return;
            }

            for (const unit of event.units) {
                if (ModifierStormExtra.findOne(unit) || unit == this.parent) {
                    return;
                }
                ModifierStormExtra.apply(unit, this.parent, this.ability, { duration: 0.35 });
                this.OnImpactEnemyCollision(unit);
            }
        }
    }

    OnImpactEnemy(target: CDOTA_BaseNPC, damage: number) {
        if (this.GetStackCount() >= 1) {
            if (!isObstacle(target) && !isGem(target)) {
                this.parent.Heal(this.healMultiplier * damage, this.ability);
            }
        }

        if (this.GetStackCount() == 2) {
            ModifierStun.apply(target, this.parent, undefined, { duration: this.stunDuration });
        }

        ApplyDamage({
            victim: target,
            damage: damage,
            attacker: this.parent,
            damage_type: DamageTypes.PURE
        });

        if (!isObstacle(target) && this.ability.GetLevel() >= 2) {
            StormSecondAttack.findOne(this.parent)?.EndCooldown();
        }
    }

    OnImpactEnemyAOE(target: CDOTA_BaseNPC) {
        this.OnImpactEnemy(target, this.damageAoe);
        ModifierFadingSlow.apply(target, this.parent, undefined, {
            duration: this.Value("fading_slow_duration"),
            maxSlowPct: this.Value("fading_slow_pct")
        });
    }

    OnImpactEnemyCollision(target: CDOTA_BaseNPC) {
        this.OnImpactEnemy(target, this.damage);
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            const units = CustomEntitiesLegacy.FindUnitsInRadius(
                this.parent,
                this.parent.GetAbsOrigin(),
                this.radius,
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            );

            for (const unit of units) {
                this.OnImpactEnemyAOE(unit);
            }

            createRadiusMarker(this.parent, this.parent.GetAbsOrigin(), this.radius, "public", 0.1);
            ScreenShake(this.parent.GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true);
            StopSoundOn("Hero_StormSpirit.BallLightning.Loop", this.parent);
            this.PlayEffectsOnDestroy();

            const modifier = ModifierStormExBasicAttack.findOne(this.parent);
            if (modifier) {
                modifier.SetStackCount(modifier.GetStackCount() - 10);
            }
        }
    }

    GetEffectName() {
        const stacks = this.GetStackCount();
        if (stacks == 0) {
            return "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf";
        } else if (stacks == 1) {
            return "particles/econ/items/storm_spirit/storm_spirit_orchid_hat_retro/stormspirit_orchid_retro_ball_lightning.vpcf";
        } else {
            return "particles/storm/storm_ultimate_level_two.vpcf";
        }
    }

    GetEffectAttachType() {
        return ParticleAttachment.ROOTBONE_FOLLOW;
    }

    PlayEffectsOnCreated() {
        EmitSoundOn("Hero_StormSpirit.BallLightning", this.parent);
        EmitSoundOn("Hero_StormSpirit.BallLightning.Loop", this.parent);
    }

    PlayEffectsOnDestroy() {
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 2, this.parent.GetAbsOrigin());
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION];
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.ROOTED]: true,
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.OUT_OF_GAME]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_4;
    }

    GetIsCommandRestricted() {
        return false;
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_extra" })
class ModifierStormExtra extends CustomModifier {}
