local ____lualib = require("lualib_bundle")
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["19"] = 4,["20"] = 4,["21"] = 8,["22"] = 8,["23"] = 87,["24"] = 88,["25"] = 87,["26"] = 91,["27"] = 92,["28"] = 91,["29"] = 100,["30"] = 101,["31"] = 100,["32"] = 107,["33"] = 108,["34"] = 107,["35"] = 114,["36"] = 115,["37"] = 114,["38"] = 121,["39"] = 121,["40"] = 121,["42"] = 122,["43"] = 121,["44"] = 129,["45"] = 130,["46"] = 129,["47"] = 136,["48"] = 137,["49"] = 138,["50"] = 140,["51"] = 141,["52"] = 143,["53"] = 145,["54"] = 146,["55"] = 148,["56"] = 149,["57"] = 150,["59"] = 148,["60"] = 157,["61"] = 158,["62"] = 160,["63"] = 161,["65"] = 163,["67"] = 157,["68"] = 167,["70"] = 168,["71"] = 169,["74"] = 170,["75"] = 171,["79"] = 175,["82"] = 178,["86"] = 182,["89"] = 183,["90"] = 184,["91"] = 184,["92"] = 184,["93"] = 184,["98"] = 190,["105"] = 196,["109"] = 201,["110"] = 202,["111"] = 218,["112"] = 219,["114"] = 238,["115"] = 238,["116"] = 239,["117"] = 240,["118"] = 241,["123"] = 247,["124"] = 248,["127"] = 145,["128"] = 253,["129"] = 255,["132"] = 257,["133"] = 258,["134"] = 259,["135"] = 261,["136"] = 263,["137"] = 264,["139"] = 266,["142"] = 270,["143"] = 257,["144"] = 273,["145"] = 274,["146"] = 275,["147"] = 275,["148"] = 277,["150"] = 273,["151"] = 281,["152"] = 282,["153"] = 283,["154"] = 283,["155"] = 285,["156"] = 286,["157"] = 287,["161"] = 281,["162"] = 293,["163"] = 304,["164"] = 304,["165"] = 305,["166"] = 306,["168"] = 308,["169"] = 310,["170"] = 311,["172"] = 314,["175"] = 318,["176"] = 319,["177"] = 320,["179"] = 322,["180"] = 322,["181"] = 322,["182"] = 322,["183"] = 322,["184"] = 322,["185"] = 322,["186"] = 322,["189"] = 294,["190"] = 295,["191"] = 297,["192"] = 301,["193"] = 297,["194"] = 326,["195"] = 327,["196"] = 326,["197"] = 330,["198"] = 330,["199"] = 330,["200"] = 331,["201"] = 332,["202"] = 333,["205"] = 336,["208"] = 340,["210"] = 341,["211"] = 342,["213"] = 345,["214"] = 345,["215"] = 345,["216"] = 346,["217"] = 347,["218"] = 347,["219"] = 347,["220"] = 347,["226"] = 352,["227"] = 353,["228"] = 353,["230"] = 355,["231"] = 355,["232"] = 355,["233"] = 355,["234"] = 357,["235"] = 358,["237"] = 361,["238"] = 361,["240"] = 362,["241"] = 362,["243"] = 363,["244"] = 363,["246"] = 365,["247"] = 365,["249"] = 366,["250"] = 366,["252"] = 367,["253"] = 367,["255"] = 368,["256"] = 368,["258"] = 352,["259"] = 371,["260"] = 372,["261"] = 372,["263"] = 373,["264"] = 373,["266"] = 374,["267"] = 374,["269"] = 371,["270"] = 377,["271"] = 378,["272"] = 378,["274"] = 379,["275"] = 379,["277"] = 380,["278"] = 380,["280"] = 381,["281"] = 381,["283"] = 382,["284"] = 382,["286"] = 377,["287"] = 385,["288"] = 386,["289"] = 386,["291"] = 387,["292"] = 387,["294"] = 388,["295"] = 388,["297"] = 385,["298"] = 392,["299"] = 393,["300"] = 394,["301"] = 395,["302"] = 396,["303"] = 397,["304"] = 398,["305"] = 399,["306"] = 400,["307"] = 401,["308"] = 401,["309"] = 401,["311"] = 391,["312"] = 391,["313"] = 391,["314"] = 391,["315"] = 391,["316"] = 391,["317"] = 391,["318"] = 391,["319"] = 391,["320"] = 391,["321"] = 391,["322"] = 391,["323"] = 391,["324"] = 391,["325"] = 391,["326"] = 391,["327"] = 391,["328"] = 391,["329"] = 391,["330"] = 391,["331"] = 391,["332"] = 391,["333"] = 416,["334"] = 417,["335"] = 417,["337"] = 420,["338"] = 421,["339"] = 421,["341"] = 424,["342"] = 425,["343"] = 427,["344"] = 429,["345"] = 293,["346"] = 432,["347"] = 434,["348"] = 435,["349"] = 436,["350"] = 436,["352"] = 438,["353"] = 439,["354"] = 440,["355"] = 441,["357"] = 443,["359"] = 446,["360"] = 447,["362"] = 449,["364"] = 452,["365"] = 453,["367"] = 456,["368"] = 457,["370"] = 460,["371"] = 461,["373"] = 464,["374"] = 465,["377"] = 468,["379"] = 471,["380"] = 472,["381"] = 473,["382"] = 475,["384"] = 477,["385"] = 478,["386"] = 478,["388"] = 480,["389"] = 481,["390"] = 482,["391"] = 484,["393"] = 487,["394"] = 488,["395"] = 489,["396"] = 491,["397"] = 492,["399"] = 495,["400"] = 253,["401"] = 498,["402"] = 499,["403"] = 498,["404"] = 502,["405"] = 503,["406"] = 503,["407"] = 503,["408"] = 503,["409"] = 502,["410"] = 506,["411"] = 507,["412"] = 506,["413"] = 510,["414"] = 511,["415"] = 510});
local ____exports = {}
local ____ai = require("ai")
local addAbilityAI = ____ai.addAbilityAI
local ____modifier_ability_extension = require("modifiers.modifier_ability_extension")
local ModifierAbilityExtension = ____modifier_ability_extension.ModifierAbilityExtension
function ____exports.charges(self)
    return {type = "charges"}
end
function ____exports.special(self, name, op, value)
    return {type = "overrideSpecial", name = name, value = value, operation = op}
end
function ____exports.reduceCooldown(self, amount)
    return {type = "reduceCooldown", amount = amount}
end
function ____exports.reduceManacost(self, amount)
    return {type = "reduceManacost", amount = amount}
end
function ____exports.increaseCastRange(self, amount)
    return {type = "increaseCastRange", amount = amount}
end
function ____exports.secondaryAbility(self, name, level)
    if level == nil then
        level = 1
    end
    return {type = "ability", name = name, level = level}
end
function ____exports.item(self, name)
    return {type = "item", name = name}
end
local vanillaAbilities = LoadKeyValues("scripts/npc/npc_abilities.txt")
local vanillaAbilitiesOverride = LoadKeyValues("scripts/npc/npc_abilities_override.txt")
local customAbilities = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
local abilityDefinitions = {}
local abilityDefinitionByName = {}
local listLocked = false
local function validateUpgrades(self, abilityName, kv, upgrades)
    local upgradeSpecialNames = __TS__New(Set)
    local function maybeAddSpecialName(self, valueOrSpecial)
        if type(valueOrSpecial) == "string" then
            upgradeSpecialNames:add(valueOrSpecial)
        end
    end
    local function softlyHandleError(self, text)
        text = "ERROR: " .. text
        if IsInToolsMode() then
            error(text, 0)
        else
            print(text)
        end
    end
    for ____, upgrade in ipairs(upgrades) do
        repeat
            local ____switch16 = upgrade.type
            local ____cond16 = ____switch16 == "overrideSpecial"
            if ____cond16 then
                do
                    upgradeSpecialNames:add(upgrade.name)
                    maybeAddSpecialName(nil, upgrade.value)
                    break
                end
            end
            ____cond16 = ____cond16 or (____switch16 == "reduceCooldown" or ____switch16 == "reduceManacost" or ____switch16 == "increaseCastRange")
            if ____cond16 then
                do
                    maybeAddSpecialName(nil, upgrade.amount)
                    break
                end
            end
            ____cond16 = ____cond16 or ____switch16 == "ability"
            if ____cond16 then
                do
                    if not vanillaAbilities[upgrade.name] and not customAbilities[upgrade.name] then
                        softlyHandleError(
                            nil,
                            ("Ability \"" .. tostring(upgrade.name)) .. "\" specified in upgrades not found in ability KV!"
                        )
                    end
                    break
                end
            end
            ____cond16 = ____cond16 or (____switch16 == "item" or ____switch16 == "charges")
            if ____cond16 then
                do
                    break
                end
            end
            do
                unreachable(nil, upgrade)
            end
        until true
    end
    for ____, specialName in __TS__Iterator(upgradeSpecialNames) do
        local found = false
        if (kv.AbilityValues or ({}))[specialName] ~= nil then
            found = true
        end
        for ____, ____value in ipairs(__TS__ObjectEntries(kv.AbilitySpecial or ({}))) do
            local specialContent = ____value[2]
            if type(specialContent) == "table" then
                if specialContent[specialName] ~= nil then
                    found = true
                    break
                end
            end
        end
        if not found then
            softlyHandleError(nil, ((("Special \"" .. abilityName) .. ".") .. specialName) .. "\" specified in upgrades not found in ability KV!")
        end
    end
end
function ____exports.defineAbility(self, code, element, options)
    if listLocked or IsClient() then
        return
    end
    local function normalizeUpgrades(self, option)
        local upgrades = {}
        local modifier = ModifierAbilityExtension
        for ____, upgradeOr in ipairs(option) do
            if upgradeOr.apply ~= nil then
                modifier = upgradeOr
            else
                upgrades[#upgrades + 1] = upgradeOr
            end
        end
        return {upgrades = upgrades, modifier = modifier}
    end
    local function maybeValidateUpgradeOption(self, abilityName, kv, option)
        if option then
            local ____normalizeUpgrades_result_0 = normalizeUpgrades(nil, option)
            local upgrades = ____normalizeUpgrades_result_0.upgrades
            validateUpgrades(nil, abilityName, kv, upgrades)
        end
    end
    local function maybeRegisterSecondaryAbilities(self, option)
        if option then
            local ____normalizeUpgrades_result_1 = normalizeUpgrades(nil, option)
            local upgrades = ____normalizeUpgrades_result_1.upgrades
            for ____, upgrade in ipairs(upgrades) do
                if upgrade.type == "ability" then
                    ____exports.defineAbility(nil, upgrade.name, element, {availableInShop = false})
                end
            end
        end
    end
    local function pushAbility(self, kv, id)
        local formatSingleValue, parseValuesFromStringOrNumber
        function formatSingleValue(self, value)
            if value % 1 == 0 then
                return value
            else
                local formatted = string.format("%.3f", value)
                while __TS__StringEndsWith(formatted, "0") do
                    formatted = __TS__StringSubstring(formatted, 0, #formatted - 1)
                end
                return __TS__ParseFloat(formatted)
            end
        end
        function parseValuesFromStringOrNumber(self, value)
            if type(value) == "number" then
                return {formatSingleValue(nil, value)}
            else
                local ____opt_2 = value
                return __TS__ArrayMap(
                    ____opt_2 and __TS__StringSplit(value, " ") or ({}),
                    function(____, value) return formatSingleValue(
                        nil,
                        __TS__ParseFloat(value)
                    ) end
                )
            end
        end
        local values = {}
        local reservedSpecialKeys = {"LinkedSpecialBonus", "var_type"}
        local function getParsedValuesFromKVOrAbilityValues(self, key, values)
            return kv[key] and parseValuesFromStringOrNumber(nil, kv[key]) or (values[key] or ({}))
        end
        local function maybeHandleValueSpecialCases(self, key, value)
            return key == "abilitycastrange" and (kv.AbilityCastRange or "0") or value
        end
        for ____, ____value in ipairs(__TS__ObjectEntries(kv.AbilityValues or ({}))) do
            local key = ____value[1]
            local value = ____value[2]
            if type(value) == "table" then
                if not value.RequiresScepter and not value.RequiresShard and value.value then
                    values[key] = parseValuesFromStringOrNumber(nil, value.value)
                end
            else
                values[key] = parseValuesFromStringOrNumber(nil, value)
            end
        end
        for ____, entry in ipairs(__TS__ObjectValues(kv.AbilitySpecial or ({}))) do
            do
                if entry.RequiresScepter or entry.RequiresShard then
                    goto __continue61
                end
                for ____, ____value in ipairs(__TS__ObjectEntries(entry)) do
                    local key = ____value[1]
                    local value = ____value[2]
                    if not __TS__ArrayIncludes(reservedSpecialKeys, key) then
                        values[key] = parseValuesFromStringOrNumber(
                            nil,
                            maybeHandleValueSpecialCases(nil, key, value)
                        )
                    end
                end
            end
            ::__continue61::
        end
        local function parseAbilityBehavior(self, ____type)
            if not ____type then
                return QAbilityBehavior.noTarget
            end
            local behaviors = __TS__ArrayMap(
                __TS__StringSplit(____type, "|"),
                function(____, behavior) return __TS__StringTrim(behavior) end
            )
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_UNIT_TARGET") and __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_POINT") then
                return QAbilityBehavior.unitOrPointTarget
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_AUTOCAST") then
                return QAbilityBehavior.autoCast
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_CHANNELLED") then
                return QAbilityBehavior.channeled
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_TOGGLE") then
                return QAbilityBehavior.toggle
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_NO_TARGET") then
                return QAbilityBehavior.noTarget
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_PASSIVE") then
                return QAbilityBehavior.passive
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_UNIT_TARGET") then
                return QAbilityBehavior.target
            end
            if __TS__ArrayIncludes(behaviors, "DOTA_ABILITY_BEHAVIOR_POINT") then
                return QAbilityBehavior.point
            end
        end
        local function parseDamageType(self, ____type)
            if ____type == "DAMAGE_TYPE_PHYSICAL" then
                return QAbilityDamageType.physical
            end
            if ____type == "DAMAGE_TYPE_MAGICAL" then
                return QAbilityDamageType.magical
            end
            if ____type == "DAMAGE_TYPE_PURE" then
                return QAbilityDamageType.pure
            end
        end
        local function parseSpellImmunityPierce(self, ____type)
            if ____type == "SPELL_IMMUNITY_ENEMIES_YES" then
                return QAbilityPierceType.yes
            end
            if ____type == "SPELL_IMMUNITY_ALLIES_YES" then
                return QAbilityPierceType.yes
            end
            if ____type == "SPELL_IMMUNITY_ENEMIES_NO" then
                return QAbilityPierceType.no
            end
            if ____type == "SPELL_IMMUNITY_ALLIES_NO" then
                return QAbilityPierceType.no
            end
            if ____type == "SPELL_IMMUNITY_ALLIES_YES_ENEMIES_NO" then
                return QAbilityPierceType.alliesYesEnemiesNo
            end
        end
        local function parseDispellability(self, ____type)
            if ____type == "SPELL_DISPELLABLE_YES_STRONG" then
                return QAbilityDispellability.yesStrong
            end
            if ____type == "SPELL_DISPELLABLE_YES" then
                return QAbilityDispellability.yes
            end
            if ____type == "SPELL_DISPELLABLE_NO" then
                return QAbilityDispellability.no
            end
        end
        local ____temp_17 = #abilityDefinitions + 1
        local ____id_18 = id
        local ____element_19 = element
        local ____temp_20 = options and options.super and normalizeUpgrades(nil, options.super) or nil
        local ____temp_21 = options and options.gaben and normalizeUpgrades(nil, options.gaben) or nil
        local ____temp_22 = options and options.pantheon and normalizeUpgrades(nil, options.pantheon) or nil
        local ____temp_23 = options and options.intrinsicModifier
        local ____temp_24 = kv.AbilityTextureName or id
        local ____temp_25 = kv.AbilityType == "DOTA_ABILITY_TYPE_ULTIMATE" and "ultimate" or "normal"
        local ____temp_14 = options and options.availableInShop
        if ____temp_14 == nil then
            ____temp_14 = true
        end
        local definition = {
            id = ____temp_17,
            name = ____id_18,
            element = ____element_19,
            superUpgrades = ____temp_20,
            gabenUpgrades = ____temp_21,
            pantheonUpgrades = ____temp_22,
            intrinsicModifier = ____temp_23,
            icon = ____temp_24,
            slot = ____temp_25,
            availableInShop = ____temp_14,
            tags = options and options.tags or ({}),
            cooldown = getParsedValuesFromKVOrAbilityValues(nil, "AbilityCooldown", values),
            manaCost = getParsedValuesFromKVOrAbilityValues(nil, "AbilityManaCost", values),
            castRange = getParsedValuesFromKVOrAbilityValues(nil, "AbilityCastRange", values),
            damage = parseValuesFromStringOrNumber(nil, kv.AbilityDamage),
            behavior = parseAbilityBehavior(nil, kv.AbilityBehavior),
            piercesSpellImmunity = parseSpellImmunityPierce(nil, kv.SpellImmunityType),
            dispellabilityType = parseDispellability(nil, kv.SpellDispellableType),
            damageType = parseDamageType(nil, kv.AbilityUnitDamageType),
            values = values
        }
        if definition.slot == "ultimate" then
            local ____definition_tags_26 = definition.tags
            ____definition_tags_26[#____definition_tags_26 + 1] = "ultimate"
        end
        if definition.behavior == QAbilityBehavior.passive then
            local ____definition_tags_27 = definition.tags
            ____definition_tags_27[#____definition_tags_27 + 1] = "passive"
        end
        abilityDefinitions[#abilityDefinitions + 1] = definition
        abilityDefinitionByName[definition.name] = definition
        print("Registered ability", id, definition.id)
        return definition
    end
    local definition
    if type(code) == "string" then
        local kv = vanillaAbilities[code] or customAbilities[code]
        if not kv then
            error("Missing keyvalues for ability " .. code, 0)
        end
        local overrideKv = vanillaAbilitiesOverride[code]
        if overrideKv then
            if kv.AbilitySpecial then
                __TS__ObjectAssign(kv.AbilitySpecial, overrideKv.AbilitySpecial or ({}))
            else
                kv.AbilitySpecial = overrideKv.AbilitySpecial
            end
            if kv.AbilityValues then
                __TS__ObjectAssign(kv.AbilityValues, overrideKv.AbilityValues or ({}))
            else
                kv.AbilityValues = overrideKv.AbilityValues
            end
            if kv.AbilityManaCost and overrideKv.AbilityManaCost then
                kv.AbilityManaCost = overrideKv.AbilityManaCost
            end
            if kv.AbilityDamage and overrideKv.AbilityDamage then
                kv.AbilityDamage = overrideKv.AbilityDamage
            end
            if kv.AbilityCooldown and overrideKv.AbilityCooldown then
                kv.AbilityCooldown = overrideKv.AbilityCooldown
            end
            if kv.AbilityCastRange and overrideKv.AbilityCastRange then
                kv.AbilityCastRange = overrideKv.AbilityCastRange
            end
        else
            print("Missing override for ability " .. code)
        end
        maybeValidateUpgradeOption(nil, code, kv, options and options.super)
        maybeValidateUpgradeOption(nil, code, kv, options and options.gaben)
        maybeValidateUpgradeOption(nil, code, kv, options and options.pantheon)
        definition = pushAbility(nil, kv, code)
    else
        local kv = customAbilities[code.name]
        if not kv then
            error("Missing keyvalues for ability " .. code.name, 0)
        end
        maybeValidateUpgradeOption(nil, code.name, kv, options and options.super)
        maybeValidateUpgradeOption(nil, code.name, kv, options and options.gaben)
        maybeValidateUpgradeOption(nil, code.name, kv, options and options.pantheon)
        definition = pushAbility(nil, kv, code.name)
    end
    maybeRegisterSecondaryAbilities(nil, options and options.super)
    maybeRegisterSecondaryAbilities(nil, options and options.gaben)
    maybeRegisterSecondaryAbilities(nil, options and options.pantheon)
    if options and options.ai then
        options:ai(function(____, ...) return addAbilityAI(nil, code, ...) end)
    end
    return definition
end
function ____exports.getAllAbilityDefinitions(self)
    return abilityDefinitions
end
function ____exports.findAbilityDefinition(self, id)
    return __TS__ArrayFind(
        abilityDefinitions,
        function(____, def) return def.id == id end
    )
end
function ____exports.findAbilityDefinitionByName(self, name)
    return abilityDefinitionByName[name]
end
function ____exports.lockAbilityList(self)
    listLocked = true
end
return ____exports
