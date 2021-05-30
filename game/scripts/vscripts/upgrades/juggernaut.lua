--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 6,["9"] = 33,["10"] = 38});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = {{id = "juggernaut_fury_attack", name = "Blade Fury attacks", description = "Blade Fury damage count as basic attacks", ability = "juggernaut_mobility", maxStacks = 1, modifier = {name = "modifier_upgrade_juggernaut_fury_attack"}, tier = 0, type = UpgradeTypes.FAVOR}, {id = "juggernaut_refresh_dagger", name = "Refreshing dagger", description = "Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.", ability = "juggernaut_special_attack", maxStacks = 1, modifier = {name = "modifier_upgrade_juggernaut_refresh_dagger"}, tier = 1, type = UpgradeTypes.FAVOR}}
local JuggernautRewards = {Shards = Shards, Favors = Favors}
____exports.default = JuggernautRewards
return ____exports
