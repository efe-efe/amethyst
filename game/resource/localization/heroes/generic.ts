import {
  AbilityLocalization,
  HeroTalents,
  Language,
  LocalizationData,
  ModifierLocalization,
  StandardLocalization,
} from "../../localizationInterfaces";

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

  Modifiers.push({
    modifier_classname: "modifier_emerald",
    name: "Emerald buff",
    description: `Healing {${LocalizationModifierProperty.TOOLTIP}} HP per second.`,
  });

  Modifiers.push({
    modifier_classname: "modifier_ruby",
    name: "Ruby buff",
    description: "Your basic attacks deals extra fire damage.",
  });

  Modifiers.push({
    modifier_classname: "modifier_sapphire",
    name: "Sapphire buff",
    description: `Blocks {${LocalizationModifierProperty.TOOLTIP}} damage. Duplicates the mana gain.`,
  });

  Modifiers.push({
    modifier_classname: "modifier_death_zone_damage",
    name: "Death Zone",
    description:
      "You are on the death zone, you will recive damage, move to a safer area!",
  });

  return localization_info;
}
