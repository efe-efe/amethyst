import { castpointValue, keywords, manaValue } from "../common";
import { localizeAbility } from "../localization";
import {
  abilityWithIcon,
  createKeyword,
  heal,
  image,
  secondaryAbility,
  upgrade,
} from "../util";

const endlessMisschief = abilityWithIcon(
  "Endless Mischief",
  "puck_second_attack"
);
const fairyFlare = abilityWithIcon("Fairy Flare", "puck_basic_attack");
const fairyPower = abilityWithIcon("Fairy Power", "puck_basic_attack_related");
const illusoryOrb = abilityWithIcon("Illusory Orb", "puck_mobility");

const fairyDust = createKeyword("Fairy Dust", {
  description: `Reduces the target movement speed by X percent and adds extra effects to ${image(
    "puck_second_attack.png"
  )} <b>Lightining Orb.`,
  icon: "fairy_dust",
  color: "#C5FAFF",
  dynamic: true,
});

localizeAbility("puck_basic_attack", {
  title: "Fairy Flare",
  description: `Range attack that deals ${keywords.baseDamage.name()}. When its charged, Puck gains extra %charged_damage% base damage and this ability inflicts ${fairyDust.name(
    "%fairy_dust_slow_pct%%%"
  )} for %fairy_dust_duration%s. Charges every %replenish_time% seconds.`,
  upgrade: upgrade("Successful hits charges your weapon."),
  lore: [fairyDust.description],
  values: [manaValue, ["related", "Fairy Power"]],
});

localizeAbility("puck_second_attack", {
  title: "Lightining Orb",
  description: `Fire a orb of light that deals %ability_damage% on impact. If the target is affected by ${fairyDust.name()}, also applies ${keywords.silence.name()} for %silence_duration%s.`,
  upgrade: upgrade(
    `Increases damage and refreshes ${endlessMisschief} cooldown.`
  ),
  lore: [fairyDust.description, keywords.silence.description],
  values: [manaValue, castpointValue],
});

localizeAbility("puck_counter", {
  title: "Phase Shift",
  description: `Puck Banishes for %banish_duration5s. When activated, launch a ${fairyFlare} towards mouse position. Casting any spell will remove the banish. Has %max_charges% charges.`,
  upgrade: upgrade(
    `Reduces the cooldown ${fairyFlare} before throwing the projectile.`
  ),
  values: [castpointValue],
});

localizeAbility("puck_mobility", {
  title: "Illusory Orb",
  description:
    "Puck launches a magic orb that floats in a straight path, dealing %ability_damage% to enemy units along the way. Can be recasted to teleport Puck to the orb's location and deal %damage_aoe% damage in area to enemies on the arrival location.",
  upgrade: upgrade("If hits an enemy, resets the cooldown."),
  values: [manaValue, castpointValue],
});

localizeAbility("puck_special_attack", {
  title: "Endless Mischief",
  description: `Puck realeses his power in an area. First in a small wave, dealing %damage_small% damage and applying ${keywords.silence.name()} for %silence_duration%s to enemies in area, and then in a bigger wave deaing %damage% and applying ${fairyDust.name(
    "%fairy_dust_slow_pct%%%"
  )} for %fairy_dust_duration%s.`,
  upgrade: upgrade(
    `Applies ${keywords.stun.name()} for %stun_duration_small%s in the small wave and for %stun_duration%s in the big wave and increases the damage dealt in both waves. No longer silences`
  ),
  lore: [
    fairyDust.description,
    keywords.silence.description,
    keywords.stun.description,
  ],
  values: [manaValue, castpointValue],
});

localizeAbility("puck_ultimate", {
  title: "Dream Coil",
  description: `Creates a coil of volatile magic that latches onto enemy Heroes, inflicting a %initial_stun_duration%s ${keywords.stun.name()} on them. If the enemy hero stretches the coil by moving too far away, it snaps, inflicting ${keywords.stun.name()} for %snap_stun_duration%s, and dealing %ability_damage% damage. Any time that puck launches a ${fairyFlare}, the coil launches one too targeted at the same direction.`,
  lore: [keywords.stun.description],
  values: [["duration", "DURATION"], castpointValue],
});

localizeAbility("puck_extra", {
  title: "Waning Rift",
  description: `Puck teleports himself to the target location and releases a burst of dust that inflicts ${keywords.spellBlock.name(
    "%silence_duration%"
  )} for %pre_silence_duration%s on the enemy units nearby.`,
  upgrade: upgrade(
    `Grants one free recast if ${keywords.spellBlock.name()} is triggered.`
  ),
  lore: [keywords.spellBlock.description, keywords.silence.description],
  values: [castpointValue],
});

localizeAbility("puck_ex_basic_attack", {
  title: "Fairy Form",
  description: `Puck tranforms himself into his Fairy Form, replacing its ${fairyFlare}. Lasts for %duration%.`,
  upgrade: upgrade(
    `When hitting an enemy with ${fairyPower} also heals you for ${heal(
      "%heal_per_hit%"
    )} health.`
  ),
  secondaryAbility: secondaryAbility(
    "Fairy Power",
    "puck_basic_attack_related",
    `Ranged area attack that after a delay of %delay_time%s deals ${keywords.baseDamage.name()}. When charged, inflicts ${fairyDust.name(
      "%fairy_dust_slow_pct%%%"
    )} for %fairy_dust_duration%s. Charges every %replenish_time% seconds. When hitting at least one enemy gains %shield_per_hit% shield points.`
  ),
  lore: [fairyDust.description],
  values: [castpointValue],
});

localizeAbility("puck_ex_mobility", {
  title: "Merry Wanderer",
  description: `Puck launches a magic orb that floats in a straight path, dealing %ability_damage% to enemy units along the way. Can be recasted to teleport Puck to the orb's location and deal %damage_aoe% damage and applies ${keywords.fear.name()} for %fear_duration%s in area to enemies on the arrival location.`,
  upgrade: upgrade(`No longer shares cooldown with ${illusoryOrb}.`),
  lore: [keywords.fear.description],
  values: [castpointValue],
});

//     Modifiers.push({
//       modifier_classname: "modifier_puck_basic_attack_cooldown",
//       {title:"Weapon Cooldown",
//       description: "When has one stack, your weapon is charged.",
//     });

//     Modifiers.push({
//       modifier_classname: "modifier_puck_counter_charges",
//       {title:"Phase Shift Charges",
//       description: "Amount of charges.",
//     });

//     Modifiers.push({
//       modifier_classname: "modifier_puck_counter_banish",
//       {title:"Banished",
//       description: "Invulnerable and unable to act.",
//     });

//     Modifiers.push({
//       modifier_classname: "modifier_puck_ex_basic_attack",
//       {title:"Fairy Form",
//       description: "Basic attack changed to an area effect.",
//     });

//     Modifiers.push({
//       modifier_classname: "modifier_puck_fairy_dust",
//       {title:"Fairy Dust",
//       description: "You move slower.",
//     });

//     return localization_info;
//   }
