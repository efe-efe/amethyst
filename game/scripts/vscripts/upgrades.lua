--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 19,["6"] = 44});
local ____exports = {}
local Upgrades = {{id = "meele_extra_radius", name = "Extra radius", description = "Provides extra radius on your basic attack", maxLevel = 1, modifier = {name = "modifier_upgrade_meele_extra_radius"}, tier = 0}, {id = "phantom_extra_daggers", name = "Extra daggers", description = "Your stiffling daggers throws 3 daggers.", hero = "npc_dota_hero_phantom_assassin", ability = "phantom_special_attack", maxLevel = 1, modifier = {name = "modifier_upgrade_phantom_extra_daggers"}, tier = 1}}
____exports.default = Upgrades
return ____exports
