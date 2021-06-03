--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 6,["9"] = 6,["10"] = 62,["11"] = 62,["12"] = 62,["13"] = 62,["14"] = 62,["15"] = 62,["16"] = 62,["17"] = 6,["18"] = 6,["19"] = 71,["20"] = 76});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = __TS__ArrayMap(
    {{id = "juggernaut_blade_dance_recast", name = "Blade Dance recast", description = "Blade Dance can be recasted to perform a slash. Can be used freely for a short time while not missing. The recast duration dependes on the stacks used.", ability = "juggernaut_second_attack", maxStacks = 1, modifier = {}, tier = 0}, {id = "juggernaut_fury_reflects", name = "Blade Fury reflects", description = "Blade Fury reflect enemy projectiles.", ability = "juggernaut_mobility", maxStacks = 1, modifier = {}, tier = 0}, {id = "juggernaut_fury_reflects", name = "Blade Fury reflects", description = "Blade Fury reflect enemy projectiles.", ability = "juggernaut_mobility", maxStacks = 1, modifier = {}, tier = 0}, {id = "juggernaut_fury_attack", name = "Blade Fury attacks", description = "Blade Fury damage count as basic attacks", ability = "juggernaut_mobility", maxStacks = 1, modifier = {}, tier = 0}, {id = "juggernaut_refresh_dagger", name = "Refreshing dagger", description = "Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.", ability = "juggernaut_special_attack", maxStacks = 1, modifier = {}, tier = 1}, {id = "juggernaut_spinning_ward", name = "Spinning Ward", description = "Your Healing Ward also spins when you activates your Blade Fury. It also resists 5 hits instead of 1.", ability = "juggernaut_extra", secondaryAbilities = {"juggernaut_mobility"}, maxStacks = 1, modifier = {}, tier = 1}},
    function(____, favor) return __TS__ObjectAssign(
        {},
        favor,
        {
            type = UpgradeTypes.FAVOR,
            modifier = __TS__ObjectAssign({}, favor.modifier, {name = "modifier_upgrade_" .. favor.id})
        }
    ) end
)
local JuggernautRewards = {Shards = Shards, Favors = Favors}
____exports.default = JuggernautRewards
return ____exports
