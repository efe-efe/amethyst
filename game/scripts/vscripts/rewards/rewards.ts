import { CustomActionEvent } from '../addon_game_mode';

export interface Reward {
    type: RewardTypes;
    name: string;
    description: string;
}

export enum RewardTypes {
    FAVOR = 0,
    SHARD,
    ITEM,
    KNOWLEDGE,
    TARRASQUE,
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
        type: RewardTypes.TARRASQUE,
        name: 'Heart of Tarrasque',
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