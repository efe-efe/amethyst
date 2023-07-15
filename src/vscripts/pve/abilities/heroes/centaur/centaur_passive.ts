import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierCombatEvents, OnHitEvent } from "../../../../modifiers/modifier_combat_events";
import { precache, resource } from "../../../../precache";
import { areUnitsAllied, direction2D } from "../../../../util";

const resources = precache({
    hit: resource.fx("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"),
    projectile: resource.fx("particles/invoker/invoker_spirit_projectile.vpcf"),
    impact: resource.fx("particles/units/heroes/hero_invoker_kid/invoker_kid_forged_spirit_projectile_end.vpcf")
});

@registerAbility("centaur_passive")
class CentaurPassive extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierCentaurPassive.name;
    }
}

@registerModifier("modifier_centaur_passive")
class ModifierCentaurPassive extends ModifierCombatEvents {
    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            if (!event.triggerCounters) {
                return true;
            }

            ParticleManager.ReleaseParticleIndex(
                ParticleManager.CreateParticle(resources.hit.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
            );

            if (event.attackCategory == "projectile") {
                this.LaunchProjectile(event.projectile.getSource().GetAbsOrigin());
            }

            return true;
        }

        return true;
    }

    LaunchProjectile(point: Vector) {
        if (IsServer()) {
            const origin = this.parent.GetAbsOrigin();
            const projectileDirection = direction2D(origin, point);
            const projectileSpeed = 500;
            const damage = 7;

            this.ability.ProjectileAttack({
                source: this.parent,
                attackType: "basic",
                effectName: resources.projectile.path,
                distance: 1200,
                startRadius: 70,
                spawnOrigin: origin.__add(Vector(0, 0, 96)),
                velocity: projectileDirection.__mul(projectileSpeed),
                groundOffset: 0,
                unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
                onUnitHit: (unit, projectile) => {
                    ApplyDamage({
                        victim: unit,
                        attacker: projectile.getSource(),
                        damage: damage,
                        damage_type: DamageTypes.PHYSICAL,
                        ability: this.ability
                    });
                },
                onFinish: projectile => {
                    EFX(resources.impact.path, ParticleAttachment.WORLDORIGIN, undefined, {
                        cp0: projectile.getPosition(),
                        cp3: projectile.getPosition()
                    });
                }
            });
        }
    }
}
