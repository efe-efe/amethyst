import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement } from "../../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../../modifiers/modifier_fading_slow";
import { ProjectileBehavior } from "../../../../projectiles";
import { clampPosition, direction2D, getCursorPosition } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";

@registerAbility("invoker_blast_custom")
class InvokerBlast extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_DEAFENING_BLAST;
    }
    GetPlaybackRateOverride() {
        return 1.0;
    }
    GetCastingCrawl() {
        return 20;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const projectileDistance = this.GetCastRange(Vector(0, 0, 0), undefined);
        const finalPoint = clampPosition(origin, point, { maxRange: projectileDistance, minRange: projectileDistance });

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6.vpcf",
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
                const distance = finalPoint.__sub(unit.GetAbsOrigin()).Length2D();
                ModifierInvokerBlastDisplacement.apply(unit, projectile.getSource(), this, {
                    x: projectileDirection.x,
                    y: projectileDirection.y,
                    distance: distance,
                    speed: projectileSpeed,
                    peak: 0
                });
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PURE
                });
            }
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnFinish(position: Vector) {
        EFX("particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf", ParticleAttachment.ABSORIGIN, this.caster, {
            cp0: position,
            cp1: position,
            cp2: position,
            release: true
        });
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Invoker.DeafeningBlast", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_blast_custom_displacement" })
class ModifierInvokerBlastDisplacement extends ModifierDisplacement {
    particleId?: ParticleID;
    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);
        if (IsServer()) {
            this.particleId = EFX(
                "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_knockback_debuff.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {}
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

            if (IsServer()) {
                if (this.particleId) {
                    ParticleManager.DestroyParticle(this.particleId, false);
                    ParticleManager.ReleaseParticleIndex(this.particleId);
                }
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
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
