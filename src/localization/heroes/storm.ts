import { castpointValue, keywords, manaValue } from "../common";
import { localizeAbility } from "../localization";
import { abilityWithIcon, upgrade } from "../util";

const unestableEnergy = abilityWithIcon("Unestable Energy", "storm_second_attack");
const ballLightning = abilityWithIcon("Ball Lightning", "storm_extra.png");

localizeAbility("storm_basic_attack", {
    title: "Overload",
    description: `Storm attacks with lightining balls dealing ${keywords.baseDamage.name()} to the enemy. If hits a target when charged, deals %ability_damage% damage in area and applies ${keywords.fadingSlow.name(
        "%fading_slow_pct%"
    )} for %fading_slow_duration%s to enemies. Casting any spell appart from this one, creates a charge.`,
    lore: [keywords.fadingSlow.description],
    values: [manaValue]
});

localizeAbility("storm_second_attack", {
    title: "Unestable Energy",
    description: "Storm attacks with an unestable ball of energy that deals %ability_damage% to the enemy.",
    upgrade: upgrade(
        `Applies a debuff that deals %damage_per_tick% damage and applies ${keywords.stun.name()} for %stun_duration every %think_interval%s. Lasts for %duration%s.`
    ),
    lore: [keywords.stun.description],
    values: [manaValue, castpointValue]
});

localizeAbility("storm_counter", {
    title: "Second Thunder",
    description:
        "Goes into counter state for a short period of time. During which, if storm is hit by a melee attack or projectile, he knockbacks and deals %ability_damage% damage to any enemy in close range, and also recovers %mana_gain% mana.",
    upgrade: upgrade("Reduces cooldown."),
    values: [castpointValue]
});

localizeAbility("storm_special_attack", {
    title: "Electric Vortex",
    description:
        "Generates an electric vortex on the map. After %delay_time%s, it deals %ability_damage% damage to enemies hit by it and pulls them towards target location. The pull lasts for %duration%.",
    upgrade: upgrade("Increases the mana gain percentage. Can gain mana from multiple targets. Also drains mana from the enemies."),
    values: [manaValue, castpointValue]
});

localizeAbility("storm_mobility", {
    title: "Static Remnant",
    description:
        "Creates an explosively charged image of Storm Spirit that lasts %duration% seconds and will detonate and deal %ability_damage% damage if an enemy unit comes near.",
    upgrade: upgrade("Adds an aditional charge."),
    values: [manaValue, castpointValue]
});

localizeAbility("storm_ultimate", {
    title: "Storm Unleashed",
    description:
        "The spirit becomes one with the storm, teleporting himself to a different location and falling from the sky in the form of a thunder. Deals %ability_damage% damage to enemies at the arrival location. After falling, all the mana he gains from spells is multiplied by %mana_multiplier% during %duration%s.",
    values: [castpointValue]
});

localizeAbility("storm_extra", {
    title: "Ball Lightning",
    description: `Storm Spirit becomes volatile electricity, charging across the battlefield. Deals %ability_damage% damage to the enemies in the way, and %aoe_damage% damage to enemies on the arrival area. Also applies ${keywords.fadingSlow.name(
        "%fading_slow_pct%"
    )} for %fading_slow_duration%s to enemies at the arrival area.`,
    upgrade: upgrade(`When hitting an enemy, resets ${unestableEnergy} cooldown.`),
    lore: [keywords.fadingSlow.description],
    values: [castpointValue]
});

localizeAbility("storm_ex_basic_attack", {
    title: "Thunder Mastery",
    description: `Buff your next ${ballLightning}, adding %damage_per_level% damage and healing yourself for half of the damage dealt with it. If you cast it again while buffed, it will add %damage_per_level% extra damage and inflict ${keywords.stun.name()} for %stun_duration%s.`,
    upgrade: upgrade(`Works for the next two ${ballLightning}s.`),
    lore: [keywords.stun.description]
});

localizeAbility("storm_ex_mobility", {
    title: "Paralyzing Remnant",
    description: `Creates an explosively charged image of Storm Spirit that lasts %duration% seconds and will detonate and deal %ability_damage% damage and applies ${keywords.sleep.name()} for %sleep_duration%s to enemies that comes near.`,
    upgrade: upgrade("Increases the sleeping duration."),
    lore: [keywords.sleep.description],
    values: [castpointValue]
});

//   const Shards: Upgrade[] = [];

//   const Favors: Upgrade[] = [
//     {
//       id: "storm_ranged_remnant",
//       name: "Ranged remnant",
//       description: "Your static remnant can be casted with range",
//       ability: "storm_mobility",
//       maxStacks: 1,
//       modifier: {
//         name: "ModifierUpgradeStormRangedRemnant",
//       },
//       tier: 0,
//       type: UpgradeTypes.FAVOR,
//     },
//     {
//       id: "storm_unleashed_knockback",
//       name: "Storm Unleashed knockback",
//       description: "Your Storm Unleashed push enemies out.",
//       ability: "storm_ultimate",
//       maxStacks: 1,
//       modifier: {
//         name: "ModifierUpgradeStormUnleashedKnockback",
//       },
//       tier: 0,
//       type: UpgradeTypes.FAVOR,
//     },
//   ];

//   Modifiers.push(...Upgrades([...Shards, ...Favors]));
//   return localization_info;
// }
