--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 61,["48"] = 61,["49"] = 61,["50"] = 79,["51"] = 62,["52"] = 63,["53"] = 66,["54"] = 67,["55"] = 70,["56"] = 71,["57"] = 80,["58"] = 89,["59"] = 90,["60"] = 90,["61"] = 90,["62"] = 90,["63"] = 90,["64"] = 90,["65"] = 90,["66"] = 90,["67"] = 91,["69"] = 94,["70"] = 95,["71"] = 96,["72"] = 97,["73"] = 98,["74"] = 99,["75"] = 79,["76"] = 102,["77"] = 103,["78"] = 103,["79"] = 103,["80"] = 103,["81"] = 103,["82"] = 103,["83"] = 103,["84"] = 103,["85"] = 103,["86"] = 103,["87"] = 103,["88"] = 115,["89"] = 116,["91"] = 118,["93"] = 102,["94"] = 122,["95"] = 123,["96"] = 125,["97"] = 126,["100"] = 129,["103"] = 132,["105"] = 122,["106"] = 136,["107"] = 137,["108"] = 138,["109"] = 140,["110"] = 141,["111"] = 142,["112"] = 144,["113"] = 145,["115"] = 148,["116"] = 149,["118"] = 151,["119"] = 136,["120"] = 154,["121"] = 155,["122"] = 154,["123"] = 158,["124"] = 159,["125"] = 159,["126"] = 159,["127"] = 159,["128"] = 163,["129"] = 164,["130"] = 164,["131"] = 164,["132"] = 164,["133"] = 164,["134"] = 164,["135"] = 164,["136"] = 164,["137"] = 159,["138"] = 171,["139"] = 171,["140"] = 171,["141"] = 171,["142"] = 171,["143"] = 171,["144"] = 171,["145"] = 159,["146"] = 159,["147"] = 180,["148"] = 158,["149"] = 183,["150"] = 184,["151"] = 183,["152"] = 187,["153"] = 188,["154"] = 190,["155"] = 191,["157"] = 194,["158"] = 195,["159"] = 196,["160"] = 187,["161"] = 199,["162"] = 200,["163"] = 201,["165"] = 204,["166"] = 205,["167"] = 206,["168"] = 206,["169"] = 206,["170"] = 207,["171"] = 209,["172"] = 210,["173"] = 211,["174"] = 212,["177"] = 215,["178"] = 216,["179"] = 217,["182"] = 220,["183"] = 221,["184"] = 221,["185"] = 221,["186"] = 221,["187"] = 221,["188"] = 221,["189"] = 222,["190"] = 223,["193"] = 226,["194"] = 227,["195"] = 227,["196"] = 227,["197"] = 228,["198"] = 229,["202"] = 233,["203"] = 234,["205"] = 236,["206"] = 237,["208"] = 206,["209"] = 206,["210"] = 241,["211"] = 242,["212"] = 243,["213"] = 244,["214"] = 245,["216"] = 247,["218"] = 199,["219"] = 251,["220"] = 252,["221"] = 251,["222"] = 255,["223"] = 256,["224"] = 257,["225"] = 259,["226"] = 260,["228"] = 262,["229"] = 263,["230"] = 264,["232"] = 255,["233"] = 268,["234"] = 269,["235"] = 270,["236"] = 271,["237"] = 271,["238"] = 271,["239"] = 271,["240"] = 271,["241"] = 272,["242"] = 272,["243"] = 272,["244"] = 272,["245"] = 272,["246"] = 273,["247"] = 268,["248"] = 276,["249"] = 277,["250"] = 276,["251"] = 280,["252"] = 281,["253"] = 280,["254"] = 284,["255"] = 285,["256"] = 286,["258"] = 288,["259"] = 289,["261"] = 291,["262"] = 292,["265"] = 295,["266"] = 296,["267"] = 297,["268"] = 298,["269"] = 299,["270"] = 300,["273"] = 303,["274"] = 304,["277"] = 307,["278"] = 308,["282"] = 312,["283"] = 313,["284"] = 314,["286"] = 284,["287"] = 319,["288"] = 325,["289"] = 326,["290"] = 327,["291"] = 331,["292"] = 331,["293"] = 331,["294"] = 331,["295"] = 331,["296"] = 331,["297"] = 335,["298"] = 335,["299"] = 335,["300"] = 335,["301"] = 335,["302"] = 335,["303"] = 339,["304"] = 339,["305"] = 339,["306"] = 339,["307"] = 339,["308"] = 339,["309"] = 339,["310"] = 346,["311"] = 346,["312"] = 346,["313"] = 346,["314"] = 346,["315"] = 346,["316"] = 350,["317"] = 350,["318"] = 350,["319"] = 350,["320"] = 350,["321"] = 350,["322"] = 350,["323"] = 357,["324"] = 357,["325"] = 357,["326"] = 357,["327"] = 357,["328"] = 357,["329"] = 357,["330"] = 364,["331"] = 325,["332"] = 325,["333"] = 324,["334"] = 368,["335"] = 369,["336"] = 370,["337"] = 372,["338"] = 372,["339"] = 372,["340"] = 372,["341"] = 372,["342"] = 372,["343"] = 372,["344"] = 379,["345"] = 379,["346"] = 379,["347"] = 379,["348"] = 379,["349"] = 379,["350"] = 379,["351"] = 386,["352"] = 386,["353"] = 386,["354"] = 386,["355"] = 386,["356"] = 386,["357"] = 386,["358"] = 393,["359"] = 393,["360"] = 393,["361"] = 393,["362"] = 393,["363"] = 393,["364"] = 393,["365"] = 400,["366"] = 400,["367"] = 400,["368"] = 400,["369"] = 400,["370"] = 400,["371"] = 404,["372"] = 368,["373"] = 368,["374"] = 324,["375"] = 408,["376"] = 409,["377"] = 410,["378"] = 415,["379"] = 415,["380"] = 415,["381"] = 415,["382"] = 415,["383"] = 415,["384"] = 419,["385"] = 419,["386"] = 419,["387"] = 419,["388"] = 419,["389"] = 419,["390"] = 419,["391"] = 426,["392"] = 408,["393"] = 408,["394"] = 324,["395"] = 430,["396"] = 431,["397"] = 432,["398"] = 437,["399"] = 437,["400"] = 437,["401"] = 437,["402"] = 437,["403"] = 437,["404"] = 437,["405"] = 444,["406"] = 430,["407"] = 430,["408"] = 324,["409"] = 448,["410"] = 449,["411"] = 450,["412"] = 455,["413"] = 455,["414"] = 455,["415"] = 455,["416"] = 455,["417"] = 455,["418"] = 459,["419"] = 459,["420"] = 459,["421"] = 459,["422"] = 459,["423"] = 459,["424"] = 459,["425"] = 466,["426"] = 448,["427"] = 448,["428"] = 324,["429"] = 470,["430"] = 471,["431"] = 472,["432"] = 479,["433"] = 479,["434"] = 479,["435"] = 479,["436"] = 479,["437"] = 479,["438"] = 479,["439"] = 487,["440"] = 488,["441"] = 470,["442"] = 470,["443"] = 324,["444"] = 492,["445"] = 493,["446"] = 494,["447"] = 501,["448"] = 501,["449"] = 501,["450"] = 501,["451"] = 501,["452"] = 501,["453"] = 501,["454"] = 509,["455"] = 510,["456"] = 492,["457"] = 492,["458"] = 324,["459"] = 514,["460"] = 515,["461"] = 516,["462"] = 523,["463"] = 523,["464"] = 523,["465"] = 523,["466"] = 523,["467"] = 523,["468"] = 523,["469"] = 531,["470"] = 514,["471"] = 514,["472"] = 324,["473"] = 535,["474"] = 536,["475"] = 537,["476"] = 541,["477"] = 541,["478"] = 541,["479"] = 541,["480"] = 541,["481"] = 541,["482"] = 541,["483"] = 548,["484"] = 549,["485"] = 535,["486"] = 535,["487"] = 324,["488"] = 324});
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
____exports.CustomAI = __TS__Class()
local CustomAI = ____exports.CustomAI
CustomAI.name = "CustomAI"
function CustomAI.prototype.____constructor(self, name, origin, options)
    self.state = CustomAIState.IDLE
    self.abilities = {}
    self.tauntedDuration = 3
    self.tauntedRemainingDuration = 0
    self.remainingRestTime = 0
    self.rangeOfAction = 3000
    self.unit = CreateUnitByName(name, origin, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    if options.shield then
        self.unit:AddNewModifier(
            self.unit,
            nil,
            "modifier_generic_npc_shield",
            {
                damage_block = self.unit:GetMaxHealth()
            }
        )
        self.unit:AddNewModifier(self.unit, nil, "modifier_generic_npc_mini_stun", {})
    end
    self.restTime = options.restTime or 1
    self.followRange = options.followRange or 2500
    self.tauntedFollowRange = self.followRange * 1.5
    self.minFollowRange = options.minFollowRange or 0
    self.behavior = options.behavior or CustomAIBehavior.FOLLOWER
    self.originalPosition = origin
end
function CustomAI.prototype.FindEnemy(self, radius)
    local units = FindUnitsInRadius(
        self.unit:GetTeamNumber(),
        self.unit:GetAbsOrigin(),
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
function CustomAI.prototype.UpdateTarget(self)
    local followRange = ((self.tauntedRemainingDuration > 0) and self.tauntedFollowRange) or self.followRange
    if self.followTarget then
        if (CustomEntitiesLegacy:GetDistance(self.unit, self.followTarget) <= followRange) and (not self.followTarget:IsInvisible()) then
            return
        else
            self.followTarget = nil
        end
    else
        self.followTarget = self:FindEnemy(followRange)
    end
end
function CustomAI.prototype.Follow(self)
    local origin = self.unit:GetAbsOrigin()
    self:UpdateTarget()
    if self.followTarget and self.followTarget:IsAlive() then
        local distance = CustomEntitiesLegacy:GetDistance(self.unit, self.followTarget)
        local direction = Vector(0, 0)
        if self.followTarget:IsAlive() and (distance > self.minFollowRange) then
            direction = self.followTarget:GetAbsOrigin():__sub(origin):Normalized()
        end
        CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
        return true
    end
    return false
end
function CustomAI.prototype.IsAbilityReady(self, ability)
    return ability:IsCooldownReady() and (not ability:IsInAbilityPhase())
end
function CustomAI.prototype.RegisterAbility(self, options)
    local npcAbility = {
        ability = options.ability,
        orderType = options.orderType,
        priority = #self.abilities + 1,
        cast = function(____, ability, target)
            ExecuteOrderFromTable(
                {
                    OrderType = options.orderType,
                    UnitIndex = self.unit:GetEntityIndex(),
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
    __TS__ArrayPush(self.abilities, npcAbility)
end
function CustomAI.prototype.StartRest(self, restTime)
    self.remainingRestTime = restTime * 30
end
function CustomAI.prototype.BackToOrigin(self, origin)
    local distanceFromOrigin = self.originalPosition:__sub(origin):Length2D()
    if self.rangeOfAction > distanceFromOrigin then
        return false
    end
    local direction = self.originalPosition:__sub(origin):Normalized()
    CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
    return true
end
function CustomAI.prototype.Cast(self)
    if ((CustomEntitiesLegacy:IsDisplacing(self.unit) or CustomEntitiesLegacy:IsCasting(self.unit)) or CustomEntitiesLegacy:IsChanneling(self.unit)) or (self.remainingRestTime > 0) then
        return false
    end
    local abilityToExecute = nil
    local abilityTarget = nil
    __TS__ArrayForEach(
        self.abilities,
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
                    abilityTarget = self:FindEnemy(
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
                    abilityTarget = self:FindEnemy(
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
        self:StartRest(self.restTime)
        return true
    else
        return false
    end
end
function CustomAI.prototype.StopMoving(self)
    CustomEntitiesLegacy:SetDirection(self.unit, 0, 0)
end
function CustomAI.prototype.MoveTowards(self, point)
    local origin = self.unit:GetAbsOrigin()
    local distance = point:__sub(origin):Length2D()
    if distance < 10 then
        return false
    else
        local direction = point:__sub(origin):Normalized()
        CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
        return true
    end
end
function CustomAI.prototype.PickTargetPosition(self)
    local origin = self.unit:GetAbsOrigin()
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
    self.targetPosition = Vector(x, y)
end
function CustomAI.prototype.ClearTargetPosition(self)
    self.targetPosition = nil
end
function CustomAI.prototype.OnHurt(self)
    self.tauntedRemainingDuration = self.tauntedDuration * 30
end
function CustomAI.prototype.Update(self)
    if self.tauntedRemainingDuration > 0 then
        self.tauntedRemainingDuration = self.tauntedRemainingDuration - 1
    end
    if self.remainingRestTime > 0 then
        self.remainingRestTime = self.remainingRestTime - 1
    end
    if not self:Cast() then
        if self.behavior == CustomAIBehavior.STATIC then
            return
        end
        if self.behavior == CustomAIBehavior.WANDERER then
            if (self.state == CustomAIState.WANDERING) and self.targetPosition then
                if not self:MoveTowards(self.targetPosition) then
                    self.state = CustomAIState.IDLE
                    self:ClearTargetPosition()
                    self:StopMoving()
                end
            else
                self.state = CustomAIState.WANDERING
                self:PickTargetPosition()
            end
        else
            if not self:Follow() then
                self:StopMoving()
            end
        end
    else
        self.remainingRestTime = 1 * 30
        self:ClearTargetPosition()
        self:StopMoving()
    end
end
____exports.CustomAIMeta = {
    [____exports.NPCNames.QUEEN] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "npc_dota_hero_queenofpain", origin, {minFollowRange = 500})
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
            local ai = __TS__New(____exports.CustomAI, "npc_dota_hero_centaur", origin, {})
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
            local ai = __TS__New(____exports.CustomAI, "radiant_zombie_healer", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
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
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_range", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
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
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_range_mega", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
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
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_meele_mega", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER, shield = true})
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
            local ai = __TS__New(____exports.CustomAI, "radiant_zombie_meele", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER, shield = true})
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
            local ai = __TS__New(____exports.CustomAI, "flying_skull", origin, {followRange = 1000, minFollowRange = 150, behavior = CustomAIBehavior.FOLLOWER, shield = true})
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
            local ai = __TS__New(____exports.CustomAI, "dire_tower", origin, {behavior = CustomAIBehavior.STATIC})
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
