import { CustomActionEvent } from '../addon_game_mode';
import { CustomPlayerHeroNPC } from '../clases/pve/custom_npc';
import Math from '../util/math';

export interface Reward {
    type: RewardTypes;
    name: string;
    description: string;
}

interface GenerateRewardsOptions {
    amount: number;
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
        name: 'Favor',
        description: 'Change the effect one of your abilities.',
    },
    {
        type: RewardTypes.KNOWLEDGE,
        name: 'Tome of Knowledge',
        description: 'Enhances one of your existing shard effects.',
    },
    {
        type: RewardTypes.VITALITY,
        name: 'Vitality',
        description: 'Increases your maximun health pool.',
    },
    {
        type: RewardTypes.ITEM,
        name: 'Item',
        description: 'Artifacts that improves your hero powers.',
    },
    {
        type: RewardTypes.SHARD,
        name: 'Shard',
        description: 'Improves one of your abilities.',
    },/*
    {
        id: 'bounty_shop',
        name: 'Shop',
        description: 'Spawns a shop where you can buy goods.',
    },
    {
        id: 'bounty_money',
        name: 'Money',
        description: 'You get money to buy things and stuff.',
    }*/
];

export const RewardsManager = {
    Rewards,
    GenerateRewards: (customNpc: CustomPlayerHeroNPC, options: GenerateRewardsOptions): Reward[] => {
        const rewards = Rewards.filter((reward) => (
            RewardsManager.ValidateReward(customNpc, reward)
        ));

        return Math.GetRandomElementsFromArray(rewards, Clamp(options.amount, rewards.length, 0));
    },
    ValidateReward: (customNpc: CustomPlayerHeroNPC, reward: Reward): boolean => {
        if(reward.type === RewardTypes.KNOWLEDGE){
            if(customNpc.heroUpgrades.length < 2){
                return false;
            }
        }
        return true;
    }
};

CustomGameEventManager.RegisterListener<CustomActionEvent>('custom_npc:select_reward', (eventSourceIndex, event) => {
    const playerId = event.playerIndex;
    const player = GameRules.Addon.FindPlayerById(playerId);

    if(player){
        const customNpc = player.customNpc;
        if(customNpc){
            const reward = Rewards.filter((_reward) => _reward.type === event.payload.type)[0];
            if(reward){
                customNpc.SelectReward(reward);
            }
        }
    }
});

export default Rewards;