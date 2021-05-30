--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 62});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Items = {{id = "upgrade_broom_handle", name = "Broom handle", description = "Provides extra radius on your basic attack", maxStacks = 1, attackCapability = DOTA_UNIT_CAP_MELEE_ATTACK, modifier = {name = "modifier_upgrade_meele_extra_radius"}, tier = 0, type = UpgradeTypes.ITEM}, {id = "upgrade_blades_of_attack", name = "Blades of attack", description = "Increases your base damage by 3.", maxStacks = 3, modifier = {name = "modifier_upgrade_extra_base_damage"}, tier = 1, type = UpgradeTypes.ITEM}, {id = "upgrade_item_moonshard", name = "Moonshard", description = "Increases your movement and attack speed.", maxStacks = 3, modifier = {name = "modifier_upgrade_extra_speed"}, tier = 1, type = UpgradeTypes.ITEM}, {id = "upgrade_item_maelstrom", name = "Maelstrom", description = "Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.", maxStacks = 3, modifier = {name = "modifier_upgrade_lightining_attack"}, tier = 1, type = UpgradeTypes.ITEM}, {id = "upgrade_item_basher", name = "Basher", description = "Your attacks has a chance to deal extra damage and stun the target.", maxStacks = 3, modifier = {name = "modifier_upgrade_stun_attack"}, tier = 1, type = UpgradeTypes.ITEM}}
____exports.default = Items
return ____exports
