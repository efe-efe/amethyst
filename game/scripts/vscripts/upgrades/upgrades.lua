--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 5,["12"] = 5,["13"] = 7,["14"] = 7,["15"] = 9,["19"] = 10,["22"] = 11,["25"] = 12,["28"] = 9,["29"] = 9,["30"] = 22,["31"] = 22,["32"] = 24,["33"] = 25,["34"] = 22,["35"] = 32,["36"] = 33,["37"] = 22,["38"] = 40,["39"] = 41,["40"] = 22,["41"] = 48,["42"] = 49,["43"] = 22,["44"] = 56,["45"] = 57,["46"] = 57,["47"] = 57,["48"] = 58,["49"] = 59,["51"] = 61,["52"] = 62,["54"] = 64,["55"] = 65,["57"] = 67,["58"] = 68,["60"] = 70,["61"] = 71,["63"] = 73,["64"] = 74,["66"] = 76,["67"] = 77,["69"] = 79,["70"] = 80,["72"] = 82,["73"] = 57,["74"] = 57,["75"] = 85,["76"] = 85,["77"] = 85,["78"] = 85,["79"] = 22,["80"] = 87,["81"] = 88,["82"] = 22,["83"] = 90,["84"] = 91,["85"] = 92,["87"] = 94,["88"] = 22,["89"] = 96,["90"] = 97,["91"] = 98,["93"] = 101,["94"] = 102,["95"] = 103,["97"] = 106,["98"] = 22,["99"] = 108,["100"] = 109,["101"] = 110,["103"] = 113,["104"] = 116,["106"] = 119,["107"] = 22,["108"] = 121,["109"] = 122,["110"] = 122,["111"] = 122,["112"] = 122,["113"] = 124,["114"] = 125,["116"] = 128,["117"] = 22,["118"] = 130,["119"] = 131,["120"] = 132,["122"] = 134,["123"] = 135,["125"] = 137,["126"] = 22,["127"] = 139,["128"] = 140,["129"] = 140,["130"] = 140,["131"] = 140,["132"] = 142,["133"] = 143,["135"] = 146,["136"] = 147,["138"] = 150,["139"] = 22,["140"] = 22,["141"] = 154,["142"] = 154,["143"] = 154,["144"] = 155,["145"] = 156,["146"] = 158,["147"] = 159,["148"] = 160,["149"] = 161,["150"] = 161,["151"] = 161,["152"] = 161,["153"] = 162,["154"] = 163,["158"] = 154,["159"] = 154,["160"] = 169});
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
