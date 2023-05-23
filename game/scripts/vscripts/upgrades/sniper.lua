local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 5,["9"] = 6,["10"] = 6,["11"] = 6,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 6,["16"] = 6,["17"] = 5,["18"] = 18,["19"] = 18,["20"] = 18,["21"] = 18,["22"] = 18,["23"] = 18,["24"] = 18,["25"] = 18,["26"] = 5,["27"] = 32,["28"] = 37});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = {}
local Favors = {{
    id = "sniper_snipe_cast_fast",
    name = "Quick snipe",
    description = "Your Snipe cast point is reduced drastically.",
    ability = "sniper_second_attack",
    maxStacks = 1,
    modifier = {name = "modifier_upgrade_sniper_snipe_cast_fast"},
    tier = 1,
    type = UpgradeTypes.FAVOR
}, {
    id = "sniper_jump_knockback",
    name = "Jump knockback",
    description = "Your jump knocks back enemies and deals damage to enemies at the arrival area.",
    ability = "sniper_mobility",
    maxStacks = 1,
    modifier = {name = "modifier_upgrade_sniper_jump_knockback"},
    tier = 1,
    type = UpgradeTypes.FAVOR
}}
local SniperRewards = {Shards = Shards, Favors = Favors}
____exports.default = SniperRewards
return ____exports
