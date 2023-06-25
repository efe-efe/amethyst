import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierThinker, ModifierThinkerParams } from "../../../../modifiers/modifier_thinker";
import { ProjectileBehavior } from "../../../../projectiles";
import { clampPosition, direction2D, getCursorPosition } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";
import { CustomModifier } from "../../../framework/custom_modifier";

@registerAbility("invoker_meteor_custom")
class InvokerMeteor extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_CHAOS_METEOR;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 80;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined),
            minRange: this.GetSpecialValueFor("min_range")
        });

        ModifierInvokerMeteorImpactThinker.createThinker(this.caster, this, point, {
            radius: this.GetSpecialValueFor("radius"),
            delayTime: this.GetSpecialValueFor("delay_time"),
            x: origin.x,
            y: origin.y
        });
        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EFX("particles/invoker/invoker_meteor_cast.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
        EmitSoundOn("Hero_Invoker.ChaosMeteor.Cast", this.caster);
    }
}

@registerModifier()
class ModifierInvokerMeteorImpactThinker extends ModifierThinker {
    direction!: Vector;

    OnCreated(params: ModifierThinkerParams & { x: number; y: number }) {
        super.OnCreated(params);

        if (IsServer()) {
            const casterOrigin = Vector(params.x, params.y);
            this.direction = direction2D(casterOrigin, this.origin);

            AddFOWViewer(this.caster.GetTeamNumber(), this.origin, this.radius, this.delayTime + 0.2, true);

            const endPoint = this.origin.__add(this.direction.__mul(this.Value("projectile_speed"))).__sub(Vector(0, 0, 1000));
            const efx = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.caster
            );
            ParticleManager.SetParticleControl(efx, 0, casterOrigin.__add(Vector(0, 0, 1000)));
            ParticleManager.SetParticleControl(efx, 1, endPoint);
            ParticleManager.SetParticleControl(efx, 2, Vector(1.0, 0, 0));

            EmitSoundOn("Hero_Invoker.ChaosMeteor.Loop", this.caster);
        }
    }

    OnReady() {
        let counter = 0;

        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.ability.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(this.origin, point);
        const projectileDistance = this.Value("projectile_distance");

        ModifierInvokerMeteorThinker.createThinker(this.caster, this.ability, this.origin, {
            duration: this.Value("duration_linger")
        });

        this.ability.ProjectileAttack({
            source: this.caster,
            effectName: "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
            spawnOrigin: this.origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 0)),
            velocity: this.direction.__mul(projectileSpeed),
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
                const damage_table = {
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                };
                ApplyDamage(damage_table);
            },
            afterUpdate: projectile => {
                counter++;

                if (counter == 5) {
                    ModifierInvokerMeteorThinker.createThinker(this.caster, this.ability, projectile.getPosition(), {
                        duration: this.Value("duration_linger")
                    });
                    counter = 0;
                }
            },
            onFinish: projectile => {
                EFX("particles/units/heroes/hero_invoker/invoker_chaos_meteor_crumble.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                    cp0: projectile.getPosition(),
                    cp3: projectile.getPosition().__add(Vector(0, 0, 32)),
                    release: true
                });
                EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", this.caster);
                StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", this.caster);
            }
        });

        EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", this.caster);

        EFX("particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: Vector(this.radius, 0, 0),
            release: true
        });

        this.Destroy();
    }

    PlayEffectsOnFinish(position: Vector) {
        EFX("particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf", ParticleAttachment.ABSORIGIN, this.caster, {
            cp0: position,
            cp1: position,
            cp2: position,
            release: true
        });
    }
}

@registerModifier()
class ModifierInvokerMeteorThinker extends CustomModifier {
    origin!: Vector;
    particleId?: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();

            this.StartIntervalThink(this.Value("delay_time"));

            this.particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fire_trail.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined
            );
            ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 3, this.parent.GetAbsOrigin());
        }
    }

    OnIntervalThink() {
        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            this.origin,
            this.Value("radius_linger"),
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.Value("damage_linger"),
                damage_type: DamageTypes.PURE
            });
        }
    }

    OnDestroy() {
        if (IsServer()) {
            UTIL_Remove(this.parent);
            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
        }
    }
}
