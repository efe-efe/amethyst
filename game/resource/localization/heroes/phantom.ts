import { AbilityLocalization, HeroTalents, Language, LocalizationData, ModifierLocalization, StandardLocalization } from '../../localizationInterfaces';
import { Keywords, Description, multipleKeywords, Ability, UpgradeTypes, Upgrades, Upgrade } from '../specific';

export function GenerateLocalizationData(): LocalizationData
{
    const Abilities: Array<AbilityLocalization> = new Array<AbilityLocalization>();
    const Modifiers: Array<ModifierLocalization> = new Array<ModifierLocalization>();
    const StandardTooltips: Array<StandardLocalization> = new Array<StandardLocalization>();
    const Talents: Array<HeroTalents> = new Array<HeroTalents>();

    const localization_info: LocalizationData =
    {
        AbilityArray: Abilities,
        ModifierArray: Modifiers,
        StandardArray: StandardTooltips,
        TalentArray: Talents
    };

    const Swift = Ability('Swift', 'phantom_mobility.png');
    const CriticalStrike = Ability('Critical Strike', 'phantom_second_attack.png');
    const LesserStiflingDagger = Ability('Lesser Stifling Dagger', 'phantom_basic_attack_related.png');
    const PoisonusDagger = Ability('Poisonus Dagger', 'phantom_ex_counter_recast.png');
    const PhantomStrike = Ability('Phantom Strike', 'phantom_counter.png');

    Abilities.push({
        ability_classname: 'phantom_basic_attack',
        name: 'Blade Swing',
        description: Description({
            description: 'Melee attack that deals ' + Keywords.BaseDamage + '. Successfully hitting a target generate a ' + Keywords.PhantomStack.instance() + ' and reduces the cooldown of ' + CriticalStrike + ' in @{cooldown_reduction}s.',
            level: ''
        }),
        lore: Keywords.PhantomStack.definition,
        ability_specials:
        [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

            {
                ability_special: 'related',
                text: 'Lesser Stifling Dagger',
            },

            {
                ability_special: 'related_mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

        ],
    });

    Abilities.push({
        ability_classname: 'phantom_second_attack',
        name: 'Critical Strike',
        description: Description({
            description: 'Swings your weapon in a melee attack, dealing @{damage_multiplier_per_stack} times your ' + Keywords.BaseDamage + ' to all enemies in front of you. Consumes all ' + Keywords.PhantomStack.instance() + ' to increase the damage multiplier by @{damage_multiplier_per_stack} per stack. If you consume 3 stacks, instantly gives ' + Swift + ' a charge.',
            level: 'Fully replenish ' + Swift + ' when used with 3 ' + Keywords.PhantomStack.instance() + '.',
        }),
        lore: Keywords.PhantomStack.definition,
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

        ],
    });
    Abilities.push({
        ability_classname: 'phantom_counter',
        name: 'Phantom Strike',
        description: Description({
            description: 'Counters the next projectile or melee attack. Countering an attack banishes yourself for @{banish_duration} second, after that, teleports you to target location, heals you in <font color="#97DF3B">@{heal}</font>, increases your attack speed by @{as_speed} for @{buff_duration}s and teleports you to a new location.',
            level: 'Can be recasted to get the attack speed buff again and gain a shield that blocks @{shield} damage during @{shield_duration}s.',
        }),
    });
    Abilities.push({
        ability_classname: 'phantom_special_attack',
        name: 'Stifling Dagger',
        description: Description({
            description: 'Throws a dagger that deals @{damage_multiplier} times your ' + Keywords.BaseDamage + ' to the target (rounded down), inflicts ' + Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s and generates a ' + Keywords.PhantomStack.instance() + '. You can stack up to @{max_charges} charges.',
            level: 'Adds another charge, increases the damage and also applies ' + Keywords.Bleeding.instance() + '.', 
        }),
        lore: multipleKeywords([Keywords.Bleeding.definition, Keywords.FadingSlow.definition, Keywords.PhantomStack.definition]),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

        ],
    });
    Abilities.push({
        ability_classname: 'phantom_mobility',
        name: 'Swift',
        description: Description({
            description: 'Dashes towards your movement direction. You can stack up to @{max_charges} charges.',
            level: 'Adds another charge and reduces cooldown.',
        }),
    });
    Abilities.push({
        ability_classname: 'phantom_ultimate',
        name: 'Coup de Grace',
        description: Description({
            description: 'Throws your weapon, dealing @{damage_multiplier} times your ' + Keywords.BaseDamage + ' and blinking towards the first unit it strikes. The damage mulitplier is increased by @{damage_multiplier_per_stack} per each' + Keywords.PhantomStack.instance() + ' consumed.',
            level: '', 
        }),
        lore: Keywords.PhantomStack.definition,
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'phantom_extra',
        name: 'Quick Strike',
        description: Description({
            description: 'Dashes towards the pointing direction, dealing @{ability_damage} damage and inflicting ' + Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s to enemies in the way and at the arriving area.',
            level: 'Can be recasted when hit an enemy.',
        }),
        lore: Keywords.FadingSlow.definition,
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'phantom_ex_basic_attack',
        name: 'Dancing Blades',
        description: Description({
            description: 'Phantom Assassin replaces her basic attack with ' + LesserStiflingDagger + '. Lasts for @{duration}s.',
            subAbility: {
                name: 'Lesser Stifling Dagger',
                description: 'Throws a dagger that deals @{ability_damage} damage to the target, inflicts ' + Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s and generates a ' + Keywords.PhantomStack.instance() + '.',
                iconPath: 'phantom_basic_attack_related.png',
            },
            level: 'Your daggers applies an stacking ' + Keywords.Bleeding.instance() + ' debuff on target for @{bleed_duration}s.',
        }),
        lore: multipleKeywords([Keywords.PhantomStack.definition, Keywords.FadingSlow.definition, Keywords.Bleeding.definition]),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'phantom_ex_counter',
        name: 'Blur',
        description: Description({
            description: 'Phantom Assassin blurs her body, causing her to be impossible to see and increasing her movement speed in @{speed_buff_pct}% for @{duration}s. During that time, this spell can be recasted to throw a ' + PoisonusDagger + '.',
            subAbility: {
                name: 'Poisonus Dagger',
                description: 'Throws a dagger that deals @{ability_damage} damage to the target, inflicts ' + Keywords.Sleep.instance() + ' for @{sleep_duration}s and generates a ' + Keywords.PhantomStack.instance() + '. Consumes all your courrent stacks to increase the duration of ' + Keywords.Sleep.instance() + ' by @{duration_per_stack}s per stack.',
                iconPath: 'phantom_ex_counter_recast.png',
            },
            level: 'No longer shares cooldown with '+ PhantomStrike + '.',
        }),
        lore: Keywords.Sleep.definition,
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

            {
                ability_special: 'recast',
                text: 'Poisonus Dagger',
            },

            {
                ability_special: 'recast_AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });

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
        {
            id: 'phantom_act_while_countering',
            name: 'Phantom Strike while acting',
            description: 'You can act while in counter state.',
            ability: 'phantom_counter',
            maxStacks: 1,
            modifier: {
                name: 'modifier_upgrade_phantom_act_while_countering'
            },
            tier: 1,
            type: UpgradeTypes.FAVOR,
        },
    ];

    Modifiers.push(...Upgrades([...Shards, ...Favors]));
    return localization_info;
}