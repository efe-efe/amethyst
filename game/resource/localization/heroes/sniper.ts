import { AbilityLocalization, HeroTalents, Language, LocalizationData, ModifierLocalization, StandardLocalization } from "../../localizationInterfaces";
import { Keywords, Description, multipleKeywords, Ability, Upgrade, UpgradeTypes, Upgrades } from "../specific";

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

    const Snipe = Ability("Snipe", "sniper_second_attack.png");
    const Shrapnel = Ability("Shrapnel", "sniper_special_attack.png");
    const DualShoot = Ability("Dual Shoot", "sniper_basic_attack.png");

    Abilities.push({
        ability_classname: "sniper_basic_attack",
        name: "Dual Shoot",
        description: Description({
            description: "Fire with your gun @{max_charges} times before reloading, dealing " + Keywords.BaseDamage + " per bullet.",
            level: "Adds an additional charge.",
        }),
        ability_specials:
        [
            {
                ability_special: "replenish_time",
                text: "REPLENISH TIME",
            },

            {
                ability_special: "mana_gain_pct",
                text: "<font color=\"#00A6DE\">MANA GAIN</font>",
                percentage: true,
            },

        ],
    });
    Abilities.push({
        ability_classname: "sniper_second_attack",
        name: "Snipe",
        description: Description({
            description: "Fire a piercing shot that deals @{ability_damage} damage and inflicts " + Keywords.Stun.instance() + " for @{stun_duration}s. Damage is reduced @{reduction_per_hit} % per target hit.",
            level: "Reduces the damage but also reduces the cast point and allows you to cast it while moving.",
        }),
        lore: Keywords.Stun.definition,
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
        ability_classname: "sniper_counter",
        name: "Stealth",
        description: Description({
            description: "Becomes invisible for @{duration}s. Moves @{speed_buff_pct} % faster while invisible. Resets the cooldown of " + Snipe + ".",
            level: "Increases movement speed while active.",
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
        ability_classname: "sniper_special_attack",
        name: "Shrapnel",
        description: Description({
            description: "Deploys a rocket that showers an area with explosive shards, dealing @{damage_per_think} damage every @{think_interval}s and inflicts @{slow_pct}% slow over time. Lasts for @{duration}s.",
            level: "Adds an additional charge.",
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
        ability_classname: "sniper_mobility",
        name: "Grenade Jump",
        description: Description({
            description: "Dash towards a new location, while creating a " + Shrapnel + " in the starting location.",
            level: "Resets the cooldown of " + Snipe + ".",
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
        ability_classname: "sniper_ultimate",
        name: "Assassinate",
        description: Description({
            description: "Fire 4 rockets dealing @{ability_damage} damage on hit and @{aoe_damage} damage on the explosion.",
            channeled: true,
        }),
        lore: Keywords.Channeling.definition,
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
        ability_classname: "sniper_extra",
        name: "Shotgun",
        description: Description({
            description: "Fire 3 piercing bullets in a cone, dealing @{damage_per_bullet} damage per bullet and knocking enemies back. Sniper is also pushed back. Pushing enemies into a wall deals @{damage_on_collision} extra damage.",
            level: "Removes the mana cost.",
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
        ability_classname: "sniper_ex_second_attack",
        name: "Quick Snipe",
        description: Description({
            description: "Fire a piercing shot that deals @{ability_damage} damage and inflicts " + Keywords.Root.instance() + " for @{root_duration}s. Damage is reduced @{reduction_per_hit} per target hit.",
            level: "The bullet bounces back when it reaches its max distance.",
        }),
        lore: Keywords.Root.definition,
        ability_specials:
        [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },

        ],
    });
    Abilities.push({
        ability_classname: "sniper_ex_special_attack",
        name: "Adrenaline Grenade",
        description: Description({
            description: "Deploys a grenade that leaves the impact area covered in electricity, increasing the movement speed by @{ms_pct}% to the allies in the area and constatly reloading Sniper's " + DualShoot + " and increasing his " + Keywords.BaseDamage + " in @{extra_damage}. Lasts for @{duration}s.",
            level: "Increases the damage buff.",
        }),
        ability_specials:
        [
            {
                ability_special: "AbilityCastPoint",
                text: "<font color=\"#B2B5B3\">CAST POINT</font>",
            },

        ],
    });

    const Shards: Upgrade[] = [
    ];
    
    const Favors: Upgrade[] = [
        {
            id: "sniper_snipe_cast_fast",
            name: "Quick Snipe",
            description: "Your Snipe cast point is reduced drastically.",
            ability: "sniper_second_attack",
            maxStacks: 1,
            modifier: {
                name: "modifier_upgrade_sniper_snipe_cast_fast"
            },
            tier: 1,
            type: UpgradeTypes.FAVOR,
        },
    ];

    Modifiers.push(...Upgrades([...Shards, ...Favors]));
    return localization_info;
}