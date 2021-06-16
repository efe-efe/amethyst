--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 5,["12"] = 5,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 10,["21"] = 11,["24"] = 12,["27"] = 13,["30"] = 10,["31"] = 10,["32"] = 23,["33"] = 23,["34"] = 25,["35"] = 26,["36"] = 27,["37"] = 28,["38"] = 23,["39"] = 30,["40"] = 31,["41"] = 32,["42"] = 33,["43"] = 35,["44"] = 36,["45"] = 36,["46"] = 36,["47"] = 37,["48"] = 38,["49"] = 39,["51"] = 44,["52"] = 36,["53"] = 36,["54"] = 47,["55"] = 48,["56"] = 48,["57"] = 48,["58"] = 48,["61"] = 55,["62"] = 56,["64"] = 58,["65"] = 59,["67"] = 61,["68"] = 62,["70"] = 64,["71"] = 65,["73"] = 68,["74"] = 69,["75"] = 70,["76"] = 23,["77"] = 72,["78"] = 73,["79"] = 23,["80"] = 80,["81"] = 81,["82"] = 23,["83"] = 88,["84"] = 89,["85"] = 23,["86"] = 96,["87"] = 97,["88"] = 23,["89"] = 104,["90"] = 105,["91"] = 105,["92"] = 105,["93"] = 106,["94"] = 107,["96"] = 109,["97"] = 110,["99"] = 112,["100"] = 113,["102"] = 115,["103"] = 116,["105"] = 118,["106"] = 119,["108"] = 121,["109"] = 122,["111"] = 124,["112"] = 125,["114"] = 127,["115"] = 128,["117"] = 130,["118"] = 131,["120"] = 133,["121"] = 105,["122"] = 105,["123"] = 136,["124"] = 136,["125"] = 136,["126"] = 136,["127"] = 23,["128"] = 138,["129"] = 139,["130"] = 23,["131"] = 141,["132"] = 142,["133"] = 143,["135"] = 145,["136"] = 23,["137"] = 147,["138"] = 148,["139"] = 149,["141"] = 152,["142"] = 153,["143"] = 154,["145"] = 157,["146"] = 158,["149"] = 161,["150"] = 161,["151"] = 162,["152"] = 163,["153"] = 164,["154"] = 165,["156"] = 161,["159"] = 169,["160"] = 23,["161"] = 171,["162"] = 172,["163"] = 173,["165"] = 176,["166"] = 179,["168"] = 182,["169"] = 23,["170"] = 184,["171"] = 185,["172"] = 185,["173"] = 185,["174"] = 185,["175"] = 187,["176"] = 188,["178"] = 191,["179"] = 23,["180"] = 193,["181"] = 194,["182"] = 195,["184"] = 197,["185"] = 198,["187"] = 200,["188"] = 23,["189"] = 202,["190"] = 203,["191"] = 203,["192"] = 203,["193"] = 203,["194"] = 205,["195"] = 206,["197"] = 209,["198"] = 210,["200"] = 213,["201"] = 23,["202"] = 215,["203"] = 216,["204"] = 217,["207"] = 220,["208"] = 220,["209"] = 221,["210"] = 222,["211"] = 222,["212"] = 222,["213"] = 222,["214"] = 224,["215"] = 225,["217"] = 220,["220"] = 229,["221"] = 23,["222"] = 23,["223"] = 233,["224"] = 233,["225"] = 233,["226"] = 234,["227"] = 235,["228"] = 237,["229"] = 238,["230"] = 239,["231"] = 240,["232"] = 240,["233"] = 240,["234"] = 240,["235"] = 241,["236"] = 242,["240"] = 233,["241"] = 233,["242"] = 248});
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
    ClearUpgrades = function(self, customNpc)
        customNpc:ClearTable("custom_npc_favors")
        local customEvents = CustomEvents:GetInstance()
        customEvents:EmitEvent("pve:current_reward_applied", {customNpc = customNpc})
    end,
    ApplyUpgrade = function(self, customNpc, upgrade)
        if upgrade.modifier then
            local ability = ((upgrade.ability and (function() return customNpc.unit:FindAbilityByName(upgrade.ability) end)) or (function() return nil end))()
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
                __TS__ArrayPush(
                    customNpc.heroUpgrades,
                    __TS__ObjectAssign({}, upgrade, {level = 1})
                )
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
                    ____exports.UpgradeManager:ApplyUpgrade(customNpc, upgrade)
                end
            end
        end
    end
)
____exports.default = Upgrades
return ____exports
