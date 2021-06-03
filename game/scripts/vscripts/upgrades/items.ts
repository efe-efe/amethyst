import { Upgrade, UpgradeTypes } from './common';

const Items: Upgrade[] = [
    {
        itemName: 'blade_of_alacrity',
        name: 'Blade of Alacrity',
        description: 'Provides extra movement and attack speed',
        maxStacks: 1,
        modifier: {},
        tier: 0,
    },
    {
        itemName: 'boots_of_elves',
        name: 'Band of Elvenskin',
        description: 'Provides extra attack speed and damage.',
        maxStacks: 1,
        modifier: {},
        tier: 0,
    },
    {
        itemName: 'yasha',
        name: 'Yasha',
        description: 'Increases your movement and attack speed.',
        maxStacks: 1,
        modifier: {},
        tier: 1,
        ingredients: ['upgrade_item_boots_of_elves', 'upgrade_item_blade_of_alacrity'],
    },
    {
        itemName: 'broom_handle',
        name: 'Broom handle',
        description: 'Provides extra radius on your basic attack',
        maxStacks: 1,
        modifier: {},
        attackCapability: UnitAttackCapability.MELEE_ATTACK,
        tier: 0,
    },
    {
        itemName: 'blades_of_attack',
        name: 'Blades of attack',
        description: 'Increases your base damage.',
        maxStacks: 1,
        modifier: {},
        tier: 1,
    },
    {
        itemName: 'mithril_hammer',
        name: 'Mithril Hammer',
        description: 'Increases your base damage.',
        maxStacks: 1,
        modifier: {},
        tier: 1,
    },
    {
        itemName: 'javelin',
        name: 'Javelin',
        description: 'Your attacks has a chance of dealing extra damage.',
        maxStacks: 1,
        modifier: {},
        tier: 1,
    },
    {
        itemName: 'maelstrom',
        name: 'Maelstrom',
        description: 'Increases your base damage. Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.',
        maxStacks: 1,
        modifier: {},
        ingredients: [
            'upgrade_item_javelin',
            'upgrade_item_mithril_hammer'
        ],
        tier: 1,
    },
    {
        itemName: 'basher',
        name: 'Basher',
        description: 'Increases your maximum HP and your base damage. Your attacks has a chance to deal extra damage and stun the target.',
        maxStacks: 1,
        modifier: {},
        ingredients: [
            'belt_of_strength',
            'upgrade_item_mithril_hammer'
        ],
        tier: 1,
    },
    {
        itemName: 'belt_of_strength',
        name: 'Belt of Strength',
        description: 'Increases your maximum HP.',
        maxStacks: 1,
        modifier: {},
        tier: 1,
    }

].map((item) => (
    {
        ...item,
        id: `upgrade_item_${item.itemName}`,
        abilityIconName: `item_${item.itemName}`,
        modifier: {
            ...item.modifier,
            name: `modifier_upgrade_item_${item.itemName}`
        },
        type: UpgradeTypes.ITEM,
    }
));

export default Items;