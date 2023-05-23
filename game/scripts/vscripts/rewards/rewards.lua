local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 2,["12"] = 2,["13"] = 4,["14"] = 4,["15"] = 5,["16"] = 5,["17"] = 6,["18"] = 6,["19"] = 18,["20"] = 19,["21"] = 19,["22"] = 20,["23"] = 20,["24"] = 21,["25"] = 21,["26"] = 22,["27"] = 22,["28"] = 23,["29"] = 23,["30"] = 24,["31"] = 24,["32"] = 25,["33"] = 25,["34"] = 28,["35"] = 28,["36"] = 28,["37"] = 28,["38"] = 28,["39"] = 28,["40"] = 28,["41"] = 66,["42"] = 66,["43"] = 66,["44"] = 68,["45"] = 66,["46"] = 69,["47"] = 69,["48"] = 69,["49"] = 69,["50"] = 74,["51"] = 68,["52"] = 77,["53"] = 78,["54"] = 79,["55"] = 80,["56"] = 81,["57"] = 81,["58"] = 81,["59"] = 81,["60"] = 81,["61"] = 81,["62"] = 81,["63"] = 81,["64"] = 81,["65"] = 85,["66"] = 88,["67"] = 91,["68"] = 92,["69"] = 92,["70"] = 92,["71"] = 92,["72"] = 92,["73"] = 92,["74"] = 92,["75"] = 92,["76"] = 92,["77"] = 77,["78"] = 98,["79"] = 98,["80"] = 102,["81"] = 102,["82"] = 102,["83"] = 103,["84"] = 102,["85"] = 103,["86"] = 110,["87"] = 102,["88"] = 112,["89"] = 110,["90"] = 116,["91"] = 116,["92"] = 116,["93"] = 117,["94"] = 116,["95"] = 117,["96"] = 124,["97"] = 116,["98"] = 126,["99"] = 124,["100"] = 130,["101"] = 130,["102"] = 130,["103"] = 131,["104"] = 130,["105"] = 131,["106"] = 138,["107"] = 130,["108"] = 140,["109"] = 138,["110"] = 144,["111"] = 144,["112"] = 144,["113"] = 145,["114"] = 144,["115"] = 145,["116"] = 152,["117"] = 144,["118"] = 154,["119"] = 152,["120"] = 158,["121"] = 158,["122"] = 158,["123"] = 159,["124"] = 158,["125"] = 159,["126"] = 166,["127"] = 158,["128"] = 168,["129"] = 166,["130"] = 172,["131"] = 172,["132"] = 174,["133"] = 175,["134"] = 176,["137"] = 180,["138"] = 180,["139"] = 180,["140"] = 180,["141"] = 185,["142"] = 185,["143"] = 185,["144"] = 185,["145"] = 185,["146"] = 172,["147"] = 187,["148"] = 188,["149"] = 188,["150"] = 188,["151"] = 188,["152"] = 188,["153"] = 189,["154"] = 191,["155"] = 192,["157"] = 194,["158"] = 195,["160"] = 197,["161"] = 198,["163"] = 200,["164"] = 201,["166"] = 203,["167"] = 204,["169"] = 206,["170"] = 172,["171"] = 208,["172"] = 209,["173"] = 211,["174"] = 212,["175"] = 213,["178"] = 217,["179"] = 217,["180"] = 217,["181"] = 217,["182"] = 222,["183"] = 223,["184"] = 223,["185"] = 223,["186"] = 223,["187"] = 223,["188"] = 172,["189"] = 225,["190"] = 226,["191"] = 228,["192"] = 229,["193"] = 230,["196"] = 234,["197"] = 234,["198"] = 234,["199"] = 234,["200"] = 239,["201"] = 240,["202"] = 240,["203"] = 240,["204"] = 240,["205"] = 240,["206"] = 172,["207"] = 242,["208"] = 243,["209"] = 245,["210"] = 246,["211"] = 247,["214"] = 251,["215"] = 251,["216"] = 251,["217"] = 251,["218"] = 256,["219"] = 257,["220"] = 257,["221"] = 257,["222"] = 257,["223"] = 257,["224"] = 172,["225"] = 259,["226"] = 260,["227"] = 260,["228"] = 260,["229"] = 260,["230"] = 262,["231"] = 263,["232"] = 264,["235"] = 268,["236"] = 268,["237"] = 268,["238"] = 268,["239"] = 273,["240"] = 274,["241"] = 274,["242"] = 274,["243"] = 274,["244"] = 274,["245"] = 172,["246"] = 276,["247"] = 277,["248"] = 278,["249"] = 279,["250"] = 280,["251"] = 172,["252"] = 282,["253"] = 283,["254"] = 283,["255"] = 283,["256"] = 284,["257"] = 284,["258"] = 284,["260"] = 284,["262"] = 284,["263"] = 283,["264"] = 283,["265"] = 287,["266"] = 287,["267"] = 287,["268"] = 287,["269"] = 172,["270"] = 289,["271"] = 290,["272"] = 172,["273"] = 292,["274"] = 293,["275"] = 294,["276"] = 295,["277"] = 296,["278"] = 298,["279"] = 299,["280"] = 300,["282"] = 302,["283"] = 303,["286"] = 306,["287"] = 307,["288"] = 308,["291"] = 311,["292"] = 312,["293"] = 313,["296"] = 316,["297"] = 317,["298"] = 318,["301"] = 321,["302"] = 172,["303"] = 172,["304"] = 325,["305"] = 325,["306"] = 325,["307"] = 326,["308"] = 327,["309"] = 329,["310"] = 330,["311"] = 331,["312"] = 332,["313"] = 332,["314"] = 332,["315"] = 332,["316"] = 333,["317"] = 334,["321"] = 325,["322"] = 325,["323"] = 340});
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
