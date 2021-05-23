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
    maxLevel: number;
    modifier?: UpgradeModifier;
    tier: number;
    effect?(hero: CDOTA_BaseNPC_Hero): void;
}

const Upgrades: Upgrade[] = [
    {
        id: 'meele_extra_radius',
        name: 'Extra radius',
        description: 'Provides extra radius on your basic attack',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_meele_extra_radius'
        },
        tier: 0,
    },
    {
        id: 'phantom_extra_daggers',
        name: 'Extra daggers',
        description: 'Your stiffling daggers throws 3 daggers.',
        hero: 'npc_dota_hero_phantom_assassin',
        ability: 'phantom_special_attack',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_extra_daggers'
        },
        tier: 1,
    }
];

export default Upgrades;