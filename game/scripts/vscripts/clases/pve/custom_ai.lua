--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 69,["48"] = 77,["49"] = 279,["50"] = 280,["51"] = 281,["52"] = 282,["54"] = 279,["55"] = 70,["56"] = 71,["57"] = 72,["58"] = 73,["59"] = 74,["60"] = 75,["61"] = 76,["62"] = 77,["63"] = 78,["64"] = 79,["65"] = 87,["66"] = 88,["67"] = 89,["68"] = 90,["69"] = 91,["70"] = 94,["71"] = 95,["72"] = 95,["73"] = 95,["74"] = 95,["75"] = 95,["76"] = 95,["77"] = 95,["78"] = 95,["79"] = 96,["81"] = 99,["82"] = 99,["83"] = 99,["84"] = 99,["85"] = 99,["86"] = 101,["87"] = 102,["88"] = 102,["89"] = 102,["90"] = 102,["91"] = 102,["92"] = 102,["93"] = 102,["94"] = 102,["95"] = 102,["96"] = 102,["97"] = 102,["98"] = 114,["99"] = 115,["101"] = 117,["103"] = 101,["104"] = 121,["105"] = 122,["106"] = 124,["107"] = 125,["110"] = 128,["113"] = 131,["115"] = 121,["116"] = 135,["117"] = 136,["118"] = 137,["119"] = 139,["120"] = 140,["121"] = 141,["122"] = 143,["123"] = 144,["125"] = 147,["126"] = 148,["128"] = 150,["129"] = 135,["130"] = 153,["131"] = 154,["132"] = 153,["133"] = 157,["134"] = 158,["135"] = 158,["136"] = 158,["137"] = 158,["138"] = 162,["139"] = 163,["140"] = 163,["141"] = 163,["142"] = 163,["143"] = 163,["144"] = 163,["145"] = 163,["146"] = 163,["147"] = 158,["148"] = 170,["149"] = 170,["150"] = 170,["151"] = 170,["152"] = 170,["153"] = 170,["154"] = 170,["155"] = 158,["156"] = 158,["157"] = 179,["158"] = 157,["159"] = 182,["160"] = 183,["161"] = 182,["162"] = 186,["163"] = 187,["164"] = 189,["165"] = 190,["167"] = 193,["168"] = 194,["169"] = 195,["170"] = 186,["171"] = 198,["172"] = 199,["173"] = 200,["175"] = 203,["176"] = 204,["177"] = 205,["178"] = 205,["179"] = 205,["180"] = 206,["181"] = 208,["182"] = 209,["183"] = 210,["184"] = 211,["187"] = 214,["188"] = 215,["189"] = 216,["192"] = 219,["193"] = 220,["194"] = 220,["195"] = 220,["196"] = 220,["197"] = 220,["198"] = 220,["199"] = 220,["200"] = 221,["201"] = 222,["204"] = 225,["205"] = 226,["206"] = 226,["207"] = 226,["208"] = 226,["209"] = 227,["210"] = 228,["214"] = 232,["215"] = 233,["217"] = 235,["218"] = 236,["220"] = 205,["221"] = 205,["222"] = 240,["223"] = 241,["224"] = 242,["225"] = 243,["226"] = 244,["228"] = 246,["230"] = 198,["231"] = 250,["232"] = 251,["233"] = 250,["234"] = 254,["235"] = 255,["236"] = 256,["237"] = 258,["238"] = 259,["240"] = 261,["241"] = 262,["242"] = 263,["244"] = 254,["245"] = 267,["246"] = 268,["247"] = 269,["248"] = 270,["249"] = 270,["250"] = 270,["251"] = 270,["252"] = 270,["253"] = 271,["254"] = 271,["255"] = 271,["256"] = 271,["257"] = 271,["258"] = 272,["259"] = 267,["260"] = 275,["261"] = 276,["262"] = 275,["263"] = 286,["264"] = 287,["265"] = 288,["267"] = 290,["268"] = 291,["270"] = 293,["271"] = 294,["274"] = 297,["275"] = 298,["276"] = 299,["277"] = 300,["278"] = 301,["279"] = 302,["282"] = 305,["283"] = 306,["286"] = 309,["287"] = 310,["291"] = 314,["292"] = 315,["293"] = 316,["295"] = 286,["296"] = 320,["297"] = 69,["298"] = 329,["299"] = 335,["300"] = 336,["301"] = 337,["302"] = 341,["303"] = 341,["304"] = 341,["305"] = 341,["306"] = 341,["307"] = 341,["308"] = 345,["309"] = 345,["310"] = 345,["311"] = 345,["312"] = 345,["313"] = 345,["314"] = 349,["315"] = 349,["316"] = 349,["317"] = 349,["318"] = 349,["319"] = 349,["320"] = 349,["321"] = 356,["322"] = 356,["323"] = 356,["324"] = 356,["325"] = 356,["326"] = 356,["327"] = 360,["328"] = 360,["329"] = 360,["330"] = 360,["331"] = 360,["332"] = 360,["333"] = 360,["334"] = 367,["335"] = 367,["336"] = 367,["337"] = 367,["338"] = 367,["339"] = 367,["340"] = 367,["341"] = 374,["342"] = 335,["343"] = 335,["344"] = 334,["345"] = 378,["346"] = 379,["347"] = 380,["348"] = 382,["349"] = 382,["350"] = 382,["351"] = 382,["352"] = 382,["353"] = 382,["354"] = 382,["355"] = 389,["356"] = 389,["357"] = 389,["358"] = 389,["359"] = 389,["360"] = 389,["361"] = 389,["362"] = 396,["363"] = 396,["364"] = 396,["365"] = 396,["366"] = 396,["367"] = 396,["368"] = 396,["369"] = 403,["370"] = 403,["371"] = 403,["372"] = 403,["373"] = 403,["374"] = 403,["375"] = 403,["376"] = 410,["377"] = 410,["378"] = 410,["379"] = 410,["380"] = 410,["381"] = 410,["382"] = 414,["383"] = 378,["384"] = 378,["385"] = 334,["386"] = 418,["387"] = 419,["388"] = 420,["389"] = 425,["390"] = 425,["391"] = 425,["392"] = 425,["393"] = 425,["394"] = 425,["395"] = 429,["396"] = 429,["397"] = 429,["398"] = 429,["399"] = 429,["400"] = 429,["401"] = 429,["402"] = 436,["403"] = 418,["404"] = 418,["405"] = 334,["406"] = 440,["407"] = 441,["408"] = 442,["409"] = 447,["410"] = 447,["411"] = 447,["412"] = 447,["413"] = 447,["414"] = 447,["415"] = 447,["416"] = 454,["417"] = 440,["418"] = 440,["419"] = 334,["420"] = 458,["421"] = 459,["422"] = 460,["423"] = 465,["424"] = 465,["425"] = 465,["426"] = 465,["427"] = 465,["428"] = 465,["429"] = 469,["430"] = 469,["431"] = 469,["432"] = 469,["433"] = 469,["434"] = 469,["435"] = 469,["436"] = 476,["437"] = 458,["438"] = 458,["439"] = 334,["440"] = 480,["441"] = 481,["442"] = 482,["443"] = 489,["444"] = 489,["445"] = 489,["446"] = 489,["447"] = 489,["448"] = 489,["449"] = 489,["450"] = 497,["451"] = 498,["452"] = 480,["453"] = 480,["454"] = 334,["455"] = 502,["456"] = 503,["457"] = 504,["458"] = 511,["459"] = 511,["460"] = 511,["461"] = 511,["462"] = 511,["463"] = 511,["464"] = 511,["465"] = 519,["466"] = 520,["467"] = 502,["468"] = 502,["469"] = 334,["470"] = 524,["471"] = 525,["472"] = 526,["473"] = 533,["474"] = 533,["475"] = 533,["476"] = 533,["477"] = 533,["478"] = 533,["479"] = 533,["480"] = 541,["481"] = 524,["482"] = 524,["483"] = 334,["484"] = 545,["485"] = 546,["486"] = 547,["487"] = 551,["488"] = 551,["489"] = 551,["490"] = 551,["491"] = 551,["492"] = 551,["493"] = 551,["494"] = 558,["495"] = 559,["496"] = 545,["497"] = 545,["498"] = 334,["499"] = 334});
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
