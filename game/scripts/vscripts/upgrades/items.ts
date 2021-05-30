import { Upgrade, UpgradeTypes } from './common';

const Items: Upgrade[] = [
    {
        id: 'upgrade_broom_handle',
        name: 'Broom handle',
        description: 'Provides extra radius on your basic attack',
        maxStacks: 1,
        attackCapability: UnitAttackCapability.MELEE_ATTACK,
        modifier: {
            name: 'modifier_upgrade_meele_extra_radius'
        },
        tier: 0,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_blades_of_attack',
        name: 'Blades of attack',
        description: 'Increases your base damage by 1.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_extra_base_damage'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_item_moonshard',
        name: 'Moonshard',
        description: 'Increases your movement and attack speed.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_extra_speed'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_item_maelstrom',
        name: 'Maelstrom',
        description: 'Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_lightining_attack'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    },
    {
        id: 'upgrade_item_basher',
        name: 'Basher',
        description: 'Your attacks has a chance to deal extra damage and stun the target.',
        maxStacks: 1,
        modifier: {
            name: 'modifier_upgrade_stun_attack'
        },
        tier: 1,
        type: UpgradeTypes.ITEM,
    }
];

export default Items;