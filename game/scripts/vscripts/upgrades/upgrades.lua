--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 26,["17"] = 27,["20"] = 28,["23"] = 29,["26"] = 30,["29"] = 26,["30"] = 26,["31"] = 33,["32"] = 33,["33"] = 33,["34"] = 34,["35"] = 35,["36"] = 37,["37"] = 38,["38"] = 39,["39"] = 40,["40"] = 40,["41"] = 40,["42"] = 40,["43"] = 41,["44"] = 42,["48"] = 33,["49"] = 33,["50"] = 48});
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
CustomGameEventManager:RegisterListener(
    "custom_npc:apply_favor",
    function(eventSourceIndex, event)
        local playerId = event.playerIndex
        local player = GameRules.Addon:FindPlayerById(playerId)
        if player then
            local customNpc = player.customNpc
            if customNpc then
                local upgrade = __TS__ArrayFilter(
                    Upgrades,
                    function(____, currentUpgrade) return currentUpgrade.id == event.payload.upgradeId end
                )[1]
                if upgrade then
                    customNpc:ApplyFavor(upgrade)
                end
            end
        end
    end
)
____exports.default = Upgrades
return ____exports
