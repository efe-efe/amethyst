import phantom from './phantom';
import juggernaut from './juggernaut';
import storm from './storm';
import generic from './generic';

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

export default Upgrades;