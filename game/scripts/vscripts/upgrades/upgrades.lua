local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 8,["23"] = 10,["26"] = 10,["30"] = 10,["32"] = 10,["33"] = 19,["34"] = 19,["35"] = 21,["36"] = 22,["37"] = 23,["38"] = 24,["39"] = 19,["40"] = 26,["41"] = 27,["42"] = 28,["43"] = 28,["44"] = 29,["46"] = 30,["48"] = 28,["49"] = 31,["50"] = 38,["51"] = 39,["52"] = 39,["53"] = 39,["54"] = 40,["55"] = 41,["56"] = 42,["58"] = 47,["59"] = 39,["60"] = 39,["61"] = 50,["62"] = 51,["63"] = 51,["66"] = 58,["67"] = 59,["69"] = 61,["70"] = 62,["72"] = 64,["73"] = 65,["75"] = 67,["76"] = 68,["78"] = 71,["79"] = 72,["80"] = 73,["81"] = 19,["82"] = 75,["83"] = 76,["84"] = 19,["85"] = 83,["86"] = 84,["87"] = 19,["88"] = 91,["89"] = 92,["90"] = 19,["91"] = 99,["92"] = 100,["93"] = 19,["94"] = 107,["95"] = 111,["96"] = 111,["97"] = 111,["98"] = 112,["99"] = 113,["101"] = 115,["102"] = 116,["104"] = 118,["105"] = 119,["107"] = 121,["108"] = 122,["110"] = 124,["111"] = 125,["113"] = 127,["114"] = 128,["116"] = 130,["117"] = 131,["119"] = 134,["120"] = 137,["122"] = 140,["123"] = 143,["125"] = 145,["126"] = 111,["127"] = 111,["128"] = 148,["129"] = 148,["130"] = 148,["131"] = 148,["132"] = 19,["133"] = 153,["134"] = 154,["135"] = 19,["136"] = 156,["137"] = 160,["138"] = 161,["140"] = 163,["141"] = 19,["142"] = 165,["143"] = 169,["144"] = 170,["146"] = 173,["147"] = 174,["148"] = 175,["150"] = 178,["151"] = 179,["154"] = 182,["155"] = 182,["156"] = 183,["157"] = 184,["158"] = 186,["159"] = 187,["161"] = 182,["164"] = 191,["165"] = 19,["166"] = 193,["167"] = 197,["168"] = 198,["170"] = 201,["171"] = 206,["173"] = 209,["174"] = 19,["175"] = 211,["176"] = 215,["177"] = 215,["178"] = 215,["179"] = 215,["180"] = 219,["181"] = 220,["183"] = 223,["184"] = 19,["185"] = 225,["186"] = 226,["187"] = 227,["189"] = 229,["190"] = 230,["192"] = 232,["193"] = 19,["194"] = 234,["195"] = 238,["196"] = 238,["197"] = 238,["198"] = 238,["199"] = 242,["200"] = 243,["202"] = 246,["203"] = 247,["205"] = 250,["206"] = 19,["207"] = 252,["208"] = 256,["209"] = 257,["212"] = 260,["213"] = 260,["214"] = 261,["215"] = 262,["216"] = 262,["217"] = 262,["218"] = 262,["219"] = 266,["220"] = 267,["222"] = 260,["225"] = 271,["226"] = 19,["227"] = 19,["228"] = 275,["229"] = 275,["230"] = 277,["231"] = 278,["232"] = 279,["233"] = 281,["234"] = 282,["235"] = 283,["236"] = 284,["237"] = 284,["238"] = 284,["239"] = 284,["240"] = 287,["241"] = 288,["245"] = 275,["246"] = 275,["247"] = 295});
local ____exports = {}
local ____items = require("upgrades.items")
local Items = ____items.default
local ____shards = require("upgrades.shards")
local Shards = ____shards.default
local ____favors = require("upgrades.favors")
local Favors = ____favors.default
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local ____math = require("util.math")
local Math = ____math.default
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
local ____array_0 = __TS__SparseArrayNew(unpack(Items))
__TS__SparseArrayPush(
    ____array_0,
    unpack(Shards)
)
__TS__SparseArrayPush(
    ____array_0,
    unpack(Favors)
)
local Upgrades = {__TS__SparseArraySpread(____array_0)}
____exports.UpgradeManager = {
    Upgrades = Upgrades,
    ClearUpgrades = function(self, customNpc)
        customNpc:ClearTable("custom_npc_favors")
        local customEvents = CustomEvents:GetInstance()
        customEvents:EmitEvent("pve:current_reward_applied", {customNpc = customNpc})
    end,
    ApplyUpgrade = function(self, customNpc, upgrade)
        if upgrade.modifier then
            local ____upgrade_ability_1
            if upgrade.ability then
                ____upgrade_ability_1 = customNpc.unit:FindAbilityByName(upgrade.ability)
            else
                ____upgrade_ability_1 = nil
            end
            local ability = ____upgrade_ability_1
            customNpc.unit:AddNewModifier(customNpc.unit, ability, upgrade.modifier.name, {duration = upgrade.modifier.duration})
            local found = false
            customNpc.heroUpgrades = __TS__ArrayMap(
                customNpc.heroUpgrades,
                function(____, heroUpgrade)
                    if heroUpgrade.id == upgrade.id then
                        found = true
                        return __TS__ObjectAssign({}, heroUpgrade, {level = heroUpgrade.level + 1})
                    end
                    return heroUpgrade
                end
            )
            if not found then
                local ____customNpc_heroUpgrades_2 = customNpc.heroUpgrades
                ____customNpc_heroUpgrades_2[#____customNpc_heroUpgrades_2 + 1] = __TS__ObjectAssign({}, upgrade, {level = 1})
            end
        end
        if upgrade.effect then
            upgrade:effect(customNpc.unit)
        end
        if upgrade.type == UpgradeTypes.ITEM then
            customNpc:ApplyItem(upgrade)
        end
        if upgrade.type == UpgradeTypes.FAVOR then
            customNpc:ApplyFavor(upgrade)
        end
        if upgrade.type == UpgradeTypes.SHARD then
            customNpc:ApplyShard(upgrade)
        end
        local customEvents = CustomEvents:GetInstance()
        customEvents:EmitEvent("pve:current_reward_applied", {customNpc = customNpc})
        self:ClearUpgrades(customNpc)
    end,
    GenerateFavors = function(self, customNpc, amount)
        return self:GenerateUpgrades(customNpc, {amount = amount, type = UpgradeTypes.FAVOR, allowDuplicates = false, existingOnly = false})
    end,
    GenerateShards = function(self, customNpc, amount)
        return self:GenerateUpgrades(customNpc, {amount = amount, type = UpgradeTypes.SHARD, allowDuplicates = false, existingOnly = false})
    end,
    GenerateKnowledge = function(self, customNpc, amount)
        return self:GenerateUpgrades(customNpc, {amount = amount, type = UpgradeTypes.SHARD, allowDuplicates = true, existingOnly = true})
    end,
    GenerateItems = function(self, customNpc, amount)
        return self:GenerateUpgrades(customNpc, {amount = amount, type = UpgradeTypes.ITEM, allowDuplicates = false, existingOnly = false})
    end,
    GenerateUpgrades = function(self, customNpc, options)
        local upgrades = __TS__ArrayFilter(
            Upgrades,
            function(____, upgrade)
                if not self:ValidateUpgradeType(upgrade, options.type) then
                    return false
                end
                if not self:ValidateUpgradeHero(customNpc, upgrade) then
                    return false
                end
                if not self:ValidateUpgradeAbility(customNpc, upgrade) then
                    return false
                end
                if not self:ValidateUpgradeAttackCapabilities(customNpc, upgrade) then
                    return false
                end
                if not self:ValidateUpgradeStacks(customNpc, upgrade) then
                    return false
                end
                if not self:ValidateUpgradeLevel(upgrade) then
                    return false
                end
                if not self:ValidateUpgradeIngredients(customNpc, upgrade) then
                    return false
                end
                if not options.allowDuplicates and self:ValidateUpgradeAlreadyExists(customNpc, upgrade) then
                    return false
                end
                if options.existingOnly and not self:ValidateUpgradeAlreadyExists(customNpc, upgrade) then
                    return false
                end
                return true
            end
        )
        return Math:GetRandomElementsFromArray(
            upgrades,
            Clamp(options.amount, #upgrades, 0)
        )
    end,
    ValidateUpgradeType = function(____, upgrade, ____type)
        return upgrade.type == ____type
    end,
    ValidateUpgradeHero = function(____, customNpc, upgrade)
        if not upgrade.hero then
            return true
        end
        return upgrade.hero == customNpc.unit:GetName()
    end,
    ValidateUpgradeAbility = function(____, customNpc, upgrade)
        if not upgrade.ability then
            return true
        end
        local ability = customNpc.unit:FindAbilityByName(upgrade.ability)
        if not ability or ability:GetLevel() == 0 then
            return false
        end
        if not upgrade.secondaryAbilities then
            return true
        end
        do
            local i = 0
            while i < #upgrade.secondaryAbilities do
                local secondaryAbilityName = upgrade.secondaryAbilities[i + 1]
                local secondaryAbility = customNpc.unit:FindAbilityByName(secondaryAbilityName)
                if not secondaryAbility or secondaryAbility:GetLevel() == 0 then
                    return false
                end
                i = i + 1
            end
        end
        return true
    end,
    ValidateUpgradeAttackCapabilities = function(____, customNpc, upgrade)
        if not upgrade.attackCapability then
            return true
        end
        if upgrade.attackCapability == DOTA_UNIT_CAP_MELEE_ATTACK and not customNpc:IsMeele() or upgrade.attackCapability == DOTA_UNIT_CAP_RANGED_ATTACK and not customNpc:IsRanged() then
            return false
        end
        return true
    end,
    ValidateUpgradeAlreadyExists = function(____, customNpc, upgrade)
        local heroUpgrade = __TS__ArrayFilter(
            customNpc.heroUpgrades,
            function(____, heroUpgrade) return heroUpgrade.id == upgrade.id end
        )[1]
        if not heroUpgrade then
            return false
        end
        return true
    end,
    ValidateUpgradeLevel = function(____, upgrade)
        if not upgrade.minLevel then
            return true
        end
        if GameRules.Addon.currentRoom < upgrade.minLevel - 1 then
            return false
        end
        return true
    end,
    ValidateUpgradeStacks = function(____, customNpc, upgrade)
        local heroUpgrade = __TS__ArrayFilter(
            customNpc.heroUpgrades,
            function(____, heroUpgrade) return heroUpgrade.id == upgrade.id end
        )[1]
        if not heroUpgrade then
            return true
        end
        if heroUpgrade.level >= upgrade.maxStacks then
            return false
        end
        return true
    end,
    ValidateUpgradeIngredients = function(____, customNpc, upgrade)
        if not upgrade.ingredients then
            return true
        end
        do
            local i = 0
            while i < #upgrade.ingredients do
                local ingredientId = upgrade.ingredients[i + 1]
                local heroUpgrade = __TS__ArrayFilter(
                    customNpc.heroUpgrades,
                    function(____, heroUpgrade) return heroUpgrade.id == ingredientId end
                )[1]
                if not heroUpgrade then
                    return false
                end
                i = i + 1
            end
        end
        return true
    end
}
CustomGameEventManager:RegisterListener(
    "custom_npc:apply_favor",
    function(eventSourceIndex, event)
        local playerId = event.playerIndex
        local player = GameRules.Addon:FindPlayerById(playerId)
        if player then
            local customNpc = player.customNpc
            if customNpc then
                local upgrade = __TS__ArrayFilter(
                    Upgrades,
                    function(____, currentUpgrade) return currentUpgrade.id == event.payload.upgradeId end
                )[1]
                if upgrade then
                    ____exports.UpgradeManager:ApplyUpgrade(customNpc, upgrade)
                end
            end
        end
    end
)
____exports.default = Upgrades
return ____exports
