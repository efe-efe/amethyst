--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 13,["18"] = 14,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 48,["29"] = 48,["30"] = 48,["31"] = 63,["32"] = 49,["33"] = 50,["34"] = 54,["35"] = 55,["36"] = 64,["37"] = 73,["38"] = 74,["39"] = 75,["40"] = 76,["41"] = 77,["42"] = 63,["43"] = 80,["44"] = 81,["45"] = 81,["46"] = 81,["47"] = 81,["48"] = 81,["49"] = 81,["50"] = 81,["51"] = 81,["52"] = 81,["53"] = 81,["54"] = 81,["55"] = 93,["56"] = 94,["58"] = 96,["60"] = 80,["61"] = 100,["62"] = 101,["63"] = 102,["66"] = 105,["69"] = 108,["71"] = 100,["72"] = 112,["73"] = 113,["74"] = 115,["75"] = 116,["77"] = 118,["78"] = 119,["79"] = 121,["80"] = 122,["82"] = 125,["83"] = 126,["84"] = 112,["85"] = 129,["86"] = 130,["87"] = 129,["88"] = 133,["89"] = 134,["90"] = 134,["91"] = 134,["92"] = 134,["93"] = 138,["94"] = 139,["95"] = 139,["96"] = 139,["97"] = 139,["98"] = 139,["99"] = 139,["100"] = 139,["101"] = 139,["102"] = 134,["103"] = 146,["104"] = 146,["105"] = 146,["106"] = 146,["107"] = 146,["108"] = 146,["109"] = 146,["110"] = 134,["111"] = 134,["112"] = 155,["113"] = 133,["114"] = 158,["115"] = 159,["116"] = 158,["117"] = 162,["118"] = 163,["119"] = 165,["120"] = 166,["122"] = 169,["123"] = 170,["124"] = 171,["125"] = 162,["126"] = 174,["127"] = 175,["128"] = 176,["130"] = 179,["131"] = 180,["132"] = 181,["133"] = 181,["134"] = 181,["135"] = 182,["136"] = 184,["137"] = 185,["138"] = 186,["139"] = 187,["142"] = 190,["143"] = 191,["144"] = 192,["147"] = 195,["148"] = 196,["149"] = 196,["150"] = 196,["151"] = 196,["152"] = 196,["153"] = 196,["154"] = 197,["155"] = 198,["158"] = 201,["159"] = 202,["160"] = 202,["161"] = 202,["162"] = 203,["163"] = 204,["167"] = 208,["168"] = 209,["170"] = 211,["171"] = 212,["173"] = 181,["174"] = 181,["175"] = 216,["176"] = 217,["177"] = 218,["178"] = 219,["179"] = 220,["181"] = 222,["183"] = 174,["184"] = 226,["185"] = 227,["186"] = 226,["187"] = 230,["188"] = 231,["189"] = 233,["190"] = 234,["192"] = 236,["193"] = 237,["194"] = 238,["196"] = 230,["197"] = 242,["198"] = 243,["199"] = 244,["200"] = 244,["201"] = 244,["202"] = 244,["203"] = 244,["204"] = 245,["205"] = 245,["206"] = 245,["207"] = 245,["208"] = 245,["209"] = 246,["210"] = 242,["211"] = 249,["212"] = 250,["213"] = 249,["214"] = 253,["215"] = 254,["216"] = 256,["217"] = 257,["219"] = 259,["220"] = 260,["221"] = 261,["222"] = 262,["223"] = 263,["224"] = 264,["225"] = 265,["228"] = 268,["229"] = 269,["232"] = 272,["235"] = 275,["236"] = 276,["237"] = 277,["239"] = 253,["240"] = 282,["241"] = 285,["242"] = 286,["243"] = 290,["244"] = 290,["245"] = 290,["246"] = 290,["247"] = 290,["248"] = 290,["249"] = 294,["250"] = 294,["251"] = 294,["252"] = 294,["253"] = 294,["254"] = 294,["255"] = 298,["256"] = 298,["257"] = 298,["258"] = 298,["259"] = 298,["260"] = 298,["261"] = 298,["262"] = 305,["263"] = 305,["264"] = 305,["265"] = 305,["266"] = 305,["267"] = 305,["268"] = 309,["269"] = 309,["270"] = 309,["271"] = 309,["272"] = 309,["273"] = 309,["274"] = 309,["275"] = 316,["276"] = 316,["277"] = 316,["278"] = 316,["279"] = 316,["280"] = 316,["281"] = 316,["282"] = 323,["283"] = 284,["284"] = 325,["285"] = 326,["286"] = 328,["287"] = 328,["288"] = 328,["289"] = 328,["290"] = 328,["291"] = 328,["292"] = 328,["293"] = 335,["294"] = 335,["295"] = 335,["296"] = 335,["297"] = 335,["298"] = 335,["299"] = 335,["300"] = 342,["301"] = 342,["302"] = 342,["303"] = 342,["304"] = 342,["305"] = 342,["306"] = 342,["307"] = 349,["308"] = 349,["309"] = 349,["310"] = 349,["311"] = 349,["312"] = 349,["313"] = 349,["314"] = 356,["315"] = 356,["316"] = 356,["317"] = 356,["318"] = 356,["319"] = 356,["320"] = 360,["321"] = 284,["322"] = 362,["323"] = 363,["324"] = 367,["325"] = 367,["326"] = 367,["327"] = 367,["328"] = 367,["329"] = 367,["330"] = 367,["331"] = 374,["332"] = 284,["333"] = 376,["334"] = 377,["335"] = 381,["336"] = 381,["337"] = 381,["338"] = 381,["339"] = 381,["340"] = 381,["341"] = 385,["342"] = 385,["343"] = 385,["344"] = 385,["345"] = 385,["346"] = 385,["347"] = 385,["348"] = 392,["349"] = 284,["350"] = 394,["351"] = 395,["352"] = 400,["353"] = 400,["354"] = 400,["355"] = 400,["356"] = 400,["357"] = 400,["358"] = 400,["359"] = 408,["360"] = 409,["361"] = 410,["362"] = 284,["363"] = 284});
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
____exports.NPCNames = NPCNames or ({})
____exports.NPCNames.DIRE_ZOMBIE = 0
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE] = "DIRE_ZOMBIE"
____exports.NPCNames.DIRE_ZOMBIE_RAGER = 1
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_RAGER] = "DIRE_ZOMBIE_RAGER"
____exports.NPCNames.DIRE_ZOMBIE_MEELE = 2
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_MEELE] = "DIRE_ZOMBIE_MEELE"
____exports.NPCNames.QUEEN = 3
____exports.NPCNames[____exports.NPCNames.QUEEN] = "QUEEN"
____exports.NPCNames.CENTAUR = 4
____exports.NPCNames[____exports.NPCNames.CENTAUR] = "CENTAUR"
____exports.CustomAI = __TS__Class()
local CustomAI = ____exports.CustomAI
CustomAI.name = "CustomAI"
function CustomAI.prototype.____constructor(self, name, origin, options)
    self.state = CustomAIState.IDLE
    self.abilities = {}
    self.remainingRestTime = 0
    self.rangeOfAction = 3000
    self.unit = CreateUnitByName(name, origin, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    self.restTime = options.restTime or 1
    self.followRange = options.followRange or 2500
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
    if self.followTarget then
        if (CustomEntitiesLegacy:GetDistance(self.unit, self.followTarget) <= self.followRange) and (not self.followTarget:IsInvisible()) then
            return
        else
            self.followTarget = nil
        end
    else
        self.followTarget = self:FindEnemy(self.followRange)
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
function CustomAI.prototype.Update(self)
    local origin = self.unit:GetAbsOrigin()
    if self.remainingRestTime > 0 then
        self.remainingRestTime = self.remainingRestTime - 1
    end
    if not self:Cast() then
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
            self:Follow(origin)
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
        local ai = __TS__New(____exports.CustomAI, "dire_zombie_meele", origin, {minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER})
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
    end
}
return ____exports
