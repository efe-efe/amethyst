import { CustomActionEvent } from '../addon_game_mode';
import { CustomEvents } from '../custom_events';

export interface Prize {
    type: PrizeTypes;
    name: string;
    description: string;
}

export enum PrizeTypes {
    FAVOR = 0,
    ENHANCEMENT,
    TARRASQUE,
    SECRET_SHOP,
    GOLD,
}

const Prizes: Prize[] = [
    {
        type: PrizeTypes.FAVOR,
        name: 'Favor',
        description: 'Upgrades one of your abilities.',
    },
    {
        type: PrizeTypes.ENHANCEMENT,
        name: 'Improvement',
        description: 'Improves one of your existing upgrades.',
    },
    {
        type: PrizeTypes.TARRASQUE,
        name: 'Regenerate',
        description: 'Fully restores all your HP.',
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


CustomGameEventManager.RegisterListener<CustomActionEvent>('custom_npc:select_bounty', (eventSourceIndex, event) => {
    const customEvents = CustomEvents.GetInstance();
    const playerId = event.playerIndex;
    const player = GameRules.Addon.FindPlayerById(playerId);

    if(player){
        const customNpc = player.customNpc;
        if(customNpc){
            const prize = Prizes.filter((_prize) => _prize.type === event.payload.type)[0];
            if(prize){
                customNpc.SelectBounty(prize);
                customEvents.EmitEvent('pve:prize_selected', { customNpc });
            }
        }
    }
});

export default Prizes;