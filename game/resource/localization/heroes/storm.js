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
    var UnestableEnergy = specific_1.Ability('Unestable Energy', 'storm_second_attack.png');
    var BallLightning = specific_1.Ability('Ball Lightning', 'storm_extra.png');
    Abilities.push({
        ability_classname: 'storm_basic_attack',
        name: 'Overload',
        description: specific_1.Description({
            description: 'Storm attacks with lightining balls dealing ' + specific_1.Keywords.BaseDamage + ' to the enemy. If hits a target when charged, deals ${ability_damage} damage in area and applies ' + specific_1.Keywords.FadingSlow.instance('${fading_slow_pct}') + ' for ${fading_slow_duration}s to enemies. Casting any spell appart from this one, creates a charge.',
        }),
        lore: specific_1.Keywords.FadingSlow.definition,
        ability_specials: [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color=\\"#00A6DE\\">MANA GAIN</font>',
                percentage: true,
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_second_attack',
        name: 'Unestable Energy',
        description: specific_1.Description({
            description: 'Storm attacks with an unestable ball of energy that deals ${ability_damage} to the enemy.',
            level: 'Applies a debuff that deals ${damage_per_tick} damage and applies ' + specific_1.Keywords.Stun.instance() + ' for ${stun_duration} every ${think_interval}s. Lasts for ${duration}s.',
        }),
        lore: specific_1.Keywords.Stun.definition,
        ability_specials: [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color=\\"#00A6DE\\">MANA GAIN</font>',
                percentage: true,
            },
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_counter',
        name: 'Second Thunder',
        description: specific_1.Description({
            description: 'Goes into counter state for a short period of time. During which, if storm is hit by a melee attack or projectile, he knockbacks and deals ${ability_damage} damage to any enemy in close range, and also recovers ${mana_gain} mana.',
            level: 'Reduces cooldown.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_special_attack',
        name: 'Electric Vortex',
        description: specific_1.Description({
            description: 'Generates an electric vortex on the map. After ${delay_time}s, it deals ${ability_damage} damage to enemies hit by it and pulls them towards target location. The pull lasts for ${duration}.',
            level: 'Increases the mana gain percentage. Can gain mana from multiple targets. Also drains mana from the enemies.',
        }),
        ability_specials: [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color=\\"#00A6DE\\">MANA GAIN</font>',
                percentage: true,
            },
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_mobility',
        name: 'Static Remnant',
        description: specific_1.Description({
            description: 'Creates an explosively charged image of Storm Spirit that lasts ${duration} seconds and will detonate and deal ${ability_damage} damage if an enemy unit comes near.',
            level: 'Adds an aditional charge.',
        }),
        ability_specials: [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color=\\"#00A6DE\\">MANA GAIN</font>',
                percentage: true,
            },
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_ultimate',
        name: 'Storm Unleashed',
        description: specific_1.Description({
            description: 'The spirit becomes one with the storm, teleporting himself to a different location and falling from the sky in the form of a thunder. Deals ${ability_damage} damage to enemies at the arrival location. After falling, all the mana he gains from spells is multiplied by ${mana_multiplier} during ${duration}s.',
            level: '',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_extra',
        name: 'Ball Lightning',
        description: specific_1.Description({
            description: 'Storm Spirit becomes volatile electricity, charging across the battlefield. Deals ${ability_damage} damage to the enemies in the way, and ${aoe_damage} damage to enemies on the arrival area. Also applies ' + specific_1.Keywords.FadingSlow.instance('${fading_slow_pct}') + ' for ${fading_slow_duration}s to enemies at the arrival area.',
            level: 'When hitting an enemy, resets ' + UnestableEnergy + ' cooldown.',
        }),
        lore: specific_1.Keywords.FadingSlow.definition,
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_ex_basic_attack',
        name: 'Thunder Mastery',
        description: specific_1.Description({
            description: 'Buff your next ' + BallLightning + ', adding ${damage_per_level} damage and healing yourself for half of the damage dealt with it. If you cast it again while buffed, it will add ${damage_per_level} extra damage and inflict ' + specific_1.Keywords.Stun.instance() + ' for ${stun_duration}s.',
            level: 'Works for the next two ' + BallLightning + 's .',
        }),
        lore: specific_1.Keywords.Stun.definition,
    });
    Abilities.push({
        ability_classname: 'storm_ex_mobility',
        name: 'Paralyzing Remnant',
        description: specific_1.Description({
            description: 'Creates an explosively charged image of Storm Spirit that lasts ${duration} seconds and will detonate and deal ${ability_damage} damage and applies ' + specific_1.Keywords.Sleep.instance() + ' for ${sleep_duration}s to enemies that comes near.',
            level: 'Increases the sleeping duration.',
        }),
        lore: specific_1.Keywords.Sleep.definition,
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
