--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 25,["17"] = 26,["20"] = 27,["23"] = 28,["26"] = 29,["29"] = 25,["30"] = 25,["31"] = 32});
local ____exports = {}
local ____phantom = require("upgrades.phantom")
local phantom = ____phantom.default
local ____juggernaut = require("upgrades.juggernaut")
local juggernaut = ____juggernaut.default
local ____storm = require("upgrades.storm")
local storm = ____storm.default
local ____generic = require("upgrades.generic")
local generic = ____generic.default
local Upgrades = {
    unpack(
        __TS__ArrayConcat(
            {
                unpack(phantom)
            },
            {
                unpack(juggernaut)
            },
            {
                unpack(storm)
            },
            {
                unpack(generic)
            }
        )
    )
}
____exports.default = Upgrades
return ____exports
