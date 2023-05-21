--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 5,["9"] = 32,["10"] = 37});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = {{id = "storm_ranged_remnant", name = "Ranged remnant", description = "Your static remnant can be casted with range", ability = "storm_mobility", maxStacks = 1, modifier = {name = "modifier_upgrade_storm_ranged_remnant"}, tier = 0, type = UpgradeTypes.FAVOR}, {id = "storm_unleashed_knockback", name = "Storm Unleashed knockback", description = "Your Storm Unleashed push enemies out.", ability = "storm_ultimate", maxStacks = 1, modifier = {name = "modifier_upgrade_storm_unleashed_knockback"}, tier = 0, type = UpgradeTypes.FAVOR}}
local StormRewards = {Shards = Shards, Favors = Favors}
____exports.default = StormRewards
return ____exports
