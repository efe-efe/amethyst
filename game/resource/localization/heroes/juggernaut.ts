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

    const BladeDance = Ability('Blade Dance', 'juggernaut_second_attack.png') ;
    const Preparation = Ability('Preparation', 'juggernaut_counter.png');
    const Swiftslash = Ability('Swiftslash', 'juggernaut_ex_counter.png');
    const YurneroDash = Ability('Yurnero Dash', 'juggernaut_counter_recast.png');
    const BladeMastery = Ability('Blade Mastery', 'juggernaut_basic_attack.png');
    
    Abilities.push({
        ability_classname: 'juggernaut_basic_attack',
        name: 'Blade Mastery',
        description: Description({
            description: 'Juggernaut attacks with his weapon dealing ' + Keywords.BaseDamage + ' to the enemy. Every successful attack generates a ' + Keywords.FuryStack.instance() + ' and reduces the cooldown of ' + BladeDance + '.',
            level: 'Successful hits also reduces the cooldown from ' + Preparation + ' and ' + Swiftslash + '.',
        }),
        lore: Keywords.FuryStack.definition,
        ability_specials:
        [
            {
                ability_special: 'mana_gain_pct',
                text: '<font color=\\"#00A6DE\\">MANA GAIN</font>',
                percentage: true,
            },

        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_second_attack',
        name: 'Blade Dance',
        description: Description({
            description: 'Juggernaut swings his blade dealing ${ability_damage} to the enemy and consuming all his current ' + Keywords.FuryStack.instance() + ' to increase the damage dealt by ${damage_per_stack} per stack. If 4 stacks are consumed, a spin attack is cast instead, dealing damage to all enemies around Juggernaut',
            level: 'Increases damage per stack. Successful hits provides a shield that blocks ${shield_per_stack} damage per stack per target.',
        }),
        lore: Keywords.FuryStack.definition,
        ability_specials:
        [
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
        ability_classname: 'juggernaut_counter',
        name: 'Preparation',
        description: Description({
            description: 'Goes into counter state for a short period of time. During which, if Juggernaut is hit by a melee attack or projectile, he reflects the attack and gains ' + YurneroDash + ' as a recast of this spell.',
            level: 'Increases the times that ' + YurneroDash + ' can be recasted.',
            subAbility: {
                name: 'Yurnero Dash',
                iconPath: 'juggernaut_counter_recast.png', 
                description: 'Performs a range slash attack towards the cursor location. If the slash attacks hits an enemy, it deals ${ability_damage} damage and allows ' + YurneroDash + ' re-casted once again. Can be re-casted up to ${recasts} times.',
            }
        }),
    });
    Abilities.push({
        ability_classname: 'juggernaut_special_attack',
        name: 'Dagger Throw',
        description: Description({
            description: 'Throws a dagger that deals ${ability_damage} damage and applies ' + Keywords.FadingSlow.instance('${fading_slow_pct}') + ' for ${fading_slow_duration}s on the target.',
            level: 'When hitting an enemy, can be recasted to instantly teleport behind him.',
        }),
        lore: Keywords.FadingSlow.definition,
        ability_specials:
        [
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
        ability_classname: 'juggernaut_mobility',
        name: 'Blade Fury',
        description: Description({
            description: 'Causes a bladestorm of destructive force around Juggernaut increasing his movement speed by ${speed_buff_pct}% and dealing ${damage_per_second} damage every ${think_interval}s to enemies in around. Juggernaut is Silenced during the duration. Lasts for ${duration}s. Purge negative effects on cast.',
            level: 'Also reflects enemy projectiles.',
        }),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_ultimate',
        name: 'Omnislash',
        description: 'Juggernaut very quickly leaps towards the mouse location. If an enemy is hit during the dash, Juggernaunt will start lunging between random targets around him, dealing <b><font color=\\"#ffffff\\">base damage</font></b> every hit. The time between attacks is based on Juggernaut\'s attack rate. Juggernaut is invulnerable for the duration. Ability ends after there is no valid nearby target or after ${duration}s has passed. Consumes all ' + Keywords.FuryStack.instance() + ' to increase Juggernaut\'s attack speed by ${aspd_per_stack} per stack consumed for the ability duration.',
        lore: Keywords.FadingSlow.definition,
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_extra',
        name: 'Healing Ward',
        description: Description({
            description: 'Summons a Healing Ward which heals all nearby allied units for ${heal_per_second} health every second. The Healing Ward moves towards Juggernaut after being summoned. Can be recasted to move the healing ward towards the cursor location. Lasts for ${duration}s.',
            level: 'When invoked, the totem gives a shield that blocks ${shield} damage to all nearby allies.',
        }),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
            },

        ],
    });
    Abilities.push({
        ability_classname: 'juggernaut_ex_counter',
        name: 'Swifthslash',
        description: Description({
            description: 'Performs a range slash attack towards the cursor location. If the slash attacks hits an enemy, it deals ${ability_damage}, imbues your ' + BladeMastery + ' with extra ${extra_damage} for the next attack and grants you ' + Keywords.Swiftness.instance('${swiftness_pct}') + ' for ${swiftness_duration}s. Can be recasted up to ${recasts} times on successful hits.',
            level: 'Increases the times this ability can be recasted.',
        }),
        lore: Keywords.Swiftness.definition,
    });
    Abilities.push({
        ability_classname: 'juggernaut_ex_second_attack',
        name: 'Weakspot',
        description: Description({
            description: 'Performs a meele slash attack that deals ${ability_damage} damage and applies ' + Keywords.Sleep.instance() + ' for ${duration}s. Consumes all ' + Keywords.FuryStack.instance() + ' to increase the sleep duration in ${duration_per_stack}s per stack consumed.',
            level: 'When hitting at least one enemy, replenish all ' + Keywords.FuryStack.instance() + ', refunds the mana spend and gives ' + Keywords.Swiftness.instance('${swiftness_pct}') + ' for ${swiftness_duration}s</font></b>.',
        }),
        lore: multipleKeywords([Keywords.FuryStack.definition, Keywords.Sleep.definition, Keywords.Swiftness.definition]),
        ability_specials:
        [
            {
                ability_special: 'AbilityCastPoint',
                text: '<font color=\\"#B2B5B3\\">CAST POINT</font>',
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
        description: `Blocks {${LocalizationModifierProperty.TOOLTIP}} incoming damage.`,
    });

    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_ex_counter',
        name: 'Swiftslash',
        description: `Your next basic attack deals {${LocalizationModifierProperty.PREATTACK_BONUS_DAMAGE}} extra damage.`,
    });

    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_extra',
        name: 'Healing Ward',
        description: `Recovering {${LocalizationModifierProperty.TOOLTIP}} health per second.`,
    });

    Modifiers.push({
        modifier_classname: 'modifier_juggernaut_swiftness',
        name: 'Swiftness',
        description: `Moves {${LocalizationModifierProperty.MOVESPEED_BONUS_PERCENTAGE}}% faster.`,
    });

    return localization_info;
}