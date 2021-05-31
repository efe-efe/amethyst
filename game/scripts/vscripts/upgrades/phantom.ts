import { Upgrade, UpgradeTypes } from './common';

const Shards: Upgrade[] = [
    {
        id: 'phantom_dash_damage',
        name: 'Swift damage',
        description: 'Your Swift deals damage when passing through enemies and increases its range.',
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
        name: 'Swift shield',
        description: 'Your Swift gives you shield for a short period of time after passing through enemies and increases its range.',
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
    {
        id: 'phantom_countering_stacks',
        name: 'Phantom Strike stacks',
        description: 'Your Phantom Strike consumes all your Phantom Stacks to multiply your damage while the attack speed buff is on.',
        ability: 'phantom_counter',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_countering_stacks'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
    {
        id: 'phantom_act_while_countering',
        name: 'Phantom Strike while acting',
        description: 'You can act while in counter state but the counter state duration its reduced.',
        ability: 'phantom_counter',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_act_while_countering'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
    {
        id: 'phantom_strike_instant',
        name: 'Phantom Strike instant effect',
        description: 'Your Phantom Strike is activated instantly without the need to be activated by an attack, but no longer heals and the banish duration is reduced.',
        ability: 'phantom_counter',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_strike_instant'
        },
        tier: 1,
        type: UpgradeTypes.FAVOR,
    },
    {
        id: 'phantom_quick_recast',
        name: 'Phantom Quick Strike recast',
        description: 'Your Quick Strike can be used again for free after hitting at least one enemy.',
        ability: 'phantom_extra',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_phantom_quick_recast'
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