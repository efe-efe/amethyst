import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { direction2D } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("sniper_extra")
class SniperExtra extends CustomAbility {
    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            EmitSoundOn("Ability.AssassinateLoad", this.caster);
            return true;
        }
        return false;
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 0.4;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const knockbackDistance = this.GetSpecialValueFor("knockback_distance");
        const damage = this.GetSpecialValueFor("damage_per_bullet");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const straightDirection = direction2D(origin, point);
        const directions: Vector[] = [];

        directions.push(straightDirection);
        directions.push(RotatePoint(Vector(0, 0, 0), Vector(0, 0, 0).__add(straightDirection), -30).Normalized());
        directions.push(RotatePoint(Vector(0, 0, 0), Vector(0, 0, 0).__add(straightDirection), 30).Normalized());

        for (const direction of directions) {
            this.ProjectileAttack({
                source: this.caster,
                effectName: "particles/sniper/sniper_extra.vpcf",
                spawnOrigin: origin.__add(Vector(0, 0, 60)),
                velocity: direction.__mul(projectileSpeed),
                groundOffset: 0,
                unitTest: (unit, projectile) =>
                    unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
                onUnitHit: (unit, projectile) => {
                    const x = unit.GetAbsOrigin().x - origin.x;
                    const y = unit.GetAbsOrigin().y - origin.y;

                    const distance = knockbackDistance - unit.GetAbsOrigin().__sub(origin).Length2D();

                    ModifierSniperExtraEnemy.apply(unit, projectile.getSource(), this, {
                        x: x,
                        y: y,
                        distance: distance,
                        speed: distance / 0.35,
                        peak: 32
                    });
                    ApplyDamage({
                        victim: unit,
                        attacker: projectile.getSource(),
                        damage: damage,
                        damage_type: DamageTypes.MAGICAL
                    });
                },
                onFinish: projectile => {
                    this.PlayEffectsOnFinish(projectile.getPosition());
                }
            });
        }

        const knockbackDirection = point.__sub(origin).__mul(Vector(-1, -1, -1)).Normalized();

        ModifierSniperExtra.apply(this.caster, this.caster, this, {
            x: knockbackDirection.x,
            y: knockbackDirection.y,
            distance: knockbackDistance,
            speed: knockbackDistance / 0.35,
            peak: 64
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Techies.LandMine.Detonate", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Sniper.ProjectileImpact", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_techies/techies_base_attack_explosion.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier({ customNameForI18n: "modifier_sniper_extra_displacement" })
class ModifierSniperExtra extends ModifierDisplacement {
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

@registerModifier({ customNameForI18n: "modifier_sniper_extra_displacement_enemy" })
class ModifierSniperExtraEnemy extends ModifierDisplacement {
    OnCollide(event: OnCollisionEvent) {
        if (IsServer()) {
            if (event.collision == "wall") {
                ApplyDamage({
                    victim: this.parent,
                    attacker: this.caster,
                    damage: this.Value("damage_on_collision"),
                    damage_type: DamageTypes.MAGICAL
                });
                this.Destroy();
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
