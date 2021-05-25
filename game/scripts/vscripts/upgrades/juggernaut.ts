import { Upgrade } from './upgrades';

const juggernautUpgrades: Upgrade[] = [
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
    },
];

export default juggernautUpgrades;