import { castpointValue, keywords, manaValue } from "../common";
import { localizeAbility, localizeModifier } from "../localization";
import { abilityWithIcon, upgrade } from "../util";

const snipe = abilityWithIcon("Snipe", "sniper_second_attack.png");
const shrapnel = abilityWithIcon("Shrapnel", "sniper_special_attack.png");
const dualShoot = abilityWithIcon("Dual Shoot", "sniper_basic_attack.png");

localizeAbility("sniper_basic_attack", {
    title: "Dual Shoot",
    description: `Fire with your gun %max_charges% times before reloading, dealing ${keywords.baseDamage.name()} per bullet.`,
    upgrade: upgrade("Adds an additional charge."),
    values: [["replenish_time", "REPLENISH TIME"], manaValue]
});

localizeAbility("sniper_second_attack", {
    title: "Snipe",
    description: `Fire a piercing shot that deals %ability_damage% damage and inflicts ${keywords.stun.name()} for %stun_duration%s. Damage is reduced %reduction_per_hit%%% per target hit.`,
    upgrade: upgrade("Reduces the damage but also reduces the cast point and allows you to cast it while moving."),
    lore: [keywords.stun.description],
    values: [manaValue, castpointValue]
});

localizeAbility("sniper_counter", {
    title: "Stealth",
    description: `Becomes invisible for %duration%s. Moves %speed_buff_pct%%% faster while invisible. Resets the cooldown of ${snipe}.`,
    upgrade: upgrade("Increases movement speed while active."),
    values: [castpointValue]
});

localizeAbility("sniper_special_attack", {
    title: "Shrapnel",
    description:
        "Deploys a rocket that showers an area with explosive shards, dealing %damage_per_think% damage every %think_interval%s and inflicts %slow_pct%%% slow over time. Lasts for %duration%s.",
    upgrade: upgrade("Adds an additional charge."),
    values: [castpointValue]
});

localizeAbility("sniper_mobility", {
    title: "Grenade Jump",
    description: `Dash towards a new location, while creating a ${shrapnel} in the starting location.`,
    upgrade: upgrade(`Resets the cooldown of ${snipe}.`),
    values: [castpointValue]
});

localizeAbility("sniper_ultimate", {
    title: "Assassinate",
    description: `${keywords.channeling.name()} - Fire 4 rockets dealing %ability_damage% damage on hit and %aoe_damage% damage on the explosion.`,
    lore: [keywords.channeling.description],
    values: [["duration", "DURATION"], castpointValue]
});

localizeAbility("sniper_extra", {
    title: "Shotgun",
    description:
        "Fire 3 piercing bullets in a cone, dealing %damage_per_bullet% damage per bullet and knocking enemies back. Sniper is also pushed back. Pushing enemies into a wall deals %damage_on_collision% extra damage.",
    upgrade: upgrade("Removes the mana cost."),
    values: [castpointValue]
});

localizeAbility("sniper_ex_second_attack", {
    title: "Quick Snipe",
    description: `Fire a piercing shot that deals %ability_damage% damage and inflicts ${keywords.root.name()} for %root_duration%s. Damage is reduced %reduction_per_hit% per target hit.`,
    upgrade: upgrade("The bullet bounces back when it reaches its max distance."),
    lore: [keywords.root.description],
    values: [castpointValue]
});

localizeAbility("sniper_ex_special_attack", {
    title: "Adrenaline Grenade",
    description: `Deploys a grenade that leaves the impact area covered in electricity, increasing the movement speed by %ms_pct%%% to the allies in the area and constatly reloading Sniper's ${dualShoot} and increasing his ${keywords.baseDamage.name()} in %extra_damage%. Lasts for %duration%s.`,
    upgrade: upgrade("Increases the damage buff."),
    values: [castpointValue]
});

localizeModifier("modifier_sniper_counter", {
    title: "Inivisible",
    description: "Invisible. Moving faster."
});

localizeModifier("modifier_sniper_ultimate_channeling", {
    title: "Ultimate"
});

//     const Shards: Upgrade[] = [];

//     const Favors: Upgrade[] = [
//       {
//         id: "sniper_snipe_cast_fast",
//         {title:"Quick Snipe",
//         description: "Your Snipe cast point is reduced drastically.",
//         ability: "sniper_second_attack",
//         maxStacks: 1,
//         modifier: {
//           {title:"modifier_upgrade_sniper_snipe_cast_fast",
//         },
//         tier: 1,
//         type: UpgradeTypes.FAVOR,
//       },
//     ];

//     Modifiers.push(...Upgrades([...Shards, ...Favors]));
//     return localization_info;
//   }
