local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 6,["16"] = 6,["17"] = 6,["18"] = 6,["19"] = 6,["20"] = 5,["21"] = 16,["22"] = 16,["23"] = 16,["24"] = 16,["25"] = 16,["26"] = 16,["27"] = 16,["28"] = 16,["29"] = 5,["30"] = 25,["31"] = 25,["32"] = 25,["33"] = 25,["34"] = 25,["35"] = 25,["36"] = 25,["37"] = 25,["38"] = 5,["39"] = 34,["40"] = 34,["41"] = 34,["42"] = 34,["43"] = 34,["44"] = 34,["45"] = 34,["46"] = 34,["47"] = 5,["48"] = 43,["49"] = 43,["50"] = 43,["51"] = 43,["52"] = 43,["53"] = 43,["54"] = 43,["55"] = 43,["56"] = 5,["57"] = 5,["58"] = 53,["59"] = 53,["60"] = 53,["61"] = 53,["62"] = 53,["63"] = 53,["64"] = 53,["65"] = 5,["66"] = 5,["67"] = 62,["68"] = 67});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = __TS__ArrayMap(
    {
        {
            id = "juggernaut_blade_dance_recast",
            name = "Blade Dance recast",
            description = "Blade Dance can be recasted to perform a slash. Can be used freely for a short time while not missing. The recast duration dependes on the stacks used.",
            ability = "juggernaut_second_attack",
            maxStacks = 1,
            modifier = {},
            tier = 0
        },
        {
            id = "juggernaut_fury_reflects",
            name = "Blade Fury reflects",
            description = "Blade Fury reflect enemy projectiles.",
            ability = "juggernaut_mobility",
            maxStacks = 1,
            modifier = {},
            tier = 0
        },
        {
            id = "juggernaut_fury_attack",
            name = "Blade Fury attacks",
            description = "Blade Fury damage count as basic attacks",
            ability = "juggernaut_mobility",
            maxStacks = 1,
            modifier = {},
            tier = 0
        },
        {
            id = "juggernaut_refresh_dagger",
            name = "Refreshing dagger",
            description = "Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.",
            ability = "juggernaut_special_attack",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "juggernaut_spinning_ward",
            name = "Spinning Ward",
            description = "Your Healing Ward also spins when you activates your Blade Fury. It also resists 5 hits instead of 1.",
            ability = "juggernaut_extra",
            maxStacks = 1,
            modifier = {},
            tier = 1
        }
    },
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
