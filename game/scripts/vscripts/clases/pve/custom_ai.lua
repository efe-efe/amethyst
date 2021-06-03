--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 61,["48"] = 61,["49"] = 61,["50"] = 79,["51"] = 62,["52"] = 63,["53"] = 66,["54"] = 67,["55"] = 70,["56"] = 71,["57"] = 80,["58"] = 89,["59"] = 90,["60"] = 90,["61"] = 90,["62"] = 90,["63"] = 90,["64"] = 90,["65"] = 90,["66"] = 90,["67"] = 91,["69"] = 94,["70"] = 95,["71"] = 96,["72"] = 97,["73"] = 98,["74"] = 99,["75"] = 79,["76"] = 102,["77"] = 103,["78"] = 103,["79"] = 103,["80"] = 103,["81"] = 103,["82"] = 103,["83"] = 103,["84"] = 103,["85"] = 103,["86"] = 103,["87"] = 103,["88"] = 115,["89"] = 116,["91"] = 118,["93"] = 102,["94"] = 122,["95"] = 123,["96"] = 125,["97"] = 126,["100"] = 129,["103"] = 132,["105"] = 122,["106"] = 136,["107"] = 137,["108"] = 139,["109"] = 140,["111"] = 142,["112"] = 143,["113"] = 145,["114"] = 146,["116"] = 149,["117"] = 150,["118"] = 136,["119"] = 153,["120"] = 154,["121"] = 153,["122"] = 157,["123"] = 158,["124"] = 158,["125"] = 158,["126"] = 158,["127"] = 162,["128"] = 163,["129"] = 163,["130"] = 163,["131"] = 163,["132"] = 163,["133"] = 163,["134"] = 163,["135"] = 163,["136"] = 158,["137"] = 170,["138"] = 170,["139"] = 170,["140"] = 170,["141"] = 170,["142"] = 170,["143"] = 170,["144"] = 158,["145"] = 158,["146"] = 179,["147"] = 157,["148"] = 182,["149"] = 183,["150"] = 182,["151"] = 186,["152"] = 187,["153"] = 189,["154"] = 190,["156"] = 193,["157"] = 194,["158"] = 195,["159"] = 186,["160"] = 198,["161"] = 199,["162"] = 200,["164"] = 203,["165"] = 204,["166"] = 205,["167"] = 205,["168"] = 205,["169"] = 206,["170"] = 208,["171"] = 209,["172"] = 210,["173"] = 211,["176"] = 214,["177"] = 215,["178"] = 216,["181"] = 219,["182"] = 220,["183"] = 220,["184"] = 220,["185"] = 220,["186"] = 220,["187"] = 220,["188"] = 221,["189"] = 222,["192"] = 225,["193"] = 226,["194"] = 226,["195"] = 226,["196"] = 227,["197"] = 228,["201"] = 232,["202"] = 233,["204"] = 235,["205"] = 236,["207"] = 205,["208"] = 205,["209"] = 240,["210"] = 241,["211"] = 242,["212"] = 243,["213"] = 244,["215"] = 246,["217"] = 198,["218"] = 250,["219"] = 251,["220"] = 250,["221"] = 254,["222"] = 255,["223"] = 257,["224"] = 258,["226"] = 260,["227"] = 261,["228"] = 262,["230"] = 254,["231"] = 266,["232"] = 267,["233"] = 268,["234"] = 268,["235"] = 268,["236"] = 268,["237"] = 268,["238"] = 269,["239"] = 269,["240"] = 269,["241"] = 269,["242"] = 269,["243"] = 270,["244"] = 266,["245"] = 273,["246"] = 274,["247"] = 273,["248"] = 277,["249"] = 278,["250"] = 277,["251"] = 281,["252"] = 282,["253"] = 284,["254"] = 285,["256"] = 287,["257"] = 288,["259"] = 290,["260"] = 291,["263"] = 294,["264"] = 295,["265"] = 296,["266"] = 297,["267"] = 298,["268"] = 299,["271"] = 302,["272"] = 303,["275"] = 306,["276"] = 307,["280"] = 311,["281"] = 312,["282"] = 313,["284"] = 281,["285"] = 318,["286"] = 324,["287"] = 325,["288"] = 326,["289"] = 330,["290"] = 330,["291"] = 330,["292"] = 330,["293"] = 330,["294"] = 330,["295"] = 334,["296"] = 334,["297"] = 334,["298"] = 334,["299"] = 334,["300"] = 334,["301"] = 338,["302"] = 338,["303"] = 338,["304"] = 338,["305"] = 338,["306"] = 338,["307"] = 338,["308"] = 345,["309"] = 345,["310"] = 345,["311"] = 345,["312"] = 345,["313"] = 345,["314"] = 349,["315"] = 349,["316"] = 349,["317"] = 349,["318"] = 349,["319"] = 349,["320"] = 349,["321"] = 356,["322"] = 356,["323"] = 356,["324"] = 356,["325"] = 356,["326"] = 356,["327"] = 356,["328"] = 363,["329"] = 324,["330"] = 324,["331"] = 323,["332"] = 367,["333"] = 368,["334"] = 369,["335"] = 371,["336"] = 371,["337"] = 371,["338"] = 371,["339"] = 371,["340"] = 371,["341"] = 371,["342"] = 378,["343"] = 378,["344"] = 378,["345"] = 378,["346"] = 378,["347"] = 378,["348"] = 378,["349"] = 385,["350"] = 385,["351"] = 385,["352"] = 385,["353"] = 385,["354"] = 385,["355"] = 385,["356"] = 392,["357"] = 392,["358"] = 392,["359"] = 392,["360"] = 392,["361"] = 392,["362"] = 392,["363"] = 399,["364"] = 399,["365"] = 399,["366"] = 399,["367"] = 399,["368"] = 399,["369"] = 403,["370"] = 367,["371"] = 367,["372"] = 323,["373"] = 407,["374"] = 408,["375"] = 409,["376"] = 414,["377"] = 414,["378"] = 414,["379"] = 414,["380"] = 414,["381"] = 414,["382"] = 418,["383"] = 418,["384"] = 418,["385"] = 418,["386"] = 418,["387"] = 418,["388"] = 418,["389"] = 425,["390"] = 407,["391"] = 407,["392"] = 323,["393"] = 429,["394"] = 430,["395"] = 431,["396"] = 436,["397"] = 436,["398"] = 436,["399"] = 436,["400"] = 436,["401"] = 436,["402"] = 436,["403"] = 443,["404"] = 429,["405"] = 429,["406"] = 323,["407"] = 447,["408"] = 448,["409"] = 449,["410"] = 454,["411"] = 454,["412"] = 454,["413"] = 454,["414"] = 454,["415"] = 454,["416"] = 458,["417"] = 458,["418"] = 458,["419"] = 458,["420"] = 458,["421"] = 458,["422"] = 458,["423"] = 465,["424"] = 447,["425"] = 447,["426"] = 323,["427"] = 469,["428"] = 470,["429"] = 471,["430"] = 478,["431"] = 478,["432"] = 478,["433"] = 478,["434"] = 478,["435"] = 478,["436"] = 478,["437"] = 486,["438"] = 487,["439"] = 469,["440"] = 469,["441"] = 323,["442"] = 491,["443"] = 492,["444"] = 493,["445"] = 500,["446"] = 500,["447"] = 500,["448"] = 500,["449"] = 500,["450"] = 500,["451"] = 500,["452"] = 508,["453"] = 509,["454"] = 491,["455"] = 491,["456"] = 323,["457"] = 513,["458"] = 514,["459"] = 515,["460"] = 522,["461"] = 522,["462"] = 522,["463"] = 522,["464"] = 522,["465"] = 522,["466"] = 522,["467"] = 530,["468"] = 513,["469"] = 513,["470"] = 323,["471"] = 534,["472"] = 535,["473"] = 536,["474"] = 540,["475"] = 540,["476"] = 540,["477"] = 540,["478"] = 540,["479"] = 540,["480"] = 540,["481"] = 547,["482"] = 548,["483"] = 534,["484"] = 534,["485"] = 323,["486"] = 323});
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
____exports.NPCNames.DIRE_ZOMBIE = 0
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE] = "DIRE_ZOMBIE"
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
function CustomAI.prototype.Follow(self, origin)
    self:UpdateTarget()
    if (not self.followTarget) or (not self.followTarget:IsAlive()) then
        return false
    end
    local distance = CustomEntitiesLegacy:GetDistance(self.unit, self.followTarget)
    local direction = Vector(0, 0)
    if self.followTarget:IsAlive() and (distance > self.minFollowRange) then
        direction = self.followTarget:GetAbsOrigin():__sub(origin):Normalized()
    end
    CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
    return true
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
function CustomAI.prototype.MoveTowards(self, origin, point)
    local distance = point:__sub(origin):Length2D()
    if distance < 10 then
        return false
    else
        local direction = point:__sub(origin):Normalized()
        CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
        return true
    end
end
function CustomAI.prototype.PickTargetPosition(self, origin)
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
    local origin = self.unit:GetAbsOrigin()
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
                if not self:MoveTowards(origin, self.targetPosition) then
                    self.state = CustomAIState.IDLE
                    self:ClearTargetPosition()
                    self:StopMoving()
                end
            else
                self.state = CustomAIState.WANDERING
                self:PickTargetPosition(origin)
            end
        else
            if not self:Follow(origin) then
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
    [____exports.NPCNames.DIRE_ZOMBIE] = {
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
            local ai = __TS__New(____exports.CustomAI, "flying_skull", origin, {followRange = 1000, minFollowRange = 450, behavior = CustomAIBehavior.FOLLOWER, shield = true})
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
