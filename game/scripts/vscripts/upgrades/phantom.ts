import { Upgrade, UpgradeTypes } from './common';

const Shards: Upgrade[] = [
    {
        id: 'phantom_dash_damage',
        name: 'Swift damage',
        description: 'Your Swift deals damage when passing through enemies.',
        ability: 'phantom_mobility',
        maxStacks: 5,
        modifier: {
            name: 'modifier_upgrade_phantom_dash_damage'
        },
        tier: 1,
        type: UpgradeTypes.SHARD,
    },
    {
        id: 'phantom_dash_shield',
        name: 'Swift Shield',
        description: 'Your Swift gives you shield for a short period of time after passing through enemies.',
        ability: 'phantom_mobility',
        maxStacks: 5,
        modifier: {
            name: 'modifier_upgrade_phantom_dash_shield'
        },
        tier: 1,
        type: UpgradeTypes.SHARD,
    },
];

const Favors: Upgrade[] = [
    {
        id: 'phantom_extra_daggers',
        name: 'Extra daggers',
        description: 'Your stiffling daggers throws 3 daggers.',
        ability: 'phantom_special_attack',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_extra_daggers'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },    
    {
        id: 'phantom_coup_cast_fast',
        name: 'Coup de Grace cast fast',
        description: 'Reduces the cast time of Coup de Grace considerably.',
        ability: 'phantom_ultimate',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_coup_cast_fast'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
];

const PhantomRewards = {
    Shards,
    Favors,
};

export default PhantomRewards;