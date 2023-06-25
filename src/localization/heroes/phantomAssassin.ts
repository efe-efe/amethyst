import { castpointValue, keywords, manaValue } from "../common";
import { localizeAbility, localizeModifier } from "../localization";
import { abilityWithIcon, createKeyword, heal, secondaryAbility, upgrade } from "../util";

const swift = abilityWithIcon("Swift", "phantom_mobility");
const criticalStrike = abilityWithIcon("Critical Strike", "phantom_second_attack");
const lesserStiflingDagger = abilityWithIcon("Lesser Stifling Dagger", "phantom_basic_attack_related");
const poisonusDagger = abilityWithIcon("Poisonus Dagger", "phantom_ex_counter_recast");
const phantomStrike = abilityWithIcon("Phantom Strike", "phantom_counter");
const coupDeGrace = abilityWithIcon("Coup De Grace", "phantom_ultimate");
const blurStrike = abilityWithIcon("Blur Strike", "phantom_ex_counter");

const phantomStack = createKeyword("Phantom Stack", {
    description: `Extra effects on ${criticalStrike}, ${coupDeGrace}, and ${blurStrike}.`,
    icon: "phantom_stack",
    color: "#ff8da1"
});

const bleeding = createKeyword("Bleeding", {
    description: "Deals 1 damage per stack every 1.0s. Can be stacked up to 3 times. The duration is refreshed every time is reapplied.",
    icon: "bleeding",
    color: "#ed4747"
});

localizeAbility("phantom_basic_attack", {
    title: "Blade Swing",

    description: `Melee attack that deals ${keywords.baseDamage.name()}. Successfully hitting a target generate a ${phantomStack.name()} and reduces the cooldown of ${criticalStrike} in %cooldown_reduction%s.`,
    lore: [phantomStack.description],
    values: [manaValue, ["related", "Lesser Stifling Dagger"]]
});

localizeAbility("phantom_second_attack", {
    title: "Critical Strike",

    description: `Swings your weapon in a melee attack, dealing ${keywords.baseDamage.name()} to all enemies in front of you. Consumes all ${phantomStack.name()} to increase the damage done by %damage_per_stack% per stack. If you consume 3 stacks, instantly gives ${swift} a charge.`,
    upgrade: upgrade(`Fully replenish ${swift} when used with 3 ${phantomStack.name()}.`),
    lore: [phantomStack.description],
    values: [manaValue, castpointValue]
});

localizeAbility("phantom_counter", {
    title: "Phantom Strike",
    description: `Counters the next projectile or melee attack. Countering an attack banishes yourself for %banish_duration% second, after that, teleports you to target location, heals you in ${heal(
        "%heal%"
    )}, increases your attack speed by %as_speed% for %buff_duration%s and teleports you to a new location.`,
    upgrade: upgrade(
        "Can be recasted to get the attack speed buff again and gain a shield that blocks %shield% damage during %shield_duration%s."
    )
});

localizeAbility("phantom_special_attack", {
    title: "Stifling Dagger",

    description: `Throws a dagger that deals ${keywords.baseDamage.name()} to the target plus %damage_modifier%, inflicts ${keywords.fadingSlow.name(
        "%fading_slow_pct%"
    )} for %fading_slow_duration%s and generates a ${phantomStack.name()}. You can stack up to %max_charges% charges.`,
    upgrade: upgrade(`Adds another charge, increases the damage and also applies ${bleeding.name()}.`),
    lore: [bleeding.description, keywords.fadingSlow.description, phantomStack.description],
    values: [manaValue, castpointValue]
});

localizeAbility("phantom_mobility", {
    title: "Swift",

    description: "Dashes towards your movement direction. You can stack up to %max_charges% charges.",
    upgrade: upgrade("Adds another charge and reduces cooldown.")
});

localizeAbility("phantom_ultimate", {
    title: "Coup de Grace",

    description: `Throws your weapon, dealing %damage_multiplier% times your ${keywords.baseDamage.name()} and blinking towards the first unit it strikes. The damage mulitplier is increased by %damage_multiplier_per_stack% per each ${phantomStack.name()} consumed.`,
    lore: [phantomStack.description],
    values: [castpointValue]
});

localizeAbility("phantom_extra", {
    title: "Quick Strike",
    description: `Dashes towards the pointing direction, dealing %ability_damage% damage and inflicting ${keywords.fadingSlow.name(
        "%fading_slow_pct%%%"
    )} for %fading_slow_duration%s to enemies in the way and at the arriving area.`,
    upgrade: upgrade("Can be recasted when hit an enemy."),
    lore: [keywords.fadingSlow.description],
    values: [castpointValue]
});

localizeAbility("phantom_ex_basic_attack", {
    title: "Dancing Blades",
    description: `Phantom Assassin replaces her basic attack with ${lesserStiflingDagger}. Lasts for %duration%s.`,
    secondaryAbility: secondaryAbility(
        "Lesser Stifling Dagger",
        "phantom_basic_attack_related",
        `Throws a dagger that deals %ability_damage% damage to the target, inflicts ${keywords.fadingSlow.name(
            "%fading_slow_pct%%%"
        )} for %fading_slow_duration%s and generates a ${phantomStack.name()}.`
    ),
    upgrade: upgrade(`Your daggers applies an stacking ${bleeding.name()} debuff on target for %bleed_duration%s.`),
    lore: [phantomStack.description, keywords.fadingSlow.description, bleeding.description],
    values: [castpointValue]
});

localizeAbility("phantom_ex_counter", {
    title: "Blur",

    description: `Phantom Assassin blurs her body, causing her to be impossible to see and increasing her movement speed in %speed_buff_pct%%% for %duration%s. During that time, this spell can be recasted to throw a ${poisonusDagger}.`,
    secondaryAbility: secondaryAbility(
        "Poisonus Dagger",
        "phantom_ex_counter_recast",
        `Throws a dagger that deals %ability_damage% damage to the target, inflicts ${keywords.sleep.name()} for %sleep_duration%s and generates a ${phantomStack.name()}. Consumes all your courrent stacks to increase the duration of ${keywords.sleep.name()} by %duration_per_stack%s per stack.`
    ),
    upgrade: upgrade("No longer shares cooldown with " + phantomStrike + "."),
    lore: [keywords.sleep.description],
    values: [castpointValue, ["recast", "Poisonus Dagger"], ["recast_AbilityCastPoint", "<font color='#B2B5B3'>CAST POINT</font>"]]
});

localizeModifier("modifier_phantom_bleed", {
    title: "Bleeding"
});

localizeModifier("modifier_phantom_ex_basic_attack", {
    title: "Dancing Blades"
});

localizeModifier("modifier_phantom_counter_countering", {
    title: "Counter"
});

localizeModifier("modifier_phantom_counter", {
    title: "Attack Speed"
});

localizeModifier("modifier_phantom_counter_recast", {
    title: "Recast"
});

localizeModifier("modifier_phantom_ex_counter_recast", {
    title: "Recast"
});

localizeModifier("modifier_phantom_extra_recast", {
    title: "Recast"
});

localizeModifier("modifier_phantom_counter_shield", {
    title: "Shield"
});

//     const Shards: Upgrade[] = [
//       {
//         id: "phantom_dash_damage",
//         {title:"Swift knives",
//         description:
//           "Your Swift leaves a fan of knives on its original position.",
//         ability: "phantom_mobility",
//         maxStacks: 5,
//         modifier: {
//           {title:"modifier_upgrade_phantom_dash_damage",
//         },
//         tier: 1,
//         type: UpgradeTypes.SHARD,
//       },
//       {
//         id: "phantom_dash_shield",
//         {title:"Swift shield",
//         description:
//           "Your Swift gives you shield for a short period of time after passing through enemies and increases its range.",
//         ability: "phantom_mobility",
//         maxStacks: 5,
//         modifier: {
//           {title:"modifier_upgrade_phantom_dash_shield",
//         },
//         tier: 1,
//         type: UpgradeTypes.SHARD,
//       },
//       {
//         id: "phantom_strike_knives",
//         {title:"Strike knives",
//         description:
//           "Your Phantom Strike leaves a fan of knives on the arival location.",
//         ability: "phantom_counter",
//         maxStacks: 5,
//         modifier: {
//           {title:"modifier_upgrade_phantom_strike_knives",
//         },
//         tier: 1,
//         type: UpgradeTypes.SHARD,
//       },
//     ];

//     const Favors: Upgrade[] = [
//       {
//         id: "phantom_extra_daggers",
//         {title:"Extra daggers",
//         description: "Your Stiffling Daggers throws 3 daggers.",
//         ability: "phantom_special_attack",
//         maxStacks: 1,
//         modifier: {
//           {title:"modifier_upgrade_phantom_extra_daggers",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//       {
//         id: "phantom_fast_daggers",
//         {title:"Fast daggers",
//         description:
//           "Your Stiffling Daggers cooldown is two times to your attack speed, but no longer apply slow.",
//         ability: "phantom_special_attack",
//         maxStacks: 1,
//         modifier: {
//           {title:"ModifierUpgradePhantomFastDaggers",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//       {
//         id: "phantom_coup_cast_fast",
//         {title:"Coup de Grace cast fast",
//         description: "Reduces the cast time of Coup de Grace considerably.",
//         ability: "phantom_ultimate",
//         maxStacks: 1,
//         modifier: {
//           {title:"ModifierUpgradePhantomFastCoup",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//       {
//         id: "phantom_countering_stacks",
//         {title:"Phantom Strike stacks",
//         description:
//           "Your Phantom Strike consumes all your Phantom Stacks to multiply your damage while the attack speed buff is on.",
//         ability: "phantom_counter",
//         maxStacks: 1,
//         modifier: {
//           {title:"ModifierUpgradePhantomCounterStacks",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//       {
//         id: "phantom_act_while_countering",
//         {title:"Phantom Strike while acting",
//         description:
//           "You can act while in counter state but the counter state duration its reduced.",
//         ability: "phantom_counter",
//         maxStacks: 1,
//         modifier: {
//           {title:"ModifierUpgradePhantomActCounter",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//       {
//         id: "phantom_strike_instant",
//         {title:"Phantom Strike instant effect",
//         description:
//           "Your Phantom Strike is activated instantly without the need to be activated by an attack, but no longer heals and the banish duration is reduced.",
//         ability: "phantom_counter",
//         maxStacks: 1,
//         modifier: {
//           {title:"ModifierUpgradeSniperStrikeInstant",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//       {
//         id: "phantom_quick_recast",
//         {title:"Phantom Quick Strike recast",
//         description:
//           "Your Quick Strike can be used again for free after hitting at least one enemy.",
//         ability: "phantom_extra",
//         maxStacks: 1,
//         modifier: {
//           {title:"ModifierUpgradePhantomQuickRecast",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//     ];

//     Modifiers.push(...Upgrades([...Shards, ...Favors]));
//     return localization_info;
//   }
