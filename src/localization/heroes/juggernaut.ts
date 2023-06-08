import { castpointValue, keywords, manaValue } from "../common";
import { localizeAbility, localizeModifier } from "../localization";
import { abilityWithIcon, createKeyword, heal, secondaryAbility, upgrade } from "../util";

const bladeDance = abilityWithIcon("Blade Dance", "juggernaut_second_attack");
const preparation = abilityWithIcon("Preparation", "juggernaut_counter");
const swiftslash = abilityWithIcon("Swiftslash", "juggernaut_ex_counter");
const yurneroDash = abilityWithIcon("Yurnero Dash", "juggernaut_counter_recast");
const bladeMastery = abilityWithIcon("Blade Mastery", "juggernaut_basic_attack");
const omnislash = abilityWithIcon("Omnislash", "juggernaut_ultimate");
const weakspot = abilityWithIcon("Weakspot", "juggernaut_ex_second_attack");

const furyStack = createKeyword("Fury Stack", {
    description: `Extra effects on ${bladeDance}, ${omnislash} and ${weakspot}.`,
    icon: "fury_stack",
    color: "#FFB556"
});

const swiftness = createKeyword("Swiftness", {
    description:
        "Increases the movement speed by X% with a max of 100% and gives the ability to pass through units. If applied when already active, the speed bonuses are added.",
    icon: "swiftness",
    color: "#b2f7bd"
});

localizeAbility("juggernaut_basic_attack", {
    title: "Blade Mastery",
    description: `Juggernaut attacks with his weapon dealing ${keywords.baseDamage.name()} to the enemy. Every successful attack generates a ${furyStack.name()} and reduces the cooldown of ${bladeDance}.`,
    upgrade: upgrade(`Successful hits also reduces the cooldown from ${preparation} and ${swiftslash}.`),
    lore: [furyStack.description],
    values: [manaValue]
});

localizeAbility("juggernaut_second_attack", {
    title: "Blade Dance",
    description: `Juggernaut swings his blade dealing %damage_multiplier_per_stack% times your ${keywords.baseDamage.name()} to all enemies in front of you. Consumes all his current ${furyStack.name()} to increase the damage multiplier by %damage_multiplier_per_stack% per stack. If 4 stacks are consumed, a spin attack is cast instead, dealing damage to all enemies around Juggernaut`,
    upgrade: upgrade(
        "Increases damage per stack. Successful hits provides a shield that blocks %shield_per_stack% damage per stack per target."
    ),
    lore: [furyStack.description],
    values: [manaValue, castpointValue]
});

localizeAbility("juggernaut_counter", {
    title: "Preparation",
    description: `Goes into counter state for a short period of time. During which, if Juggernaut is hit by a melee attack or projectile, he reflects the attack and gains ${yurneroDash} as a recast of this spell.`,
    upgrade: upgrade(`Increases the times that ${yurneroDash} can be recasted.`),
    secondaryAbility: secondaryAbility(
        "Yurnero Dash",
        "juggernaut_counter_recast",
        `Performs a range slash attack towards the cursor location. If the slash attacks hits an enemy, it deals %ability_damage% damage and allows ${yurneroDash} re-casted once again. Can be re-casted up to %recasts% times.`
    )
});

localizeAbility("juggernaut_special_attack", {
    title: "Dagger Throw",
    description: `Throws a dagger that deals %ability_damage% damage and applies ${keywords.fadingSlow.name(
        "%fading_slow_pct%"
    )} for %fading_slow_duration%s on the target.`,
    upgrade: upgrade("When hitting an enemy, can be recasted to instantly teleport behind him."),
    lore: [keywords.fadingSlow.description],
    values: [manaValue, castpointValue]
});

localizeAbility("juggernaut_mobility", {
    title: "Blade Fury",
    description:
        "Causes a bladestorm of destructive force around Juggernaut increasing his movement speed by %speed_buff_pct%%% and dealing %damage_per_second% damage every %think_interval%s to enemies in around. Juggernaut is Silenced during the duration. Lasts for %duration%s. Purge negative effects on cast.",
    upgrade: upgrade("Also reflects enemy projectiles."),
    values: [castpointValue]
});

localizeAbility("juggernaut_ultimate", {
    title: "Omnislash",
    description: `Juggernaut very quickly leaps towards the mouse location. If an enemy is hit during the dash, Juggernaunt will start lunging between random targets around him, dealing ${keywords.baseDamage.name()} every hit. The time between attacks is based on Juggernaut's attack rate. Juggernaut is invulnerable for the duration. Ability ends after there is no valid nearby target or after %duration%s has passed. Consumes all ${furyStack.name()} to increase Juggernaut's attack speed by %aspd_per_stack% per stack consumed for the ability duration.`,
    lore: [keywords.fadingSlow.description],
    values: [castpointValue]
});

localizeAbility("juggernaut_extra", {
    title: "Healing Ward",
    description: `Summons a Healing Ward which heals all nearby allied units for ${heal(
        "%heal_per_second%"
    )} health every second. The Healing Ward moves towards Juggernaut after being summoned. Can be recasted to move the healing ward towards the cursor location. Lasts for %duration%s.`,
    upgrade: upgrade("When invoked, the totem gives a shield that blocks %shield% damage to all nearby allies."),
    values: [castpointValue]
});

localizeAbility("juggernaut_ex_counter", {
    title: "Swifthslash",
    description: `Performs a range slash attack towards the cursor location. If the slash attacks hits an enemy, it deals %ability_damage%, imbues your ${bladeMastery} with extra %extra_damage% for the next attack and grants you ${swiftness.name(
        "%swiftness_pct%"
    )} for %swiftness_duration%s. Can be recasted up to %recasts% times on successful hits.`,
    upgrade: "Increases the times this ability can be recasted.",
    lore: [swiftness.description]
});

localizeAbility("juggernaut_ex_second_attack", {
    title: "Weakspot",
    description: `Performs a meele slash attack that deals %ability_damage% damage and applies ${keywords.sleep.name()} for %duration%s. Consumes all ${furyStack.name()} to increase the sleep duration in %duration_per_stack%s per stack consumed.`,
    upgrade: upgrade(
        `When hitting at least one enemy, replenish all ${furyStack.name()} refunds the mana spend and gives ${swiftness.name(
            "%swiftness_pct%"
        )} for %swiftness_duration%s.`
    ),
    lore: [furyStack.description, keywords.sleep.description, swiftness.description],
    values: [castpointValue]
});

localizeModifier("modifier_juggernaut_mobility", {
    title: "Blade Fury"
});

localizeModifier("modifier_juggernaut_swiftness", {
    title: "Swiftness",
    description: "Moves %MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE%%% faster."
});

localizeModifier("modifier_juggernaut_basic_attack_stacks", {
    title: "Fury Stacks",
    description: "Can be consumed to add extra effects on some abilities."
});

localizeModifier("modifier_juggernaut_extra_shield", {
    title: "Totem Shield",
    description: "Blocks %MODIFIER_PROPERTY_TOOLTIP% incoming damage."
});

localizeModifier("modifier_juggernaut_ex_counter", {
    title: "Swiftslash",
    description: "Your next basic attack deals %MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE% extra damage."
});

localizeModifier("modifier_juggernaut_extra", {
    title: "Healing Ward",
    description: "Recovering %MODIFIER_PROPERTY_TOOLTIP% health per second."
});

localizeModifier("modifier_juggernaut_counter_countering", {
    title: "Counter"
});

localizeModifier("modifier_juggernaut_counter_recast", {
    title: "Recast"
});

localizeModifier("modifier_juggernaut_special_attack_recast", {
    title: "Recast"
});

localizeModifier("modifier_juggernaut_extra_recast", {
    title: "Recast"
});

// const Shards: Upgrade[] = [];

// const Favors: Upgrade[] = [
//   {
//     id: "juggernaut_fury_reflects",
//     name: "Blade Fury reflects",
//     description: "Blade Fury reflect enemy projectiles.",
//     ability: "juggernaut_mobility",
//     maxStacks: 1,
//     modifier: {
//       name: "modifier_upgrade_juggernaut_fury_reflects",
//     },
//     tier: 0,
//     type: UpgradeTypes.FAVOR,
//   },
//   {
//     id: "juggernaut_fury_attack",
//     name: "Blade Fury attacks",
//     description: "Blade Fury damage count as basic attacks",
//     ability: "juggernaut_mobility",
//     maxStacks: 1,
//     modifier: {
//       name: "modifier_upgrade_juggernaut_fury_attack",
//     },
//     tier: 0,
//     type: UpgradeTypes.FAVOR,
//   },
//   {
//     id: "juggernaut_refresh_dagger",
//     name: "Refreshing dagger",
//     description:
//       "Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.",
//     ability: "juggernaut_special_attack",
//     maxStacks: 1,
//     modifier: {
//       name: "modifier_upgrade_juggernaut_refresh_dagger",
//     },
//     tier: 1,
//     type: UpgradeTypes.FAVOR,
//   },
//   {
//     id: "juggernaut_spinning_ward",
//     name: "Spinning Ward",
//     description:
//       "Your Healing Ward also spins when you activates your Blade Fury. It also resists 5 hits instead of 1.",
//     ability: "juggernaut_extra",
//     secondaryAbilities: ["juggernaut_mobility"],
//     maxStacks: 1,
//     modifier: {
//       name: "modifier_upgrade_juggernaut_spinning_ward",
//     },
//     tier: 1,
//     type: UpgradeTypes.FAVOR,
//   },
// ];

// Modifiers.push(...Upgrades([...Shards, ...Favors]));
// return localization_info;
