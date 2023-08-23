import { CustomModifier } from "./abilities/framework/custom_modifier";
import { findPlayerById } from "./game";
import { Player } from "./players";
import { takeNRandomFromArrayWeighted } from "./util";

type LegendDefinition = {
    id: LegendId;
    model: string;
};

type LegendOptions = {
    id: LegendId;
    model: string;
};

type LevelableValue = {
    initial: number;
    perk: number;
    formula: (perk: number, level: number) => number;
};

export type UpgradeInstance = {
    definition: UpgradeDefinition;
    level: number;
};

export type UpgradeDefinition = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
    validHeroes: HeroName[];
    values: Record<string, number | LevelableValue>;
    legendId?: LegendId;
    modifier?: typeof CustomModifier<undefined>;
    // tier: "common" | "rare" | "veryRare" | "legendary";
};

export type UpgradeOptions = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
    validHeroes?: string[];
    values?: Record<string, number | LevelableValue>;
    legendId?: LegendId;
    modifier?: typeof CustomModifier<undefined>;
    // tier: "common" | "rare" | "veryRare" | "legendary";
};

export const legendDefinitions: LegendDefinition[] = [];
export const upgradeDefinitions: UpgradeDefinition[] = [];

export function findLegendById(id: LegendId) {
    return legendDefinitions.find(definition => definition.id == id);
}

export function getCurrentUpgradeValues(level: number, upgradeValues: Record<string, number | LevelableValue>) {
    const result: Record<string, number> = {};

    for (const [key, value] of Object.entries(upgradeValues)) {
        if (typeof value == "number") {
            result[key] = value;
            continue;
        }

        result[key] = value.initial + value.formula(value.perk, level);
    }

    return result;
}

export function defineUpgrade(options: UpgradeOptions) {
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

export function defineLegend(options: LegendOptions) {
    legendDefinitions.push({
        id: options.id,
        model: options.model
    });
}

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

    return player?.upgrades.find(upgrade => upgrade.definition.id == id);
}

export function generateLegendUpgradesForPlayer(player: Player, legendId: LegendId, amount: number) {
    function canPlayerHaveUpgrade(player: Player, upgrade: UpgradeDefinition) {
        return !player.upgrades.some(playerUpgrade => playerUpgrade.definition.id == upgrade.id);
    }

    const upgrades = upgradeDefinitions.filter(upgrade => upgrade.legendId == legendId && canPlayerHaveUpgrade(player, upgrade));

    return takeNRandomFromArrayWeighted(upgrades, amount, () => 1);
}

export function generateKnowledgeUpgradesForPlayer(player: Player, amount: number): UpgradeDefinition[] {
    const upgradeable = player.upgrades
        .filter(upgrade => Object.values(upgrade.definition.values).some(value => typeof value != "number"))
        .map(upgrade => upgrade.definition);
    return takeNRandomFromArrayWeighted(upgradeable, amount, () => 1);
}

export function generateUpgradesOfTypeForPlayer(player: Player, upgradeType: UpgradeType, amount: number) {
    function canHeroHaveUpgrade(upgrade: UpgradeDefinition, hero: string | undefined) {
        if (!hero) {
            return false;
        }

        return upgrade.validHeroes.length == 0 || upgrade.validHeroes.find(validHero => validHero == hero);
    }

    function canPlayerHaveUpgrade(player: Player, upgrade: UpgradeDefinition) {
        return !player.upgrades.some(playerUpgrade => playerUpgrade.definition.id == upgrade.id);
    }

    const upgrades = upgradeDefinitions.filter(
        upgrade =>
            upgrade.type == upgradeType &&
            canPlayerHaveUpgrade(player, upgrade) &&
            canHeroHaveUpgrade(upgrade, player.entity?.handle.GetUnitName())
    );

    return takeNRandomFromArrayWeighted(upgrades, amount, () => 1);
}
