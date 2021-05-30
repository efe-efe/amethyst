import { Upgrade, UpgradeTypes } from './common';

const Shards: Upgrade[] = [
];

const Favors: Upgrade[] = [
    {
        id: 'sniper_snipe_cast_fast',
        name: 'Quick Snipe',
        description: 'Your Snipe cast point is reduced drastically.',
        ability: 'sniper_second_attack',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_sniper_snipe_cast_fast'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
];

const SniperRewards = {
    Shards,
    Favors,
};

export default SniperRewards;