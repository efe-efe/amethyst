import { findPlayerById } from "./game";
import { Player } from "./players";
import { randomInArray, takeNRandomFromArrayWeighted } from "./util";

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
    // tier: "common" | "rare" | "veryRare" | "legendary";
    // maxStacks: number;
};

export const legendDefinitions: LegendDefinition[] = [];
export const upgradeDefinitions: UpgradeDefinition[] = [];

function defineUpgrade(options: UpgradeOptions) {
    upgradeDefinitions.push({
        id: options.id,
        icon: options.icon,
        validHeroes: (options.validHeroes ?? []) as HeroName[],
        values: options.values ?? {},
        type: options.type,
        legendId: options.legendId
    });
}

function defineLegend(options: LegendOptions) {
    legendDefinitions.push({
        id: options.id
    });
}

defineLegend({
    id: LegendId.timbersaw
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.timbersaw,
    icon: "file://{images}/spellicons/shredder_chakram.png",
    id: UpgradeId.timberMobilityChakram
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
    icon: "file://{images}/spellicons/phantom_second_attack.png"
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
