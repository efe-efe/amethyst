import { findPlayerById } from "./game";
import { precache, resource } from "./precache";

const resources = precache({
    blessingModel: resource.model("models/props_gameplay/stout_shield.vmdl")
});

export type RewardDefinition = {
    id: RewardId;
    model: string;
    scale: number;
};

type RewardOptions = {
    id: RewardId;
    model: string;
    scale?: number;
};

const rewardDefinitions: RewardDefinition[] = [];
export const blessingDefinitions: BlessingDefinition[] = [];

function defineReward(options: RewardOptions) {
    rewardDefinitions.push({
        id: options.id,
        model: options.model,
        scale: options.scale ?? 1
    });
}

defineReward({
    id: RewardId.blessing,
    model: resources.blessingModel.path
});

export function findRewardById(id: RewardId) {
    return rewardDefinitions.find(reward => reward.id == id);
}

export type BlessingDefinition = {
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values: Record<string, number | number[]>;
};

type BlessingOptions = {
    id: UpgradeId;
    icon: string;
    hero: string;
    values?: Record<string, number | number[]>;
};

const enum ShardId {}

type ShardOptions = {
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values?: Record<string, number | number[]>;
    tier: "common" | "rare" | "veryRare" | "legendary";
    maxStacks: number;
};

function defineBlessing(options: BlessingOptions) {
    blessingDefinitions.push({
        id: options.id,
        icon: options.icon,
        hero: options.hero as HeroName,
        values: options.values ?? {}
    });
}

defineBlessing({
    id: UpgradeId.phantomExtraDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "a"
});

defineBlessing({
    id: UpgradeId.phantomFastDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "a"
});

defineBlessing({
    id: UpgradeId.phantomInstantCounter,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "a"
});

export function hasUpgrade(unit: CDOTA_BaseNPC, id: UpgradeId) {
    const playerId = unit.GetPlayerOwnerID();
    const player = findPlayerById(playerId);

    return player?.upgrades.find(upgrade => upgrade == id);
}
