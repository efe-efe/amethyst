import { findPlayerById } from "./game";
import { precache, resource } from "./precache";

const resources = precache({
    stanceModel: resource.model("models/props_gameplay/stout_shield.vmdl"),
    shardModel: resource.model("models/props_gameplay/aghanim_scepter.vmdl")
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
export const stanceDefinitions: StanceDefinition[] = [];
export const shardDefinitions: ShardDefinition[] = [];

function defineReward(options: RewardOptions) {
    rewardDefinitions.push({
        id: options.id,
        model: options.model,
        scale: options.scale ?? 1
    });
}

defineReward({
    id: RewardId.stance,
    model: resources.stanceModel.path
});

defineReward({
    id: RewardId.shard,
    model: resources.shardModel.path
});

export function findRewardById(id: RewardId) {
    return rewardDefinitions.find(reward => reward.id == id);
}

export type StanceDefinition = {
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values: Record<string, number | number[]>;
};

export type BlessingDefinition = {
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values: Record<string, number | number[]>;
};

export type ShardDefinition = {
    id: UpgradeId;
    icon: string;
    hero: HeroName;
    values: Record<string, number | number[]>;
};

type ShardOptions = {
    id: UpgradeId;
    icon: string;
    hero: string;
    values?: Record<string, number | number[]>;
};

type StanceOptions = {
    id: UpgradeId;
    icon: string;
    hero: string;
    values?: Record<string, number | number[]>;
};

type BlessingOptions = {
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

function defineStance(options: StanceOptions) {
    stanceDefinitions.push({
        id: options.id,
        icon: options.icon,
        hero: options.hero as HeroName,
        values: options.values ?? {}
    });
}

function defineShard(options: ShardOptions) {
    shardDefinitions.push({
        id: options.id,
        icon: options.icon,
        hero: options.hero as HeroName,
        values: options.values ?? {}
    });
}

defineStance({
    id: UpgradeId.phantomFastDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

defineStance({
    id: UpgradeId.phantomInstantCounter,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_blur.png"
});

defineStance({
    id: UpgradeId.phantomSecondRecast,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_second_attack.png"
});

defineShard({
    id: UpgradeId.phantomDashDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

defineShard({
    id: UpgradeId.phantomExtraDaggers,
    hero: "npc_dota_hero_phantom_assassin",
    icon: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
});

export function hasUpgrade(unit: CDOTA_BaseNPC, id: UpgradeId) {
    const playerId = unit.GetPlayerOwnerID();
    const player = findPlayerById(playerId);

    return player?.upgrades.find(upgrade => upgrade == id);
}
