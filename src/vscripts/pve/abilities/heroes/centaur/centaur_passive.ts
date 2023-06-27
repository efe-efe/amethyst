import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierCombatEvents, OnHitEvent } from "../../../../modifiers/modifier_combat_events";
import { direction2D } from "../../../../util";

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
                ParticleManager.CreateParticle(
                    "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
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
                effectName: "particles/invoker/invoker_spirit_projectile.vpcf",
                distance: 1200,
                startRadius: 70,
                spawnOrigin: origin.__add(Vector(0, 0, 96)),
                velocity: projectileDirection.__mul(projectileSpeed),
                groundOffset: 0,
                unitTest: (unit, projectile) =>
                    unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
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
                    EFX(
                        "particles/units/heroes/hero_invoker_kid/invoker_kid_forged_spirit_projectile_end.vpcf",
                        ParticleAttachment.WORLDORIGIN,
                        undefined,
                        {
                            cp0: projectile.getPosition(),
                            cp3: projectile.getPosition()
                        }
                    );
                }
            });
        }
    }
}
