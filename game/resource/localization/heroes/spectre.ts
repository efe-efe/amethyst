import {
  AbilityLocalization,
  HeroTalents,
  Language,
  LocalizationData,
  ModifierLocalization,
  StandardLocalization,
} from "../../localizationInterfaces";
import { Keywords, Description, multipleKeywords, Ability } from "../specific";

export function GenerateLocalizationData(): LocalizationData {
  const Abilities: Array<AbilityLocalization> =
    new Array<AbilityLocalization>();
  const Modifiers: Array<ModifierLocalization> =
    new Array<ModifierLocalization>();
  const StandardTooltips: Array<StandardLocalization> =
    new Array<StandardLocalization>();
  const Talents: Array<HeroTalents> = new Array<HeroTalents>();

  const localization_info: LocalizationData = {
    AbilityArray: Abilities,
    ModifierArray: Modifiers,
    StandardArray: StandardTooltips,
    TalentArray: Talents,
  };

  const ShadowStep = Ability("Shadow Step", "spectre_mobility.png");
  const Isolate = Ability("Isolate", "spectre_counter_recast.png");
  const SpectralDagger = Ability(
    "Spectral Dagger",
    "spectre_special_attack.png"
  );

  Abilities.push({
    ability_classname: "spectre_basic_attack",
    name: "Void Strike",
    description: Description({
      description:
        "Melee attack that deals " +
        Keywords.BaseDamage +
        " damage. Your weapon charges after @{replenish_time}s. When fully charged, it deals @{charged_damage} extra damage, heals you in @{heal_charged} HP and inflicts " +
        Keywords.Silence.instance() +
        " for @{silence_duration}s and " +
        Keywords.Desolate.instance() +
        ". When hitting enemies affected by " +
        Keywords.Desolate.instance() +
        ", deals @{damage_bonus_desolate} extra damage and heals @{heal_desolate} HP.",
      level: "Increases the " + Keywords.Silence.instance() + " duration",
    }),
    lore: multipleKeywords([
      Keywords.Desolate.definition,
      Keywords.Silence.definition,
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
    description: Description({
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
    description: Description({
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
    description: Description({
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
    description: Description({
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
    description: Description({
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
    description: Description({
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
    description: Description({
      description:
        "After @{delay_time}s, drags all enemies around yourself dealing @{ability_damage} and healing yourself in @{heal} health and inflicting " +
        Keywords.FadingSlow.instance("@{fading_slow_pct}") +
        " for @{fading_slow_duration}s to opponents.",
      level: "Increases the damage dealt",
    }),
    lore: Keywords.FadingSlow.definition,
  });
  Abilities.push({
    ability_classname: "spectre_ex_mobility",
    name: "Revenant",
    description: Description({
      description:
        "Teleports to a new location, inflicting " +
        Keywords.Desolate.instance() +
        " for @{desolate_duration}s to all enemies on the landing area and healing herself for @{heal} health if find any.",
      level:
        "Also applies " +
        Keywords.Fear.instance() +
        " for @{fear_duration}s to the enemies affected.",
    }),
    lore: multipleKeywords([
      Keywords.Desolate.definition,
      Keywords.Fear.definition,
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
    description: Description({
      description:
        "Creates a warp that afetr @{delay_time}s banishes all enemies for @{banish_duration}s. This ability can be recasted to teleport all enemies banished to the target location. After appearing, gets " +
        Keywords.FadingSlow.instance("@{fading_slow_pct}") +
        " for @{fading_slow_duration}s.",
      level: "Increases the banish duration and the cast range.",
    }),
    lore: Keywords.FadingSlow.definition,
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });

  return localization_info;
}
