import { castpointValue, keywords, manaValue } from "../common";
import { localizeAbility } from "../localization";
import {
  abilityWithIcon,
  upgrade,
  createKeyword,
  heal,
  secondaryAbility,
} from "../util";

const shadowStep = abilityWithIcon("Shadow Step", "spectre_mobility");
const isolate = abilityWithIcon("Isolate", "spectre_counter_recast");
const spectralDagger = abilityWithIcon(
  "Spectral Dagger",
  "spectre_special_attack"
);

const voidStrike = abilityWithIcon("Void Strike", "spectre_basic_attack");

const desolate = createKeyword("Desolate", {
  description: `Adds extra effects on ${voidStrike}.`,
  icon: "desolate",
  color: "#9C24A0",
});

localizeAbility("spectre_basic_attack", {
  title: "Void Strike",
  description: `Melee attack that deals ${keywords.baseDamage.name()} damage. Your weapon charges after %replenish_time%s. When fully charged, it deals %charged_damage% extra damage, heals you in ${heal(
    "%heal_charged%"
  )} HP and inflicts ${keywords.silence.name()} for %silence_duration%s and ${desolate.name()}. When hitting enemies affected by ${desolate.name()}, deals %damage_bonus_desolate% extra damage and heals ${heal(
    "%heal_desolate%"
  )} HP.`,
  upgrade: upgrade(`Increases the ${keywords.silence.name()} duration.`),
  lore: [desolate.description, keywords.silence.description],
  values: [manaValue],
});

localizeAbility("spectre_second_attack", {
  title: "Darkness Bolt",
  description:
    "Launch a dark energy ball that deals %ability_damage% damage on impact.",
  upgrade: upgrade("Increases the damage"),
  values: [castpointValue, manaValue],
});
localizeAbility("spectre_counter", {
  title: "Dispersion",
  description: `Counters every projectile or melee attack in front of Spectre. Lasts for %counter_duration%s. Countering an attack charges your weapon and allows you to recast this spell to launch a ${isolate}.`,
  upgrade: upgrade(`Refresh all ${shadowStep} charges.`),
  secondaryAbility: secondaryAbility(
    "Isolate",
    "spectre_counter_recast",
    "Launch a dark energy ball that deals %ability_damage% damage on impact and teleports the target to Spectre's current location"
  ),
});

localizeAbility("spectre_special_attack", {
  title: "Spectral Dagger",
  description:
    "Flings a dagger to draw a Shadow Path, dealing %ability_damage% damage. While treading the path, phases through otherwise impassable terrain and gains %speed_buff_pct%%%  movement speed. Enemies hit by the dagger will also leave a trail of spectral path for %debuff_duration%s.",
  upgrade: upgrade("Increases the range of the projectile."),
  values: [castpointValue, manaValue],
});

localizeAbility("spectre_mobility", {
  title: "Shadow Step",
  description:
    "Travels to a new location, reduces the cooldown of your weapon in %cooldown_reduction%s if she lands on a target. Also deal %ability_damage% damage to any enemy on the landing area.",
  upgrade: upgrade("Adds an aditional charge to the spell."),
  values: [manaValue],
});

localizeAbility("spectre_ultimate", {
  title: "Haunt",
  description: `Creates a dark area on the target location. When in the darkness, Spectre is able to phase through otherwise impassable terrain, gains %speed_buff_pct%%% movement speed and %bonus_damage% damage. Deals %ability_damage% damage to opponents that touches the edges and applies ${spectralDagger} debuff on them for %duration%s. The darkness lasts for %duration%s.`,
  values: [castpointValue],
});

localizeAbility("spectre_extra", {
  title: "Reaping Scythe",
  description:
    "Spin your scythe, dealing %damage_per_second% damage every %think_interval%s over %duration%s to nearby enemies. Increases movement speed by %speed_buff_pct%%% while spinning. After the duration, heal self equal to damage dealt.",
  upgrade: upgrade(
    "Can be recasted as a projectile that deals %recast_damage% plus the damage dealt with the scythe while spining with a maximum of %max_damage%."
  ),
  values: [castpointValue],
});

localizeAbility("spectre_ex_counter", {
  title: "Revenant",
  description: `After %delay_time%s, drags all enemies around yourself dealing %ability_damage% and healing yourself in ${heal(
    "%heal%"
  )} health and inflicting ${keywords.fadingSlow.name(
    "%fading_slow_pct%%%"
  )} for %fading_slow_duration%s to opponents.`,
  upgrade: upgrade("Increases the damage dealt"),
  lore: [keywords.fadingSlow.description],
});

localizeAbility("spectre_ex_mobility", {
  title: "Revenant",

  description: `Teleports to a new location, inflicting ${desolate.name()} for %desolate_duration%s to all enemies on the landing area and healing herself for ${heal(
    "%heal%"
  )} health if find any.`,
  upgrade: upgrade(
    `Also applies ${keywords.fear.name()} for %fear_duration%s to the enemies affected.`
  ),
  lore: [desolate.description, keywords.fear.description],
  values: [castpointValue],
});

localizeAbility("spectre_ex_special_attack", {
  title: "Illusion Warp",

  description: `Creates a warp that afetr %delay_time%s banishes all enemies for %banish_duration%s. This ability can be recasted to teleport all enemies banished to the target location. After appearing, gets ${keywords.fadingSlow.name(
    "%fading_slow_pct%%%"
  )} for %fading_slow_duration%s.`,
  upgrade: upgrade("Increases the banish duration and the cast range."),
  lore: [keywords.fadingSlow.description],
  values: [castpointValue],
});
