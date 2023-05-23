local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 6,["16"] = 8,["19"] = 8,["23"] = 8,["27"] = 8,["29"] = 8,["30"] = 10});
local ____exports = {}
local ____juggernaut = require("upgrades.juggernaut")
local JuggernautRewards = ____juggernaut.default
local ____phantom = require("upgrades.phantom")
local PhantomRewards = ____phantom.default
local ____storm = require("upgrades.storm")
local StormRewards = ____storm.default
local ____sniper = require("upgrades.sniper")
local SniperRewards = ____sniper.default
local ____array_0 = __TS__SparseArrayNew(unpack(JuggernautRewards.Favors))
__TS__SparseArrayPush(
    ____array_0,
    unpack(PhantomRewards.Favors)
)
__TS__SparseArrayPush(
    ____array_0,
    unpack(StormRewards.Favors)
)
__TS__SparseArrayPush(
    ____array_0,
    unpack(SniperRewards.Favors)
)
local Favors = {__TS__SparseArraySpread(____array_0)}
____exports.default = Favors
return ____exports
