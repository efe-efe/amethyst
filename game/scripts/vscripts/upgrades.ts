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
        attackCapability: UnitAttackCapability.MELEE_ATTACK,
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
    },
    {
        id: 'extra_base_damage',
        name: 'Extra base damage',
        description: 'Increases your base damage by 3.',
        maxLevel: 3,
        modifier: {
            name: 'modifier_upgrade_extra_base_damage'
        },
        tier: 1,
    },
    {
        id: 'juggernaut_refresh_dagger',
        name: 'Refreshing dagger',
        description: 'Your dagger cooldown is recharged when succesfully hitting enemies',
        hero: 'npc_dota_hero_juggernaut',
        ability: 'juggernaut_special_attack',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_juggernaut_refresh_dagger'
        },
        tier: 1,
    },
    {
        id: 'lightining_attack',
        name: 'Lightining attack',
        description: 'Your attacks has a chance to release a bolt of electricity that leaps between enemy targets ',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_lightining_attack'
        },
        tier: 1,
    }
];

export default Upgrades;