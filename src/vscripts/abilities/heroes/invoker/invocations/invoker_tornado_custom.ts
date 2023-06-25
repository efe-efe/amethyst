import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement } from "../../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../../modifiers/modifier_fading_slow";
import { ProjectileBehavior } from "../../../../projectiles";
import { direction2D, getCursorPosition } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";

@registerAbility("invoker_tornado_custom")
class InvokerTornado extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_TORNADO;
    }
    GetPlaybackRateOverride() {
        return 1.3;
    }
    GetCastingCrawl() {
        return 100;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const projectileDistance = this.GetCastRange(Vector(0, 0, 0), undefined);

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/econ/items/invoker/invoker_ti6/invoker_tornado_ti6.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            distance: projectileDistance,
            triggerCounters: false,
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            wallBehavior: ProjectileBehavior.NOTHING,
            // bIsReflectable =        false,
            isDestructible: false,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    damage: damage,
                    damage_type: DamageTypes.PURE,
                    victim: unit,
                    attacker: projectile.getSource()
                });

                ModifierInvokerTornado.apply(unit, projectile.getSource(), this, {
                    x: projectileDirection.x,
                    y: projectileDirection.y,
                    distance: 1,
                    speed: 1 / 1.0,
                    peak: 350
                });

                EmitSoundOn("Hero_Invoker.Tornado.Target", unit);
            },
            onFinish: projectile => {
                EFX("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                    cp0: projectile.getPosition(),
                    release: true
                });
                StopSoundOn("Hero_Invoker.Tornado", this.caster);
            }
        });

        EmitSoundOn("Hero_Invoker.Tornado", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_tornado_custom_displacement" })
class ModifierInvokerTornado extends ModifierDisplacement {
    particleId?: ParticleID;

    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);
        if (IsServer()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/econ/items/invoker/invoker_ti6/invoker_tornado_child_ti6.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.parent
            );
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            ModifierFadingSlow.apply(this.parent, this.caster, undefined, {
                duration: this.Value("fading_slow_duration"),
                maxSlowPct: this.Value("fading_slow_pct")
            });

            StopSoundOn("Hero_Invoker.Tornado.Target", this.parent);
            EmitSoundOn("Hero_Invoker.Tornado.LandDamage", this.parent);

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
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
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.OUT_OF_GAME]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
