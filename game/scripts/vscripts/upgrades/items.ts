import { Upgrade, UpgradeTypes } from './common';

const Items: Upgrade[] = [
    {
        id: 'upgrade_broom_handle',
        abilityIconName: 'item_broom_handle',
        name: 'Broom handle',
        description: 'Provides extra radius on your basic attack',
        maxStacks: 1,
        attackCapability: UnitAttackCapability.MELEE_ATTACK,
        modifier: {
            name: 'modifier_upgrade_broom_handle'
        },
        tier: 0,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_blades_of_attack',
        abilityIconName: 'item_blades_of_attack',
        name: 'Blades of attack',
        description: 'Increases your base damage by 1.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_blades_of_attack'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_item_yasha',
        abilityIconName: 'item_yasha',
        name: 'Yasha',
        description: 'Increases your movement and attack speed.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_yasha'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_item_maelstrom',
        abilityIconName: 'item_maelstrom',
        name: 'Maelstrom',
        description: 'Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_maelstrom'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_item_basher',
        abilityIconName: 'item_basher',
        name: 'Basher',
        description: 'Your attacks has a chance to deal extra damage and stun the target.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_basher'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    }
];

export default Items;