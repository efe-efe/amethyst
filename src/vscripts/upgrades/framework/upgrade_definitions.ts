import { CustomModifier } from "../../abilities/framework/custom_modifier";
import { findPlayerById } from "../../game";
import { Player } from "../../players";
import { takeNRandomFromArrayWeighted } from "../../util";

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
    requirementSets: UpgradeId[][];
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
    requirementSets?: UpgradeId[][];
    // tier: "common" | "rare" | "veryRare" | "legendary";
};

let listLocked = false;

export const upgradeDefinitions: UpgradeDefinition[] = [];

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
    // Top-level constructs are called every time an upgrade is spawned, so we need to prevent re-registration of upgrades
    if (listLocked || IsClient()) return;

    upgradeDefinitions.push({
        id: options.id,
        icon: options.icon,
        validHeroes: (options.validHeroes ?? []) as HeroName[],
        values: options.values ?? {},
        type: options.type,
        legendId: options.legendId,
        modifier: options.modifier,
        requirementSets: options.requirementSets ?? []
    });

    print(`Defined upgrade: ${options.id}`);
}

export function hasUpgrade(unit: CDOTA_BaseNPC, id: UpgradeId) {
    const playerId = unit.GetPlayerOwnerID();
    const player = findPlayerById(playerId);

    return player?.upgrades.find(upgrade => upgrade.definition.id == id);
}

export function generateLegendUpgradesForPlayer(player: Player, legendId: LegendId, amount: number) {
    function canPlayerHaveUpgrade(player: Player, upgrade: UpgradeDefinition) {
        return !player.upgrades.some(playerUpgrade => playerUpgrade.definition.id == upgrade.id);
    }

    function playerHasUpgrade(player: Player, upgradeId: UpgradeId) {
        return player.upgrades.some(upgrade => upgrade.definition.id == upgradeId);
    }

    function hasRequirements(player: Player, upgrade: UpgradeDefinition) {
        for (const requirements of upgrade.requirementSets) {
            if (!requirements.some(requirement => playerHasUpgrade(player, requirement))) {
                return false;
            }
        }

        return true;
    }

    const upgrades = findAllUpgradesForLegendId(legendId).filter(
        upgrade => canPlayerHaveUpgrade(player, upgrade) && hasRequirements(player, upgrade)
    );

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

export function findUpgradeById(upgradeId: UpgradeId) {
    return upgradeDefinitions.find(definition => definition.id == upgradeId);
}

export function findAllUpgradesForLegendId(legendId: LegendId) {
    return upgradeDefinitions.filter(definition => definition.legendId == legendId);
}

export function lockUpgradeList() {
    listLocked = true;
}
