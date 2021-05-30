import { Upgrade, UpgradeTypes } from './common';

const Shards: Upgrade[] = [
];

const Favors: Upgrade[] = [
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
        type: UpgradeTypes.FAVOR,
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
        type: UpgradeTypes.FAVOR,
    },
];

const StormRewards = {
    Shards,
    Favors,
};

export default StormRewards;