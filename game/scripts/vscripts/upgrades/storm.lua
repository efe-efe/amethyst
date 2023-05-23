local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 5,["9"] = 6,["10"] = 6,["11"] = 6,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 6,["16"] = 6,["17"] = 5,["18"] = 18,["19"] = 18,["20"] = 18,["21"] = 18,["22"] = 18,["23"] = 18,["24"] = 18,["25"] = 18,["26"] = 5,["27"] = 32,["28"] = 37});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = {{
    id = "storm_ranged_remnant",
    name = "Ranged remnant",
    description = "Your static remnant can be casted with range",
    ability = "storm_mobility",
    maxStacks = 1,
    modifier = {name = "modifier_upgrade_storm_ranged_remnant"},
    tier = 0,
    type = UpgradeTypes.FAVOR
}, {
    id = "storm_unleashed_knockback",
    name = "Storm Unleashed knockback",
    description = "Your Storm Unleashed push enemies out.",
    ability = "storm_ultimate",
    maxStacks = 1,
    modifier = {name = "modifier_upgrade_storm_unleashed_knockback"},
    tier = 0,
    type = UpgradeTypes.FAVOR
}}
local StormRewards = {Shards = Shards, Favors = Favors}
____exports.default = StormRewards
return ____exports
