--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 4,["8"] = 4,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 8,["17"] = 9,["20"] = 10,["23"] = 11,["26"] = 12,["29"] = 8,["30"] = 8,["31"] = 15});
local ____exports = {}
local ____juggernaut = require("upgrades.juggernaut")
local JuggernautRewards = ____juggernaut.default
local ____phantom = require("upgrades.phantom")
local PhantomRewards = ____phantom.default
local ____storm = require("upgrades.storm")
local StormRewards = ____storm.default
local ____sniper = require("upgrades.sniper")
local SniperRewards = ____sniper.default
local Favors = {
    unpack(
        __TS__ArrayConcat(
            {
                unpack(JuggernautRewards.Favors)
            },
            {
                unpack(PhantomRewards.Favors)
            },
            {
                unpack(StormRewards.Favors)
            },
            {
                unpack(SniperRewards.Favors)
            }
        )
    )
}
____exports.default = Favors
return ____exports
