--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 5,["12"] = 5,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 10,["21"] = 10,["24"] = 10,["27"] = 10,["30"] = 10,["31"] = 10,["32"] = 19,["33"] = 19,["34"] = 21,["35"] = 22,["36"] = 23,["37"] = 24,["38"] = 19,["39"] = 26,["40"] = 27,["41"] = 28,["42"] = 31,["43"] = 38,["44"] = 39,["45"] = 39,["46"] = 39,["47"] = 40,["48"] = 41,["49"] = 42,["51"] = 47,["52"] = 39,["53"] = 39,["54"] = 50,["55"] = 51,["56"] = 51,["57"] = 51,["58"] = 51,["61"] = 58,["62"] = 59,["64"] = 61,["65"] = 62,["67"] = 64,["68"] = 65,["70"] = 67,["71"] = 68,["73"] = 71,["74"] = 72,["75"] = 73,["76"] = 19,["77"] = 75,["78"] = 76,["79"] = 19,["80"] = 83,["81"] = 84,["82"] = 19,["83"] = 91,["84"] = 92,["85"] = 19,["86"] = 99,["87"] = 100,["88"] = 19,["89"] = 107,["90"] = 111,["91"] = 111,["92"] = 111,["93"] = 112,["94"] = 113,["96"] = 115,["97"] = 116,["99"] = 118,["100"] = 119,["102"] = 121,["103"] = 122,["105"] = 124,["106"] = 125,["108"] = 127,["109"] = 128,["111"] = 130,["112"] = 131,["114"] = 134,["115"] = 137,["117"] = 140,["118"] = 143,["120"] = 145,["121"] = 111,["122"] = 111,["123"] = 148,["124"] = 148,["125"] = 148,["126"] = 148,["127"] = 19,["128"] = 153,["129"] = 154,["130"] = 19,["131"] = 156,["132"] = 160,["133"] = 161,["135"] = 163,["136"] = 19,["137"] = 165,["138"] = 169,["139"] = 170,["141"] = 173,["142"] = 174,["143"] = 175,["145"] = 178,["146"] = 179,["149"] = 182,["150"] = 182,["151"] = 183,["152"] = 184,["153"] = 186,["154"] = 187,["156"] = 182,["159"] = 191,["160"] = 19,["161"] = 193,["162"] = 197,["163"] = 198,["165"] = 201,["166"] = 206,["168"] = 209,["169"] = 19,["170"] = 211,["171"] = 215,["172"] = 215,["173"] = 215,["174"] = 215,["175"] = 219,["176"] = 220,["178"] = 223,["179"] = 19,["180"] = 225,["181"] = 226,["182"] = 227,["184"] = 229,["185"] = 230,["187"] = 232,["188"] = 19,["189"] = 234,["190"] = 238,["191"] = 238,["192"] = 238,["193"] = 238,["194"] = 242,["195"] = 243,["197"] = 246,["198"] = 247,["200"] = 250,["201"] = 19,["202"] = 252,["203"] = 256,["204"] = 257,["207"] = 260,["208"] = 260,["209"] = 261,["210"] = 262,["211"] = 262,["212"] = 262,["213"] = 262,["214"] = 266,["215"] = 267,["217"] = 260,["220"] = 271,["221"] = 19,["222"] = 19,["223"] = 275,["224"] = 275,["225"] = 277,["226"] = 278,["227"] = 279,["228"] = 281,["229"] = 282,["230"] = 283,["231"] = 284,["232"] = 284,["233"] = 284,["234"] = 284,["235"] = 287,["236"] = 288,["240"] = 275,["241"] = 275,["242"] = 295});
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
