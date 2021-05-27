--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 19,["29"] = 19,["30"] = 20,["31"] = 20,["32"] = 21,["33"] = 21,["34"] = 22,["35"] = 22,["36"] = 23,["37"] = 23,["38"] = 53,["39"] = 53,["40"] = 53,["41"] = 71,["42"] = 54,["43"] = 55,["44"] = 58,["45"] = 59,["46"] = 62,["47"] = 63,["48"] = 72,["49"] = 81,["50"] = 82,["51"] = 83,["52"] = 84,["53"] = 85,["54"] = 86,["55"] = 71,["56"] = 89,["57"] = 90,["58"] = 90,["59"] = 90,["60"] = 90,["61"] = 90,["62"] = 90,["63"] = 90,["64"] = 90,["65"] = 90,["66"] = 90,["67"] = 90,["68"] = 102,["69"] = 103,["71"] = 105,["73"] = 89,["74"] = 109,["75"] = 110,["76"] = 112,["77"] = 113,["80"] = 116,["83"] = 119,["85"] = 109,["86"] = 123,["87"] = 124,["88"] = 126,["89"] = 127,["91"] = 129,["92"] = 130,["93"] = 132,["94"] = 133,["96"] = 136,["97"] = 137,["98"] = 123,["99"] = 140,["100"] = 141,["101"] = 140,["102"] = 144,["103"] = 145,["104"] = 145,["105"] = 145,["106"] = 145,["107"] = 149,["108"] = 150,["109"] = 150,["110"] = 150,["111"] = 150,["112"] = 150,["113"] = 150,["114"] = 150,["115"] = 150,["116"] = 145,["117"] = 157,["118"] = 157,["119"] = 157,["120"] = 157,["121"] = 157,["122"] = 157,["123"] = 157,["124"] = 145,["125"] = 145,["126"] = 166,["127"] = 144,["128"] = 169,["129"] = 170,["130"] = 169,["131"] = 173,["132"] = 174,["133"] = 176,["134"] = 177,["136"] = 180,["137"] = 181,["138"] = 182,["139"] = 173,["140"] = 185,["141"] = 186,["142"] = 187,["144"] = 190,["145"] = 191,["146"] = 192,["147"] = 192,["148"] = 192,["149"] = 193,["150"] = 195,["151"] = 196,["152"] = 197,["153"] = 198,["156"] = 201,["157"] = 202,["158"] = 203,["161"] = 206,["162"] = 207,["163"] = 207,["164"] = 207,["165"] = 207,["166"] = 207,["167"] = 207,["168"] = 208,["169"] = 209,["172"] = 212,["173"] = 213,["174"] = 213,["175"] = 213,["176"] = 214,["177"] = 215,["181"] = 219,["182"] = 220,["184"] = 222,["185"] = 223,["187"] = 192,["188"] = 192,["189"] = 227,["190"] = 228,["191"] = 229,["192"] = 230,["193"] = 231,["195"] = 233,["197"] = 185,["198"] = 237,["199"] = 238,["200"] = 237,["201"] = 241,["202"] = 242,["203"] = 244,["204"] = 245,["206"] = 247,["207"] = 248,["208"] = 249,["210"] = 241,["211"] = 253,["212"] = 254,["213"] = 255,["214"] = 255,["215"] = 255,["216"] = 255,["217"] = 255,["218"] = 256,["219"] = 256,["220"] = 256,["221"] = 256,["222"] = 256,["223"] = 257,["224"] = 253,["225"] = 260,["226"] = 261,["227"] = 260,["228"] = 264,["229"] = 265,["230"] = 264,["231"] = 268,["232"] = 269,["233"] = 271,["234"] = 272,["236"] = 274,["237"] = 275,["239"] = 277,["240"] = 278,["243"] = 281,["244"] = 282,["245"] = 283,["246"] = 284,["247"] = 285,["248"] = 286,["251"] = 289,["252"] = 290,["255"] = 293,["256"] = 294,["260"] = 298,["261"] = 299,["262"] = 300,["264"] = 268,["265"] = 305,["266"] = 308,["267"] = 309,["268"] = 313,["269"] = 313,["270"] = 313,["271"] = 313,["272"] = 313,["273"] = 313,["274"] = 317,["275"] = 317,["276"] = 317,["277"] = 317,["278"] = 317,["279"] = 317,["280"] = 321,["281"] = 321,["282"] = 321,["283"] = 321,["284"] = 321,["285"] = 321,["286"] = 321,["287"] = 328,["288"] = 328,["289"] = 328,["290"] = 328,["291"] = 328,["292"] = 328,["293"] = 332,["294"] = 332,["295"] = 332,["296"] = 332,["297"] = 332,["298"] = 332,["299"] = 332,["300"] = 339,["301"] = 339,["302"] = 339,["303"] = 339,["304"] = 339,["305"] = 339,["306"] = 339,["307"] = 346,["308"] = 307,["309"] = 348,["310"] = 349,["311"] = 351,["312"] = 351,["313"] = 351,["314"] = 351,["315"] = 351,["316"] = 351,["317"] = 351,["318"] = 358,["319"] = 358,["320"] = 358,["321"] = 358,["322"] = 358,["323"] = 358,["324"] = 358,["325"] = 365,["326"] = 365,["327"] = 365,["328"] = 365,["329"] = 365,["330"] = 365,["331"] = 365,["332"] = 372,["333"] = 372,["334"] = 372,["335"] = 372,["336"] = 372,["337"] = 372,["338"] = 372,["339"] = 379,["340"] = 379,["341"] = 379,["342"] = 379,["343"] = 379,["344"] = 379,["345"] = 383,["346"] = 307,["347"] = 385,["348"] = 386,["349"] = 390,["350"] = 390,["351"] = 390,["352"] = 390,["353"] = 390,["354"] = 390,["355"] = 394,["356"] = 394,["357"] = 394,["358"] = 394,["359"] = 394,["360"] = 394,["361"] = 394,["362"] = 401,["363"] = 307,["364"] = 403,["365"] = 404,["366"] = 408,["367"] = 408,["368"] = 408,["369"] = 408,["370"] = 408,["371"] = 408,["372"] = 408,["373"] = 415,["374"] = 307,["375"] = 417,["376"] = 418,["377"] = 422,["378"] = 422,["379"] = 422,["380"] = 422,["381"] = 422,["382"] = 422,["383"] = 426,["384"] = 426,["385"] = 426,["386"] = 426,["387"] = 426,["388"] = 426,["389"] = 426,["390"] = 433,["391"] = 307,["392"] = 435,["393"] = 436,["394"] = 442,["395"] = 442,["396"] = 442,["397"] = 442,["398"] = 442,["399"] = 442,["400"] = 442,["401"] = 450,["402"] = 451,["403"] = 452,["404"] = 307,["405"] = 454,["406"] = 455,["407"] = 461,["408"] = 461,["409"] = 461,["410"] = 461,["411"] = 461,["412"] = 461,["413"] = 461,["414"] = 469,["415"] = 470,["416"] = 471,["417"] = 307,["418"] = 473,["419"] = 474,["420"] = 480,["421"] = 480,["422"] = 480,["423"] = 480,["424"] = 480,["425"] = 480,["426"] = 480,["427"] = 488,["428"] = 307,["429"] = 490,["430"] = 491,["431"] = 495,["432"] = 495,["433"] = 495,["434"] = 495,["435"] = 495,["436"] = 495,["437"] = 495,["438"] = 502,["439"] = 503,["440"] = 307,["441"] = 307});
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
____exports.CustomAIFactories = {
    [____exports.NPCNames.QUEEN] = function(____, origin)
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
    [____exports.NPCNames.CENTAUR] = function(____, origin)
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
    [____exports.NPCNames.RADIANT_ZOMBIE_HEALER] = function(____, origin)
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
    [____exports.NPCNames.DIRE_ZOMBIE] = function(____, origin)
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
    [____exports.NPCNames.DIRE_ZOMBIE_RAGER] = function(____, origin)
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
    [____exports.NPCNames.DIRE_ZOMBIE_MEELE] = function(____, origin)
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
    [____exports.NPCNames.RADIANT_ZOMBIE_MEELE] = function(____, origin)
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
    [____exports.NPCNames.FLYING_SKULL] = function(____, origin)
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
    [____exports.NPCNames.DIRE_TOWER] = function(____, origin)
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
    end
}
return ____exports
