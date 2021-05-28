import { CustomActionEvent } from '../addon_game_mode';
import { CustomEvents } from '../custom_events';

export interface Reward {
    type: RewardTypes;
    name: string;
    description: string;
}

export enum RewardTypes {
    FAVOR = 0,
    ENHANCEMENT,
    TARRASQUE,
    SECRET_SHOP,
    GOLD,
}

const Rewards: Reward[] = [
    {
        type: RewardTypes.FAVOR,
        name: 'Favor',
        description: 'Applies a new favor on one of your abilities, improving one aspect from it.',
    },
    {
        type: RewardTypes.ENHANCEMENT,
        name: 'Enhancement',
        description: 'Enhances one of your existing favors.',
    },
    {
        type: RewardTypes.TARRASQUE,
        name: 'Heart of Tarrasque',
        description: 'Increases your maximun health pool.',
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
    const customEvents = CustomEvents.GetInstance();
    const playerId = event.playerIndex;
    const player = GameRules.Addon.FindPlayerById(playerId);

    if(player){
        const customNpc = player.customNpc;
        if(customNpc){
            const reward = Rewards.filter((_reward) => _reward.type === event.payload.type)[0];
            if(reward){
                customNpc.SelectReward(reward);
                customEvents.EmitEvent('pve:next_reward_selected', { customNpc, reward });
            }
        }
    }
});

export default Rewards;