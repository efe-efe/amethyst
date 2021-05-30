--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 4,["8"] = 4,["9"] = 5,["10"] = 5,["11"] = 7,["15"] = 8,["18"] = 9,["21"] = 10,["24"] = 7,["25"] = 7,["26"] = 13});
local ____exports = {}
local ____juggernaut = require("upgrades.juggernaut")
local JuggernautRewards = ____juggernaut.default
local ____phantom = require("upgrades.phantom")
local PhantomRewards = ____phantom.default
local ____storm = require("upgrades.storm")
local StormRewards = ____storm.default
local Shards = {
    unpack(
        __TS__ArrayConcat(
            {
                unpack(JuggernautRewards.Shards)
            },
            {
                unpack(PhantomRewards.Shards)
            },
            {
                unpack(StormRewards.Shards)
            }
        )
    )
}
____exports.default = Shards
return ____exports
