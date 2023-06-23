import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { createRadiusMarker, direction2D, fullyFaceTowards } from "../util";
import { CustomAbility } from "./framework/custom_ability";
import { CustomModifier } from "./framework/custom_modifier";

@registerAbility("passive_shoot")
class PassiveShot extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierPassiveShot.name;
    }
}

@registerModifier({ customNameForI18n: "modifier_passive_shoot" })
class ModifierPassiveShot extends CustomModifier {
    radius = 700;

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(1.0);
        }
    }

    OnIntervalThink() {
        const origin = this.parent.GetAbsOrigin();

        if (!this.parent.IsAlive()) {
            return;
        }

        createRadiusMarker(this.parent, origin, this.radius, "public", 0.1);

        const enemy = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            origin,
            this.radius,
            UnitTargetTeam.BOTH,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        )
            .filter(enemy => enemy != this.parent)
            .shift();

        if (enemy) {
            const point = enemy.GetAbsOrigin();
            const projectileDirection = direction2D(origin, point);
            const projectileSpeed = 1200;
            const projectileHitbox = 100;

            fullyFaceTowards(this.parent, Vector(projectileDirection.x, projectileDirection.y, this.parent.GetForwardVector().z));

            this.ability.ProjectileAttack({
                source: this.caster,
                effectName: "particles/phantom/phantom_special_attack.vpcf",
                distance: this.radius,
                startRadius: projectileHitbox,
                spawnOrigin: origin.__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
                velocity: projectileDirection.__mul(projectileSpeed),
                groundOffset: 0,
                unitTest: (unit, projectile) =>
                    unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
                onUnitHit: (unit, projectile) => {
                    ApplyDamage({
                        victim: unit,
                        attacker: projectile.getSource(),
                        damage: this.ability.GetAbilityDamage(),
                        damage_type: DamageTypes.PHYSICAL
                    });
                }
            });
        }
    }
}
