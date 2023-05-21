--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 6,["8"] = 6,["9"] = 7,["10"] = 7,["11"] = 8,["12"] = 8,["13"] = 20,["14"] = 21,["15"] = 21,["16"] = 22,["17"] = 22,["18"] = 23,["19"] = 23,["20"] = 24,["21"] = 24,["22"] = 25,["23"] = 25,["24"] = 26,["25"] = 26,["26"] = 27,["27"] = 27,["28"] = 30,["29"] = 68,["30"] = 68,["31"] = 68,["32"] = 71,["33"] = 68,["35"] = 75,["36"] = 75,["38"] = 80,["39"] = 70,["40"] = 83,["41"] = 84,["42"] = 85,["43"] = 86,["44"] = 92,["45"] = 92,["46"] = 92,["47"] = 92,["48"] = 96,["49"] = 96,["50"] = 96,["51"] = 92,["52"] = 92,["53"] = 101,["54"] = 107,["55"] = 113,["56"] = 119,["57"] = 119,["58"] = 119,["59"] = 119,["60"] = 123,["61"] = 123,["62"] = 123,["63"] = 119,["64"] = 119,["65"] = 83,["66"] = 130,["67"] = 130,["68"] = 134,["69"] = 134,["70"] = 134,["71"] = 135,["72"] = 134,["73"] = 135,["74"] = 142,["75"] = 134,["76"] = 144,["77"] = 142,["78"] = 148,["79"] = 148,["80"] = 148,["81"] = 149,["82"] = 148,["83"] = 149,["84"] = 156,["85"] = 148,["86"] = 158,["87"] = 156,["88"] = 162,["89"] = 162,["90"] = 162,["91"] = 163,["92"] = 162,["93"] = 163,["94"] = 170,["95"] = 162,["96"] = 172,["97"] = 170,["98"] = 176,["99"] = 176,["100"] = 176,["101"] = 177,["102"] = 176,["103"] = 177,["104"] = 184,["105"] = 176,["106"] = 186,["107"] = 184,["108"] = 190,["109"] = 190,["110"] = 190,["111"] = 191,["112"] = 190,["113"] = 191,["114"] = 198,["115"] = 190,["116"] = 200,["117"] = 198,["118"] = 204,["119"] = 204,["120"] = 206,["121"] = 207,["122"] = 208,["125"] = 212,["126"] = 212,["127"] = 212,["128"] = 212,["129"] = 217,["130"] = 217,["131"] = 219,["132"] = 219,["133"] = 217,["134"] = 217,["135"] = 217,["136"] = 204,["137"] = 223,["138"] = 227,["139"] = 229,["140"] = 229,["141"] = 229,["142"] = 229,["143"] = 227,["144"] = 227,["145"] = 230,["146"] = 232,["147"] = 233,["149"] = 235,["150"] = 236,["152"] = 238,["153"] = 239,["155"] = 241,["156"] = 242,["158"] = 244,["159"] = 245,["161"] = 247,["162"] = 204,["163"] = 249,["164"] = 250,["165"] = 252,["166"] = 253,["167"] = 254,["170"] = 258,["171"] = 258,["172"] = 258,["173"] = 258,["174"] = 263,["175"] = 264,["176"] = 264,["177"] = 266,["178"] = 266,["179"] = 264,["180"] = 264,["181"] = 264,["182"] = 204,["183"] = 270,["184"] = 271,["185"] = 273,["186"] = 274,["187"] = 275,["190"] = 279,["191"] = 279,["192"] = 279,["193"] = 279,["194"] = 284,["195"] = 285,["196"] = 285,["197"] = 287,["198"] = 287,["199"] = 285,["200"] = 285,["201"] = 285,["202"] = 204,["203"] = 291,["204"] = 292,["205"] = 294,["206"] = 295,["207"] = 296,["210"] = 300,["211"] = 300,["212"] = 300,["213"] = 300,["214"] = 305,["215"] = 306,["216"] = 306,["217"] = 308,["218"] = 308,["219"] = 306,["220"] = 306,["221"] = 306,["222"] = 204,["223"] = 312,["224"] = 313,["225"] = 313,["226"] = 313,["227"] = 313,["228"] = 315,["229"] = 316,["230"] = 317,["233"] = 321,["234"] = 321,["235"] = 321,["236"] = 321,["237"] = 326,["238"] = 327,["239"] = 327,["240"] = 329,["241"] = 329,["242"] = 327,["243"] = 327,["244"] = 327,["245"] = 204,["246"] = 333,["247"] = 334,["248"] = 340,["249"] = 341,["250"] = 342,["251"] = 204,["252"] = 344,["253"] = 348,["254"] = 348,["255"] = 348,["256"] = 348,["257"] = 354,["258"] = 354,["259"] = 354,["260"] = 354,["261"] = 204,["262"] = 359,["263"] = 360,["264"] = 204,["265"] = 362,["266"] = 363,["267"] = 364,["268"] = 365,["269"] = 366,["270"] = 368,["271"] = 369,["272"] = 370,["274"] = 372,["275"] = 373,["278"] = 376,["279"] = 377,["280"] = 378,["283"] = 381,["284"] = 382,["285"] = 383,["288"] = 386,["289"] = 387,["290"] = 388,["293"] = 391,["294"] = 204,["295"] = 204,["296"] = 395,["297"] = 395,["298"] = 397,["299"] = 398,["300"] = 399,["301"] = 401,["302"] = 402,["303"] = 403,["304"] = 404,["305"] = 404,["306"] = 404,["307"] = 404,["308"] = 407,["309"] = 408,["313"] = 395,["314"] = 395,["315"] = 415});
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
