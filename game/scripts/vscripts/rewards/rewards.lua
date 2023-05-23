local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 2,["12"] = 2,["13"] = 6,["14"] = 6,["15"] = 7,["16"] = 7,["17"] = 8,["18"] = 8,["19"] = 20,["20"] = 21,["21"] = 21,["22"] = 22,["23"] = 22,["24"] = 23,["25"] = 23,["26"] = 24,["27"] = 24,["28"] = 25,["29"] = 25,["30"] = 26,["31"] = 26,["32"] = 27,["33"] = 27,["34"] = 30,["35"] = 30,["36"] = 30,["37"] = 30,["38"] = 30,["39"] = 30,["40"] = 30,["41"] = 68,["42"] = 68,["43"] = 68,["44"] = 71,["45"] = 68,["46"] = 75,["47"] = 75,["48"] = 75,["49"] = 75,["50"] = 80,["51"] = 70,["52"] = 83,["53"] = 84,["54"] = 85,["55"] = 86,["56"] = 92,["57"] = 92,["58"] = 92,["59"] = 92,["60"] = 96,["61"] = 96,["62"] = 96,["63"] = 92,["64"] = 92,["65"] = 101,["66"] = 107,["67"] = 113,["68"] = 119,["69"] = 119,["70"] = 119,["71"] = 119,["72"] = 123,["73"] = 123,["74"] = 123,["75"] = 119,["76"] = 119,["77"] = 83,["78"] = 130,["79"] = 130,["80"] = 134,["81"] = 134,["82"] = 134,["83"] = 135,["84"] = 134,["85"] = 135,["86"] = 142,["87"] = 134,["88"] = 144,["89"] = 142,["90"] = 148,["91"] = 148,["92"] = 148,["93"] = 149,["94"] = 148,["95"] = 149,["96"] = 156,["97"] = 148,["98"] = 158,["99"] = 156,["100"] = 162,["101"] = 162,["102"] = 162,["103"] = 163,["104"] = 162,["105"] = 163,["106"] = 170,["107"] = 162,["108"] = 172,["109"] = 170,["110"] = 176,["111"] = 176,["112"] = 176,["113"] = 177,["114"] = 176,["115"] = 177,["116"] = 184,["117"] = 176,["118"] = 186,["119"] = 184,["120"] = 190,["121"] = 190,["122"] = 190,["123"] = 191,["124"] = 190,["125"] = 191,["126"] = 198,["127"] = 190,["128"] = 200,["129"] = 198,["130"] = 204,["131"] = 204,["132"] = 206,["133"] = 207,["134"] = 208,["137"] = 212,["138"] = 212,["139"] = 212,["140"] = 212,["141"] = 217,["142"] = 217,["143"] = 217,["144"] = 217,["145"] = 217,["146"] = 204,["147"] = 223,["148"] = 227,["149"] = 229,["150"] = 229,["151"] = 229,["152"] = 227,["153"] = 230,["154"] = 232,["155"] = 233,["157"] = 235,["158"] = 236,["160"] = 238,["161"] = 239,["163"] = 241,["164"] = 242,["166"] = 244,["167"] = 245,["169"] = 247,["170"] = 204,["171"] = 249,["172"] = 250,["173"] = 252,["174"] = 253,["175"] = 254,["178"] = 258,["179"] = 258,["180"] = 258,["181"] = 258,["182"] = 263,["183"] = 264,["184"] = 264,["185"] = 264,["186"] = 264,["187"] = 264,["188"] = 204,["189"] = 270,["190"] = 271,["191"] = 273,["192"] = 274,["193"] = 275,["196"] = 279,["197"] = 279,["198"] = 279,["199"] = 279,["200"] = 284,["201"] = 285,["202"] = 285,["203"] = 285,["204"] = 285,["205"] = 285,["206"] = 204,["207"] = 291,["208"] = 292,["209"] = 294,["210"] = 295,["211"] = 296,["214"] = 300,["215"] = 300,["216"] = 300,["217"] = 300,["218"] = 305,["219"] = 306,["220"] = 306,["221"] = 306,["222"] = 306,["223"] = 306,["224"] = 204,["225"] = 312,["226"] = 313,["227"] = 313,["228"] = 313,["229"] = 313,["230"] = 315,["231"] = 316,["232"] = 317,["235"] = 321,["236"] = 321,["237"] = 321,["238"] = 321,["239"] = 326,["240"] = 327,["241"] = 327,["242"] = 327,["243"] = 327,["244"] = 327,["245"] = 204,["246"] = 333,["247"] = 334,["248"] = 340,["249"] = 341,["250"] = 342,["251"] = 204,["252"] = 344,["253"] = 348,["254"] = 348,["255"] = 348,["256"] = 349,["257"] = 349,["258"] = 350,["260"] = 351,["262"] = 349,["263"] = 348,["264"] = 348,["265"] = 354,["266"] = 354,["267"] = 354,["268"] = 354,["269"] = 204,["270"] = 359,["271"] = 360,["272"] = 204,["273"] = 362,["274"] = 363,["275"] = 364,["276"] = 365,["277"] = 366,["278"] = 368,["279"] = 369,["280"] = 370,["282"] = 372,["283"] = 373,["286"] = 376,["287"] = 377,["288"] = 378,["291"] = 381,["292"] = 382,["293"] = 383,["296"] = 386,["297"] = 387,["298"] = 388,["301"] = 391,["302"] = 204,["303"] = 204,["304"] = 395,["305"] = 395,["306"] = 397,["307"] = 398,["308"] = 399,["309"] = 401,["310"] = 402,["311"] = 403,["312"] = 404,["313"] = 404,["314"] = 404,["315"] = 404,["316"] = 407,["317"] = 408,["321"] = 395,["322"] = 395,["323"] = 415});
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
                local reward = __TS__ArrayFind(
                    Rewards,
                    function(____, reward) return reward.type == event.payload.type end
                )
                if reward then
                    customNpc:SelectReward(reward)
                end
            end
        end
    end
)
____exports.default = Rewards
return ____exports
