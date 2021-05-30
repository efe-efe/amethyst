--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 4,["8"] = 4,["9"] = 16,["10"] = 17,["11"] = 17,["12"] = 18,["13"] = 18,["14"] = 19,["15"] = 19,["16"] = 20,["17"] = 20,["18"] = 21,["19"] = 21,["20"] = 22,["21"] = 22,["22"] = 23,["23"] = 23,["24"] = 26,["25"] = 64,["26"] = 64,["27"] = 66,["28"] = 67,["29"] = 67,["30"] = 67,["31"] = 67,["32"] = 71,["33"] = 71,["34"] = 71,["35"] = 71,["36"] = 64,["37"] = 73,["38"] = 74,["39"] = 75,["40"] = 76,["41"] = 77,["42"] = 79,["43"] = 80,["44"] = 81,["46"] = 83,["47"] = 84,["50"] = 87,["51"] = 88,["52"] = 89,["55"] = 92,["56"] = 93,["57"] = 94,["60"] = 97,["61"] = 98,["62"] = 99,["65"] = 102,["66"] = 64,["67"] = 64,["68"] = 106,["69"] = 106,["70"] = 106,["71"] = 107,["72"] = 108,["73"] = 110,["74"] = 111,["75"] = 112,["76"] = 113,["77"] = 113,["78"] = 113,["79"] = 113,["80"] = 114,["81"] = 115,["85"] = 106,["86"] = 106,["87"] = 121});
local ____exports = {}
local ____upgrades = require("upgrades.upgrades")
local UpgradeManager = ____upgrades.UpgradeManager
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
    GenerateRewards = function(self, customNpc, options)
        local rewards = __TS__ArrayFilter(
            Rewards,
            function(____, reward) return self:ValidateReward(customNpc, reward) end
        )
        return Math:GetRandomElementsFromArray(
            rewards,
            Clamp(options.amount, #rewards, 0)
        )
    end,
    ValidateReward = function(____, customNpc, reward)
        local knowledge = UpgradeManager:GenerateKnowledge(customNpc, 1)
        local items = UpgradeManager:GenerateItems(customNpc, 1)
        local shards = UpgradeManager:GenerateShards(customNpc, 1)
        local favors = UpgradeManager:GenerateFavors(customNpc, 1)
        if reward.type == ____exports.RewardTypes.KNOWLEDGE then
            if #knowledge == 0 then
                return false
            end
            if #customNpc.heroUpgrades < 2 then
                return false
            end
        end
        if reward.type == ____exports.RewardTypes.ITEM then
            if #items == 0 then
                return false
            end
        end
        if reward.type == ____exports.RewardTypes.SHARD then
            if #shards == 0 then
                return false
            end
        end
        if reward.type == ____exports.RewardTypes.FAVOR then
            if #favors == 0 then
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
