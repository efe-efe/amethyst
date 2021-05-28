--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 10,["8"] = 11,["9"] = 11,["10"] = 12,["11"] = 12,["12"] = 13,["13"] = 13,["14"] = 14,["15"] = 14,["16"] = 15,["17"] = 15,["18"] = 18,["19"] = 47,["20"] = 47,["21"] = 47,["22"] = 48,["23"] = 49,["24"] = 50,["25"] = 52,["26"] = 53,["27"] = 54,["28"] = 55,["29"] = 55,["30"] = 55,["31"] = 55,["32"] = 56,["33"] = 57,["34"] = 58,["38"] = 47,["39"] = 47,["40"] = 64});
local ____exports = {}
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
____exports.PrizeTypes = PrizeTypes or ({})
____exports.PrizeTypes.FAVOR = 0
____exports.PrizeTypes[____exports.PrizeTypes.FAVOR] = "FAVOR"
____exports.PrizeTypes.ENHANCEMENT = 1
____exports.PrizeTypes[____exports.PrizeTypes.ENHANCEMENT] = "ENHANCEMENT"
____exports.PrizeTypes.TARRASQUE = 2
____exports.PrizeTypes[____exports.PrizeTypes.TARRASQUE] = "TARRASQUE"
____exports.PrizeTypes.SECRET_SHOP = 3
____exports.PrizeTypes[____exports.PrizeTypes.SECRET_SHOP] = "SECRET_SHOP"
____exports.PrizeTypes.GOLD = 4
____exports.PrizeTypes[____exports.PrizeTypes.GOLD] = "GOLD"
local Prizes = {{type = ____exports.PrizeTypes.FAVOR, name = "Favor", description = "Upgrades one of your abilities."}, {type = ____exports.PrizeTypes.ENHANCEMENT, name = "Improvement", description = "Improves one of your existing upgrades."}, {type = ____exports.PrizeTypes.TARRASQUE, name = "Regenerate", description = "Fully restores all your HP."}}
CustomGameEventManager:RegisterListener(
    "custom_npc:select_bounty",
    function(eventSourceIndex, event)
        local customEvents = CustomEvents:GetInstance()
        local playerId = event.playerIndex
        local player = GameRules.Addon:FindPlayerById(playerId)
        if player then
            local customNpc = player.customNpc
            if customNpc then
                local prize = __TS__ArrayFilter(
                    Prizes,
                    function(____, _prize) return _prize.type == event.payload.type end
                )[1]
                if prize then
                    customNpc:SelectBounty(prize)
                    customEvents:EmitEvent("pve:prize_selected", {customNpc = customNpc})
                end
            end
        end
    end
)
____exports.default = Prizes
return ____exports
