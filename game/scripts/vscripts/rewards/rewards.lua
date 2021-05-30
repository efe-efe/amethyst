--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 9,["6"] = 10,["7"] = 10,["8"] = 11,["9"] = 11,["10"] = 12,["11"] = 12,["12"] = 13,["13"] = 13,["14"] = 14,["15"] = 14,["16"] = 15,["17"] = 15,["18"] = 16,["19"] = 16,["20"] = 19,["21"] = 58,["22"] = 58,["23"] = 58,["24"] = 59,["25"] = 60,["26"] = 62,["27"] = 63,["28"] = 64,["29"] = 65,["30"] = 65,["31"] = 65,["32"] = 65,["33"] = 66,["34"] = 67,["38"] = 58,["39"] = 58,["40"] = 73});
local ____exports = {}
____exports.RewardTypes = RewardTypes or ({})
____exports.RewardTypes.FAVOR = 0
____exports.RewardTypes[____exports.RewardTypes.FAVOR] = "FAVOR"
____exports.RewardTypes.SHARD = 1
____exports.RewardTypes[____exports.RewardTypes.SHARD] = "SHARD"
____exports.RewardTypes.ITEM = 2
____exports.RewardTypes[____exports.RewardTypes.ITEM] = "ITEM"
____exports.RewardTypes.KNOWLEDGE = 3
____exports.RewardTypes[____exports.RewardTypes.KNOWLEDGE] = "KNOWLEDGE"
____exports.RewardTypes.TARRASQUE = 4
____exports.RewardTypes[____exports.RewardTypes.TARRASQUE] = "TARRASQUE"
____exports.RewardTypes.SECRET_SHOP = 5
____exports.RewardTypes[____exports.RewardTypes.SECRET_SHOP] = "SECRET_SHOP"
____exports.RewardTypes.GOLD = 6
____exports.RewardTypes[____exports.RewardTypes.GOLD] = "GOLD"
local Rewards = {{type = ____exports.RewardTypes.FAVOR, name = "Favor", description = "Change the effect one of your abilities."}, {type = ____exports.RewardTypes.KNOWLEDGE, name = "Tome of Knowledge", description = "Enhances one of your existing shard effects."}, {type = ____exports.RewardTypes.TARRASQUE, name = "Heart of Tarrasque", description = "Increases your maximun health pool."}, {type = ____exports.RewardTypes.ITEM, name = "Item", description = "Artifacts that improves your hero powers."}, {type = ____exports.RewardTypes.SHARD, name = "Shard", description = "Improves one of your abilities."}}
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
