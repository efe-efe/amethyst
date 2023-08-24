import { findAbilityDefinitionByName } from "../abilities/framework/ability_definition";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "../modifiers/modifier_combat_events";
import { precache, resource } from "../precache";
import { ProjectileBehavior, createProjectile } from "../projectiles";
import { areUnitsAllied, direction2D, getCursorPosition } from "../util";
import { defineUpgrade } from "./framework/upgrade_definitions";

const resources = precache({
    sounds: resource.soundFile("soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts"),
    chakram: resource.fx("particles/units/heroes/hero_shredder/shredder_chakram.vpcf"),
    chakramStay: resource.fx("particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf"),
    whirlingDeath: resource.fx("particles/units/heroes/hero_shredder/shredder_whirling_death.vpcf")
});

function getChakramExtraRadius(unit: CDOTA_BaseNPC) {
    return ModifierTimberChakramRadius.findOne(unit)?.GetStackCount() ?? 0;
}

@registerModifier()
class ModifierTimberChakramRadius extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    OnCreated(): void {
        this.SetStackCount(100);
    }
}

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
            EmitSoundOn("Hero_Shredder.Chakram", this.caster);

            this.radius = params.radius + getChakramExtraRadius(this.parent);
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
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, true);
            ParticleManager.ReleaseParticleIndex(this.particleId);
            StopSoundOn("Hero_Shredder.Chakram", this.caster);
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

@registerModifier()
class ModifierTimberAttackWhirling extends ModifierCombatEvents<undefined> {
    OnCreated() {
        this.SetStackCount(1);
    }

    OnBasicAttackLanded() {
        this.IncrementStackCount();
    }

    OnStackCountChanged() {
        if (IsServer()) {
            if (this.GetStackCount() >= 5) {
                this.SetStackCount(0);

                const enemies = FindUnitsInRadius(
                    this.parent.GetTeam(),
                    this.parent.GetAbsOrigin(),
                    undefined,
                    250,
                    UnitTargetTeam.ENEMY,
                    UnitTargetType.HERO + UnitTargetType.CREEP,
                    UnitTargetFlags.NONE,
                    FindOrder.ANY,
                    false
                );

                for (const enemy of enemies) {
                    ApplyDamage({
                        attacker: this.parent,
                        damage: 10,
                        damage_type: DamageTypes.MAGICAL,
                        victim: enemy
                    });
                }

                EmitSoundOn("Hero_Shredder.WhirlingDeath.Cast", this.parent);

                const particleId = ParticleManager.CreateParticle(
                    resources.whirlingDeath.path,
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                );
                ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
                ParticleManager.ReleaseParticleIndex(particleId);
            }
        }
    }
}

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

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.timbersaw,
    icon: "file://{images}/spellicons/shredder_whirling_death.png",
    id: UpgradeId.timberAttackWhirling,
    modifier: ModifierTimberAttackWhirling
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.timbersaw,
    icon: "file://{images}/spellicons/shredder_whirling_death.png",
    id: UpgradeId.timberChakramRadius,
    modifier: ModifierTimberChakramRadius,
    requirementSets: [[UpgradeId.timberSpecialChakram, UpgradeId.timberMobilityChakram]]
});
