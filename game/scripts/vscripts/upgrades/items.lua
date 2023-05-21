--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 93,["10"] = 93,["11"] = 93,["12"] = 93,["13"] = 93,["14"] = 93,["15"] = 93,["16"] = 93,["17"] = 93,["18"] = 3,["19"] = 3,["20"] = 104});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Items = __TS__ArrayMap(
    {{itemName = "blade_of_alacrity", name = "Blade of Alacrity", description = "Provides extra movement and attack speed.", maxStacks = 1, modifier = {}, tier = 0}, {itemName = "boots_of_elves", name = "Band of Elvenskin", description = "Provides extra attack speed and damage.", maxStacks = 1, modifier = {}, tier = 0}, {itemName = "yasha", name = "Yasha", description = "Increases your movement and attack speed.", maxStacks = 1, modifier = {}, tier = 1, ingredients = {"upgrade_item_boots_of_elves", "upgrade_item_blade_of_alacrity"}}, {itemName = "broom_handle", name = "Broom handle", description = "Provides extra radius on your basic attack", maxStacks = 1, modifier = {}, attackCapability = DOTA_UNIT_CAP_MELEE_ATTACK, tier = 0}, {itemName = "blades_of_attack", name = "Blades of attack", description = "Increases your base damage.", maxStacks = 1, modifier = {}, tier = 1}, {itemName = "mithril_hammer", name = "Mithril Hammer", description = "Increases your base damage.", maxStacks = 1, modifier = {}, tier = 1}, {itemName = "javelin", name = "Javelin", description = "Your attacks has a chance of dealing extra damage.", maxStacks = 1, modifier = {}, tier = 1}, {itemName = "maelstrom", name = "Maelstrom", description = "Increases your base damage. Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.", maxStacks = 1, modifier = {}, ingredients = {"upgrade_item_javelin", "upgrade_item_mithril_hammer"}, tier = 1}, {itemName = "basher", name = "Basher", description = "Increases your maximum HP and your base damage. Your attacks has a chance to deal extra damage and stun the target.", maxStacks = 1, modifier = {}, ingredients = {"upgrade_belt_of_strength", "upgrade_item_mithril_hammer"}, tier = 1}, {itemName = "belt_of_strength", name = "Belt of Strength", description = "Increases your maximum HP.", maxStacks = 1, modifier = {}, tier = 1}},
    function(____, item) return __TS__ObjectAssign(
        {},
        item,
        {
            id = "upgrade_item_" .. item.itemName,
            abilityIconName = "item_" .. item.itemName,
            modifier = __TS__ObjectAssign({}, item.modifier, {name = "modifier_upgrade_item_" .. item.itemName}),
            type = UpgradeTypes.ITEM
        }
    ) end
)
____exports.default = Items
return ____exports
