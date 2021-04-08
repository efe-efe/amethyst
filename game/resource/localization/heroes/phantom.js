"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GenerateLocalizationData = void 0;
var specific_1 = require("../specific");
function GenerateLocalizationData() {
    var Abilities = new Array();
    var Modifiers = new Array();
    var StandardTooltips = new Array();
    var Talents = new Array();
    var localization_info = {
        AbilityArray: Abilities,
        ModifierArray: Modifiers,
        StandardArray: StandardTooltips,
        TalentArray: Talents
    };
    var Swift = specific_1.Ability('Swift', 'phantom_mobility.png');
    var CriticalStrike = specific_1.Ability('Critical Strike', 'phantom_second_attack.png');
    var LesserStiflingDagger = specific_1.Ability('Lesser Stifling Dagger', 'phantom_basic_attack_related.png');
    var PoisonusDagger = specific_1.Ability('Poisonus Dagger', 'phantom_ex_counter_recast.png');
    var PhantomStrike = specific_1.Ability('Phantom Strike', 'phantom_counter.png');
    Abilities.push({
        ability_classname: 'phantom_basic_attack',
        name: 'Blade Swing',
        description: specific_1.Description({
            description: 'Melee attack that deals ' + specific_1.Keywords.BaseDamage + '. Successfully hitting a target generate a ' + specific_1.Keywords.PhantomStack.instance() + ' and reduces the cooldown of ' + CriticalStrike + ' in @{cooldown_reduction}s.',
            level: ''
        }),
        lore: specific_1.Keywords.PhantomStack.definition,
        ability_specials: [
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
        description: specific_1.Description({
            description: 'Swings your weapon in a melee attack, dealing @{ability_damage} damage to the enemy. Consumes all ' + specific_1.Keywords.PhantomStack.instance() + ' to increase the damage dealt by @{damage_per_stack} per stack. If you consume 3 stacks, instantly gives ' + Swift + ' a charge.',
            level: 'Fully replenish ' + Swift + ' when used with 3 ' + specific_1.Keywords.PhantomStack.instance() + '.',
        }),
        lore: specific_1.Keywords.PhantomStack.definition,
        ability_specials: [
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
        description: specific_1.Description({
            description: 'Counters the next projectile or melee attack. Countering an attack banishes yourself for @{banish_duration} second, after that, teleports you to target location, heals you in <font color="#97DF3B">{heal}</font>, increases your attack speed by @{as_speed} for @{buff_duration}s and teleports you to a new location.',
            level: 'Can be recasted to get the attack speed buff again and gain a shield that blocks @{shield} damage during @{shield_duration}s.',
        }),
    });
    Abilities.push({
        ability_classname: 'phantom_special_attack',
        name: 'Stifling Dagger',
        description: specific_1.Description({
            description: 'Throws a dagger that deals @{ability_damage} damage to the target, inflicts ' + specific_1.Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s and generates a ' + specific_1.Keywords.PhantomStack.instance() + '. You can stack up to @{max_charges} charges.',
            level: 'Adds another charge, increases the damage and also applies ' + specific_1.Keywords.Bleeding.instance() + '.',
        }),
        lore: specific_1.multipleKeywords([specific_1.Keywords.Bleeding.definition, specific_1.Keywords.FadingSlow.definition, specific_1.Keywords.PhantomStack.definition]),
        ability_specials: [
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
        description: specific_1.Description({
            description: 'Dashes towards your movement direction. You can stack up to @{max_charges} charges.',
            level: 'Adds another charge and reduces cooldown.',
        }),
    });
    Abilities.push({
        ability_classname: 'phantom_ultimate',
        name: 'Coup de Grace',
        description: specific_1.Description({
            description: 'Throws your weapon, dealing @{ability_damage} damage and blinking towards the first unit it strikes. Deals @{damage_per_stack} extra damage per ' + specific_1.Keywords.PhantomStack.instance() + ' consumed.',
            level: '',
        }),
        lore: specific_1.Keywords.PhantomStack.definition,
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'phantom_extra',
        name: 'Quick Strike',
        description: specific_1.Description({
            description: 'Dashes towards the pointing direction, dealing @{ability_damage} damage and inflicting ' + specific_1.Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s to enemies in the way and at the arriving area.',
            level: 'Can be recasted when hit an enemy.',
        }),
        lore: specific_1.Keywords.FadingSlow.definition,
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'phantom_ex_basic_attack',
        name: 'Dancing Blades',
        description: specific_1.Description({
            description: 'Phantom Assassin replaces her basic attack with ' + LesserStiflingDagger + '. Lasts for @{duration}s.',
            subAbility: {
                name: 'Lesser Stifling Dagger',
                description: 'Throws a dagger that deals @{ability_damage} damage to the target, inflicts ' + specific_1.Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s and generates a ' + specific_1.Keywords.PhantomStack.instance() + '.',
                iconPath: 'phantom_basic_attack_related.png',
            },
            level: 'Your daggers applies an stacking ' + specific_1.Keywords.Bleeding.instance() + ' debuff on target for @{bleed_duration}s.',
        }),
        lore: specific_1.multipleKeywords([specific_1.Keywords.PhantomStack.definition, specific_1.Keywords.FadingSlow.definition, specific_1.Keywords.Bleeding.definition]),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'phantom_ex_counter',
        name: 'Blur',
        description: specific_1.Description({
            description: 'Phantom Assassin blurs her body, causing her to be impossible to see and increasing her movement speed in @{speed_buff_pct}% for @{duration}s. During that time, this spell can be recasted to throw a ' + PoisonusDagger + '.',
            subAbility: {
                name: 'Poisonus Dagger',
                description: 'Throws a dagger that deals @{ability_damage} damage to the target, inflicts ' + specific_1.Keywords.Sleep.instance() + ' for @{sleep_duration}s and generates a ' + specific_1.Keywords.PhantomStack.instance() + '. Consumes all your courrent stacks to increase the duration of ' + specific_1.Keywords.Sleep.instance() + ' by @{duration_per_stack}s per stack.',
                iconPath: 'phantom_ex_counter_recast.png',
            },
            level: 'No longer shares cooldown with ' + PhantomStrike + '.',
        }),
        lore: specific_1.Keywords.Sleep.definition,
        ability_specials: [
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
    return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
