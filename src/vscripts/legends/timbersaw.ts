import { findAbilityDefinitionByName } from "../abilities/framework/ability_definition";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { precache, resource } from "../precache";
import { ProjectileBehavior, createProjectile } from "../projectiles";
import { defineLegend, defineUpgrade } from "../upgrade_definitions";
import { areUnitsAllied, direction2D, getCursorPosition } from "../util";

const resources = precache({
    chakram: resource.fx("particles/units/heroes/hero_shredder/shredder_chakram.vpcf"),
    chakramStay: resource.fx("particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf")
});

@registerModifier()
class ModifierTimberMobilityChakram extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    wheelDuration!: number;
    damage!: number;
    radius!: number;
    interval!: number;

    OnCreated(params: { wheelDuration: number; radius: number; damage: number; interval: number }) {
        if (IsServer()) {
            this.wheelDuration = params.wheelDuration;
            this.damage = params.damage;
            this.radius = params.radius;
            this.interval = params.interval;
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST];
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent) {
            const definition = findAbilityDefinitionByName(event.ability.GetName());

            if (definition?.category == "mobility") {
                ModifierTimberChakramThinker.createThinker(this.parent, undefined, this.parent.GetAbsOrigin(), {
                    duration: this.wheelDuration,
                    damage: this.damage,
                    radius: this.radius,
                    interval: this.interval
                });
            }
        }
    }
}

@registerModifier()
class ModifierTimberChakramThinker extends CustomModifier<undefined> {
    particleId!: ParticleID;
    damage!: number;
    radius!: number;

    OnCreated(params: { radius: number; damage: number; interval: number }) {
        if (IsServer()) {
            this.caster.EmitSound("Hero_Shredder.Chakram");

            this.radius = params.radius;
            this.damage = params.damage;

            this.particleId = ParticleManager.CreateParticle(resources.chakramStay.path, ParticleAttachment.WORLDORIGIN, undefined);
            ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 15, Vector(255, 165, 0));

            this.StartIntervalThink(params.interval);
        }
    }

    OnIntervalThink() {
        const enemies = FindUnitsInRadius(
            this.caster.GetTeam(),
            this.parent.GetAbsOrigin(),
            undefined,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.CREEP,
            UnitTargetFlags.NONE,
            FindOrder.ANY,
            false
        );

        for (const enemy of enemies) {
            ApplyDamage({
                attacker: this.caster,
                damage: this.damage,
                damage_type: DamageTypes.MAGICAL,
                victim: enemy
            });
        }
    }

    OnDestroy(): void {
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, true);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}

@registerModifier()
class ModifierTimberSpecialChakram extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    wheelDuration!: number;
    damage!: number;
    radius!: number;
    interval!: number;
    distance!: number;
    speed!: number;
    impactDamage!: number;

    OnCreated(params: {
        distance: number;
        speed: number;
        wheelDuration: number;
        radius: number;
        damage: number;
        interval: number;
        impactDamage: number;
    }) {
        if (IsServer()) {
            this.distance = params.distance;
            this.speed = params.speed;
            this.wheelDuration = params.wheelDuration;
            this.damage = params.damage;
            this.radius = params.radius;
            this.interval = params.interval;
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST];
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent) {
            const definition = findAbilityDefinitionByName(event.ability.GetName());

            if (definition?.category == "special") {
                const origin = this.parent.GetAbsOrigin();
                const point = getCursorPosition(this.parent);
                const projectileDirection = direction2D(origin, point);

                createProjectile({
                    source: this.parent,
                    effectName: resources.chakram.path,
                    spawnOrigin: origin,
                    velocity: projectileDirection.__mul(this.speed),
                    groundOffset: 0,
                    startRadius: this.radius,
                    distance: this.distance,
                    unitBehavior: ProjectileBehavior.NOTHING,
                    unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
                    onUnitHit: unit => {
                        ApplyDamage({
                            victim: unit,
                            attacker: this.caster,
                            damage: this.impactDamage,
                            damage_type: DamageTypes.MAGICAL
                        });
                    },
                    onFinish: projectile => {
                        ModifierTimberChakramThinker.createThinker(this.parent, undefined, projectile.getPosition(), {
                            duration: this.wheelDuration,
                            damage: this.damage,
                            radius: this.radius,
                            interval: this.interval
                        });
                    }
                });
            }
        }
    }
}

defineLegend({
    id: LegendId.timbersaw
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.timbersaw,
    icon: "file://{images}/spellicons/shredder_chakram.png",
    id: UpgradeId.timberMobilityChakram,
    modifier: ModifierTimberMobilityChakram,
    values: {
        wheelDuration: {
            initial: 3,
            perk: 2,
            formula: (perk, level) => {
                if (level == 1) {
                    return 0;
                }

                if (level == 2) {
                    return perk;
                }

                return 1;
            }
        },
        damage: 2,
        radius: 250,
        interval: 0.5
    }
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.timbersaw,
    icon: "file://{images}/spellicons/shredder_chakram.png",
    id: UpgradeId.timberSpecialChakram,
    modifier: ModifierTimberSpecialChakram,
    values: {
        distance: 600,
        speed: 1500,
        wheelDuration: 3,
        impactDamage: 5,
        damage: {
            initial: 2,
            perk: 6,
            formula: (perk, level) => {
                if (level == 1) {
                    return 0;
                }

                if (level == 2) {
                    return perk;
                }

                return Math.max(1, perk - level);
            }
        },
        radius: 250,
        interval: 0.5
    }
});
