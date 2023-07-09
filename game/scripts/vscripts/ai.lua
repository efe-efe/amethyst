local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["13"] = 437,["14"] = 1,["15"] = 1,["16"] = 2,["17"] = 2,["18"] = 3,["19"] = 5,["20"] = 6,["21"] = 7,["22"] = 8,["23"] = 9,["24"] = 10,["25"] = 11,["26"] = 12,["27"] = 13,["28"] = 14,["29"] = 77,["30"] = 78,["31"] = 78,["32"] = 78,["33"] = 78,["34"] = 78,["35"] = 77,["36"] = 81,["37"] = 82,["38"] = 84,["39"] = 85,["40"] = 86,["41"] = 87,["42"] = 88,["43"] = 89,["45"] = 91,["47"] = 81,["48"] = 95,["49"] = 96,["50"] = 97,["51"] = 97,["52"] = 97,["53"] = 97,["54"] = 99,["55"] = 100,["58"] = 104,["59"] = 95,["60"] = 107,["61"] = 108,["62"] = 109,["63"] = 111,["64"] = 112,["66"] = 115,["67"] = 116,["69"] = 119,["70"] = 120,["74"] = 122,["75"] = 123,["78"] = 125,["82"] = 129,["85"] = 130,["90"] = 135,["91"] = 107,["92"] = 138,["93"] = 180,["94"] = 144,["95"] = 145,["96"] = 146,["98"] = 149,["99"] = 150,["101"] = 152,["102"] = 144,["103"] = 155,["104"] = 156,["105"] = 155,["106"] = 159,["107"] = 160,["108"] = 160,["109"] = 160,["110"] = 160,["111"] = 160,["112"] = 160,["113"] = 160,["114"] = 159,["115"] = 163,["116"] = 170,["117"] = 163,["118"] = 173,["119"] = 174,["120"] = 173,["121"] = 177,["122"] = 178,["123"] = 178,["125"] = 180,["126"] = 182,["127"] = 183,["128"] = 183,["130"] = 185,["133"] = 185,["135"] = 185,["136"] = 185,["137"] = 185,["138"] = 186,["139"] = 187,["141"] = 189,["142"] = 190,["143"] = 192,["144"] = 192,["145"] = 192,["146"] = 192,["147"] = 190,["148"] = 193,["149"] = 193,["150"] = 193,["151"] = 193,["152"] = 190,["153"] = 190,["154"] = 190,["155"] = 190,["156"] = 185,["157"] = 185,["158"] = 200,["159"] = 201,["160"] = 201,["163"] = 203,["164"] = 204,["166"] = 205,["168"] = 206,["170"] = 207,["171"] = 207,["172"] = 207,["173"] = 207,["175"] = 211,["178"] = 212,["179"] = 212,["180"] = 212,["181"] = 212,["185"] = 218,["188"] = 138,["189"] = 222,["190"] = 231,["191"] = 230,["192"] = 229,["193"] = 228,["194"] = 227,["195"] = 226,["196"] = 225,["197"] = 224,["198"] = 223,["199"] = 223,["200"] = 224,["201"] = 225,["202"] = 226,["203"] = 227,["204"] = 228,["205"] = 229,["206"] = 230,["207"] = 231,["208"] = 233,["209"] = 239,["210"] = 240,["211"] = 240,["213"] = 241,["214"] = 241,["216"] = 242,["217"] = 242,["219"] = 243,["220"] = 243,["222"] = 244,["223"] = 244,["224"] = 244,["225"] = 244,["226"] = 244,["227"] = 244,["229"] = 246,["230"] = 239,["231"] = 249,["232"] = 251,["233"] = 251,["234"] = 251,["235"] = 251,["236"] = 252,["237"] = 252,["238"] = 252,["239"] = 252,["240"] = 252,["241"] = 249,["242"] = 255,["243"] = 256,["244"] = 256,["245"] = 256,["246"] = 256,["247"] = 257,["248"] = 259,["249"] = 260,["250"] = 262,["251"] = 263,["252"] = 264,["255"] = 267,["258"] = 271,["259"] = 272,["260"] = 272,["261"] = 272,["262"] = 272,["263"] = 272,["264"] = 272,["265"] = 272,["266"] = 274,["267"] = 275,["268"] = 275,["269"] = 275,["270"] = 275,["271"] = 275,["272"] = 275,["274"] = 278,["275"] = 278,["276"] = 278,["277"] = 278,["278"] = 278,["280"] = 280,["281"] = 281,["284"] = 282,["285"] = 283,["287"] = 286,["288"] = 286,["289"] = 286,["290"] = 286,["291"] = 286,["292"] = 286,["293"] = 286,["294"] = 288,["295"] = 289,["298"] = 292,["301"] = 293,["302"] = 293,["303"] = 293,["304"] = 293,["305"] = 293,["306"] = 293,["307"] = 294,["309"] = 297,["310"] = 298,["313"] = 301,["316"] = 302,["317"] = 303,["319"] = 305,["321"] = 308,["326"] = 313,["327"] = 233,["328"] = 316,["329"] = 317,["330"] = 318,["331"] = 321,["332"] = 322,["333"] = 324,["334"] = 325,["335"] = 325,["336"] = 325,["337"] = 325,["338"] = 325,["339"] = 325,["340"] = 325,["342"] = 328,["343"] = 316,["344"] = 331,["345"] = 332,["346"] = 332,["347"] = 332,["348"] = 332,["349"] = 332,["350"] = 333,["351"] = 331,["352"] = 336,["353"] = 337,["354"] = 336,["355"] = 347,["356"] = 348,["357"] = 349,["358"] = 350,["359"] = 347,["360"] = 353,["361"] = 354,["362"] = 353,["363"] = 357,["364"] = 357,["365"] = 357,["366"] = 357,["367"] = 359,["368"] = 360,["369"] = 360,["370"] = 360,["371"] = 360,["372"] = 360,["373"] = 360,["375"] = 363,["376"] = 365,["377"] = 366,["379"] = 369,["380"] = 370,["381"] = 370,["382"] = 370,["383"] = 370,["384"] = 370,["385"] = 370,["386"] = 370,["387"] = 371,["389"] = 376,["390"] = 377,["392"] = 380,["393"] = 381,["395"] = 384,["396"] = 385,["397"] = 385,["398"] = 385,["399"] = 385,["400"] = 385,["401"] = 386,["402"] = 386,["403"] = 388,["404"] = 388,["405"] = 388,["406"] = 386,["407"] = 386,["409"] = 392,["410"] = 394,["412"] = 397,["413"] = 398,["414"] = 399,["415"] = 399,["416"] = 401,["417"] = 401,["418"] = 401,["419"] = 399,["420"] = 399,["422"] = 405,["423"] = 405,["424"] = 405,["425"] = 405,["426"] = 405,["427"] = 405,["428"] = 407,["430"] = 410,["431"] = 411,["432"] = 411,["433"] = 411,["434"] = 414,["435"] = 414,["436"] = 414,["437"] = 411,["438"] = 411,["440"] = 418,["441"] = 419,["442"] = 419,["443"] = 419,["444"] = 419,["445"] = 419,["446"] = 421,["447"] = 422,["451"] = 430,["452"] = 431,["454"] = 434,["455"] = 222,["457"] = 437,["459"] = 437,["460"] = 439,["461"] = 440,["462"] = 441,["463"] = 442,["464"] = 449,["465"] = 439,["466"] = 438,["467"] = 437,["468"] = 454,["469"] = 456,["470"] = 457,["471"] = 454,["472"] = 453,["473"] = 437,["474"] = 462,["475"] = 461,["476"] = 437,["477"] = 466,["478"] = 465});
local ____exports = {}
local rules
local ____entities = require("entities")
local setEntityDirection = ____entities.setEntityDirection
local ____modifier_casting = require("modifiers.modifier_casting")
local ModifierCasting = ____modifier_casting.ModifierCasting
local ____util = require("util")
local direction2D = ____util.direction2D
local distanceBetweenEntities = ____util.distanceBetweenEntities
local distanceBetweenPoints = ____util.distanceBetweenPoints
local findElementWithSmallestValue = ____util.findElementWithSmallestValue
local hasBehavior = ____util.hasBehavior
local isChanneling = ____util.isChanneling
local isInDeveloperMode = ____util.isInDeveloperMode
local simpleTrigger = ____util.simpleTrigger
local triggerNow = ____util.triggerNow
local valueOrSpecial = ____util.valueOrSpecial
local function findClosestGuy(self, who, fromWhom)
    return findElementWithSmallestValue(
        nil,
        fromWhom,
        function(____, unit) return distanceBetweenEntities(nil, who, unit) end
    )
end
local function inferAbilityTarget(self, ability)
    local behavior = ability:GetBehavior()
    if hasBehavior(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
        return "unit"
    elseif hasBehavior(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT) then
        return "ground"
    elseif hasBehavior(nil, behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
        return "none"
    else
        print((("Unsupported ability targeting for " .. ability:GetAbilityName()) .. ": ") .. tostring(behavior))
    end
end
local function executeRuleChain(self, units, rules, context)
    for ____, rule in ipairs(rules) do
        units = __TS__ArrayFilter(
            units,
            function(____, unit) return rule(nil, unit, context, units) end
        )
        if #units == 0 then
            return {}
        end
    end
    return units
end
local function inferAbilityAI(self, ability)
    local result = {}
    local targetTeam = ability:GetAbilityTargetTeam()
    if bit.band(targetTeam, DOTA_UNIT_TARGET_TEAM_ENEMY) ~= 0 then
        result[#result + 1] = ____exports.rules:enemy()
    end
    if bit.band(targetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY) ~= 0 then
        result[#result + 1] = ____exports.rules:ally()
    end
    local target = inferAbilityTarget(nil, ability)
    if not target then
        return
    end
    repeat
        local ____switch18 = target
        local ____cond18 = ____switch18 == "unit" or ____switch18 == "ground"
        if ____cond18 then
            do
                result[#result + 1] = ____exports.rules:isClosest()
                break
            end
        end
        ____cond18 = ____cond18 or ____switch18 == "none"
        if ____cond18 then
            do
                result[#result + 1] = ____exports.rules:inAOERadius()
                break
            end
        end
    until true
    return {ruleSets = {{rules = result}}}
end
function ____exports.decideHowToCastAbilityByAI(self, unit, allies, enemies, ability)
    local context
    local function unitCanBeUnitTargeted(self, targetUnit)
        if targetUnit:IsOutOfGame() or targetUnit:IsUntargetableFrom(unit) then
            return false
        end
        if unit:GetTeamNumber() == targetUnit:GetTeamNumber() then
            return true
        end
        return not targetUnit:IsUnselectable() and not targetUnit:IsInvisible()
    end
    local function flagOrDefault(self, flag, def)
        return flag == 0 and def or flag
    end
    local function findFittingRuleSetTargets(self, units, sets)
        return __TS__ArrayFind(
            __TS__ArrayMap(
                sets,
                function(____, set) return executeRuleChain(nil, units, set.rules, context) end
            ),
            function(____, targets) return #targets > 0 end
        )
    end
    local function findCastPositionSafe(self, targets)
        return targets[1]:GetAbsOrigin()
    end
    local function findCastPosition(self, targets)
        return targets and findCastPositionSafe(nil, targets) or nil
    end
    local ai = inferAbilityAI(nil, ability)
    if not ai then
        return {outcome = "dontCast"}
    end
    context = {caster = unit, allies = allies, enemies = enemies, ability = ability}
    local abilityTarget = inferAbilityTarget(nil, ability)
    if not abilityTarget then
        return {outcome = "dontCast"}
    end
    local ____array_0 = __TS__SparseArrayNew(unpack(allies))
    __TS__SparseArrayPush(
        ____array_0,
        unpack(enemies)
    )
    local allTargets = __TS__ArrayFilter(
        {__TS__SparseArraySpread(____array_0)},
        function(____, target)
            if abilityTarget == "unit" and not unitCanBeUnitTargeted(nil, target) then
                return false
            end
            return UnitFilter(
                target,
                flagOrDefault(
                    nil,
                    ability:GetAbilityTargetTeam(),
                    DOTA_UNIT_TARGET_TEAM_BOTH
                ),
                flagOrDefault(
                    nil,
                    ability:GetAbilityTargetType(),
                    DOTA_UNIT_TARGET_ALL
                ),
                ability:GetAbilityTargetFlags(),
                unit:GetTeamNumber()
            ) == UF_SUCCESS
        end
    )
    local maybeTargets = findFittingRuleSetTargets(nil, allTargets, ai.ruleSets)
    if not maybeTargets then
        return {outcome = "dontCast"}
    end
    repeat
        local ____switch36 = abilityTarget
        local ____cond36 = ____switch36 == "none"
        if ____cond36 then
            return {outcome = "targetNothing"}
        end
        ____cond36 = ____cond36 or ____switch36 == "unit"
        if ____cond36 then
            return {
                outcome = "targetUnit",
                target = findClosestGuy(nil, unit, maybeTargets) or maybeTargets[1]
            }
        end
        ____cond36 = ____cond36 or ____switch36 == "ground"
        if ____cond36 then
            do
                return {
                    outcome = "targetGround",
                    target = findCastPositionSafe(nil, maybeTargets)
                }
            end
        end
        do
            return unreachable(nil, abilityTarget)
        end
    until true
end
function ____exports.updateUnitAI(self, ____bindingPattern0)
    local followRange
    local minFollowRange
    local context
    local behavior
    local enemies
    local allies
    local abilities
    local unit
    local entity
    entity = ____bindingPattern0.entity
    unit = ____bindingPattern0.unit
    abilities = ____bindingPattern0.abilities
    allies = ____bindingPattern0.allies
    enemies = ____bindingPattern0.enemies
    behavior = ____bindingPattern0.behavior
    context = ____bindingPattern0.context
    minFollowRange = ____bindingPattern0.minFollowRange
    followRange = ____bindingPattern0.followRange
    local function maybeCastSomeAbility(self, unit, allies, enemies, abilities)
        local function isAbilityConsideredForAI(self, ability)
            if ability:IsHidden() then
                return false
            end
            if ability:IsPassive() then
                return false
            end
            if not ability:IsFullyCastable() then
                return false
            end
            if not ability:IsActivated() then
                return false
            end
            if ability:GetCaster():IsRooted() and hasBehavior(
                nil,
                ability:GetBehavior(),
                DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
            ) then
                return false
            end
            return true
        end
        local function isInCastRange(self, unit, ability, target)
            local castRange = ability:GetEffectiveCastRange(
                Vector(0, 0, 0),
                unit
            )
            return castRange == 0 or distanceBetweenPoints(
                nil,
                target,
                unit:GetAbsOrigin()
            ) <= castRange
        end
        local playerId = unit:GetPlayerOwnerID()
        local consideredAbilities = __TS__ArrayFilter(
            abilities,
            function(____, ability) return isAbilityConsideredForAI(nil, ability) end
        )
        local nonAutoCastAbilities = {}
        for ____, ability in ipairs(consideredAbilities) do
            local behavior = ability:GetBehavior()
            if hasBehavior(nil, behavior, DOTA_ABILITY_BEHAVIOR_AUTOCAST) and hasBehavior(nil, behavior, DOTA_ABILITY_BEHAVIOR_ATTACK) then
                if not ability:GetAutoCastState() then
                    ability:ToggleAutoCast()
                end
            else
                nonAutoCastAbilities[#nonAutoCastAbilities + 1] = ability
            end
        end
        for ____, ability in ipairs(nonAutoCastAbilities) do
            local decision = ____exports.decideHowToCastAbilityByAI(
                nil,
                unit,
                allies,
                enemies,
                ability
            )
            if isInDeveloperMode(nil) and decision.outcome ~= "dontCast" then
                DebugDrawText(
                    unit:GetAbsOrigin() + Vector(0, 0, 128),
                    ability:GetAbilityName(),
                    true,
                    1
                )
            end
            local isToggle = hasBehavior(
                nil,
                ability:GetBehavior(),
                DOTA_ABILITY_BEHAVIOR_TOGGLE
            )
            repeat
                local ____switch55 = decision.outcome
                local ____cond55 = ____switch55 == "targetGround"
                if ____cond55 then
                    do
                        if not isInCastRange(nil, unit, ability, decision.target) then
                            return false
                        end
                        DebugDrawLine_vCol(
                            unit:GetAbsOrigin(),
                            decision.target,
                            Vector(255, 0, 0),
                            true,
                            ability:GetCastPoint()
                        )
                        unit:CastAbilityOnPosition(decision.target, ability, playerId)
                        return true
                    end
                end
                ____cond55 = ____cond55 or ____switch55 == "targetUnit"
                if ____cond55 then
                    do
                        if not isInCastRange(
                            nil,
                            unit,
                            ability,
                            decision.target:GetAbsOrigin()
                        ) and unit:IsRooted() then
                            return false
                        end
                        unit:CastAbilityOnTarget(decision.target, ability, playerId)
                        return true
                    end
                end
                ____cond55 = ____cond55 or ____switch55 == "targetNothing"
                if ____cond55 then
                    do
                        if isToggle then
                            unit:CastAbilityToggle(ability, playerId)
                        else
                            unit:CastAbilityNoTarget(ability, playerId)
                        end
                        return true
                    end
                end
            until true
        end
        return false
    end
    local function pickTargetPosition(self, unit)
        local worldLimits = 1000
        local origin = unit:GetAbsOrigin()
        local x = origin.x + RandomInt(-400, 400)
        local y = origin.y + RandomInt(-400, 400)
        if IsInToolsMode() then
            DebugDrawLine_vCol(
                origin,
                Vector(x, y, 128),
                Vector(255, 0, 0),
                true,
                1
            )
        end
        return Vector(x, y)
    end
    local function isInFollowDistance(self, target)
        local distance = distanceBetweenPoints(
            nil,
            target:GetAbsOrigin(),
            unit:GetAbsOrigin()
        )
        return distance > minFollowRange and distance < followRange
    end
    local function unitCanBeFollowed(self, target)
        return not target:IsOutOfGame() and not target:IsUnselectable() and not target:IsInvulnerable() and not target:IsInvisible() and target:IsAlive() and isInFollowDistance(nil, target)
    end
    local function moveTowards(self, unit, entity, point)
        local origin = unit:GetAbsOrigin()
        local direction = direction2D(nil, origin, point)
        setEntityDirection(nil, entity, direction.x, direction.y)
    end
    local function stopMovement(self, entity)
        setEntityDirection(nil, entity, 0, 0)
    end
    local isCasting = __TS__ArraySome(
        abilities,
        function(____, ability) return ability:IsInAbilityPhase() end
    ) or isChanneling(nil, unit) or ModifierCasting:findOne(unit)
    if isInDeveloperMode(nil) then
        DebugDrawText(
            unit:GetAbsOrigin() + Vector(0, 128, 128),
            context.id,
            true,
            0.03
        )
    end
    stopMovement(nil, entity)
    if context.id == "startedCasting" then
        return {id = "idle"}
    end
    if not isCasting then
        if maybeCastSomeAbility(
            nil,
            unit,
            allies,
            enemies,
            abilities
        ) then
            return {id = "startedCasting"}
        end
        if behavior == "static" then
            return context
        end
        if context.id == "resting" then
            return triggerNow(nil, context.restTrigger) and ({id = "idle"}) or context
        end
        if context.id == "moving" then
            if distanceBetweenPoints(
                nil,
                context.target,
                unit:GetAbsOrigin()
            ) < 10 or triggerNow(nil, context.moveTrigger) then
                return {
                    id = "resting",
                    restTrigger = simpleTrigger(
                        nil,
                        GameRules:GetGameTime() + 0.35
                    )
                }
            end
            moveTowards(nil, unit, entity, context.target)
            return context
        end
        if context.id == "following" then
            if not isInFollowDistance(nil, context.target) then
                return {
                    id = "resting",
                    restTrigger = simpleTrigger(
                        nil,
                        GameRules:GetGameTime() + 0.35
                    )
                }
            end
            moveTowards(
                nil,
                unit,
                entity,
                context.target:GetAbsOrigin()
            )
            return context
        end
        if behavior == "wanderer" then
            return {
                id = "moving",
                target = pickTargetPosition(nil, unit),
                moveTrigger = simpleTrigger(
                    nil,
                    GameRules:GetGameTime() + 3
                )
            }
        end
        if behavior == "follower" then
            local target = findClosestGuy(
                nil,
                unit,
                __TS__ArrayFilter(enemies, unitCanBeFollowed)
            )
            if target then
                return {id = "following", target = target}
            end
        end
    end
    if context.id == "resting" then
        return triggerNow(nil, context.restTrigger) and ({id = "idle"}) or context
    end
    return context
end
____exports.rules = {}
rules = ____exports.rules
do
    function rules.inAOERadius(self, specificValue)
        return function(____, target, ctx)
            local distance = (ctx.caster:GetAbsOrigin() - target:GetAbsOrigin()):Length2D()
            local radiusFromSpecial = ctx.ability:GetSpecialValueFor("radius")
            local radius = specificValue and (type(specificValue) == "function" and specificValue(nil, ctx) or valueOrSpecial(nil, ctx.ability, specificValue)) or (radiusFromSpecial ~= 0 and radiusFromSpecial or ctx.ability:GetAOERadius())
            return distance <= radius
        end
    end
    function rules.isClosest(self)
        return function(____, target, ctx, remaining)
            local closest = findClosestGuy(nil, ctx.caster, remaining)
            return closest == target
        end
    end
    function rules.ally(self)
        return function(____, target, ctx) return __TS__ArrayIncludes(ctx.allies, target) end
    end
    function rules.enemy(self)
        return function(____, target, ctx) return __TS__ArrayIncludes(ctx.enemies, target) end
    end
end
return ____exports
