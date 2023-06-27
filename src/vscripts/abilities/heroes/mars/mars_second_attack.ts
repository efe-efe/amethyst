import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { ModifierSleep } from "../../../modifiers/modifier_sleep";
import { clampPosition, direction2D, getCursorPosition, meeleEFX } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

class MarsSecondAttackCommon extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_4;
    }
    GetPlaybackRateOverride() {
        return 1.0;
    }
    GetCastingCrawl() {
        return 80;
    }
    GetFadeGestureOnCast() {
        return false;
    }

    PlayEffectsCone(direction: Vector, radius: number, path: string, color?: Vector) {
        const particleId = ParticleManager.CreateParticle(path, ParticleAttachment.WORLDORIGIN, this.caster);
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, Vector(radius, radius, radius));

        if (color) {
            ParticleManager.SetParticleControl(particleId, 60, color);
            ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0));
        }

        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);

        EmitSoundOnLocationWithCaster(this.caster.GetAbsOrigin(), "Hero_Mars.Shield.Cast", this.caster);
    }
}

@registerAbility("mars_second_attack")
class MarsSecondAttack extends MarsSecondAttackCommon {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange
        });
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)

        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const direction = direction2D(origin, point);
        const modifier = this.caster.FindModifierByName("modifier_juggernaut_ex_counter");
        const multiplier = this.GetSpecialValueFor("multiplier");
        const damage = this.caster.GetAverageTrueAttackDamage(this.caster) * multiplier;
        const knockbackDistance = this.GetSpecialValueFor("knockback_distance");

        meeleEFX(this.caster, direction, radius, modifier ? Vector(0, 255, 0) : undefined);

        this.MeeleAttack({
            direction,
            origin,
            radius,
            maxTargets: 1,
            attackType: "basic",
            effect: (target: CDOTA_BaseNPC) => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });

                ModifierMarsSecondAttack.apply(target, this.caster, this, {
                    x: direction.x,
                    y: direction.y,
                    distance: knockbackDistance,
                    speed: knockbackDistance / 0.25,
                    peak: 100
                });
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        this.caster.RemoveModifierByName(ModifierMarsSecondAttack.name);
        this.PlayEffectsCone(direction, radius, "particles/units/heroes/hero_mars/mars_shield_bash.vpcf");
        // LinkAbilityCooldowns(this.caster, 'mars_ex_second_attack')
    }
}

@registerAbility("mars_ex_second_attack")
class MarsExSecondAttack extends MarsSecondAttackCommon {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange
        });
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)

        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const direction = direction2D(origin, point);
        const modifier = this.caster.FindModifierByName("modifier_juggernaut_ex_counter");
        const damage = this.GetSpecialValueFor("ability_damage");
        const knockbackDistance = this.GetSpecialValueFor("knockback_distance");

        meeleEFX(this.caster, direction, radius, modifier ? Vector(0, 255, 0) : undefined);

        this.MeeleAttack({
            direction,
            origin,
            radius,
            maxTargets: 1,
            attackType: "basic",
            effect: (target: CDOTA_BaseNPC) => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });

                const mDirection = direction2D(origin, target.GetAbsOrigin());
                const leftDistance = radius - target.GetAbsOrigin().__sub(origin).Length2D();

                ModifierSleep.apply(target, this.caster, undefined, { duration: this.GetSpecialValueFor("sleep_duration") });
                ModifierMarsSecondAttack.apply(target, this.caster, this, {
                    x: mDirection.x,
                    y: mDirection.y,
                    distance: leftDistance + knockbackDistance,
                    speed: (leftDistance + knockbackDistance) / 0.25,
                    peak: 100,
                    targetType: UnitTargetType.ALL
                });
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        this.PlayEffectsCone(
            direction,
            radius,
            "particles/econ/items/mars/mars_fall20_immortal_shield/mars_fall20_immortal_shield_bash.vpcf",
            Vector(244, 49, 255)
        );
        // LinkAbilityCooldowns(this.caster, 'mars_second_attack')
    }
}

@registerModifier("modifier_mars_second_attack_displacement")
class ModifierMarsSecondAttack extends ModifierDisplacement {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            ModifierFadingSlow.apply(this.parent, this.caster, undefined, {
                duration: this.Value("fading_slow_duration"),
                maxSlowPct: this.Value("fading_slow_pct")
            });
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }
    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer()) {
            if (event.collision == "unit") {
                for (const unit of event.units) {
                    //@Refactor wtf is this
                    if (unit.GetName() == "npc_dota_phantomassassin_gravestone") {
                        this.Destroy();
                    }
                }
            }

            if (event.collision == "wall") {
                this.Destroy();
            }
        }
    }
}
