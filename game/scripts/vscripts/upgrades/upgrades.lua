--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 7,["12"] = 7,["13"] = 9,["17"] = 10,["20"] = 11,["23"] = 12,["26"] = 9,["27"] = 9,["28"] = 22,["29"] = 22,["30"] = 24,["31"] = 25,["32"] = 25,["33"] = 25,["34"] = 26,["35"] = 27,["37"] = 29,["38"] = 30,["40"] = 32,["41"] = 33,["43"] = 35,["44"] = 36,["46"] = 38,["47"] = 39,["49"] = 41,["50"] = 42,["52"] = 44,["53"] = 45,["55"] = 47,["56"] = 48,["58"] = 50,["59"] = 25,["60"] = 25,["61"] = 53,["62"] = 53,["63"] = 53,["64"] = 53,["65"] = 22,["66"] = 55,["67"] = 56,["68"] = 22,["69"] = 58,["70"] = 59,["71"] = 60,["73"] = 62,["74"] = 22,["75"] = 64,["76"] = 65,["77"] = 66,["79"] = 69,["80"] = 70,["81"] = 71,["83"] = 74,["84"] = 22,["85"] = 76,["86"] = 77,["87"] = 78,["89"] = 81,["90"] = 84,["92"] = 87,["93"] = 22,["94"] = 89,["95"] = 90,["96"] = 90,["97"] = 90,["98"] = 90,["99"] = 92,["100"] = 93,["102"] = 96,["103"] = 22,["104"] = 98,["105"] = 99,["106"] = 100,["108"] = 102,["109"] = 103,["111"] = 105,["112"] = 22,["113"] = 107,["114"] = 108,["115"] = 108,["116"] = 108,["117"] = 108,["118"] = 110,["119"] = 111,["121"] = 114,["122"] = 115,["124"] = 118,["125"] = 22,["126"] = 22,["127"] = 122,["128"] = 122,["129"] = 122,["130"] = 123,["131"] = 124,["132"] = 126,["133"] = 127,["134"] = 128,["135"] = 129,["136"] = 129,["137"] = 129,["138"] = 129,["139"] = 130,["140"] = 131,["144"] = 122,["145"] = 122,["146"] = 137});
local ____exports = {}
local ____items = require("upgrades.items")
local Items = ____items.default
local ____shards = require("upgrades.shards")
local Shards = ____shards.default
local ____favors = require("upgrades.favors")
local Favors = ____favors.default
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
