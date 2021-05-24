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
        id: 'juggernaut_fury_attack',
        name: 'Blade Fury attacks',
        description: 'Blade Fury damage count as basic attacks',
        ability: 'juggernaut_mobility',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_juggernaut_fury_attack'
        },
        tier: 0,
    },
    {
        id: 'storm_ranged_remnant',
        name: 'Ranged remnant',
        description: 'Your static remnant can be casted with range',
        ability: 'storm_mobility',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_storm_ranged_remnant'
        },
        tier: 0,
    },
    {
        id: 'storm_unleashed_knockback',
        name: 'Storm Unleashed knockback',
        description: 'Your Storm Unleashed push enemies out.',
        ability: 'storm_ultimate',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_storm_unleashed_knockback'
        },
        tier: 0,
    },
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
        ability: 'phantom_special_attack',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_extra_daggers'
        },
        tier: 1,
    },
    {
        id: 'phantom_dash_damage',
        name: 'Swift damage',
        description: 'Your Swift deals damage when passing through enemies.',
        ability: 'phantom_mobility',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_dash_damage'
        },
        tier: 1,
    },
    {
        id: 'phantom_coup_cast_fast',
        name: 'Coup de Grace cast fast',
        description: 'Reduces the cast time of Coup de Grace considerably.',
        ability: 'phantom_ultimate',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_coup_cast_fast'
        },
        tier: 1,
    },
    {
        id: 'phantom_dash_invulnerability',
        name: 'Swift invulnerability',
        description: 'Your Swift gives you invulnerability for a short period of time after passing through enemies.',
        ability: 'phantom_mobility',
        maxLevel: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_dash_invulnerability'
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
        id: 'extra_movement_speed',
        name: 'Extra movement speed',
        description: 'Increases your movement speed.',
        maxLevel: 3,
        modifier: {
            name: 'modifier_upgrade_extra_movement_speed'
        },
        tier: 1,
    },
    {
        id: 'juggernaut_refresh_dagger',
        name: 'Refreshing dagger',
        description: 'Your dagger cooldown is recharged when succesfully hitting enemies',
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
        maxLevel: 3,
        modifier: {
            name: 'modifier_upgrade_lightining_attack'
        },
        tier: 1,
    }
];

export default Upgrades;