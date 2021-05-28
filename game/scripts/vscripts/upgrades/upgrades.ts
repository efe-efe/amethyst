import phantom from './phantom';
import juggernaut from './juggernaut';
import storm from './storm';
import generic from './generic';
import { CustomActionEvent } from '../addon_game_mode';

interface UpgradeModifier {
    name: string;
    duration?: number;
}

export interface Upgrade {
    id: string;
    name: string;
    description: string;
    hero?: string;
    ability?: string;
    attackCapability?: UnitAttackCapability;
    maxStacks: number;
    modifier?: UpgradeModifier;
    tier: number;
    minLevel?: number;
    effect?(hero: CDOTA_BaseNPC_Hero): void;
}

const Upgrades: Upgrade[] = [
    ...phantom,
    ...juggernaut,
    ...storm,
    ...generic
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