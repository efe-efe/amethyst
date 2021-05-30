--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 6,["9"] = 21,["10"] = 26});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = {{id = "sniper_snipe_cast_fast", name = "Quick Snipe", description = "Your Snipe cast point is reduced drastically.", ability = "sniper_second_attack", maxStacks = 1, modifier = {name = "modifier_upgrade_sniper_snipe_cast_fast"}, tier = 1, type = UpgradeTypes.FAVOR}}
local SniperRewards = {Shards = Shards, Favors = Favors}
____exports.default = SniperRewards
return ____exports
