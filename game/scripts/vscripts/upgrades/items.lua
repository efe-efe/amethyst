local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 4,["18"] = 3,["19"] = 12,["20"] = 12,["21"] = 12,["22"] = 12,["23"] = 12,["24"] = 12,["25"] = 12,["26"] = 3,["27"] = 20,["28"] = 20,["29"] = 20,["30"] = 20,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 3,["36"] = 29,["37"] = 29,["38"] = 29,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 3,["45"] = 38,["46"] = 38,["47"] = 38,["48"] = 38,["49"] = 38,["50"] = 38,["51"] = 38,["52"] = 3,["53"] = 46,["54"] = 46,["55"] = 46,["56"] = 46,["57"] = 46,["58"] = 46,["59"] = 46,["60"] = 3,["61"] = 54,["62"] = 54,["63"] = 54,["64"] = 54,["65"] = 54,["66"] = 54,["67"] = 54,["68"] = 3,["69"] = 62,["70"] = 62,["71"] = 62,["72"] = 62,["73"] = 62,["74"] = 62,["75"] = 62,["76"] = 62,["77"] = 3,["78"] = 72,["79"] = 72,["80"] = 72,["81"] = 72,["82"] = 72,["83"] = 72,["84"] = 72,["85"] = 72,["86"] = 3,["87"] = 81,["88"] = 81,["89"] = 81,["90"] = 81,["91"] = 81,["92"] = 81,["93"] = 81,["94"] = 3,["95"] = 3,["96"] = 89,["97"] = 89,["98"] = 89,["99"] = 89,["100"] = 89,["101"] = 89,["102"] = 89,["103"] = 89,["104"] = 89,["105"] = 3,["106"] = 3,["107"] = 100});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Items = __TS__ArrayMap(
    {
        {
            itemName = "blade_of_alacrity",
            name = "Blade of Alacrity",
            description = "Provides extra movement and attack speed.",
            maxStacks = 1,
            modifier = {},
            tier = 0
        },
        {
            itemName = "boots_of_elves",
            name = "Band of Elvenskin",
            description = "Provides extra attack speed and damage.",
            maxStacks = 1,
            modifier = {},
            tier = 0
        },
        {
            itemName = "yasha",
            name = "Yasha",
            description = "Increases your movement and attack speed.",
            maxStacks = 1,
            modifier = {},
            tier = 1,
            ingredients = {"upgrade_item_boots_of_elves", "upgrade_item_blade_of_alacrity"}
        },
        {
            itemName = "broom_handle",
            name = "Broom handle",
            description = "Provides extra radius on your basic attack",
            maxStacks = 1,
            modifier = {},
            attackCapability = 1,
            tier = 0
        },
        {
            itemName = "blades_of_attack",
            name = "Blades of attack",
            description = "Increases your base damage.",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            itemName = "mithril_hammer",
            name = "Mithril Hammer",
            description = "Increases your base damage.",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            itemName = "javelin",
            name = "Javelin",
            description = "Your attacks has a chance of dealing extra damage.",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            itemName = "maelstrom",
            name = "Maelstrom",
            description = "Increases your base damage. Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.",
            maxStacks = 1,
            modifier = {},
            ingredients = {"upgrade_item_javelin", "upgrade_item_mithril_hammer"},
            tier = 1
        },
        {
            itemName = "basher",
            name = "Basher",
            description = "Increases your maximum HP and your base damage. Your attacks has a chance to deal extra damage and stun the target.",
            maxStacks = 1,
            modifier = {},
            ingredients = {"upgrade_belt_of_strength", "upgrade_item_mithril_hammer"},
            tier = 1
        },
        {
            itemName = "belt_of_strength",
            name = "Belt of Strength",
            description = "Increases your maximum HP.",
            maxStacks = 1,
            modifier = {},
            tier = 1
        }
    },
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
