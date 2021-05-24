import { Upgrade } from './upgrades';

const stormUpgrades: Upgrade[] = [
    {
        id: 'storm_ranged_remnant',
        name: 'Ranged remnant',
        description: 'Your static remnant can be casted with range',
        ability: 'storm_mobility',
        maxStacks: 1,
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
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_storm_unleashed_knockback'
        },
        tier: 0,
    },
];

export default stormUpgrades;