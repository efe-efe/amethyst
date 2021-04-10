import { AbilityLocalization, HeroTalents, Language, LocalizationData, ModifierLocalization, StandardLocalization } from '../../localizationInterfaces';
import { Keywords, Description, multipleKeywords, Ability } from '../specific';

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

    const UnestableEnergy = Ability('Unestable Energy', 'storm_second_attack.png');
    const BallLightning = Ability('Ball Lightning', 'storm_extra.png');

    Abilities.push({
        ability_classname: 'storm_basic_attack',
        name: 'Overload',
        description: Description({
            description: 'Storm attacks with lightining balls dealing ' + Keywords.BaseDamage + ' to the enemy. If hits a target when charged, deals @{ability_damage} damage in area and applies ' + Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s to enemies. Casting any spell appart from this one, creates a charge.',
        }),
        lore: Keywords.FadingSlow.definition,
        ability_specials:
        [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

        ],
    });
    Abilities.push({
        ability_classname: 'storm_second_attack',
        name: 'Unestable Energy',
        description: Description({
            description: 'Storm attacks with an unestable ball of energy that deals @{ability_damage} to the enemy.',
            level: 'Applies a debuff that deals @{damage_per_tick} damage and applies ' + Keywords.Stun.instance() + ' for @{stun_duration} every @{think_interval}s. Lasts for @{duration}s.',
        }),
        lore: Keywords.Stun.definition,
        ability_specials:
        [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'storm_counter',
        name: 'Second Thunder',
        description: Description({
            description: 'Goes into counter state for a short period of time. During which, if storm is hit by a melee attack or projectile, he knockbacks and deals @{ability_damage} damage to any enemy in close range, and also recovers @{mana_gain} mana.',
            level: 'Reduces cooldown.',
        }),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_special_attack',
        name: 'Electric Vortex',
        description: Description({
            description: 'Generates an electric vortex on the map. After @{delay_time}s, it deals @{ability_damage} damage to enemies hit by it and pulls them towards target location. The pull lasts for @{duration}.',
            level: 'Increases the mana gain percentage. Can gain mana from multiple targets. Also drains mana from the enemies.',
        }),
        ability_specials:
        [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'storm_mobility',
        name: 'Static Remnant',
        description: Description({
            description: 'Creates an explosively charged image of Storm Spirit that lasts @{duration} seconds and will detonate and deal @{ability_damage} damage if an enemy unit comes near.',
            level: 'Adds an aditional charge.',
        }),
        ability_specials:
        [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },

            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'storm_ultimate',
        name: 'Storm Unleashed',
        description: Description({
            description: 'The spirit becomes one with the storm, teleporting himself to a different location and falling from the sky in the form of a thunder. Deals @{ability_damage} damage to enemies at the arrival location. After falling, all the mana he gains from spells is multiplied by @{mana_multiplier} during @{duration}s.',
            level: '',
        }),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'storm_extra',
        name: 'Ball Lightning',
        description: Description({
            description: 'Storm Spirit becomes volatile electricity, charging across the battlefield. Deals @{ability_damage} damage to the enemies in the way, and @{aoe_damage} damage to enemies on the arrival area. Also applies ' + Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s to enemies at the arrival area.',
            level: 'When hitting an enemy, resets ' + UnestableEnergy + ' cooldown.',
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
        ability_classname: 'storm_ex_basic_attack',
        name: 'Thunder Mastery',
        description: Description({
            description: 'Buff your next ' + BallLightning + ', adding @{damage_per_level} damage and healing yourself for half of the damage dealt with it. If you cast it again while buffed, it will add @{damage_per_level} extra damage and inflict ' + Keywords.Stun.instance() + ' for @{stun_duration}s.',
            level: 'Works for the next two ' + BallLightning + 's .',
        }),
        lore: Keywords.Stun.definition,
    });
    Abilities.push({
        ability_classname: 'storm_ex_mobility',
        name: 'Paralyzing Remnant',
        description: Description({
            description: 'Creates an explosively charged image of Storm Spirit that lasts @{duration} seconds and will detonate and deal @{ability_damage} damage and applies ' + Keywords.Sleep.instance() + ' for @{sleep_duration}s to enemies that comes near.',
            level: 'Increases the sleeping duration.',
        }),
        lore: Keywords.Sleep.definition,
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },

        ],
    });

    return localization_info;
}