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
    var Snipe = specific_1.Ability('Snipe', 'sniper_second_attack.png');
    var Shrapnel = specific_1.Ability('Shrapnel', 'sniper_special_attack.png');
    var DualShoot = specific_1.Ability('Dual Shoot', 'sniper_basic_attack.png');
    Abilities.push({
        ability_classname: 'sniper_basic_attack',
        name: 'Dual Shoot',
        description: specific_1.Description({
            description: 'Fire with your gun ${max_charges} times before reloading, dealing ' + specific_1.Keywords.BaseDamage + ' per bullet.',
            level: 'Adds an additional charge.',
        }),
        ability_specials: [
            {
                ability_special: 'replenish_time',
                text: 'REPLENISH TIME',
            },
            {
                ability_special: 'mana_gain_pct',
                text: '<font color=\\"#00A6DE\\">MANA GAIN</font>',
                percentage: true,
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_second_attack',
        name: 'Snipe',
        description: specific_1.Description({
            description: 'Fire a piercing shot that deals ${ability_damage} damage and inflicts ' + specific_1.Keywords.Stun.instance() + ' for ${stun_duration}s. Damage is reduced ${reduction_per_hit}% per target hit.',
            level: 'Reduces the damage but also reduces the cast point and allows you to cast it while moving.',
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
        ability_classname: 'sniper_counter',
        name: 'Stealth',
        description: specific_1.Description({
            description: 'Becomes invisible for ${duration}s. Moves ${speed_buff_pct}% faster while invisible. Resets the cooldown of ' + Snipe + '.',
            level: 'Increases movement speed while active.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_special_attack',
        name: 'Shrapnel',
        description: specific_1.Description({
            description: 'Deploys a rocket that showers an area with explosive shards, dealing ${damage_per_think} damage every ${think_interval}s and inflicts ${slow_pct}% slow over time. Lasts for ${duration}s.',
            level: 'Adds an additional charge.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_mobility',
        name: 'Grenade Jump',
        description: specific_1.Description({
            description: 'Dash towards a new location, while creating a ' + Shrapnel + ' in the starting location.',
            level: 'Resets the cooldown of ' + Snipe + '.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_ultimate',
        name: 'Assassinate',
        description: specific_1.Description({
            description: 'Fire 4 rockets dealing ${ability_damage} damage on hit and ${aoe_damage} damage on the explosion.',
            channeled: true,
        }),
        lore: specific_1.Keywords.Channeling.definition,
        ability_specials: [
            {
                ability_special: 'duration',
                text: 'DURATION',
            },
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_extra',
        name: 'Shotgun',
        description: specific_1.Description({
            description: 'Fire 3 piercing bullets in a cone, dealing ${damage_per_bullet} damage per bullet and knocking enemies back. Sniper is also pushed back. Pushing enemies into a wall deals ${damage_on_collision} extra damage.',
            level: 'Removes the mana cost.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_ex_second_attack',
        name: 'Quick Snipe',
        description: specific_1.Description({
            description: 'Fire a piercing shot that deals ${ability_damage} damage and inflicts ' + specific_1.Keywords.Root.instance() + ' for ${root_duration}s. Damage is reduced ${reduction_per_hit} per target hit.',
            level: 'The bullet bounces back when it reaches its max distance.',
        }),
        lore: specific_1.Keywords.Root.definition,
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'sniper_ex_special_attack',
        name: 'Adrenaline Grenade',
        description: specific_1.Description({
            description: 'Deploys a grenade that leaves the impact area covered in electricity, increasing the movement speed by ${ms_pct}% to the allies in the area and constatly reloading Sniper\'s ' + DualShoot + ' and increasing his ' + specific_1.Keywords.BaseDamage + ' in ${extra_damage}. Lasts for ${duration}s.',
            level: 'Increases the damage buff.',
        }),
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
