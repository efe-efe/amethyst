local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["10"] = 2,["11"] = 2,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 20,["19"] = 21,["20"] = 21,["21"] = 22,["22"] = 22,["23"] = 23,["24"] = 23,["25"] = 24,["26"] = 24,["27"] = 25,["28"] = 25,["29"] = 26,["30"] = 26,["31"] = 27,["32"] = 27,["33"] = 30,["34"] = 30,["35"] = 30,["36"] = 30,["37"] = 30,["38"] = 30,["39"] = 30,["40"] = 68,["41"] = 68,["42"] = 68,["43"] = 71,["44"] = 68,["45"] = 75,["46"] = 75,["47"] = 75,["48"] = 75,["49"] = 80,["50"] = 70,["51"] = 83,["52"] = 84,["53"] = 85,["54"] = 86,["55"] = 92,["56"] = 92,["57"] = 92,["58"] = 92,["59"] = 96,["60"] = 96,["61"] = 96,["62"] = 92,["63"] = 92,["64"] = 101,["65"] = 107,["66"] = 113,["67"] = 119,["68"] = 119,["69"] = 119,["70"] = 119,["71"] = 123,["72"] = 123,["73"] = 123,["74"] = 119,["75"] = 119,["76"] = 83,["77"] = 130,["78"] = 130,["79"] = 134,["80"] = 134,["81"] = 134,["82"] = 135,["83"] = 134,["84"] = 135,["85"] = 142,["86"] = 134,["87"] = 144,["88"] = 142,["89"] = 148,["90"] = 148,["91"] = 148,["92"] = 149,["93"] = 148,["94"] = 149,["95"] = 156,["96"] = 148,["97"] = 158,["98"] = 156,["99"] = 162,["100"] = 162,["101"] = 162,["102"] = 163,["103"] = 162,["104"] = 163,["105"] = 170,["106"] = 162,["107"] = 172,["108"] = 170,["109"] = 176,["110"] = 176,["111"] = 176,["112"] = 177,["113"] = 176,["114"] = 177,["115"] = 184,["116"] = 176,["117"] = 186,["118"] = 184,["119"] = 190,["120"] = 190,["121"] = 190,["122"] = 191,["123"] = 190,["124"] = 191,["125"] = 198,["126"] = 190,["127"] = 200,["128"] = 198,["129"] = 204,["130"] = 204,["131"] = 206,["132"] = 207,["133"] = 208,["136"] = 212,["137"] = 212,["138"] = 212,["139"] = 212,["140"] = 217,["141"] = 217,["142"] = 217,["143"] = 217,["144"] = 217,["145"] = 204,["146"] = 223,["147"] = 227,["148"] = 229,["149"] = 229,["150"] = 229,["151"] = 227,["152"] = 230,["153"] = 232,["154"] = 233,["156"] = 235,["157"] = 236,["159"] = 238,["160"] = 239,["162"] = 241,["163"] = 242,["165"] = 244,["166"] = 245,["168"] = 247,["169"] = 204,["170"] = 249,["171"] = 250,["172"] = 252,["173"] = 253,["174"] = 254,["177"] = 258,["178"] = 258,["179"] = 258,["180"] = 258,["181"] = 263,["182"] = 264,["183"] = 264,["184"] = 264,["185"] = 264,["186"] = 264,["187"] = 204,["188"] = 270,["189"] = 271,["190"] = 273,["191"] = 274,["192"] = 275,["195"] = 279,["196"] = 279,["197"] = 279,["198"] = 279,["199"] = 284,["200"] = 285,["201"] = 285,["202"] = 285,["203"] = 285,["204"] = 285,["205"] = 204,["206"] = 291,["207"] = 292,["208"] = 294,["209"] = 295,["210"] = 296,["213"] = 300,["214"] = 300,["215"] = 300,["216"] = 300,["217"] = 305,["218"] = 306,["219"] = 306,["220"] = 306,["221"] = 306,["222"] = 306,["223"] = 204,["224"] = 312,["225"] = 313,["226"] = 313,["227"] = 313,["228"] = 313,["229"] = 315,["230"] = 316,["231"] = 317,["234"] = 321,["235"] = 321,["236"] = 321,["237"] = 321,["238"] = 326,["239"] = 327,["240"] = 327,["241"] = 327,["242"] = 327,["243"] = 327,["244"] = 204,["245"] = 333,["246"] = 334,["247"] = 340,["248"] = 341,["249"] = 342,["250"] = 204,["251"] = 344,["252"] = 348,["253"] = 348,["254"] = 348,["255"] = 349,["256"] = 349,["257"] = 350,["259"] = 351,["261"] = 349,["262"] = 348,["263"] = 348,["264"] = 354,["265"] = 354,["266"] = 354,["267"] = 354,["268"] = 204,["269"] = 359,["270"] = 360,["271"] = 204,["272"] = 362,["273"] = 363,["274"] = 364,["275"] = 365,["276"] = 366,["277"] = 368,["278"] = 369,["279"] = 370,["281"] = 372,["282"] = 373,["285"] = 376,["286"] = 377,["287"] = 378,["290"] = 381,["291"] = 382,["292"] = 383,["295"] = 386,["296"] = 387,["297"] = 388,["300"] = 391,["301"] = 204,["302"] = 204,["303"] = 395,["304"] = 395,["305"] = 397,["306"] = 398,["307"] = 399,["308"] = 401,["309"] = 402,["310"] = 403,["311"] = 404,["312"] = 404,["313"] = 404,["314"] = 404,["315"] = 407,["316"] = 408,["320"] = 395,["321"] = 395,["322"] = 415});
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
local Rewards = {
    {type = ____exports.RewardTypes.FAVOR, name = "Favor", description = "Change the effect one of your abilities."},
    {type = ____exports.RewardTypes.KNOWLEDGE, name = "Tome of Knowledge", description = "Enhances one of your existing shard effects."},
    {type = ____exports.RewardTypes.VITALITY, name = "Vitality", description = "Increases your maximun health pool."},
    {type = ____exports.RewardTypes.ITEM, name = "Item", description = "Artifacts that improves your hero powers."},
    {type = ____exports.RewardTypes.SHARD, name = "Shard", description = "Improves one of your abilities."}
}
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
            tostring(hero.unit:GetPlayerOwnerID()),
            data
        )
    end,
    ClaimRewardForHero = function(self, customNpc, reward)
        local origin = customNpc.unit:GetAbsOrigin():__add(Vector(
            RandomFloat(-1, 1) * 150,
            RandomFloat(-1, 1) * 150,
            128
        ))
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
            tostring(customNpc.unit:GetPlayerOwnerID()),
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
            tostring(customNpc.unit:GetPlayerOwnerID()),
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
            tostring(customNpc.unit:GetPlayerOwnerID()),
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
            tostring(customNpc.unit:GetPlayerOwnerID()),
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
            function(____, reward)
                local ____options_type_0
                if options.type then
                    ____options_type_0 = self:ValidateRewardType(reward, options.type)
                else
                    ____options_type_0 = true and self:ValidateReward(customNpc, reward)
                end
                return ____options_type_0
            end
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
