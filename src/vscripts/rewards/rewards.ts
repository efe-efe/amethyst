import { CustomActionEvent } from "../addon_game_mode";
import BreakableBounty, {
  BreakableBountyOptions,
} from "../clases/breakable_bounty";
import { CustomPlayerHeroNPC } from "../clases/pve/custom_npc";
import { CustomEvents } from "../custom_events";
import { UpgradeManager } from "../upgrades/upgrades";
import Math from "../util/math";
export interface Reward {
  type: RewardTypes;
  name: string;
  description: string;
}

interface GenerateRewardsOptions {
  amount: number;
  type?: RewardTypes;
}

export enum RewardTypes {
  FAVOR = 0,
  SHARD,
  ITEM,
  KNOWLEDGE,
  VITALITY,
  SECRET_SHOP,
  GOLD,
}

const Rewards: Reward[] = [
  {
    type: RewardTypes.FAVOR,
    name: "Favor",
    description: "Change the effect one of your abilities.",
  },
  {
    type: RewardTypes.KNOWLEDGE,
    name: "Tome of Knowledge",
    description: "Enhances one of your existing shard effects.",
  },
  {
    type: RewardTypes.VITALITY,
    name: "Vitality",
    description: "Increases your maximun health pool.",
  },
  {
    type: RewardTypes.ITEM,
    name: "Item",
    description: "Artifacts that improves your hero powers.",
  },
  {
    type: RewardTypes.SHARD,
    name: "Shard",
    description: "Improves one of your abilities.",
  } /*
    {
        id: 'bounty_shop',
        name: 'Shop',
        description: 'Spawns a shop where you can buy goods.',
    },
    {
        id: 'bounty_money',
        name: 'Money',
        description: 'You get money to buy things and stuff.',
    }*/,
];

class RewardEntity extends BreakableBounty {
  owner: CustomPlayerHeroNPC;
  constructor(
    origin: Vector,
    owner: CustomPlayerHeroNPC,
    options: BreakableBountyOptions
  ) {
    super(origin, {
      ...options,
      particle: "particles/generic_gameplay/rune_doubledamage.vpcf",
      scale: 1.3,
    });
    this.owner = owner;
  }

  PlayEffectsOnSpawn(): void {
    const unit = this.GetUnit();
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", unit);
    EFX(
      "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf",
      ParticleAttachment.ABSORIGIN_FOLLOW,
      unit,
      { release: true }
    );
    EFX(
      "particles/reward_effect_impact.vpcf",
      ParticleAttachment.ABSORIGIN_FOLLOW,
      unit,
      {
        cp1: unit.GetAbsOrigin(),
        release: true,
      }
    );
    EFX(
      "particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_start.vpcf",
      ParticleAttachment.ABSORIGIN_FOLLOW,
      unit,
      { release: true }
    );
    EFX(
      "particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_end.vpcf",
      ParticleAttachment.ABSORIGIN_FOLLOW,
      unit,
      { release: true }
    );
    EFX(
      "particles/reward_effect_extra.vpcf",
      ParticleAttachment.ABSORIGIN_FOLLOW,
      unit,
      { release: true }
    );
    EFX(
      "particles/reward_effect.vpcf",
      ParticleAttachment.ABSORIGIN_FOLLOW,
      unit,
      {
        cp1: Vector(100, 100, 100),
        release: true,
      }
    );
  }

  Effect(killer: CDOTA_BaseNPC): void {
    //
  }
}
class FavorEntity extends RewardEntity {
  constructor(origin: Vector, owner: CustomPlayerHeroNPC) {
    super(origin, owner, {
      model: "models/props_gameplay/stout_shield.vmdl",
      health: 25,
    });
  }

  Effect(killer: CDOTA_BaseNPC): void {
    super.Effect(killer);
    RewardsManager.OfferFavorsForHero(this.owner);
  }
}

class ShardEntity extends RewardEntity {
  constructor(origin: Vector, owner: CustomPlayerHeroNPC) {
    super(origin, owner, {
      model: "models/props_gameplay/aghanim_scepter.vmdl",
      health: 25,
    });
  }

  Effect(killer: CDOTA_BaseNPC): void {
    super.Effect(killer);
    RewardsManager.ClaimShards(this.owner);
  }
}

class ItemEntity extends RewardEntity {
  constructor(origin: Vector, owner: CustomPlayerHeroNPC) {
    super(origin, owner, {
      model: "models/props_gameplay/neutral_box.vmdl",
      health: 25,
    });
  }

  Effect(killer: CDOTA_BaseNPC): void {
    super.Effect(killer);
    RewardsManager.ClaimItems(this.owner);
  }
}

class KnowledgeEntity extends RewardEntity {
  constructor(origin: Vector, owner: CustomPlayerHeroNPC) {
    super(origin, owner, {
      model: "models/props_items/necronomicon.vmdl",
      health: 25,
    });
  }

  Effect(killer: CDOTA_BaseNPC): void {
    super.Effect(killer);
    RewardsManager.ClaimKnowledge(this.owner);
  }
}

class VitalityEntity extends RewardEntity {
  constructor(origin: Vector, owner: CustomPlayerHeroNPC) {
    super(origin, owner, {
      model: "models/props_gameplay/heart001.vmdl",
      health: 25,
    });
  }

  Effect(killer: CDOTA_BaseNPC): void {
    super.Effect(killer);
    RewardsManager.ClaimVitality(this.owner);
  }
}

export const RewardsManager = {
  Rewards,
  OfferRewardsForHero(hero: CustomPlayerHeroNPC, rewards: Reward[]): void {
    if (rewards.length === 0) {
      print("Skipping rewards selection. No rewards available");
      return;
    }

    const data = {
      playerId: hero.unit.GetPlayerOwnerID(),
      rewards,
    } as never;

    CustomNetTables.SetTableValue(
      "custom_npc_rewards" as never,
      hero.unit.GetPlayerOwnerID().toString(),
      data
    );
  },
  ClaimRewardForHero(
    customNpc: CustomPlayerHeroNPC,
    reward: Reward
  ): RewardEntity | undefined {
    const origin = customNpc.unit
      .GetAbsOrigin()
      .__add(Vector(RandomFloat(-1, 1) * 150, RandomFloat(-1, 1) * 150, 128));
    let rewardEntity = undefined;

    if (reward.type === RewardTypes.FAVOR) {
      rewardEntity = new FavorEntity(origin, customNpc);
    }
    if (reward.type === RewardTypes.ITEM) {
      rewardEntity = new ItemEntity(origin, customNpc);
    }
    if (reward.type === RewardTypes.KNOWLEDGE) {
      rewardEntity = new KnowledgeEntity(origin, customNpc);
    }
    if (reward.type === RewardTypes.SHARD) {
      rewardEntity = new ShardEntity(origin, customNpc);
    }
    if (reward.type === RewardTypes.VITALITY) {
      rewardEntity = new VitalityEntity(origin, customNpc);
    }
    return rewardEntity;
  },
  OfferFavorsForHero(customNpc: CustomPlayerHeroNPC): void {
    const upgrades = UpgradeManager.GenerateFavors(customNpc, 3);

    if (upgrades.length === 0) {
      print("Skipping favors selection. No rewards available");
      UpgradeManager.ClearUpgrades(customNpc);
      return;
    }

    const data = {
      playerId: customNpc.unit.GetPlayerOwnerID(),
      upgrades,
    } as never;

    const tableName = "custom_npc_favors" as never;
    CustomNetTables.SetTableValue(
      tableName,
      customNpc.unit.GetPlayerOwnerID().toString(),
      data
    );
  },
  ClaimShards(customNpc: CustomPlayerHeroNPC): void {
    const upgrades = UpgradeManager.GenerateShards(customNpc, 3);

    if (upgrades.length === 0) {
      print("Skipping shards selection. No rewards available");
      UpgradeManager.ClearUpgrades(customNpc);
      return;
    }

    const data = {
      playerId: customNpc.unit.GetPlayerOwnerID(),
      upgrades,
    } as never;

    const tableName = "custom_npc_favors" as never;
    CustomNetTables.SetTableValue(
      tableName,
      customNpc.unit.GetPlayerOwnerID().toString(),
      data
    );
  },
  ClaimKnowledge(customNpc: CustomPlayerHeroNPC): void {
    const upgrades = UpgradeManager.GenerateKnowledge(customNpc, 3);

    if (upgrades.length === 0) {
      print("Skipping knowledge selection. No rewards available");
      UpgradeManager.ClearUpgrades(customNpc);
      return;
    }

    const data = {
      playerId: customNpc.unit.GetPlayerOwnerID(),
      upgrades,
    } as never;

    const tableName = "custom_npc_favors" as never;
    CustomNetTables.SetTableValue(
      tableName,
      customNpc.unit.GetPlayerOwnerID().toString(),
      data
    );
  },
  ClaimItems(customNpc: CustomPlayerHeroNPC): void {
    const upgrades = UpgradeManager.GenerateItems(customNpc, RandomInt(4, 6));

    if (upgrades.length === 0) {
      print("Skipping items selection. No rewards available");
      UpgradeManager.ClearUpgrades(customNpc);
      return;
    }

    const data = {
      playerId: customNpc.unit.GetPlayerOwnerID(),
      upgrades,
    } as never;

    const tableName = "custom_npc_favors" as never;
    CustomNetTables.SetTableValue(
      tableName,
      customNpc.unit.GetPlayerOwnerID().toString(),
      data
    );
  },
  ClaimVitality(customNpc: CustomPlayerHeroNPC): void {
    customNpc.unit.AddNewModifier(
      customNpc.unit,
      undefined,
      "modifier_upgrade_tarrasque",
      {}
    );
    CustomEntitiesLegacy.SendDataToClient(customNpc.unit);
    const customEvents = CustomEvents.GetInstance();
    customEvents.EmitEvent("pve:current_reward_applied", { customNpc });
  },
  GenerateRewards(
    customNpc: CustomPlayerHeroNPC,
    options: GenerateRewardsOptions
  ): Reward[] {
    const rewards = Rewards.filter((reward) =>
      options.type
        ? this.ValidateRewardType(reward, options.type)
        : true && this.ValidateReward(customNpc, reward)
    );

    return Math.GetRandomElementsFromArray(
      rewards,
      Clamp(options.amount, rewards.length, 0)
    );
  },
  ValidateRewardType: (reward: Reward, type: RewardTypes): boolean => {
    return reward.type === type;
  },
  ValidateReward: (customNpc: CustomPlayerHeroNPC, reward: Reward): boolean => {
    const knowledge = UpgradeManager.GenerateKnowledge(customNpc, 1);
    const items = UpgradeManager.GenerateItems(customNpc, 1);
    const shards = UpgradeManager.GenerateShards(customNpc, 1);
    const favors = UpgradeManager.GenerateFavors(customNpc, 1);

    if (reward.type === RewardTypes.KNOWLEDGE) {
      if (knowledge.length === 0) {
        return false;
      }
      if (customNpc.heroUpgrades.length < 2) {
        return false;
      }
    }
    if (reward.type === RewardTypes.ITEM) {
      if (items.length === 0) {
        return false;
      }
    }
    if (reward.type === RewardTypes.SHARD) {
      if (shards.length === 0) {
        return false;
      }
    }
    if (reward.type === RewardTypes.FAVOR) {
      if (favors.length === 0) {
        return false;
      }
    }
    return true;
  },
};

CustomGameEventManager.RegisterListener<CustomActionEvent>(
  "custom_npc:select_reward",
  (eventSourceIndex, event) => {
    const playerId = event.playerIndex;
    const player = GameRules.Addon.FindPlayerById(playerId);

    if (player) {
      const customNpc = player.customNpc;
      if (customNpc) {
        const reward = Rewards.filter(
          (_reward) => _reward.type === event.payload.type
        )[0];
        if (reward) {
          customNpc.SelectReward(reward);
        }
      }
    }
  }
);

export default Rewards;
