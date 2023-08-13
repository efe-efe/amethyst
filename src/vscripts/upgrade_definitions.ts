import { findAbilityDefinitionByName } from "./abilities/framework/ability_definition";
import { CustomModifier } from "./abilities/framework/custom_modifier";
import { findPlayerById } from "./game";
import { registerModifier } from "./lib/dota_ts_adapter";
import { Player } from "./players";
import { precache, resource } from "./precache";
import { ProjectileBehavior, createProjectile } from "./projectiles";
import { areUnitsAllied, direction2D, getCursorPosition, randomInArray } from "./util";

type LegendDefinition = {
    id: LegendId;
};

type LegendOptions = {
    id: LegendId;
};

export type UpgradeDefinition = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
    validHeroes: HeroName[];
    values: Record<string, number | number[]>;
    legendId?: LegendId;
    modifier?: typeof CustomModifier<undefined>;
    // tier: "common" | "rare" | "veryRare" | "legendary";
    // maxStacks: number;
};

export type UpgradeOptions = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
    validHeroes?: string[];
    values?: Record<string, number | number[]>;
    legendId?: LegendId;
    modifier?: typeof CustomModifier<undefined>;
    // tier: "common" | "rare" | "veryRare" | "legendary";
    // maxStacks: number;
};

export const legendDefinitions: LegendDefinition[] = [];
export const upgradeDefinitions: UpgradeDefinition[] = [];

const resources = precache({
    chakram: resource.fx("particles/units/heroes/hero_shredder/shredder_chakram.vpcf"),
    chakramStay: resource.fx("particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf"),
    chillStatusFx: resource.fx("particles/status_fx/status_effect_iceblast.vpcf"),
    ancientDash: resource.fx("particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8_start.vpcf"),
    ancientExplosion: resource.fx("particles/creatures/aghanim/aghanim_crystal_attack_impact.vpcf")
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

@registerModifier()
class ModifierApparitionBasicAttack extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_TAKEDAMAGE];
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer() && event.inflictor && event.attacker == this.parent) {
            const definition = findAbilityDefinitionByName(event.inflictor.GetName());

            if (definition?.category == "basic") {
                ModifierApparitionChill.apply(event.unit, this.parent, undefined, { duration: 5 });
            }
        }
    }
}

@registerModifier()
class ModifierApparitionSpecialAttack extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_TAKEDAMAGE];
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer() && event.inflictor && event.attacker == this.parent) {
            const definition = findAbilityDefinitionByName(event.inflictor.GetName());

            if (definition?.category == "special") {
                ModifierApparitionChill.apply(event.unit, this.parent, undefined, { duration: 5 });
            }
        }
    }
}

@registerModifier()
class ModifierApparitionMobility extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST];
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent) {
            const definition = findAbilityDefinitionByName(event.ability.GetName());

            if (definition?.category == "mobility") {
                const particleId = ParticleManager.CreateParticle(resources.ancientDash.path, ParticleAttachment.WORLDORIGIN, this.parent);
                ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
                ParticleManager.ReleaseParticleIndex(particleId);

                const enemies = FindUnitsInRadius(
                    this.caster.GetTeam(),
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
                    ModifierApparitionChill.apply(enemy, this.parent, undefined, { duration: 5 });
                }
            }
        }
    }
}

//TODO: This is a state. Should have it's own tooltips and values
@registerModifier()
class ModifierApparitionChill extends CustomModifier<undefined> {
    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        const maxStacks = 10;

        if (IsServer() && this.GetStackCount() < maxStacks) {
            this.IncrementStackCount();

            if (this.GetStackCount() == maxStacks) {
                ParticleManager.ReleaseParticleIndex(
                    ParticleManager.CreateParticle(resources.ancientExplosion.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
                );

                this.Destroy();
            }
        }
    }

    GetStatusEffectName() {
        return resources.chillStatusFx.path;
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -20 * this.GetStackCount();
    }
}

function defineUpgrade(options: UpgradeOptions) {
    upgradeDefinitions.push({
        id: options.id,
        icon: options.icon,
        validHeroes: (options.validHeroes ?? []) as HeroName[],
        values: options.values ?? {},
        type: options.type,
        legendId: options.legendId,
        modifier: options.modifier
    });
}

function defineLegend(options: LegendOptions) {
    legendDefinitions.push({
        id: options.id
    });
}

// defineLegend({
//     id: LegendId.timbersaw
// });

defineLegend({
    id: LegendId.apparition
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.timbersaw,
    icon: "file://{images}/spellicons/shredder_chakram.png",
    id: UpgradeId.timberMobilityChakram,
    modifier: ModifierTimberMobilityChakram,
    values: {
        wheelDuration: 3,
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
        damage: 2,
        radius: 250,
        interval: 0.5
    }
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.apparition,
    icon: "file://{images}/spellicons/ancient_apparition_ice_vortex.png",
    id: UpgradeId.apparitionBasicAttack,
    modifier: ModifierApparitionBasicAttack
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.apparition,
    icon: "file://{images}/spellicons/ancient_apparition_ice_vortex.png",
    id: UpgradeId.apparitionSpecialAttack,
    modifier: ModifierApparitionSpecialAttack
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.apparition,
    icon: "file://{images}/spellicons/ancient_apparition_ice_vortex.png",
    id: UpgradeId.apparitionMobility,
    modifier: ModifierApparitionMobility
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.phantomFastDaggers,
    validHeroes: ["npc_dota_hero_phantom_assassin"],
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.phantomInstantCounter,
    validHeroes: ["npc_dota_hero_phantom_assassin"],
    icon: "file://{images}/spellicons/phantom_assassin_blur.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.phantomSecondRecast,
    validHeroes: ["npc_dota_hero_phantom_assassin"],
    icon: "raw://resource/flash3/images/spellicons/phantom_second_attack.png"
});

defineUpgrade({
    type: UpgradeType.shard,
    id: UpgradeId.phantomDashDaggers,
    validHeroes: ["npc_dota_hero_phantom_assassin"],
    icon: "file://{images}/spellicons/phantom_mobility.png"
});

defineUpgrade({
    type: UpgradeType.shard,
    id: UpgradeId.phantomExtraDaggers,
    validHeroes: ["npc_dota_hero_phantom_assassin"],
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.juggernautReflectSpin,
    validHeroes: ["npc_dota_hero_juggernaut"],
    icon: "file://{images}/spellicons/juggernaut_blade_fury.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.juggernautDagggerRefresh,
    validHeroes: ["npc_dota_hero_juggernaut"],
    icon: "raw://resource/flash3/images/spellicons/juggernaut_special_attack.png"
});

defineUpgrade({
    type: UpgradeType.shard,
    id: UpgradeId.juggernautAttackSpin,
    validHeroes: ["npc_dota_hero_juggernaut"],
    icon: "file://{images}/spellicons/juggernaut_blade_fury.png"
});

export function hasUpgrade(unit: CDOTA_BaseNPC, id: UpgradeId) {
    const playerId = unit.GetPlayerOwnerID();
    const player = findPlayerById(playerId);

    return player?.upgrades.find(upgrade => upgrade.id == id);
}

export function generateLegendUpgradesForPlayer(player: Player) {
    const legend = randomInArray(legendDefinitions);
    return upgradeDefinitions.filter(upgrade => upgrade.legendId == legend.id);
}

export function generateUpgradesOfTypeForPlayer(player: Player, upgradeType: UpgradeType) {
    function canHeroHaveUpgrade(upgrade: UpgradeDefinition, hero: string | undefined) {
        if (!hero) {
            return false;
        }

        return upgrade.validHeroes.length == 0 || upgrade.validHeroes.find(validHero => validHero == hero);
    }

    function canPlayerHaveUpgrade(player: Player, upgrade: UpgradeDefinition) {
        return !player.upgrades.some(playerUpgrade => playerUpgrade.id == upgrade.id);
    }

    return upgradeDefinitions.filter(
        upgrade =>
            upgrade.type == upgradeType &&
            canPlayerHaveUpgrade(player, upgrade) &&
            canHeroHaveUpgrade(upgrade, player.entity?.handle.GetUnitName())
    );
}
