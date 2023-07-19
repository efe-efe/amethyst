import { precache, resource } from "./precache";

const resources = precache({
    favorModel: resource.model("models/props_gameplay/stout_shield.vmdl")
});

export const enum RewardId {
    "favor" = "favor",
    "shard" = "shard",
    "item" = "item",
    "vitality" = "vitality"
}

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
export const favorDefinitions: FavorDefinition[] = [];

function defineReward(options: RewardOptions) {
    rewardDefinitions.push({
        id: options.id,
        model: options.model,
        scale: options.scale ?? 1
    });
}

defineReward({
    id: RewardId.favor,
    model: resources.favorModel.path
});

export function findRewardById(id: RewardId) {
    return rewardDefinitions.find(reward => reward.id == id);
}

export type FavorDefinition = {
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values: Record<string, number | number[]>;
};

type FavorOptions = {
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

function defineFavor(options: FavorOptions) {
    favorDefinitions.push({
        id: options.id,
        icon: options.icon,
        hero: options.hero as HeroName,
        values: options.values ?? {}
    });
}

defineFavor({
    id: UpgradeId.phantomExtraDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "a"
});

defineFavor({
    id: UpgradeId.phantomFastDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "a"
});

export function hasUpgrade(unit: CDOTA_BaseNPC, id: UpgradeId) {
    return false;
}
