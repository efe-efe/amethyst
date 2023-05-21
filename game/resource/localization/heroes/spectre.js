"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GenerateLocalizationData = void 0;
var specific_1 = require("../specific");
function GenerateLocalizationData() {
  var Abilities = [];
  var Modifiers = [];
  var StandardTooltips = [];
  var Talents = [];
  var localization_info = {
    AbilityArray: Abilities,
    ModifierArray: Modifiers,
    StandardArray: StandardTooltips,
    TalentArray: Talents,
  };
  var ShadowStep = specific_1.Ability("Shadow Step", "spectre_mobility.png");
  var Isolate = specific_1.Ability("Isolate", "spectre_counter_recast.png");
  var SpectralDagger = specific_1.Ability(
    "Spectral Dagger",
    "spectre_special_attack.png"
  );
  Abilities.push({
    ability_classname: "spectre_basic_attack",
    name: "Void Strike",
    description: specific_1.Description({
      description:
        "Melee attack that deals " +
        specific_1.Keywords.BaseDamage +
        " damage. Your weapon charges after @{replenish_time}s. When fully charged, it deals @{charged_damage} extra damage, heals you in @{heal_charged} HP and inflicts " +
        specific_1.Keywords.Silence.instance() +
        " for @{silence_duration}s and " +
        specific_1.Keywords.Desolate.instance() +
        ". When hitting enemies affected by " +
        specific_1.Keywords.Desolate.instance() +
        ", deals @{damage_bonus_desolate} extra damage and heals @{heal_desolate} HP.",
      level:
        "Increases the " + specific_1.Keywords.Silence.instance() + " duration",
    }),
    lore: specific_1.multipleKeywords([
      specific_1.Keywords.Desolate.definition,
      specific_1.Keywords.Silence.definition,
    ]),
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_second_attack",
    name: "Darkness Bolt",
    description: specific_1.Description({
      description:
        "Launch a dark energy ball that deals @{ability_damage} damage on impact.",
      level: "Increases the damage",
    }),
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_counter",
    name: "Dispersion",
    description: specific_1.Description({
      description:
        "Counters every projectile or melee attack in front of Spectre. Lasts for @{counter_duration}s. Countering an attack charges your weapon and allows you to recast this spell to launch a " +
        Isolate +
        ".",
      level: "Refresh all " + ShadowStep + " charges.",
      subAbility: {
        name: "Isolate",
        description:
          "Launch a dark energy ball that deals @{ability_damage} damage on impact and teleports the target to Spectre's current location",
        iconPath: "spectre_counter_recast.png",
      },
    }),
  });
  Abilities.push({
    ability_classname: "spectre_special_attack",
    name: "Spectral Dagger",
    description: specific_1.Description({
      description:
        "Flings a dagger to draw a Shadow Path, dealing @{ability_damage} damage. While treading the path, phases through otherwise impassable terrain and gains @{speed_buff_pct}%  movement speed. Enemies hit by the dagger will also leave a trail of spectral path for @{debuff_duration}s.",
      level: "Increases the range of the projectile.",
    }),
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_mobility",
    name: "Shadow Step",
    description: specific_1.Description({
      description:
        "Travels to a new location, reduces the cooldown of your weapon in @{cooldown_reduction}s if she lands on a target. Also deal @{ability_damage} damage to any enemy on the landing area.",
      level: "Adds an aditional charge to the spell.",
    }),
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_ultimate",
    name: "Haunt",
    description: specific_1.Description({
      description:
        "Creates a dark area on the target location. When in the darkness, Spectre is able to phase through otherwise impassable terrain, gains @{speed_buff_pct}% movement speed and @{bonus_damage} damage. Deals @{ability_damage} damage to opponents that touches the edges and applies " +
        SpectralDagger +
        " debuff on them for @{duration}s. The darkness lasts for @{duration}s.",
      level: "",
    }),
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_extra",
    name: "Reaping Scythe",
    description: specific_1.Description({
      description:
        "Spin your scythe, dealing @{damage_per_second} damage every @{think_interval}s over @{duration}s to nearby enemies. Increases movement speed by @{speed_buff_pct}% while spinning. After the duration, heal self equal to damage dealt.",
      level:
        "Can be recasted as a projectile that deals @{recast_damage} plus the damage dealt with the scythe while spining with a maximum of @{max_damage}.",
    }),
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_ex_counter",
    name: "Revenant",
    description: specific_1.Description({
      description:
        "After @{delay_time}s, drags all enemies around yourself dealing @{ability_damage} and healing yourself in @{heal} health and inflicting " +
        specific_1.Keywords.FadingSlow.instance("@{fading_slow_pct}") +
        " for @{fading_slow_duration}s to opponents.",
      level: "Increases the damage dealt",
    }),
    lore: specific_1.Keywords.FadingSlow.definition,
  });
  Abilities.push({
    ability_classname: "spectre_ex_mobility",
    name: "Revenant",
    description: specific_1.Description({
      description:
        "Teleports to a new location, inflicting " +
        specific_1.Keywords.Desolate.instance() +
        " for @{desolate_duration}s to all enemies on the landing area and healing herself for @{heal} health if find any.",
      level:
        "Also applies " +
        specific_1.Keywords.Fear.instance() +
        " for @{fear_duration}s to the enemies affected.",
    }),
    lore: specific_1.multipleKeywords([
      specific_1.Keywords.Desolate.definition,
      specific_1.Keywords.Fear.definition,
    ]),
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "spectre_ex_special_attack",
    name: "Illusion Warp",
    description: specific_1.Description({
      description:
        "Creates a warp that afetr @{delay_time}s banishes all enemies for @{banish_duration}s. This ability can be recasted to teleport all enemies banished to the target location. After appearing, gets " +
        specific_1.Keywords.FadingSlow.instance("@{fading_slow_pct}") +
        " for @{fading_slow_duration}s.",
      level: "Increases the banish duration and the cast range.",
    }),
    lore: specific_1.Keywords.FadingSlow.definition,
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
