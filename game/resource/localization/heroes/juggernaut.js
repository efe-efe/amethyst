"use strict";
var __spreadArray = (this && this.__spreadArray) || function (to, from) {
    for (var i = 0, il = from.length, j = to.length; i < il; i++, j++)
        to[j] = from[i];
    return to;
};
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
    var BladeDance = specific_1.Ability('Blade Dance', 'juggernaut_second_attack.png');
    var Preparation = specific_1.Ability('Preparation', 'juggernaut_counter.png');
    var Swiftslash = specific_1.Ability('Swiftslash', 'juggernaut_ex_counter.png');
    var YurneroDash = specific_1.Ability('Yurnero Dash', 'juggernaut_counter_recast.png');
    var BladeMastery = specific_1.Ability('Blade Mastery', 'juggernaut_basic_attack.png');
    Abilities.push({
        ability_classname: 'juggernaut_basic_attack',
        name: 'Blade Mastery',
        description: specific_1.Description({
            description: 'Juggernaut attacks with his weapon dealing ' + specific_1.Keywords.BaseDamage + ' to the enemy. Every successful attack generates a ' + specific_1.Keywords.FuryStack.instance() + ' and reduces the cooldown of ' + BladeDance + '.',
            level: 'Successful hits also reduces the cooldown from ' + Preparation + ' and ' + Swiftslash + '.',
        }),
        lore: specific_1.Keywords.FuryStack.definition,
        ability_specials: [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color="#00A6DE">MANA GAIN</font>',
                percentage: true,
            },
        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_second_attack',
        name: 'Blade Dance',
        description: specific_1.Description({
            description: 'Juggernaut swings his blade dealing @{damage_multiplier_per_stack} times your ' + specific_1.Keywords.BaseDamage + ' to all enemies in front of you. Consumes all his current ' + specific_1.Keywords.FuryStack.instance() + ' to increase the damage multiplier by @{damage_multiplier_per_stack} per stack. If 4 stacks are consumed, a spin attack is cast instead, dealing damage to all enemies around Juggernaut',
            level: 'Increases damage per stack. Successful hits provides a shield that blocks @{shield_per_stack} damage per stack per target.',
        }),
        lore: specific_1.Keywords.FuryStack.definition,
        ability_specials: [
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
        ability_classname: 'juggernaut_counter',
        name: 'Preparation',
        description: specific_1.Description({
            description: 'Goes into counter state for a short period of time. During which, if Juggernaut is hit by a melee attack or projectile, he reflects the attack and gains ' + YurneroDash + ' as a recast of this spell.',
            level: 'Increases the times that ' + YurneroDash + ' can be recasted.',
            subAbility: {
                name: 'Yurnero Dash',
                iconPath: 'juggernaut_counter_recast.png',
                description: 'Performs a range slash attack towards the cursor location. If the slash attacks hits an enemy, it deals @{ability_damage} damage and allows ' + YurneroDash + ' re-casted once again. Can be re-casted up to @{recasts} times.',
            }
        }),
    });
    Abilities.push({
        ability_classname: 'juggernaut_special_attack',
        name: 'Dagger Throw',
        description: specific_1.Description({
            description: 'Throws a dagger that deals @{ability_damage} damage and applies ' + specific_1.Keywords.FadingSlow.instance('@{fading_slow_pct}') + ' for @{fading_slow_duration}s on the target.',
            level: 'When hitting an enemy, can be recasted to instantly teleport behind him.',
        }),
        lore: specific_1.Keywords.FadingSlow.definition,
        ability_specials: [
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
        ability_classname: 'juggernaut_mobility',
        name: 'Blade Fury',
        description: specific_1.Description({
            description: 'Causes a bladestorm of destructive force around Juggernaut increasing his movement speed by @{speed_buff_pct}% and dealing @{damage_per_second} damage every @{think_interval}s to enemies in around. Juggernaut is Silenced during the duration. Lasts for @{duration}s. Purge negative effects on cast.',
            level: 'Also reflects enemy projectiles.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_ultimate',
        name: 'Omnislash',
        description: 'Juggernaut very quickly leaps towards the mouse location. If an enemy is hit during the dash, Juggernaunt will start lunging between random targets around him, dealing <b><font color="#ffffff">base damage</font></b> every hit. The time between attacks is based on Juggernaut\'s attack rate. Juggernaut is invulnerable for the duration. Ability ends after there is no valid nearby target or after @{duration}s has passed. Consumes all ' + specific_1.Keywords.FuryStack.instance() + ' to increase Juggernaut\'s attack speed by @{aspd_per_stack} per stack consumed for the ability duration.',
        lore: specific_1.Keywords.FadingSlow.definition,
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_extra',
        name: 'Healing Ward',
        description: specific_1.Description({
            description: 'Summons a Healing Ward which heals all nearby allied units for @{heal_per_second} health every second. The Healing Ward moves towards Juggernaut after being summoned. Can be recasted to move the healing ward towards the cursor location. Lasts for @{duration}s.',
            level: 'When invoked, the totem gives a shield that blocks @{shield} damage to all nearby allies.',
        }),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_ex_counter',
        name: 'Swifthslash',
        description: specific_1.Description({
            description: 'Performs a range slash attack towards the cursor location. If the slash attacks hits an enemy, it deals @{ability_damage}, imbues your ' + BladeMastery + ' with extra @{extra_damage} for the next attack and grants you ' + specific_1.Keywords.Swiftness.instance('@{swiftness_pct}') + ' for @{swiftness_duration}s. Can be recasted up to @{recasts} times on successful hits.',
            level: 'Increases the times this ability can be recasted.',
        }),
        lore: specific_1.Keywords.Swiftness.definition,
    });
    Abilities.push({
        ability_classname: 'juggernaut_ex_second_attack',
        name: 'Weakspot',
        description: specific_1.Description({
            description: 'Performs a meele slash attack that deals @{ability_damage} damage and applies ' + specific_1.Keywords.Sleep.instance() + ' for @{duration}s. Consumes all ' + specific_1.Keywords.FuryStack.instance() + ' to increase the sleep duration in @{duration_per_stack}s per stack consumed.',
            level: 'When hitting at least one enemy, replenish all ' + specific_1.Keywords.FuryStack.instance() + ', refunds the mana spend and gives ' + specific_1.Keywords.Swiftness.instance('@{swiftness_pct}') + ' for @{swiftness_duration}s</font></b>.',
        }),
        lore: specific_1.multipleKeywords([specific_1.Keywords.FuryStack.definition, specific_1.Keywords.Sleep.definition, specific_1.Keywords.Swiftness.definition]),
        ability_specials: [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color="#B2B5B3">CAST POINT</font>',
            },
        ],
    });
    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_basic_attack_stacks',
        name: 'Fury Stacks',
        description: 'Can be consumed to add extra effects on some abilities.',
    });
    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_extra_shield',
        name: 'Totem Shield',
        description: "Blocks {" + "MODIFIER_PROPERTY_TOOLTIP" /* TOOLTIP */ + "} incoming damage.",
    });
    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_ex_counter',
        name: 'Swiftslash',
        description: "Your next basic attack deals {" + "MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE" /* PREATTACK_BONUS_DAMAGE */ + "} extra damage.",
    });
    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_extra',
        name: 'Healing Ward',
        description: "Recovering {" + "MODIFIER_PROPERTY_TOOLTIP" /* TOOLTIP */ + "} health per second.",
    });
    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_swiftness',
        name: 'Swiftness',
        description: "Moves {" + "MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE" /* MOVESPEED_BONUS_PERCENTAGE */ + "}% faster.",
    });
    var Shards = [];
    var Favors = [
        {
            id: 'juggernaut_fury_reflects',
            name: 'Blade Fury reflects',
            description: 'Blade Fury reflect enemy projectiles.',
            ability: 'juggernaut_mobility',
            maxStacks: 1,
            modifier: {
                name: 'modifier_upgrade_juggernaut_fury_reflects'
            },
            tier: 0,
            type: specific_1.UpgradeTypes.FAVOR,
        },
        {
            id: 'juggernaut_fury_attack',
            name: 'Blade Fury attacks',
            description: 'Blade Fury damage count as basic attacks',
            ability: 'juggernaut_mobility',
            maxStacks: 1,
            modifier: {
                name: 'modifier_upgrade_juggernaut_fury_attack'
            },
            tier: 0,
            type: specific_1.UpgradeTypes.FAVOR,
        },
        {
            id: 'juggernaut_refresh_dagger',
            name: 'Refreshing dagger',
            description: 'Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.',
            ability: 'juggernaut_special_attack',
            maxStacks: 1,
            modifier: {
                name: 'modifier_upgrade_juggernaut_refresh_dagger'
            },
            tier: 1,
            type: specific_1.UpgradeTypes.FAVOR,
        },
        {
            id: 'juggernaut_spinning_ward',
            name: 'Spinning Ward',
            description: 'Your Healing Ward also spins when you activates your Blade Fury. It also resists 5 hits instead of 1.',
            ability: 'juggernaut_extra',
            secondaryAbilities: ['juggernaut_mobility'],
            maxStacks: 1,
            modifier: {
                name: 'modifier_upgrade_juggernaut_spinning_ward'
            },
            tier: 1,
            type: specific_1.UpgradeTypes.FAVOR,
        },
    ];
    Modifiers.push.apply(Modifiers, specific_1.Upgrades(__spreadArray(__spreadArray([], Shards), Favors)));
    return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
