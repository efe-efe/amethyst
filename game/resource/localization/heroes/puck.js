"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GenerateLocalizationData = void 0;
var specific_1 = require("../specific");
function GenerateLocalizationData() {
    var Abilities = [];
    var Modifiers = [];
    var StandardTooltips = [];
    var Talents = [];
    var localization_info = {
        AbilityArray: Abilities,
        ModifierArray: Modifiers,
        StandardArray: StandardTooltips,
        TalentArray: Talents
    };
    var EndlessMisschief = specific_1.Ability("Endless Mischief", "puck_second_attack.png");
    var FairyFlare = specific_1.Ability("Fairy Flare", "puck_basic_attack.png");
    var FairyPower = specific_1.Ability("Fairy Power", "puck_basic_attack_related.png");
    var IllusoryOrb = specific_1.Ability("Illusory Orb", "puck_mobility.png");
    Abilities.push({
        ability_classname: "puck_basic_attack",
        name: "Fairy Flare",
        description: specific_1.Description({
            description: "Range attack that deals " + specific_1.Keywords.BaseDamage + ". When its charged, Puck gains extra @{charged_damage} base damage and this ability inflicts " + specific_1.Keywords.FairyDust.instance("@{fairy_dust_slow_pct}") + " for @{fairy_dust_duration}s. Charges every @{replenish_time} seconds.",
            level: "Successful hits charges your weapon."
        }),
        lore: specific_1.Keywords.FairyDust.definition,
        ability_specials: [
            {
                ability_special: "mana_gain_pct",
                text: "<font color=\"#00A6DE\">MANA GAIN</font>",
                percentage: true,
            },
            {
                ability_special: "related",
                text: "Fairy Power",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_second_attack",
        name: "Lightining Orb",
        description: specific_1.Description({
            description: "Fire a orb of light that deals @{ability_damage} on impact. If the target is affected by " + specific_1.Keywords.FairyDust.instance() + ", also applies " + specific_1.Keywords.Silence.instance() + " for @{silence_duration}s.",
            level: "Increases damage and refreshes " + EndlessMisschief + " cooldown.",
        }),
        lore: specific_1.multipleKeywords([specific_1.Keywords.FairyDust.definition, specific_1.Keywords.Silence.definition]),
        ability_specials: [
            {
                ability_special: "mana_gain_pct",
                text: "<font color=\"#00A6DE\">MANA GAIN</font>",
                percentage: true,
            },
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_counter",
        name: "Phase Shift",
        description: specific_1.Description({
            description: "Puck Banishes for @{banish_duration}s. When activated, launch a " + FairyFlare + " towards mouse position. Casting any spell will remove the banish. Has @{max_charges} charges.",
            level: "Reduces the cooldown " + FairyFlare + " before throwing the projectile."
        }),
        ability_specials: [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_mobility",
        name: "Illusory Orb",
        description: specific_1.Description({
            description: "Puck launches a magic orb that floats in a straight path, dealing @{ability_damage} to enemy units along the way. Can be recasted to teleport Puck to the orb's location and deal @{damage_aoe} damage in area to enemies on the arrival location.",
            level: "If hits an enemy, resets the cooldown.",
        }),
        ability_specials: [
            {
                ability_special: "mana_gain_pct",
                text: "<font color=\"#00A6DE\">MANA GAIN</font>",
                percentage: true,
            },
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_special_attack",
        name: "Endless Mischief",
        description: specific_1.Description({
            description: "Puck realeses his power in an area. First in a small wave, dealing @{damage_small} damage and applying " + specific_1.Keywords.Silence.instance() + " for @{silence_duration}s to enemies in area, and then in a bigger wave deaing @{damage} and applying " + specific_1.Keywords.FairyDust.instance("@{fairy_dust_slow_pct}") + " for @{fairy_dust_duration}s.",
            level: "Applies " + specific_1.Keywords.Stun.instance() + " for @{stun_duration_small}s in the small wave and for @{stun_duration}s in the big wave and increases the damage dealt in both waves. No longer silences",
        }),
        lore: specific_1.multipleKeywords([specific_1.Keywords.FairyDust.definition, specific_1.Keywords.Silence.definition, specific_1.Keywords.Stun.definition]),
        ability_specials: [
            {
                ability_special: "mana_gain_pct",
                text: "<font color=\"#00A6DE\">MANA GAIN PER WAVE</font>",
                percentage: true,
            },
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>:,<font color=\"#B2B5B3\">CAST POINT</font>:",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_ultimate",
        name: "Dream Coil",
        description: specific_1.Description({
            description: "Creates a coil of volatile magic that latches onto enemy Heroes, inflicting a @{initial_stun_duration}s " + specific_1.Keywords.Stun.instance() + " on them. If the enemy hero stretches the coil by moving too far away, it snaps, inflicting " + specific_1.Keywords.Stun.instance() + " for @{snap_stun_duration}s, and dealing @{ability_damage} damage. Any time that puck launches a " + FairyFlare + ", the coil launches one too targeted at the same direction."
        }),
        lore: specific_1.Keywords.Stun.definition,
        ability_specials: [
            {
                ability_special: "duration",
                text: "DURATION",
            },
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_extra",
        name: "Waning Rift",
        description: specific_1.Description({
            description: "Puck teleports himself to the target location and releases a burst of dust that inflicts " + specific_1.Keywords.SpellBlock.instance("@{silence_duration}") + " for @{pre_silence_duration}s on the enemy units nearby.",
            level: "Grants one free recast if " + specific_1.Keywords.SpellBlock.instance() + " is triggered.",
        }),
        lore: specific_1.multipleKeywords([specific_1.Keywords.SpellBlock.definition, specific_1.Keywords.Silence.definition]),
        ability_specials: [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_ex_basic_attack",
        name: "Fairy Form",
        description: specific_1.Description({
            description: "Puck tranforms himself into his Fairy Form, replacing its " + FairyFlare + ". Lasts for @{duration}.",
            level: "When hitting an enemy with " + FairyPower + " also heals you for @{heal_per_hit} health.",
            subAbility: {
                name: "Fairy Power",
                description: "Ranged area attack that after a delay of @{delay_time}s deals <b><font color=\"#ffffff\">base damage</font></b>. When charged, inflicts " + specific_1.Keywords.FairyDust.instance("@{fairy_dust_slow_pct}") + " for @{fairy_dust_duration}s. Charges every @{replenish_time} seconds. When hitting at least one enemy gains @{shield_per_hit} shield points.",
                iconPath: "puck_basic_attack_related",
            }
        }),
        lore: specific_1.Keywords.FairyDust.definition,
        ability_specials: [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Abilities.push({
        ability_classname: "puck_ex_mobility",
        name: "Merry Wanderer",
        description: specific_1.Description({
            description: "Puck launches a magic orb that floats in a straight path, dealing @{ability_damage} to enemy units along the way. Can be recasted to teleport Puck to the orb's location and deal @{damage_aoe} damage and applies " + specific_1.Keywords.Fear.instance() + " for @{fear_duration}s in area to enemies on the arrival location.",
            level: "No longer shares cooldown with " + IllusoryOrb + ".",
        }),
        lore: specific_1.Keywords.Fear.definition,
        ability_specials: [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },
        ],
    });
    Modifiers.push({
        modifier_classname: "modifier_puck_basic_attack_cooldown",
        name: "Weapon Cooldown",
        description: "When has one stack, your weapon is charged."
    });
    Modifiers.push({
        modifier_classname: "modifier_puck_counter_charges",
        name: "Phase Shift Charges",
        description: "Amount of charges."
    });
    Modifiers.push({
        modifier_classname: "modifier_puck_counter_banish",
        name: "Banished",
        description: "Invulnerable and unable to act."
    });
    Modifiers.push({
        modifier_classname: "modifier_puck_ex_basic_attack",
        name: "Fairy Form",
        description: "Basic attack changed to an area effect."
    });
    Modifiers.push({
        modifier_classname: "modifier_puck_fairy_dust",
        name: "Fairy Dust",
        description: "You move slower."
    });
    return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
