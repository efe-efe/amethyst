"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GenerateLocalizationData = void 0;
function GenerateLocalizationData() {
    var Abilities = [];
    var Modifiers = [];
    var StandardTooltips = [];
    var Talents = [];
    var localization_info = {
        AbilityArray: Abilities,
        ModifierArray: Modifiers,
        StandardArray: StandardTooltips,
        TalentArray: Talents
    };
    Modifiers.push({
        modifier_classname: "modifier_emerald",
        name: "Emerald buff",
        description: "Healing {" + "MODIFIER_PROPERTY_TOOLTIP" /* TOOLTIP */ + "} HP per second.",
    });
    Modifiers.push({
        modifier_classname: "modifier_ruby",
        name: "Ruby buff",
        description: "Your basic attacks deals extra fire damage."
    });
    Modifiers.push({
        modifier_classname: "modifier_sapphire",
        name: "Sapphire buff",
        description: "Blocks {" + "MODIFIER_PROPERTY_TOOLTIP" /* TOOLTIP */ + "} damage. Duplicates the mana gain."
    });
    Modifiers.push({
        modifier_classname: "modifier_death_zone_damage",
        name: "Death Zone",
        description: "You are on the death zone, you will recive damage, move to a safer area!"
    });
    return localization_info;
}
exports.GenerateLocalizationData = GenerateLocalizationData;
