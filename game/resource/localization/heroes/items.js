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
  var Items = [
    {
      id: "upgrade_item_broom_handle",
      abilityIconName: "item_broom_handle",
      name: "Broom handle",
      description: "Provides extra radius on your basic attack",
      maxStacks: 1,
      attackCapability: undefined,
      modifier: {
        name: "modifier_upgrade_item_broom_handle",
      },
      tier: 0,
      type: specific_1.UpgradeTypes.ITEM,
    },
    {
      id: "upgrade_item_blades_of_attack",
      abilityIconName: "item_blades_of_attack",
      name: "Blades of attack",
      description: "Increases your base damage by 1.",
      maxStacks: 1,
      modifier: {
        name: "modifier_upgrade_item_blades_of_attack",
      },
      tier: 1,
      type: specific_1.UpgradeTypes.ITEM,
    },
    {
      id: "upgrade_item_yasha",
      abilityIconName: "item_yasha",
      name: "Yasha",
      description: "Increases your movement and attack speed.",
      maxStacks: 1,
      modifier: {
        name: "modifier_upgrade_item_yasha",
      },
      tier: 1,
      type: specific_1.UpgradeTypes.ITEM,
    },
    {
      id: "upgrade_item_maelstrom",
      abilityIconName: "item_maelstrom",
      name: "Maelstrom",
      description:
        "Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.",
      maxStacks: 1,
      modifier: {
        name: "modifier_upgrade_item_maelstrom",
      },
      tier: 1,
      type: specific_1.UpgradeTypes.ITEM,
    },
    {
      id: "upgrade_item_basher",
      abilityIconName: "item_basher",
      name: "Basher",
      description:
        "Your attacks has a chance to deal extra damage and stun the target.",
      maxStacks: 1,
      modifier: {
        name: "modifier_upgrade_item_basher",
      },
      tier: 1,
      type: specific_1.UpgradeTypes.ITEM,
    },
  ];
  Modifiers.push.apply(Modifiers, specific_1.Upgrades(Items));
  return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
