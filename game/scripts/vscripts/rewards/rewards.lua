--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 15,["8"] = 16,["9"] = 16,["10"] = 17,["11"] = 17,["12"] = 18,["13"] = 18,["14"] = 19,["15"] = 19,["16"] = 20,["17"] = 20,["18"] = 21,["19"] = 21,["20"] = 22,["21"] = 22,["22"] = 25,["23"] = 63,["24"] = 63,["25"] = 65,["26"] = 66,["27"] = 66,["28"] = 66,["29"] = 66,["30"] = 70,["31"] = 70,["32"] = 70,["33"] = 70,["34"] = 63,["35"] = 72,["36"] = 73,["37"] = 74,["38"] = 75,["41"] = 78,["42"] = 63,["43"] = 63,["44"] = 82,["45"] = 82,["46"] = 82,["47"] = 83,["48"] = 84,["49"] = 86,["50"] = 87,["51"] = 88,["52"] = 89,["53"] = 89,["54"] = 89,["55"] = 89,["56"] = 90,["57"] = 91,["61"] = 82,["62"] = 82,["63"] = 97});
local ____exports = {}
local ____math = require("util.math")
local Math = ____math.default
____exports.RewardTypes = RewardTypes or ({})
____exports.RewardTypes.FAVOR = 0
____exports.RewardTypes[____exports.RewardTypes.FAVOR] = "FAVOR"
____exports.RewardTypes.SHARD = 1
____exports.RewardTypes[____exports.RewardTypes.SHARD] = "SHARD"
____exports.RewardTypes.ITEM = 2
____exports.RewardTypes[____exports.RewardTypes.ITEM] = "ITEM"
____exports.RewardTypes.KNOWLEDGE = 3
____exports.RewardTypes[____exports.RewardTypes.KNOWLEDGE] = "KNOWLEDGE"
____exports.RewardTypes.VITALITY = 4
____exports.RewardTypes[____exports.RewardTypes.VITALITY] = "VITALITY"
____exports.RewardTypes.SECRET_SHOP = 5
____exports.RewardTypes[____exports.RewardTypes.SECRET_SHOP] = "SECRET_SHOP"
____exports.RewardTypes.GOLD = 6
____exports.RewardTypes[____exports.RewardTypes.GOLD] = "GOLD"
local Rewards = {{type = ____exports.RewardTypes.FAVOR, name = "Favor", description = "Change the effect one of your abilities."}, {type = ____exports.RewardTypes.KNOWLEDGE, name = "Tome of Knowledge", description = "Enhances one of your existing shard effects."}, {type = ____exports.RewardTypes.VITALITY, name = "Vitality", description = "Increases your maximun health pool."}, {type = ____exports.RewardTypes.ITEM, name = "Item", description = "Artifacts that improves your hero powers."}, {type = ____exports.RewardTypes.SHARD, name = "Shard", description = "Improves one of your abilities."}}
____exports.RewardsManager = {
    Rewards = Rewards,
    GenerateRewards = function(____, customNpc, options)
        local rewards = __TS__ArrayFilter(
            Rewards,
            function(____, reward) return ____exports.RewardsManager:ValidateReward(customNpc, reward) end
        )
        return Math:GetRandomElementsFromArray(
            rewards,
            Clamp(options.amount, #rewards, 0)
        )
    end,
    ValidateReward = function(____, customNpc, reward)
        if reward.type == ____exports.RewardTypes.KNOWLEDGE then
            if #customNpc.heroUpgrades < 2 then
                return false
            end
        end
        return true
    end
}
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
