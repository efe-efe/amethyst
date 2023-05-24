local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 7,["21"] = 7,["22"] = 8,["23"] = 8,["24"] = 10,["27"] = 10,["31"] = 10,["33"] = 10,["34"] = 19,["35"] = 19,["36"] = 21,["37"] = 22,["38"] = 23,["39"] = 24,["40"] = 19,["41"] = 26,["42"] = 27,["43"] = 28,["44"] = 28,["45"] = 28,["47"] = 28,["49"] = 28,["50"] = 29,["51"] = 31,["52"] = 32,["53"] = 32,["54"] = 32,["55"] = 33,["56"] = 34,["57"] = 35,["59"] = 40,["60"] = 32,["61"] = 32,["62"] = 43,["63"] = 44,["64"] = 44,["67"] = 51,["68"] = 52,["70"] = 54,["71"] = 55,["73"] = 57,["74"] = 58,["76"] = 60,["77"] = 61,["79"] = 64,["80"] = 65,["81"] = 66,["82"] = 19,["83"] = 68,["84"] = 69,["85"] = 19,["86"] = 76,["87"] = 77,["88"] = 19,["89"] = 84,["90"] = 85,["91"] = 19,["92"] = 92,["93"] = 93,["94"] = 19,["95"] = 100,["96"] = 101,["97"] = 101,["98"] = 101,["99"] = 102,["100"] = 103,["102"] = 105,["103"] = 106,["105"] = 108,["106"] = 109,["108"] = 111,["109"] = 112,["111"] = 114,["112"] = 115,["114"] = 117,["115"] = 118,["117"] = 120,["118"] = 121,["120"] = 123,["121"] = 124,["123"] = 126,["124"] = 127,["126"] = 129,["127"] = 101,["128"] = 101,["129"] = 132,["130"] = 132,["131"] = 132,["132"] = 132,["133"] = 19,["134"] = 134,["135"] = 135,["136"] = 19,["137"] = 137,["138"] = 138,["139"] = 139,["141"] = 141,["142"] = 19,["143"] = 143,["144"] = 144,["145"] = 145,["147"] = 148,["148"] = 149,["149"] = 150,["151"] = 153,["152"] = 154,["155"] = 157,["156"] = 157,["157"] = 158,["158"] = 159,["159"] = 160,["160"] = 161,["162"] = 157,["165"] = 165,["166"] = 19,["167"] = 167,["168"] = 168,["169"] = 169,["171"] = 172,["172"] = 175,["174"] = 178,["175"] = 19,["176"] = 180,["177"] = 181,["178"] = 181,["179"] = 181,["180"] = 181,["181"] = 183,["182"] = 184,["184"] = 187,["185"] = 19,["186"] = 189,["187"] = 190,["188"] = 191,["190"] = 193,["191"] = 194,["193"] = 196,["194"] = 19,["195"] = 198,["196"] = 199,["197"] = 199,["198"] = 199,["199"] = 199,["200"] = 201,["201"] = 202,["203"] = 205,["204"] = 206,["206"] = 209,["207"] = 19,["208"] = 211,["209"] = 212,["210"] = 213,["213"] = 216,["214"] = 216,["215"] = 217,["216"] = 218,["217"] = 218,["218"] = 218,["219"] = 218,["220"] = 220,["221"] = 221,["223"] = 216,["226"] = 225,["227"] = 19,["228"] = 19,["229"] = 229,["230"] = 229,["231"] = 229,["232"] = 230,["233"] = 231,["234"] = 233,["235"] = 234,["236"] = 235,["237"] = 236,["238"] = 236,["239"] = 236,["240"] = 236,["241"] = 237,["242"] = 238,["246"] = 229,["247"] = 229,["248"] = 244});
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
                local upgrade = __TS__ArrayFind(
                    Upgrades,
                    function(____, currentUpgrade) return currentUpgrade.id == event.payload.upgradeId end
                )
                if upgrade then
                    ____exports.UpgradeManager:ApplyUpgrade(customNpc, upgrade)
                end
            end
        end
    end
)
____exports.default = Upgrades
return ____exports
