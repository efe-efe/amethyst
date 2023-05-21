--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 69,["48"] = 81,["49"] = 304,["50"] = 305,["51"] = 306,["52"] = 307,["54"] = 304,["55"] = 74,["56"] = 75,["57"] = 76,["58"] = 77,["59"] = 78,["60"] = 79,["61"] = 80,["62"] = 81,["63"] = 82,["64"] = 83,["65"] = 91,["66"] = 92,["67"] = 93,["68"] = 94,["69"] = 95,["70"] = 97,["71"] = 98,["72"] = 98,["73"] = 98,["74"] = 98,["75"] = 98,["76"] = 98,["77"] = 98,["78"] = 98,["79"] = 101,["81"] = 104,["82"] = 104,["83"] = 104,["84"] = 104,["85"] = 104,["86"] = 106,["87"] = 107,["88"] = 107,["89"] = 107,["90"] = 107,["91"] = 107,["92"] = 107,["93"] = 107,["94"] = 107,["95"] = 107,["96"] = 107,["97"] = 107,["98"] = 119,["99"] = 120,["101"] = 122,["103"] = 106,["104"] = 126,["105"] = 127,["106"] = 130,["107"] = 132,["110"] = 138,["113"] = 141,["115"] = 126,["116"] = 145,["117"] = 146,["118"] = 147,["119"] = 149,["120"] = 150,["121"] = 151,["122"] = 153,["123"] = 154,["125"] = 157,["126"] = 158,["128"] = 160,["129"] = 145,["130"] = 163,["131"] = 164,["132"] = 163,["133"] = 167,["134"] = 168,["135"] = 168,["136"] = 168,["137"] = 168,["138"] = 172,["139"] = 173,["140"] = 173,["141"] = 173,["142"] = 173,["143"] = 173,["144"] = 173,["145"] = 173,["146"] = 173,["147"] = 168,["148"] = 180,["149"] = 181,["150"] = 181,["151"] = 181,["152"] = 181,["153"] = 181,["154"] = 181,["155"] = 168,["156"] = 168,["157"] = 197,["158"] = 167,["159"] = 200,["160"] = 201,["161"] = 200,["162"] = 204,["163"] = 205,["164"] = 207,["165"] = 208,["167"] = 211,["168"] = 212,["169"] = 213,["170"] = 204,["171"] = 216,["172"] = 218,["173"] = 223,["175"] = 226,["176"] = 227,["177"] = 228,["178"] = 228,["179"] = 228,["180"] = 229,["181"] = 231,["182"] = 232,["183"] = 233,["184"] = 234,["187"] = 237,["188"] = 238,["189"] = 239,["192"] = 242,["193"] = 243,["194"] = 243,["195"] = 244,["196"] = 244,["197"] = 244,["198"] = 243,["199"] = 243,["200"] = 246,["201"] = 247,["204"] = 250,["205"] = 251,["206"] = 251,["207"] = 251,["208"] = 251,["209"] = 252,["210"] = 253,["214"] = 257,["215"] = 258,["217"] = 260,["218"] = 261,["220"] = 228,["221"] = 228,["222"] = 265,["223"] = 266,["224"] = 267,["225"] = 268,["226"] = 269,["228"] = 271,["230"] = 216,["231"] = 275,["232"] = 276,["233"] = 275,["234"] = 279,["235"] = 280,["236"] = 281,["237"] = 283,["238"] = 284,["240"] = 286,["241"] = 287,["242"] = 288,["244"] = 279,["245"] = 292,["246"] = 293,["247"] = 294,["248"] = 295,["249"] = 295,["250"] = 295,["251"] = 295,["252"] = 295,["253"] = 296,["254"] = 296,["255"] = 296,["256"] = 296,["257"] = 296,["258"] = 297,["259"] = 292,["260"] = 300,["261"] = 301,["262"] = 300,["263"] = 311,["264"] = 312,["265"] = 313,["267"] = 315,["268"] = 316,["270"] = 318,["271"] = 319,["274"] = 322,["275"] = 323,["276"] = 324,["277"] = 325,["278"] = 326,["279"] = 327,["282"] = 330,["283"] = 331,["286"] = 334,["287"] = 335,["291"] = 339,["292"] = 340,["293"] = 341,["295"] = 311,["296"] = 345,["297"] = 69,["298"] = 354,["299"] = 360,["300"] = 361,["301"] = 362,["302"] = 366,["303"] = 366,["304"] = 366,["305"] = 366,["306"] = 366,["307"] = 366,["308"] = 370,["309"] = 370,["310"] = 370,["311"] = 370,["312"] = 370,["313"] = 370,["314"] = 374,["315"] = 374,["316"] = 374,["317"] = 374,["318"] = 374,["319"] = 374,["320"] = 374,["321"] = 381,["322"] = 381,["323"] = 381,["324"] = 381,["325"] = 381,["326"] = 381,["327"] = 385,["328"] = 385,["329"] = 385,["330"] = 385,["331"] = 385,["332"] = 385,["333"] = 385,["334"] = 392,["335"] = 392,["336"] = 392,["337"] = 392,["338"] = 392,["339"] = 392,["340"] = 392,["341"] = 399,["342"] = 360,["343"] = 360,["344"] = 359,["345"] = 403,["346"] = 404,["347"] = 405,["348"] = 407,["349"] = 407,["350"] = 407,["351"] = 407,["352"] = 407,["353"] = 407,["354"] = 407,["355"] = 414,["356"] = 414,["357"] = 414,["358"] = 414,["359"] = 414,["360"] = 414,["361"] = 414,["362"] = 421,["363"] = 421,["364"] = 421,["365"] = 421,["366"] = 421,["367"] = 421,["368"] = 421,["369"] = 428,["370"] = 428,["371"] = 428,["372"] = 428,["373"] = 428,["374"] = 428,["375"] = 428,["376"] = 435,["377"] = 435,["378"] = 435,["379"] = 435,["380"] = 435,["381"] = 435,["382"] = 439,["383"] = 403,["384"] = 403,["385"] = 359,["386"] = 443,["387"] = 444,["388"] = 445,["389"] = 450,["390"] = 450,["391"] = 450,["392"] = 450,["393"] = 450,["394"] = 450,["395"] = 454,["396"] = 454,["397"] = 454,["398"] = 454,["399"] = 454,["400"] = 454,["401"] = 454,["402"] = 461,["403"] = 443,["404"] = 443,["405"] = 359,["406"] = 465,["407"] = 466,["408"] = 467,["409"] = 472,["410"] = 472,["411"] = 472,["412"] = 472,["413"] = 472,["414"] = 472,["415"] = 472,["416"] = 479,["417"] = 465,["418"] = 465,["419"] = 359,["420"] = 483,["421"] = 484,["422"] = 485,["423"] = 490,["424"] = 490,["425"] = 490,["426"] = 490,["427"] = 490,["428"] = 490,["429"] = 494,["430"] = 494,["431"] = 494,["432"] = 494,["433"] = 494,["434"] = 494,["435"] = 494,["436"] = 501,["437"] = 483,["438"] = 483,["439"] = 359,["440"] = 505,["441"] = 506,["442"] = 507,["443"] = 514,["444"] = 514,["445"] = 514,["446"] = 514,["447"] = 514,["448"] = 514,["449"] = 514,["450"] = 522,["451"] = 523,["452"] = 505,["453"] = 505,["454"] = 359,["455"] = 527,["456"] = 528,["457"] = 529,["458"] = 536,["459"] = 536,["460"] = 536,["461"] = 536,["462"] = 536,["463"] = 536,["464"] = 536,["465"] = 544,["466"] = 545,["467"] = 527,["468"] = 527,["469"] = 359,["470"] = 549,["471"] = 550,["472"] = 551,["473"] = 558,["474"] = 558,["475"] = 558,["476"] = 558,["477"] = 558,["478"] = 558,["479"] = 558,["480"] = 566,["481"] = 549,["482"] = 549,["483"] = 359,["484"] = 570,["485"] = 571,["486"] = 572,["487"] = 576,["488"] = 576,["489"] = 576,["490"] = 576,["491"] = 576,["492"] = 576,["493"] = 576,["494"] = 583,["495"] = 584,["496"] = 570,["497"] = 570,["498"] = 359,["499"] = 359});
local ____exports = {}
local CustomAIState = CustomAIState or ({})
CustomAIState.IDLE = 0
CustomAIState[CustomAIState.IDLE] = "IDLE"
CustomAIState.WANDERING = 1
CustomAIState[CustomAIState.WANDERING] = "WANDERING"
CustomAIState.RESTING = 2
CustomAIState[CustomAIState.RESTING] = "RESTING"
local CustomAIBehavior = CustomAIBehavior or ({})
CustomAIBehavior.FOLLOWER = 0
CustomAIBehavior[CustomAIBehavior.FOLLOWER] = "FOLLOWER"
CustomAIBehavior.WANDERER = 1
CustomAIBehavior[CustomAIBehavior.WANDERER] = "WANDERER"
CustomAIBehavior.STATIC = 2
CustomAIBehavior[CustomAIBehavior.STATIC] = "STATIC"
____exports.CustomAITier = CustomAITier or ({})
____exports.CustomAITier.BASIC = 1
____exports.CustomAITier[____exports.CustomAITier.BASIC] = "BASIC"
____exports.CustomAITier.MID = 2
____exports.CustomAITier[____exports.CustomAITier.MID] = "MID"
____exports.CustomAITier.HIGH = 3
____exports.CustomAITier[____exports.CustomAITier.HIGH] = "HIGH"
____exports.CustomAITier.BOSS = 4
____exports.CustomAITier[____exports.CustomAITier.BOSS] = "BOSS"
____exports.NPCNames = NPCNames or ({})
____exports.NPCNames.DIRE_ZOMBIE_RANGE = 0
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_RANGE] = "DIRE_ZOMBIE_RANGE"
____exports.NPCNames.DIRE_ZOMBIE_RANGE_MEGA = 1
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_RANGE_MEGA] = "DIRE_ZOMBIE_RANGE_MEGA"
____exports.NPCNames.DIRE_ZOMBIE_MEELE_MEGA = 2
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_MEELE_MEGA] = "DIRE_ZOMBIE_MEELE_MEGA"
____exports.NPCNames.RADIANT_ZOMBIE_RANGE_MEGA = 3
____exports.NPCNames[____exports.NPCNames.RADIANT_ZOMBIE_RANGE_MEGA] = "RADIANT_ZOMBIE_RANGE_MEGA"
____exports.NPCNames.RADIANT_ZOMBIE_MEELE_MEGA = 4
____exports.NPCNames[____exports.NPCNames.RADIANT_ZOMBIE_MEELE_MEGA] = "RADIANT_ZOMBIE_MEELE_MEGA"
____exports.NPCNames.FLYING_SKULL = 5
____exports.NPCNames[____exports.NPCNames.FLYING_SKULL] = "FLYING_SKULL"
____exports.NPCNames.DIRE_TOWER = 6
____exports.NPCNames[____exports.NPCNames.DIRE_TOWER] = "DIRE_TOWER"
____exports.NPCNames.QUEEN = 7
____exports.NPCNames[____exports.NPCNames.QUEEN] = "QUEEN"
____exports.NPCNames.CENTAUR = 8
____exports.NPCNames[____exports.NPCNames.CENTAUR] = "CENTAUR"
local function CustomAI(self, name, origin, options)
    local tauntedDuration, unit, tauntedRemainingDuration, OnUnitHurt
    function OnUnitHurt(self, event)
        local victim = EntIndexToHScript(event.entindex_killed)
        if unit == victim then
            tauntedRemainingDuration = tauntedDuration * 30
        end
    end
    local followRange = options.followRange or 2500
    local restTime = options.restTime or 1
    local tauntedFollowRange = followRange * 1.5
    local minFollowRange = options.minFollowRange or 0
    local behavior = options.behavior or CustomAIBehavior.FOLLOWER
    local originalPosition = origin
    local abilities = {}
    tauntedDuration = 3
    local rangeOfAction = 3000
    unit = CreateUnitByName(name, origin, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    local state = CustomAIState.IDLE
    tauntedRemainingDuration = 0
    local remainingRestTime = 0
    local targetPosition
    local followTarget
    if options.shield then
        unit:AddNewModifier(
            unit,
            nil,
            "modifier_generic_npc_shield",
            {
                damage_block = unit:GetMaxHealth()
            }
        )
        unit:AddNewModifier(unit, nil, "modifier_generic_npc_mini_stun", {})
    end
    ListenToGameEvent(
        "entity_hurt",
        function(event) return OnUnitHurt(nil, event) end,
        nil
    )
    local function FindEnemy(self, radius)
        local units = FindUnitsInRadius(
            unit:GetTeamNumber(),
            unit:GetAbsOrigin(),
            nil,
            radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NO_INVIS,
            FIND_ANY_ORDER,
            false
        )
        if #units > 0 then
            return units[1]
        else
            return nil
        end
    end
    local function UpdateTarget(self)
        local currentFollowRange = ((tauntedRemainingDuration > 0) and tauntedFollowRange) or followRange
        if followTarget then
            if (CustomEntitiesLegacy:GetDistance(unit, followTarget) <= currentFollowRange) and (not followTarget:IsInvisible()) then
                return
            else
                followTarget = nil
            end
        else
            followTarget = FindEnemy(nil, followRange)
        end
    end
    local function Follow(self)
        local origin = unit:GetAbsOrigin()
        UpdateTarget(nil)
        if followTarget and followTarget:IsAlive() then
            local distance = CustomEntitiesLegacy:GetDistance(unit, followTarget)
            local direction = Vector(0, 0)
            if followTarget:IsAlive() and (distance > minFollowRange) then
                direction = followTarget:GetAbsOrigin():__sub(origin):Normalized()
            end
            CustomEntitiesLegacy:SetDirection(unit, direction.x, direction.y)
            return true
        end
        return false
    end
    local function IsAbilityReady(self, ability)
        return ability:IsCooldownReady() and (not ability:IsInAbilityPhase())
    end
    local function RegisterAbility(self, options)
        local npcAbility = {
            ability = options.ability,
            orderType = options.orderType,
            priority = #abilities + 1,
            cast = function(____, ability, target)
                ExecuteOrderFromTable(
                    {
                        OrderType = options.orderType,
                        UnitIndex = unit:GetEntityIndex(),
                        AbilityIndex = ability:GetEntityIndex(),
                        Position = (target and target:GetAbsOrigin()) or nil
                    }
                )
            end,
            requirements = (options.requirements and __TS__ObjectAssign(
                {},
                options.requirements,
                {
                    cooldownReady = (((options.requirements.cooldownReady ~= nil) and (function() return options.requirements.cooldownReady end)) or (function() return true end))(),
                    phaseReady = (((options.requirements.phaseReady ~= nil) and (function() return options.requirements.phaseReady end)) or (function() return true end))()
                }
            )) or ({cooldownReady = true, phaseReady = true})
        }
        __TS__ArrayPush(abilities, npcAbility)
    end
    local function StartRest(self, restTime)
        remainingRestTime = restTime * 30
    end
    local function BackToOrigin(self, origin)
        local distanceFromOrigin = originalPosition:__sub(origin):Length2D()
        if rangeOfAction > distanceFromOrigin then
            return false
        end
        local direction = originalPosition:__sub(origin):Normalized()
        CustomEntitiesLegacy:SetDirection(unit, direction.x, direction.y)
        return true
    end
    local function Cast(self)
        if ((CustomEntitiesLegacy:IsDisplacing(unit) or CustomEntitiesLegacy:IsCasting(unit)) or CustomEntitiesLegacy:IsChanneling(unit)) or (remainingRestTime > 0) then
            return false
        end
        local abilityToExecute = nil
        local abilityTarget = nil
        __TS__ArrayForEach(
            abilities,
            function(____, npcAbility)
                local ability = npcAbility.ability
                if npcAbility.requirements then
                    if npcAbility.requirements.cooldownReady then
                        if not npcAbility.ability:IsCooldownReady() then
                            return false
                        end
                    end
                    if npcAbility.requirements.phaseReady then
                        if npcAbility.ability:IsInAbilityPhase() then
                            return false
                        end
                    end
                    if npcAbility.requirements.targetInCastRange then
                        abilityTarget = FindEnemy(
                            nil,
                            ability:GetCastRange(
                                Vector(0, 0, 0),
                                nil
                            )
                        )
                        if not abilityTarget then
                            return false
                        end
                    end
                    if npcAbility.requirements.targetInRadius then
                        abilityTarget = FindEnemy(
                            nil,
                            ability:GetSpecialValueFor("radius")
                        )
                        if not abilityTarget then
                            return false
                        end
                    end
                end
                if abilityToExecute == nil then
                    abilityToExecute = npcAbility
                end
                if npcAbility.priority > abilityToExecute.priority then
                    abilityToExecute = npcAbility
                end
            end
        )
        if abilityToExecute then
            abilityToExecute = abilityToExecute
            abilityToExecute:cast(abilityToExecute.ability, abilityTarget)
            StartRest(nil, restTime)
            return true
        else
            return false
        end
    end
    local function StopMoving(self)
        CustomEntitiesLegacy:SetDirection(unit, 0, 0)
    end
    local function MoveTowards(self, point)
        local origin = unit:GetAbsOrigin()
        local distance = point:__sub(origin):Length2D()
        if distance < 10 then
            return false
        else
            local direction = point:__sub(origin):Normalized()
            CustomEntitiesLegacy:SetDirection(unit, direction.x, direction.y)
            return true
        end
    end
    local function PickTargetPosition(self)
        local origin = unit:GetAbsOrigin()
        local worldLimits = 1500
        local x = Clamp(
            origin.x + RandomInt(-400, 400),
            worldLimits,
            -worldLimits
        )
        local y = Clamp(
            origin.y + RandomInt(-400, 400),
            worldLimits,
            -worldLimits
        )
        targetPosition = Vector(x, y)
    end
    local function ClearTargetPosition(self)
        targetPosition = nil
    end
    local function Update(self)
        if tauntedRemainingDuration > 0 then
            tauntedRemainingDuration = tauntedRemainingDuration - 1
        end
        if remainingRestTime > 0 then
            remainingRestTime = remainingRestTime - 1
        end
        if not Cast(nil) then
            if behavior == CustomAIBehavior.STATIC then
                return
            end
            if behavior == CustomAIBehavior.WANDERER then
                if (state == CustomAIState.WANDERING) and targetPosition then
                    if not MoveTowards(nil, targetPosition) then
                        state = CustomAIState.IDLE
                        ClearTargetPosition(nil)
                        StopMoving(nil)
                    end
                else
                    state = CustomAIState.WANDERING
                    PickTargetPosition(nil)
                end
            else
                if not Follow(nil) then
                    StopMoving(nil)
                end
            end
        else
            remainingRestTime = 1 * 30
            ClearTargetPosition(nil)
            StopMoving(nil)
        end
    end
    return {unit = unit, IsAbilityReady = IsAbilityReady, RegisterAbility = RegisterAbility, Update = Update, BackToOrigin = BackToOrigin}
end
____exports.CustomAIMeta = {
    [____exports.NPCNames.QUEEN] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "npc_dota_hero_queenofpain", origin, {minFollowRange = 500})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_scream"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_dodge"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_blink"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_daggers"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_wave"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BOSS
    },
    [____exports.NPCNames.CENTAUR] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "npc_dota_hero_centaur", origin, {})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_axe_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInRadius = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_range_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_short_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    requirements = {targetInRadius = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_charge"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_rage"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BOSS
    },
    [____exports.NPCNames.RADIANT_ZOMBIE_RANGE_MEGA] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "radiant_zombie_healer", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("radiant_zombie_heal_aura"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.DIRE_ZOMBIE_RANGE] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "dire_zombie_range", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.DIRE_ZOMBIE_RANGE_MEGA] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "dire_zombie_range_mega", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_rage_aura"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.DIRE_ZOMBIE_MEELE_MEGA] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "dire_zombie_meele_mega", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack_meele"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:SetHullRadius(95)
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.RADIANT_ZOMBIE_MEELE_MEGA] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "radiant_zombie_meele", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack_meele"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:SetHullRadius(95)
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.FLYING_SKULL] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "flying_skull", origin, {followRange = 1000, minFollowRange = 150, behavior = CustomAIBehavior.FOLLOWER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("flying_skull_dash"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.DIRE_TOWER] = {
        factory = function(____, origin)
            local ai = CustomAI(nil, "dire_tower", origin, {behavior = CustomAIBehavior.STATIC})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_tower_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:SetHullRadius(100)
            return ai
        end,
        tier = ____exports.CustomAITier.HIGH
    }
}
return ____exports
