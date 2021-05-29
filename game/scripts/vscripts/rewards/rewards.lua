--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 9,["6"] = 10,["7"] = 10,["8"] = 11,["9"] = 11,["10"] = 12,["11"] = 12,["12"] = 13,["13"] = 13,["14"] = 14,["15"] = 14,["16"] = 15,["17"] = 15,["18"] = 18,["19"] = 52,["20"] = 52,["21"] = 52,["22"] = 53,["23"] = 54,["24"] = 56,["25"] = 57,["26"] = 58,["27"] = 59,["28"] = 59,["29"] = 59,["30"] = 59,["31"] = 60,["32"] = 61,["36"] = 52,["37"] = 52,["38"] = 67});
local ____exports = {}
____exports.RewardTypes = RewardTypes or ({})
____exports.RewardTypes.FAVOR = 0
____exports.RewardTypes[____exports.RewardTypes.FAVOR] = "FAVOR"
____exports.RewardTypes.ENHANCEMENT = 1
____exports.RewardTypes[____exports.RewardTypes.ENHANCEMENT] = "ENHANCEMENT"
____exports.RewardTypes.TARRASQUE = 2
____exports.RewardTypes[____exports.RewardTypes.TARRASQUE] = "TARRASQUE"
____exports.RewardTypes.SECRET_SHOP = 3
____exports.RewardTypes[____exports.RewardTypes.SECRET_SHOP] = "SECRET_SHOP"
____exports.RewardTypes.GOLD = 4
____exports.RewardTypes[____exports.RewardTypes.GOLD] = "GOLD"
____exports.RewardTypes.ITEM = 5
____exports.RewardTypes[____exports.RewardTypes.ITEM] = "ITEM"
local Rewards = {{type = ____exports.RewardTypes.FAVOR, name = "Favor", description = "Applies a new favor on one of your abilities, improving one aspect from it."}, {type = ____exports.RewardTypes.ENHANCEMENT, name = "Enhancement", description = "Enhances one of your existing favors."}, {type = ____exports.RewardTypes.TARRASQUE, name = "Heart of Tarrasque", description = "Increases your maximun health pool."}, {type = ____exports.RewardTypes.ITEM, name = "Item", description = "Artifacts that improves your hero powers."}}
CustomGameEventManager:RegisterListener(
    "custom_npc:select_reward",
    function(eventSourceIndex, event)
        local playerId = event.playerIndex
        local player = GameRules.Addon:FindPlayerById(playerId)
        if player then
            local customNpc = player.customNpc
            if customNpc then
                local reward = __TS__ArrayFilter(
                    Rewards,
                    function(____, _reward) return _reward.type == event.payload.type end
                )[1]
                if reward then
                    customNpc:SelectReward(reward)
                end
            end
        end
    end
)
____exports.default = Rewards
return ____exports
