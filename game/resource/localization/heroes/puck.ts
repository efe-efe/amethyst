import { AbilityLocalization, HeroTalents, Language, LocalizationData, ModifierLocalization, StandardLocalization } from "../../localizationInterfaces";
import { Keywords, Description, multipleKeywords, Ability } from "../specific";

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

    const EndlessMisschief = Ability("Endless Mischief", "puck_second_attack.png");
    const FairyFlare = Ability("Fairy Flare", "puck_basic_attack.png");
    const FairyPower = Ability("Fairy Power", "puck_basic_attack_related.png");
    const IllusoryOrb = Ability("Illusory Orb", "puck_mobility.png");

    Abilities.push({
        ability_classname: "puck_basic_attack",
        name: "Fairy Flare",
        description: Description({
            description: "Range attack that deals " + Keywords.BaseDamage + ". When its charged, Puck gains extra @{charged_damage} base damage and this ability inflicts " + Keywords.FairyDust.instance("@{fairy_dust_slow_pct}") + " for @{fairy_dust_duration}s. Charges every @{replenish_time} seconds.",
            level: "Successful hits charges your weapon."
        }),
        lore: Keywords.FairyDust.definition,
        ability_specials:
        [
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
        description: Description({
            description: "Fire a orb of light that deals @{ability_damage} on impact. If the target is affected by "+ Keywords.FairyDust.instance() +", also applies " + Keywords.Silence.instance() + " for @{silence_duration}s.",
            level: "Increases damage and refreshes " + EndlessMisschief + " cooldown.",
        }),
        lore: multipleKeywords([Keywords.FairyDust.definition, Keywords.Silence.definition]),
        ability_specials:
        [
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
        description: Description({
            description: "Puck Banishes for @{banish_duration}s. When activated, launch a " + FairyFlare + " towards mouse position. Casting any spell will remove the banish. Has @{max_charges} charges.",
            level: "Reduces the cooldown " + FairyFlare + " before throwing the projectile."
        }),
        ability_specials:
        [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },

        ],
    });
    Abilities.push({
        ability_classname: "puck_mobility",
        name: "Illusory Orb",
        description: Description({
            description: "Puck launches a magic orb that floats in a straight path, dealing @{ability_damage} to enemy units along the way. Can be recasted to teleport Puck to the orb's location and deal @{damage_aoe} damage in area to enemies on the arrival location.",
            level: "If hits an enemy, resets the cooldown.",
        }),
        ability_specials:
        [
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
        description: Description({
            description: "Puck realeses his power in an area. First in a small wave, dealing @{damage_small} damage and applying " + Keywords.Silence.instance() + " for @{silence_duration}s to enemies in area, and then in a bigger wave deaing @{damage} and applying " + Keywords.FairyDust.instance("@{fairy_dust_slow_pct}") + " for @{fairy_dust_duration}s.",
            level: "Applies " + Keywords.Stun.instance() + " for @{stun_duration_small}s in the small wave and for @{stun_duration}s in the big wave and increases the damage dealt in both waves. No longer silences",
        }), 
        lore: multipleKeywords([Keywords.FairyDust.definition, Keywords.Silence.definition, Keywords.Stun.definition]),
        ability_specials:
        [
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
        description: Description({
            description: "Creates a coil of volatile magic that latches onto enemy Heroes, inflicting a @{initial_stun_duration}s " + Keywords.Stun.instance() + " on them. If the enemy hero stretches the coil by moving too far away, it snaps, inflicting " + Keywords.Stun.instance() + " for @{snap_stun_duration}s, and dealing @{ability_damage} damage. Any time that puck launches a " + FairyFlare + ", the coil launches one too targeted at the same direction."
        }),
        lore: Keywords.Stun.definition,
        ability_specials:
        [
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
        description: Description({
            description: "Puck teleports himself to the target location and releases a burst of dust that inflicts " + Keywords.SpellBlock.instance("@{silence_duration}") + " for @{pre_silence_duration}s on the enemy units nearby.",
            level: "Grants one free recast if " + Keywords.SpellBlock.instance() + " is triggered.",
        }),
        lore: multipleKeywords([Keywords.SpellBlock.definition, Keywords.Silence.definition]),
        ability_specials:
        [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },

        ],
    });
    Abilities.push({
        ability_classname: "puck_ex_basic_attack",
        name: "Fairy Form",
        description: Description({
            description: "Puck tranforms himself into his Fairy Form, replacing its " + FairyFlare + ". Lasts for @{duration}.",
            level: "When hitting an enemy with " + FairyPower + " also heals you for @{heal_per_hit} health.",
            subAbility: {
                name: "Fairy Power",
                description: "Ranged area attack that after a delay of @{delay_time}s deals <b><font color=\"#ffffff\">base damage</font></b>. When charged, inflicts " + Keywords.FairyDust.instance("@{fairy_dust_slow_pct}") + " for @{fairy_dust_duration}s. Charges every @{replenish_time} seconds. When hitting at least one enemy gains @{shield_per_hit} shield points.",
                iconPath: "puck_basic_attack_related",
            }
        }),
        lore: Keywords.FairyDust.definition,
        ability_specials:
        [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },

        ],
    });
    Abilities.push({
        ability_classname: "puck_ex_mobility",
        name: "Merry Wanderer",
        description: Description({
            description: "Puck launches a magic orb that floats in a straight path, dealing @{ability_damage} to enemy units along the way. Can be recasted to teleport Puck to the orb's location and deal @{damage_aoe} damage and applies " + Keywords.Fear.instance() + " for @{fear_duration}s in area to enemies on the arrival location.",
            level: "No longer shares cooldown with " + IllusoryOrb + ".",
        }),
        lore: Keywords.Fear.definition,
        ability_specials:
        [
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