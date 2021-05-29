--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 9,["6"] = 10,["7"] = 10,["8"] = 11,["9"] = 11,["10"] = 12,["11"] = 12,["12"] = 13,["13"] = 13,["14"] = 14,["15"] = 14,["16"] = 17,["17"] = 46,["18"] = 46,["19"] = 46,["20"] = 47,["21"] = 48,["22"] = 50,["23"] = 51,["24"] = 52,["25"] = 53,["26"] = 53,["27"] = 53,["28"] = 53,["29"] = 54,["30"] = 55,["34"] = 46,["35"] = 46,["36"] = 61});
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
local Rewards = {{type = ____exports.RewardTypes.FAVOR, name = "Favor", description = "Applies a new favor on one of your abilities, improving one aspect from it."}, {type = ____exports.RewardTypes.ENHANCEMENT, name = "Enhancement", description = "Enhances one of your existing favors."}, {type = ____exports.RewardTypes.TARRASQUE, name = "Heart of Tarrasque", description = "Increases your maximun health pool."}}
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
