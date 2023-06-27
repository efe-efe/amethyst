import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ModifierRoot } from "../../../modifiers/modifier_root";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { ProjectileBehavior } from "../../../projectiles";
import { direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierMarsStacks } from "./mars_basic_attack";

@registerAbility("mars_special_attack")
class MarsSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_5;
    }

    GetPlaybackRateOverride() {
        return 0.9;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const projectileDistance = this.GetCastRange(Vector(0, 0, 0), undefined);

        const damage = this.GetSpecialValueFor("ability_damage");
        const damagePerStack = this.GetSpecialValueFor("damage_per_stack");
        const stacks = ModifierMarsStacks.findOne(this.caster)?.GetStackCount() ?? 0;
        const finalDamage = damage + stacks * damagePerStack;

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/units/heroes/hero_mars/mars_spear.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 80, projectileDirection.y * 80, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            distance: projectileDistance,
            unitBehavior: ProjectileBehavior.NOTHING,
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                if (projectile.hitLog.size > 1) {
                    return;
                }

                ApplyDamage({
                    victim: unit,
                    attacker: this.caster,
                    damage: finalDamage,
                    damage_type: DamageTypes.MAGICAL
                });

                const direction = projectile.getVelocity().Normalized();
                const distance = Math.max(0, projectileDistance - projectile.getDistanceTraveled());

                ModifierMarsSpecialAttack.apply(unit, projectile.getSource(), this, {
                    x: direction.x,
                    y: direction.y,
                    distance: distance,
                    speed: projectileSpeed,
                    peak: 1,
                    offset: 50,
                    targetType: UnitTargetType.ALL
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition(), projectile.getVelocity().Normalized());
            }
        });
        // ExecuteOrderFromTable({ OrderType = DOTA_UNIT_ORDER_STOP, UnitIndex = this.caster.entindex() })
        this.caster.RemoveModifierByName(ModifierMarsStacks.name);
        EmitSoundOn("Hero_Mars.Spear.Cast", this.caster);
    }

    PlayEffectsOnFinish(position: Vector, direction: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Mars.Spear.Target", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_mars/mars_spear_end.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.SetParticleControlForward(particleId, 3, direction);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_mars_special_attack_displacement")
export class ModifierMarsSpecialAttack extends ModifierDisplacement {
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
            if (
                event.collision == "wall" ||
                event.collision == "tree" ||
                (event.collision == "unit" && event.units.some(unit => unit.GetName() == "npc_dota_phantomassassin_gravestone"))
            ) {
                ApplyDamage({
                    victim: this.parent,
                    attacker: this.caster,
                    damage: this.Value("extra_damage"),
                    damage_type: DamageTypes.MAGICAL
                });

                if (this.ability.GetLevel() >= 2) {
                    ModifierStun.apply(this.parent, this.caster, undefined, { duration: this.Value("debuff_duration") });
                } else {
                    ModifierRoot.apply(this.parent, this.caster, this.ability, { duration: this.Value("debuff_duration") });
                }

                this.PlayEffectsOnImpact();
                this.Destroy();
            }
        }
    }

    PlayEffectsOnImpact() {
        const origin = this.parent.GetAbsOrigin();
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_mars/mars_spear_impact.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, Vector(origin.x, origin.y, origin.z - 64));
        ParticleManager.SetParticleControl(particleId, 1, this.direction.__mul(1000));
        ParticleManager.SetParticleControlForward(particleId, 0, this.direction);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
