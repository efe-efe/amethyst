--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 4,["8"] = 4,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 18,["14"] = 19,["15"] = 19,["16"] = 20,["17"] = 20,["18"] = 21,["19"] = 21,["20"] = 22,["21"] = 22,["22"] = 23,["23"] = 23,["24"] = 24,["25"] = 24,["26"] = 25,["27"] = 25,["28"] = 28,["29"] = 66,["30"] = 66,["31"] = 66,["32"] = 68,["33"] = 66,["35"] = 69,["36"] = 69,["38"] = 70,["39"] = 68,["40"] = 73,["41"] = 74,["42"] = 75,["43"] = 76,["44"] = 77,["45"] = 77,["46"] = 77,["47"] = 77,["48"] = 77,["49"] = 77,["50"] = 77,["51"] = 77,["52"] = 77,["53"] = 81,["54"] = 82,["55"] = 83,["56"] = 84,["57"] = 84,["58"] = 84,["59"] = 84,["60"] = 84,["61"] = 84,["62"] = 84,["63"] = 84,["64"] = 84,["65"] = 73,["66"] = 90,["67"] = 90,["68"] = 94,["69"] = 94,["70"] = 94,["71"] = 95,["72"] = 94,["73"] = 95,["74"] = 99,["75"] = 94,["76"] = 101,["77"] = 99,["78"] = 105,["79"] = 105,["80"] = 105,["81"] = 106,["82"] = 105,["83"] = 106,["84"] = 110,["85"] = 105,["86"] = 112,["87"] = 110,["88"] = 116,["89"] = 116,["90"] = 116,["91"] = 117,["92"] = 116,["93"] = 117,["94"] = 121,["95"] = 116,["96"] = 123,["97"] = 121,["98"] = 127,["99"] = 127,["100"] = 127,["101"] = 128,["102"] = 127,["103"] = 128,["104"] = 132,["105"] = 127,["106"] = 134,["107"] = 132,["108"] = 138,["109"] = 138,["110"] = 138,["111"] = 139,["112"] = 138,["113"] = 139,["114"] = 143,["115"] = 138,["116"] = 145,["117"] = 143,["118"] = 149,["119"] = 149,["120"] = 151,["121"] = 152,["122"] = 153,["125"] = 157,["126"] = 157,["127"] = 157,["128"] = 157,["129"] = 162,["130"] = 162,["131"] = 162,["132"] = 162,["133"] = 162,["134"] = 162,["135"] = 162,["136"] = 149,["137"] = 164,["138"] = 165,["139"] = 165,["140"] = 165,["141"] = 165,["142"] = 165,["143"] = 165,["144"] = 165,["145"] = 166,["146"] = 168,["147"] = 169,["149"] = 171,["150"] = 172,["152"] = 174,["153"] = 175,["155"] = 177,["156"] = 178,["158"] = 180,["159"] = 181,["161"] = 183,["162"] = 149,["163"] = 185,["164"] = 186,["165"] = 188,["166"] = 189,["167"] = 190,["170"] = 194,["171"] = 194,["172"] = 194,["173"] = 194,["174"] = 199,["175"] = 200,["176"] = 200,["177"] = 200,["178"] = 200,["179"] = 200,["180"] = 200,["181"] = 200,["182"] = 149,["183"] = 202,["184"] = 203,["185"] = 205,["186"] = 206,["187"] = 207,["190"] = 211,["191"] = 211,["192"] = 211,["193"] = 211,["194"] = 216,["195"] = 217,["196"] = 217,["197"] = 217,["198"] = 217,["199"] = 217,["200"] = 217,["201"] = 217,["202"] = 149,["203"] = 219,["204"] = 220,["205"] = 222,["206"] = 223,["207"] = 224,["210"] = 228,["211"] = 228,["212"] = 228,["213"] = 228,["214"] = 233,["215"] = 234,["216"] = 234,["217"] = 234,["218"] = 234,["219"] = 234,["220"] = 234,["221"] = 234,["222"] = 149,["223"] = 236,["224"] = 237,["225"] = 237,["226"] = 237,["227"] = 237,["228"] = 239,["229"] = 240,["230"] = 241,["233"] = 245,["234"] = 245,["235"] = 245,["236"] = 245,["237"] = 250,["238"] = 251,["239"] = 251,["240"] = 251,["241"] = 251,["242"] = 251,["243"] = 251,["244"] = 251,["245"] = 149,["246"] = 253,["247"] = 254,["248"] = 255,["249"] = 256,["250"] = 257,["251"] = 149,["252"] = 259,["253"] = 260,["254"] = 260,["255"] = 260,["256"] = 260,["257"] = 265,["258"] = 265,["259"] = 265,["260"] = 265,["261"] = 149,["262"] = 267,["263"] = 268,["264"] = 149,["265"] = 270,["266"] = 271,["267"] = 272,["268"] = 273,["269"] = 274,["270"] = 276,["271"] = 277,["272"] = 278,["274"] = 280,["275"] = 281,["278"] = 284,["279"] = 285,["280"] = 286,["283"] = 289,["284"] = 290,["285"] = 291,["288"] = 294,["289"] = 295,["290"] = 296,["293"] = 299,["294"] = 149,["295"] = 149,["296"] = 303,["297"] = 303,["298"] = 303,["299"] = 304,["300"] = 305,["301"] = 307,["302"] = 308,["303"] = 309,["304"] = 310,["305"] = 310,["306"] = 310,["307"] = 310,["308"] = 311,["309"] = 312,["313"] = 303,["314"] = 303,["315"] = 318});
local ____exports = {}
local ____breakable_bounty = require("clases.breakable_bounty")
local BreakableBounty = ____breakable_bounty.default
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
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
local RewardEntity = __TS__Class()
RewardEntity.name = "RewardEntity"
__TS__ClassExtends(RewardEntity, BreakableBounty)
function RewardEntity.prototype.____constructor(self, origin, owner, options)
    BreakableBounty.prototype.____constructor(
        self,
        origin,
        __TS__ObjectAssign({}, options, {particle = "particles/generic_gameplay/rune_doubledamage.vpcf", scale = 1.3})
    )
    self.owner = owner
end
function RewardEntity.prototype.PlayEffectsOnSpawn(self)
    local unit = self:GetUnit()
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", unit)
    EFX("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX(
        "particles/reward_effect_impact.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        unit,
        {
            cp1 = unit:GetAbsOrigin(),
            release = true
        }
    )
    EFX("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX("particles/reward_effect_extra.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX(
        "particles/reward_effect.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        unit,
        {
            cp1 = Vector(100, 100, 100),
            release = true
        }
    )
end
function RewardEntity.prototype.Effect(self, killer)
end
local FavorEntity = __TS__Class()
FavorEntity.name = "FavorEntity"
__TS__ClassExtends(FavorEntity, RewardEntity)
function FavorEntity.prototype.____constructor(self, origin, owner)
    RewardEntity.prototype.____constructor(self, origin, owner, {model = "models/props_gameplay/stout_shield.vmdl", health = 25})
end
function FavorEntity.prototype.Effect(self, killer)
    RewardEntity.prototype.Effect(self, killer)
    ____exports.RewardsManager:OfferFavorsForHero(self.owner)
end
local ShardEntity = __TS__Class()
ShardEntity.name = "ShardEntity"
__TS__ClassExtends(ShardEntity, RewardEntity)
function ShardEntity.prototype.____constructor(self, origin, owner)
    RewardEntity.prototype.____constructor(self, origin, owner, {model = "models/props_gameplay/aghanim_scepter.vmdl", health = 25})
end
function ShardEntity.prototype.Effect(self, killer)
    RewardEntity.prototype.Effect(self, killer)
    ____exports.RewardsManager:ClaimShards(self.owner)
end
local ItemEntity = __TS__Class()
ItemEntity.name = "ItemEntity"
__TS__ClassExtends(ItemEntity, RewardEntity)
function ItemEntity.prototype.____constructor(self, origin, owner)
    RewardEntity.prototype.____constructor(self, origin, owner, {model = "models/props_gameplay/neutral_box.vmdl", health = 25})
end
function ItemEntity.prototype.Effect(self, killer)
    RewardEntity.prototype.Effect(self, killer)
    ____exports.RewardsManager:ClaimItems(self.owner)
end
local KnowledgeEntity = __TS__Class()
KnowledgeEntity.name = "KnowledgeEntity"
__TS__ClassExtends(KnowledgeEntity, RewardEntity)
function KnowledgeEntity.prototype.____constructor(self, origin, owner)
    RewardEntity.prototype.____constructor(self, origin, owner, {model = "models/props_items/necronomicon.vmdl", health = 25})
end
function KnowledgeEntity.prototype.Effect(self, killer)
    RewardEntity.prototype.Effect(self, killer)
    ____exports.RewardsManager:ClaimKnowledge(self.owner)
end
local VitalityEntity = __TS__Class()
VitalityEntity.name = "VitalityEntity"
__TS__ClassExtends(VitalityEntity, RewardEntity)
function VitalityEntity.prototype.____constructor(self, origin, owner)
    RewardEntity.prototype.____constructor(self, origin, owner, {model = "models/props_gameplay/heart001.vmdl", health = 25})
end
function VitalityEntity.prototype.Effect(self, killer)
    RewardEntity.prototype.Effect(self, killer)
    ____exports.RewardsManager:ClaimVitality(self.owner)
end
____exports.RewardsManager = {
    Rewards = Rewards,
    OfferRewardsForHero = function(self, hero, rewards)
        if #rewards == 0 then
            print("Skipping rewards selection. No rewards available")
            return
        end
        local data = {
            playerId = hero.unit:GetPlayerOwnerID(),
            rewards = rewards
        }
        CustomNetTables:SetTableValue(
            "custom_npc_rewards",
            tostring(
                hero.unit:GetPlayerOwnerID()
            ),
            data
        )
    end,
    ClaimRewardForHero = function(self, customNpc, reward)
        local origin = customNpc.unit:GetAbsOrigin():__add(
            Vector(
                RandomFloat(-1, 1) * 150,
                RandomFloat(-1, 1) * 150,
                128
            )
        )
        local rewardEntity = nil
        if reward.type == ____exports.RewardTypes.FAVOR then
            rewardEntity = __TS__New(FavorEntity, origin, customNpc)
        end
        if reward.type == ____exports.RewardTypes.ITEM then
            rewardEntity = __TS__New(ItemEntity, origin, customNpc)
        end
        if reward.type == ____exports.RewardTypes.KNOWLEDGE then
            rewardEntity = __TS__New(KnowledgeEntity, origin, customNpc)
        end
        if reward.type == ____exports.RewardTypes.SHARD then
            rewardEntity = __TS__New(ShardEntity, origin, customNpc)
        end
        if reward.type == ____exports.RewardTypes.VITALITY then
            rewardEntity = __TS__New(VitalityEntity, origin, customNpc)
        end
        return rewardEntity
    end,
    OfferFavorsForHero = function(self, customNpc)
        local upgrades = UpgradeManager:GenerateFavors(customNpc, 3)
        if #upgrades == 0 then
            print("Skipping favors selection. No rewards available")
            UpgradeManager:ClearUpgrades(customNpc)
            return
        end
        local data = {
            playerId = customNpc.unit:GetPlayerOwnerID(),
            upgrades = upgrades
        }
        local tableName = "custom_npc_favors"
        CustomNetTables:SetTableValue(
            tableName,
            tostring(
                customNpc.unit:GetPlayerOwnerID()
            ),
            data
        )
    end,
    ClaimShards = function(self, customNpc)
        local upgrades = UpgradeManager:GenerateShards(customNpc, 3)
        if #upgrades == 0 then
            print("Skipping shards selection. No rewards available")
            UpgradeManager:ClearUpgrades(customNpc)
            return
        end
        local data = {
            playerId = customNpc.unit:GetPlayerOwnerID(),
            upgrades = upgrades
        }
        local tableName = "custom_npc_favors"
        CustomNetTables:SetTableValue(
            tableName,
            tostring(
                customNpc.unit:GetPlayerOwnerID()
            ),
            data
        )
    end,
    ClaimKnowledge = function(self, customNpc)
        local upgrades = UpgradeManager:GenerateKnowledge(customNpc, 3)
        if #upgrades == 0 then
            print("Skipping knowledge selection. No rewards available")
            UpgradeManager:ClearUpgrades(customNpc)
            return
        end
        local data = {
            playerId = customNpc.unit:GetPlayerOwnerID(),
            upgrades = upgrades
        }
        local tableName = "custom_npc_favors"
        CustomNetTables:SetTableValue(
            tableName,
            tostring(
                customNpc.unit:GetPlayerOwnerID()
            ),
            data
        )
    end,
    ClaimItems = function(self, customNpc)
        local upgrades = UpgradeManager:GenerateItems(
            customNpc,
            RandomInt(4, 6)
        )
        if #upgrades == 0 then
            print("Skipping items selection. No rewards available")
            UpgradeManager:ClearUpgrades(customNpc)
            return
        end
        local data = {
            playerId = customNpc.unit:GetPlayerOwnerID(),
            upgrades = upgrades
        }
        local tableName = "custom_npc_favors"
        CustomNetTables:SetTableValue(
            tableName,
            tostring(
                customNpc.unit:GetPlayerOwnerID()
            ),
            data
        )
    end,
    ClaimVitality = function(self, customNpc)
        customNpc.unit:AddNewModifier(customNpc.unit, nil, "modifier_upgrade_tarrasque", {})
        CustomEntitiesLegacy:SendDataToClient(customNpc.unit)
        local customEvents = CustomEvents:GetInstance()
        customEvents:EmitEvent("pve:current_reward_applied", {customNpc = customNpc})
    end,
    GenerateRewards = function(self, customNpc, options)
        local rewards = __TS__ArrayFilter(
            Rewards,
            function(____, reward) return ((options.type and (function() return self:ValidateRewardType(reward, options.type) end)) or (function() return true and self:ValidateReward(customNpc, reward) end))() end
        )
        return Math:GetRandomElementsFromArray(
            rewards,
            Clamp(options.amount, #rewards, 0)
        )
    end,
    ValidateRewardType = function(____, reward, ____type)
        return reward.type == ____type
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
