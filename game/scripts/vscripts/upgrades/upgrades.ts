import { CustomActionEvent } from '../addon_game_mode';
import Items from './items';
import Shards from './shards';
import Favors from './favors';
import { Upgrade } from './common';

const Upgrades: Upgrade[] = [
    ...Items,
    ...Shards,
    ...Favors,
];

CustomGameEventManager.RegisterListener<CustomActionEvent>('custom_npc:apply_favor', (eventSourceIndex, event) => {
    const playerId = event.playerIndex;
    const player = GameRules.Addon.FindPlayerById(playerId);

    if(player){
        const customNpc = player.customNpc;
        if(customNpc){
            const upgrade = Upgrades.filter((currentUpgrade) => currentUpgrade.id === event.payload.upgradeId)[0];
            if(upgrade){
                customNpc.ApplyFavor(upgrade);
            }
        }
    }
});

export default Upgrades;