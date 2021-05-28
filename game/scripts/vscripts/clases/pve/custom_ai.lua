--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 60,["48"] = 60,["49"] = 60,["50"] = 78,["51"] = 61,["52"] = 62,["53"] = 65,["54"] = 66,["55"] = 69,["56"] = 70,["57"] = 79,["58"] = 88,["59"] = 89,["60"] = 90,["61"] = 91,["62"] = 92,["63"] = 93,["64"] = 78,["65"] = 96,["66"] = 97,["67"] = 97,["68"] = 97,["69"] = 97,["70"] = 97,["71"] = 97,["72"] = 97,["73"] = 97,["74"] = 97,["75"] = 97,["76"] = 97,["77"] = 109,["78"] = 110,["80"] = 112,["82"] = 96,["83"] = 116,["84"] = 117,["85"] = 119,["86"] = 120,["89"] = 123,["92"] = 126,["94"] = 116,["95"] = 130,["96"] = 131,["97"] = 133,["98"] = 134,["100"] = 136,["101"] = 137,["102"] = 139,["103"] = 140,["105"] = 143,["106"] = 144,["107"] = 130,["108"] = 147,["109"] = 148,["110"] = 147,["111"] = 151,["112"] = 152,["113"] = 152,["114"] = 152,["115"] = 152,["116"] = 156,["117"] = 157,["118"] = 157,["119"] = 157,["120"] = 157,["121"] = 157,["122"] = 157,["123"] = 157,["124"] = 157,["125"] = 152,["126"] = 164,["127"] = 164,["128"] = 164,["129"] = 164,["130"] = 164,["131"] = 164,["132"] = 164,["133"] = 152,["134"] = 152,["135"] = 173,["136"] = 151,["137"] = 176,["138"] = 177,["139"] = 176,["140"] = 180,["141"] = 181,["142"] = 183,["143"] = 184,["145"] = 187,["146"] = 188,["147"] = 189,["148"] = 180,["149"] = 192,["150"] = 193,["151"] = 194,["153"] = 197,["154"] = 198,["155"] = 199,["156"] = 199,["157"] = 199,["158"] = 200,["159"] = 202,["160"] = 203,["161"] = 204,["162"] = 205,["165"] = 208,["166"] = 209,["167"] = 210,["170"] = 213,["171"] = 214,["172"] = 214,["173"] = 214,["174"] = 214,["175"] = 214,["176"] = 214,["177"] = 215,["178"] = 216,["181"] = 219,["182"] = 220,["183"] = 220,["184"] = 220,["185"] = 221,["186"] = 222,["190"] = 226,["191"] = 227,["193"] = 229,["194"] = 230,["196"] = 199,["197"] = 199,["198"] = 234,["199"] = 235,["200"] = 236,["201"] = 237,["202"] = 238,["204"] = 240,["206"] = 192,["207"] = 244,["208"] = 245,["209"] = 244,["210"] = 248,["211"] = 249,["212"] = 251,["213"] = 252,["215"] = 254,["216"] = 255,["217"] = 256,["219"] = 248,["220"] = 260,["221"] = 261,["222"] = 262,["223"] = 262,["224"] = 262,["225"] = 262,["226"] = 262,["227"] = 263,["228"] = 263,["229"] = 263,["230"] = 263,["231"] = 263,["232"] = 264,["233"] = 260,["234"] = 267,["235"] = 268,["236"] = 267,["237"] = 271,["238"] = 272,["239"] = 271,["240"] = 275,["241"] = 276,["242"] = 278,["243"] = 279,["245"] = 281,["246"] = 282,["248"] = 284,["249"] = 285,["252"] = 288,["253"] = 289,["254"] = 290,["255"] = 291,["256"] = 292,["257"] = 293,["260"] = 296,["261"] = 297,["264"] = 300,["265"] = 301,["269"] = 305,["270"] = 306,["271"] = 307,["273"] = 275,["274"] = 312,["275"] = 318,["276"] = 319,["277"] = 320,["278"] = 324,["279"] = 324,["280"] = 324,["281"] = 324,["282"] = 324,["283"] = 324,["284"] = 328,["285"] = 328,["286"] = 328,["287"] = 328,["288"] = 328,["289"] = 328,["290"] = 332,["291"] = 332,["292"] = 332,["293"] = 332,["294"] = 332,["295"] = 332,["296"] = 332,["297"] = 339,["298"] = 339,["299"] = 339,["300"] = 339,["301"] = 339,["302"] = 339,["303"] = 343,["304"] = 343,["305"] = 343,["306"] = 343,["307"] = 343,["308"] = 343,["309"] = 343,["310"] = 350,["311"] = 350,["312"] = 350,["313"] = 350,["314"] = 350,["315"] = 350,["316"] = 350,["317"] = 357,["318"] = 318,["319"] = 318,["320"] = 317,["321"] = 361,["322"] = 362,["323"] = 363,["324"] = 365,["325"] = 365,["326"] = 365,["327"] = 365,["328"] = 365,["329"] = 365,["330"] = 365,["331"] = 372,["332"] = 372,["333"] = 372,["334"] = 372,["335"] = 372,["336"] = 372,["337"] = 372,["338"] = 379,["339"] = 379,["340"] = 379,["341"] = 379,["342"] = 379,["343"] = 379,["344"] = 379,["345"] = 386,["346"] = 386,["347"] = 386,["348"] = 386,["349"] = 386,["350"] = 386,["351"] = 386,["352"] = 393,["353"] = 393,["354"] = 393,["355"] = 393,["356"] = 393,["357"] = 393,["358"] = 397,["359"] = 361,["360"] = 361,["361"] = 317,["362"] = 401,["363"] = 402,["364"] = 403,["365"] = 407,["366"] = 407,["367"] = 407,["368"] = 407,["369"] = 407,["370"] = 407,["371"] = 411,["372"] = 411,["373"] = 411,["374"] = 411,["375"] = 411,["376"] = 411,["377"] = 411,["378"] = 418,["379"] = 401,["380"] = 401,["381"] = 317,["382"] = 422,["383"] = 423,["384"] = 424,["385"] = 428,["386"] = 428,["387"] = 428,["388"] = 428,["389"] = 428,["390"] = 428,["391"] = 428,["392"] = 435,["393"] = 422,["394"] = 422,["395"] = 317,["396"] = 439,["397"] = 440,["398"] = 441,["399"] = 445,["400"] = 445,["401"] = 445,["402"] = 445,["403"] = 445,["404"] = 445,["405"] = 449,["406"] = 449,["407"] = 449,["408"] = 449,["409"] = 449,["410"] = 449,["411"] = 449,["412"] = 456,["413"] = 439,["414"] = 439,["415"] = 317,["416"] = 460,["417"] = 461,["418"] = 462,["419"] = 468,["420"] = 468,["421"] = 468,["422"] = 468,["423"] = 468,["424"] = 468,["425"] = 468,["426"] = 476,["427"] = 477,["428"] = 478,["429"] = 460,["430"] = 460,["431"] = 317,["432"] = 482,["433"] = 483,["434"] = 484,["435"] = 490,["436"] = 490,["437"] = 490,["438"] = 490,["439"] = 490,["440"] = 490,["441"] = 490,["442"] = 498,["443"] = 499,["444"] = 500,["445"] = 482,["446"] = 482,["447"] = 317,["448"] = 504,["449"] = 505,["450"] = 506,["451"] = 512,["452"] = 512,["453"] = 512,["454"] = 512,["455"] = 512,["456"] = 512,["457"] = 512,["458"] = 520,["459"] = 504,["460"] = 504,["461"] = 317,["462"] = 524,["463"] = 525,["464"] = 526,["465"] = 530,["466"] = 530,["467"] = 530,["468"] = 530,["469"] = 530,["470"] = 530,["471"] = 530,["472"] = 537,["473"] = 538,["474"] = 524,["475"] = 524,["476"] = 317,["477"] = 317});
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
____exports.NPCNames.DIRE_ZOMBIE_RAGER = 1
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_RAGER] = "DIRE_ZOMBIE_RAGER"
____exports.NPCNames.DIRE_ZOMBIE_MEELE = 2
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_MEELE] = "DIRE_ZOMBIE_MEELE"
____exports.NPCNames.RADIANT_ZOMBIE_HEALER = 3
____exports.NPCNames[____exports.NPCNames.RADIANT_ZOMBIE_HEALER] = "RADIANT_ZOMBIE_HEALER"
____exports.NPCNames.RADIANT_ZOMBIE_MEELE = 4
____exports.NPCNames[____exports.NPCNames.RADIANT_ZOMBIE_MEELE] = "RADIANT_ZOMBIE_MEELE"
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
    if not self.followTarget then
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
    [____exports.NPCNames.RADIANT_ZOMBIE_HEALER] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "radiant_zombie_healer", origin, {behavior = CustomAIBehavior.WANDERER})
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
            local ai = __TS__New(____exports.CustomAI, "dire_zombie", origin, {behavior = CustomAIBehavior.WANDERER})
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
    [____exports.NPCNames.DIRE_ZOMBIE_RAGER] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_rager", origin, {behavior = CustomAIBehavior.WANDERER})
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
    [____exports.NPCNames.DIRE_ZOMBIE_MEELE] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_meele", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack_meele"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:AddNewModifier(ai.unit, nil, "modifier_generic_meele_npc", {})
            ai.unit:SetHullRadius(95)
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.RADIANT_ZOMBIE_MEELE] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "radiant_zombie_meele", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack_meele"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:AddNewModifier(ai.unit, nil, "modifier_generic_meele_npc", {})
            ai.unit:SetHullRadius(95)
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.FLYING_SKULL] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "flying_skull", origin, {followRange = 1000, minFollowRange = 450, behavior = CustomAIBehavior.FOLLOWER})
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
