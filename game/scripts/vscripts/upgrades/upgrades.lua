--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 27,["17"] = 28,["20"] = 29,["23"] = 30,["26"] = 31,["29"] = 27,["30"] = 27,["31"] = 34,["32"] = 34,["33"] = 34,["34"] = 35,["35"] = 36,["36"] = 38,["37"] = 39,["38"] = 40,["39"] = 41,["40"] = 41,["41"] = 41,["42"] = 41,["43"] = 42,["44"] = 43,["48"] = 34,["49"] = 34,["50"] = 49});
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
    "custom_npc:apply_upgrade",
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
                    customNpc:ApplyUpgrade(upgrade)
                end
            end
        end
    end
)
____exports.default = Upgrades
return ____exports
