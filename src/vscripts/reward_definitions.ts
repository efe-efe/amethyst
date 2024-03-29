import { precache, resource } from "./precache";

const resources = precache({
    stanceModel: resource.model("models/props_gameplay/stout_shield.vmdl"),
    shardModel: resource.model("models/props_gameplay/aghanim_gem.vmdl"),
    legendModel: resource.model("models/props_gameplay/aghanim_scepter.vmdl"),
    knowledgeModel: resource.model("models/props_items/necronomicon.vmdl")
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

export const rewardDefinitions: RewardDefinition[] = [];

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

defineReward({
    upgradeType: UpgradeType.stance,
    model: resources.stanceModel.path
});

defineReward({
    upgradeType: UpgradeType.shard,
    model: resources.shardModel.path
});

defineReward({
    upgradeType: UpgradeType.legend,
    model: resources.legendModel.path
});

defineReward({
    upgradeType: UpgradeType.knowledge,
    model: resources.knowledgeModel.path
});
