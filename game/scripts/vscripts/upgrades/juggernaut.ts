import { Upgrade, UpgradeTypes } from './common';

const Shards: Upgrade[] = [
];

const Favors: Upgrade[] = [
    {
        id: 'juggernaut_fury_reflects',
        name: 'Blade Fury reflects',
        description: 'Blade Fury reflect enemy projectiles.',
        ability: 'juggernaut_mobility',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_juggernaut_fury_reflects'
        },
        tier: 0,
        type: UpgradeTypes.FAVOR,
    },
    {
        id: 'juggernaut_fury_attack',
        name: 'Blade Fury attacks',
        description: 'Blade Fury damage count as basic attacks',
        ability: 'juggernaut_mobility',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_juggernaut_fury_attack'
        },
        tier: 0,
        type: UpgradeTypes.FAVOR,
    },
    {
        id: 'juggernaut_refresh_dagger',
        name: 'Refreshing dagger',
        description: 'Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.',
        ability: 'juggernaut_special_attack',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_juggernaut_refresh_dagger'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
    {
        id: 'juggernaut_spinning_ward',
        name: 'Spinning Ward',
        description: 'Your Healing Ward also spins when you activates your Blade Fury. It also resists 5 hits instead of 1.',
        ability: 'juggernaut_extra',
        secondaryAbilities: ['juggernaut_mobility'],
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_juggernaut_spinning_ward'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
];

const JuggernautRewards = {
    Shards,
    Favors,
};

export default JuggernautRewards;