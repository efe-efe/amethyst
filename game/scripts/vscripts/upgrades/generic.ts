import { Upgrade } from './upgrades';

const genericUpgrades: Upgrade[] = [
    {
        id: 'restore_health',
        name: 'Restore health',
        description: 'Fully restores your health',
        maxStacks: 1,
        minLevel: 2,
        tier: 0,
        effect: (hero: CDOTA_BaseNPC_Hero): void => {
            CustomEntitiesLegacy.TrueHeal(hero, hero.GetMaxHealth());
        },
    },
    {
        id: 'meele_extra_radius',
        name: 'Extra radius',
        description: 'Provides extra radius on your basic attack',
        maxStacks: 1,
        attackCapability: UnitAttackCapability.MELEE_ATTACK,
        modifier: {
            name: 'modifier_upgrade_meele_extra_radius'
        },
        tier: 0,
    },
    {
        id: 'extra_base_damage',
        name: 'Extra base damage',
        description: 'Increases your base damage by 3.',
        maxStacks: 3,
        modifier: {
            name: 'modifier_upgrade_extra_base_damage'
        },
        tier: 1,
    },
    {
        id: 'extra_speed',
        name: 'Extra speed',
        description: 'Increases your movement and attack speed.',
        maxStacks: 3,
        modifier: {
            name: 'modifier_upgrade_extra_speed'
        },
        tier: 1,
    },
    {
        id: 'lightining_attack',
        name: 'Lightining attack',
        description: 'Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.',
        maxStacks: 3,
        modifier: {
            name: 'modifier_upgrade_lightining_attack'
        },
        tier: 1,
    },
    {
        id: 'stun_attack',
        name: 'Stun attack',
        description: 'Your attacks has a chance to deal extra damage and stun the target.',
        maxStacks: 3,
        modifier: {
            name: 'modifier_upgrade_stun_attack'
        },
        tier: 1,
    }
];

export default genericUpgrades;