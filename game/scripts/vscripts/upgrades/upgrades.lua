--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 5,["12"] = 5,["13"] = 7,["14"] = 7,["15"] = 9,["19"] = 10,["22"] = 11,["25"] = 12,["28"] = 9,["29"] = 9,["30"] = 22,["31"] = 22,["32"] = 24,["33"] = 25,["34"] = 22,["35"] = 32,["36"] = 33,["37"] = 22,["38"] = 40,["39"] = 41,["40"] = 22,["41"] = 48,["42"] = 49,["43"] = 22,["44"] = 56,["45"] = 57,["46"] = 57,["47"] = 57,["48"] = 58,["49"] = 59,["51"] = 61,["52"] = 62,["54"] = 64,["55"] = 65,["57"] = 67,["58"] = 68,["60"] = 70,["61"] = 71,["63"] = 73,["64"] = 74,["66"] = 76,["67"] = 77,["69"] = 79,["70"] = 80,["72"] = 82,["73"] = 83,["75"] = 85,["76"] = 57,["77"] = 57,["78"] = 88,["79"] = 88,["80"] = 88,["81"] = 88,["82"] = 22,["83"] = 90,["84"] = 91,["85"] = 22,["86"] = 93,["87"] = 94,["88"] = 95,["90"] = 97,["91"] = 22,["92"] = 99,["93"] = 100,["94"] = 101,["96"] = 104,["97"] = 105,["98"] = 106,["100"] = 109,["101"] = 110,["104"] = 113,["105"] = 113,["106"] = 114,["107"] = 115,["108"] = 116,["109"] = 117,["111"] = 113,["114"] = 121,["115"] = 22,["116"] = 123,["117"] = 124,["118"] = 125,["120"] = 128,["121"] = 131,["123"] = 134,["124"] = 22,["125"] = 136,["126"] = 137,["127"] = 137,["128"] = 137,["129"] = 137,["130"] = 139,["131"] = 140,["133"] = 143,["134"] = 22,["135"] = 145,["136"] = 146,["137"] = 147,["139"] = 149,["140"] = 150,["142"] = 152,["143"] = 22,["144"] = 154,["145"] = 155,["146"] = 155,["147"] = 155,["148"] = 155,["149"] = 157,["150"] = 158,["152"] = 161,["153"] = 162,["155"] = 165,["156"] = 22,["157"] = 167,["158"] = 168,["159"] = 169,["162"] = 172,["163"] = 172,["164"] = 173,["165"] = 174,["166"] = 174,["167"] = 174,["168"] = 174,["169"] = 176,["170"] = 177,["172"] = 172,["175"] = 181,["176"] = 22,["177"] = 22,["178"] = 185,["179"] = 185,["180"] = 185,["181"] = 186,["182"] = 187,["183"] = 189,["184"] = 190,["185"] = 191,["186"] = 192,["187"] = 192,["188"] = 192,["189"] = 192,["190"] = 193,["191"] = 194,["195"] = 185,["196"] = 185,["197"] = 200});
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
local Upgrades = {
    unpack(
        __TS__ArrayConcat(
            {
                unpack(Items)
            },
            {
                unpack(Shards)
            },
            {
                unpack(Favors)
            }
        )
    )
}
____exports.UpgradeManager = {
    Upgrades = Upgrades,
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
                if (not options.allowDuplicates) and self:ValidateUpgradeAlreadyExists(customNpc, upgrade) then
                    return false
                end
                if options.existingOnly and (not self:ValidateUpgradeAlreadyExists(customNpc, upgrade)) then
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
        if (not ability) or (ability:GetLevel() == 0) then
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
                if (not secondaryAbility) or (secondaryAbility:GetLevel() == 0) then
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
        if ((upgrade.attackCapability == DOTA_UNIT_CAP_MELEE_ATTACK) and (not customNpc:IsMeele())) or ((upgrade.attackCapability == DOTA_UNIT_CAP_RANGED_ATTACK) and (not customNpc:IsRanged())) then
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
        if GameRules.Addon.currentRoom < (upgrade.minLevel - 1) then
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
                    customNpc:ApplyFavor(upgrade)
                end
            end
        end
    end
)
____exports.default = Upgrades
return ____exports
