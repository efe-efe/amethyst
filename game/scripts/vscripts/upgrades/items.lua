local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 4,["18"] = 3,["19"] = 12,["20"] = 12,["21"] = 12,["22"] = 12,["23"] = 12,["24"] = 12,["25"] = 12,["26"] = 3,["27"] = 20,["28"] = 20,["29"] = 20,["30"] = 20,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 3,["36"] = 32,["37"] = 32,["38"] = 32,["39"] = 32,["40"] = 32,["41"] = 32,["42"] = 32,["43"] = 32,["44"] = 3,["45"] = 41,["46"] = 41,["47"] = 41,["48"] = 41,["49"] = 41,["50"] = 41,["51"] = 41,["52"] = 3,["53"] = 49,["54"] = 49,["55"] = 49,["56"] = 49,["57"] = 49,["58"] = 49,["59"] = 49,["60"] = 3,["61"] = 57,["62"] = 57,["63"] = 57,["64"] = 57,["65"] = 57,["66"] = 57,["67"] = 57,["68"] = 3,["69"] = 65,["70"] = 65,["71"] = 65,["72"] = 65,["73"] = 65,["74"] = 65,["75"] = 65,["76"] = 65,["77"] = 3,["78"] = 75,["79"] = 75,["80"] = 75,["81"] = 75,["82"] = 75,["83"] = 75,["84"] = 75,["85"] = 75,["86"] = 3,["87"] = 85,["88"] = 85,["89"] = 85,["90"] = 85,["91"] = 85,["92"] = 85,["93"] = 85,["94"] = 3,["95"] = 3,["96"] = 93,["97"] = 93,["98"] = 93,["99"] = 93,["100"] = 93,["101"] = 93,["102"] = 93,["103"] = 93,["104"] = 93,["105"] = 3,["106"] = 3,["107"] = 104});
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
