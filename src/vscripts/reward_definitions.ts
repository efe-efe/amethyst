import { findPlayerById } from "./game";
import { precache, resource } from "./precache";

const resources = precache({
    stanceModel: resource.model("models/props_gameplay/stout_shield.vmdl"),
    shardModel: resource.model("models/props_gameplay/aghanim_scepter.vmdl")
});

export type RewardDefinition = {
    upgradeType: UpgradeType;
    model: string;
    scale: number;
};

type RewardOptions = {
    upgradeType: UpgradeType;
    model: string;
    scale?: number;
};

export type UpgradeDefinition = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values: Record<string, number | number[]>;
    // tier: "common" | "rare" | "veryRare" | "legendary";
    // maxStacks: number;
};

export type UpgradeOptions = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
    hero: string;
    values?: Record<string, number | number[]>;
    // tier: "common" | "rare" | "veryRare" | "legendary";
    // maxStacks: number;
};

const rewardDefinitions: RewardDefinition[] = [];
export const upgradeDefinitions: UpgradeDefinition[] = [];

function defineReward(options: RewardOptions) {
    rewardDefinitions.push({
        upgradeType: options.upgradeType,
        model: options.model,
        scale: options.scale ?? 1
    });
}

export function findRewardByType(upgradeType: UpgradeType) {
    return rewardDefinitions.find(reward => reward.upgradeType == upgradeType);
}

function defineUpgrade(options: UpgradeOptions) {
    upgradeDefinitions.push({
        id: options.id,
        icon: options.icon,
        hero: options.hero as HeroName,
        values: options.values ?? {},
        type: options.type
    });
}

defineReward({
    upgradeType: UpgradeType.stance,
    model: resources.stanceModel.path
});

defineReward({
    upgradeType: UpgradeType.shard,
    model: resources.shardModel.path
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.phantomFastDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.phantomInstantCounter,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_blur.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.phantomSecondRecast,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_second_attack.png"
});

defineUpgrade({
    type: UpgradeType.shard,
    id: UpgradeId.phantomDashDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_mobility.png"
});

defineUpgrade({
    type: UpgradeType.shard,
    id: UpgradeId.phantomExtraDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

export function hasUpgrade(unit: CDOTA_BaseNPC, id: UpgradeId) {
    const playerId = unit.GetPlayerOwnerID();
    const player = findPlayerById(playerId);

    return player?.upgrades.find(upgrade => upgrade.id == id);
}
