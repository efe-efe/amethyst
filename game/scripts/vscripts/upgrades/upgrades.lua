local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 8,["23"] = 10,["26"] = 10,["30"] = 10,["32"] = 10,["33"] = 19,["34"] = 19,["35"] = 21,["36"] = 22,["37"] = 23,["38"] = 24,["39"] = 19,["40"] = 26,["41"] = 27,["42"] = 28,["43"] = 28,["44"] = 28,["46"] = 28,["48"] = 28,["49"] = 29,["50"] = 31,["51"] = 32,["52"] = 32,["53"] = 32,["54"] = 33,["55"] = 34,["56"] = 35,["58"] = 40,["59"] = 32,["60"] = 32,["61"] = 43,["62"] = 44,["63"] = 44,["66"] = 51,["67"] = 52,["69"] = 54,["70"] = 55,["72"] = 57,["73"] = 58,["75"] = 60,["76"] = 61,["78"] = 64,["79"] = 65,["80"] = 66,["81"] = 19,["82"] = 68,["83"] = 69,["84"] = 19,["85"] = 76,["86"] = 77,["87"] = 19,["88"] = 84,["89"] = 85,["90"] = 19,["91"] = 92,["92"] = 93,["93"] = 19,["94"] = 100,["95"] = 101,["96"] = 101,["97"] = 101,["98"] = 102,["99"] = 103,["101"] = 105,["102"] = 106,["104"] = 108,["105"] = 109,["107"] = 111,["108"] = 112,["110"] = 114,["111"] = 115,["113"] = 117,["114"] = 118,["116"] = 120,["117"] = 121,["119"] = 123,["120"] = 124,["122"] = 126,["123"] = 127,["125"] = 129,["126"] = 101,["127"] = 101,["128"] = 132,["129"] = 132,["130"] = 132,["131"] = 132,["132"] = 19,["133"] = 134,["134"] = 135,["135"] = 19,["136"] = 137,["137"] = 138,["138"] = 139,["140"] = 141,["141"] = 19,["142"] = 143,["143"] = 144,["144"] = 145,["146"] = 148,["147"] = 149,["148"] = 150,["150"] = 153,["151"] = 154,["154"] = 157,["155"] = 157,["156"] = 158,["157"] = 159,["158"] = 160,["159"] = 161,["161"] = 157,["164"] = 165,["165"] = 19,["166"] = 167,["167"] = 168,["168"] = 169,["170"] = 172,["171"] = 175,["173"] = 178,["174"] = 19,["175"] = 180,["176"] = 181,["177"] = 181,["178"] = 181,["179"] = 181,["180"] = 183,["181"] = 184,["183"] = 187,["184"] = 19,["185"] = 189,["186"] = 190,["187"] = 191,["189"] = 193,["190"] = 194,["192"] = 196,["193"] = 19,["194"] = 198,["195"] = 199,["196"] = 199,["197"] = 199,["198"] = 199,["199"] = 201,["200"] = 202,["202"] = 205,["203"] = 206,["205"] = 209,["206"] = 19,["207"] = 211,["208"] = 212,["209"] = 213,["212"] = 216,["213"] = 216,["214"] = 217,["215"] = 218,["216"] = 218,["217"] = 218,["218"] = 218,["219"] = 220,["220"] = 221,["222"] = 216,["225"] = 225,["226"] = 19,["227"] = 19,["228"] = 229,["229"] = 229,["230"] = 229,["231"] = 230,["232"] = 231,["233"] = 233,["234"] = 234,["235"] = 235,["236"] = 236,["237"] = 236,["238"] = 236,["239"] = 236,["240"] = 237,["241"] = 238,["245"] = 229,["246"] = 229,["247"] = 244});
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
