--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 10,["8"] = 11,["9"] = 11,["10"] = 12,["11"] = 12,["12"] = 13,["13"] = 13,["14"] = 14,["15"] = 14,["16"] = 15,["17"] = 15,["18"] = 18,["19"] = 47,["20"] = 47,["21"] = 47,["22"] = 48,["23"] = 49,["24"] = 50,["25"] = 52,["26"] = 53,["27"] = 54,["28"] = 55,["29"] = 55,["30"] = 55,["31"] = 55,["32"] = 56,["33"] = 57,["34"] = 58,["38"] = 47,["39"] = 47,["40"] = 64});
local ____exports = {}
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
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
        local customEvents = CustomEvents:GetInstance()
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
                    customEvents:EmitEvent("pve:next_reward_selected", {customNpc = customNpc, reward = reward})
                end
            end
        end
    end
)
____exports.default = Rewards
return ____exports
