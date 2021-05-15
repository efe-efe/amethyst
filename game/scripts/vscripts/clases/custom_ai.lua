--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 13,["18"] = 14,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 48,["29"] = 48,["30"] = 48,["31"] = 62,["32"] = 49,["33"] = 50,["34"] = 54,["35"] = 55,["36"] = 63,["37"] = 72,["38"] = 73,["39"] = 74,["40"] = 75,["41"] = 76,["42"] = 62,["43"] = 79,["44"] = 80,["45"] = 80,["46"] = 80,["47"] = 80,["48"] = 80,["49"] = 80,["50"] = 80,["51"] = 80,["52"] = 80,["53"] = 80,["54"] = 80,["55"] = 92,["56"] = 93,["58"] = 95,["60"] = 79,["61"] = 99,["62"] = 100,["63"] = 99,["64"] = 103,["65"] = 104,["66"] = 104,["67"] = 104,["68"] = 104,["69"] = 108,["70"] = 109,["71"] = 109,["72"] = 109,["73"] = 109,["74"] = 109,["75"] = 109,["76"] = 109,["77"] = 109,["78"] = 104,["79"] = 116,["80"] = 116,["81"] = 116,["82"] = 116,["83"] = 116,["84"] = 116,["85"] = 116,["86"] = 104,["87"] = 104,["88"] = 125,["89"] = 103,["90"] = 128,["91"] = 129,["92"] = 128,["93"] = 132,["94"] = 133,["95"] = 135,["96"] = 136,["98"] = 139,["99"] = 140,["100"] = 141,["101"] = 132,["102"] = 144,["103"] = 145,["104"] = 146,["106"] = 149,["107"] = 150,["108"] = 151,["109"] = 151,["110"] = 151,["111"] = 152,["112"] = 154,["113"] = 155,["114"] = 156,["115"] = 157,["118"] = 160,["119"] = 161,["120"] = 162,["123"] = 165,["124"] = 166,["125"] = 166,["126"] = 166,["127"] = 166,["128"] = 166,["129"] = 166,["130"] = 167,["131"] = 168,["134"] = 171,["135"] = 172,["136"] = 172,["137"] = 172,["138"] = 173,["139"] = 174,["143"] = 178,["144"] = 179,["146"] = 181,["147"] = 182,["149"] = 151,["150"] = 151,["151"] = 186,["152"] = 187,["153"] = 188,["154"] = 189,["155"] = 190,["157"] = 192,["159"] = 144,["160"] = 196,["161"] = 197,["162"] = 198,["163"] = 199,["165"] = 201,["166"] = 202,["167"] = 204,["168"] = 205,["170"] = 208,["171"] = 209,["172"] = 196,["173"] = 212,["174"] = 213,["175"] = 212,["176"] = 216,["177"] = 217,["178"] = 219,["179"] = 220,["181"] = 222,["182"] = 223,["183"] = 224,["185"] = 216,["186"] = 228,["187"] = 229,["188"] = 230,["189"] = 230,["190"] = 230,["191"] = 230,["192"] = 230,["193"] = 231,["194"] = 231,["195"] = 231,["196"] = 231,["197"] = 231,["198"] = 232,["199"] = 228,["200"] = 235,["201"] = 236,["202"] = 235,["203"] = 239,["204"] = 240,["205"] = 242,["206"] = 243,["208"] = 245,["209"] = 246,["210"] = 247,["211"] = 248,["212"] = 249,["213"] = 250,["214"] = 251,["217"] = 254,["218"] = 255,["221"] = 258,["224"] = 261,["225"] = 262,["226"] = 263,["228"] = 239,["229"] = 268,["230"] = 271,["231"] = 272,["232"] = 276,["233"] = 276,["234"] = 276,["235"] = 276,["236"] = 276,["237"] = 276,["238"] = 280,["239"] = 280,["240"] = 280,["241"] = 280,["242"] = 280,["243"] = 280,["244"] = 284,["245"] = 284,["246"] = 284,["247"] = 284,["248"] = 284,["249"] = 284,["250"] = 284,["251"] = 291,["252"] = 291,["253"] = 291,["254"] = 291,["255"] = 291,["256"] = 291,["257"] = 295,["258"] = 295,["259"] = 295,["260"] = 295,["261"] = 295,["262"] = 295,["263"] = 295,["264"] = 302,["265"] = 302,["266"] = 302,["267"] = 302,["268"] = 302,["269"] = 302,["270"] = 302,["271"] = 309,["272"] = 270,["273"] = 311,["274"] = 312,["275"] = 314,["276"] = 314,["277"] = 314,["278"] = 314,["279"] = 314,["280"] = 314,["281"] = 314,["282"] = 321,["283"] = 321,["284"] = 321,["285"] = 321,["286"] = 321,["287"] = 321,["288"] = 321,["289"] = 328,["290"] = 328,["291"] = 328,["292"] = 328,["293"] = 328,["294"] = 328,["295"] = 328,["296"] = 335,["297"] = 335,["298"] = 335,["299"] = 335,["300"] = 335,["301"] = 335,["302"] = 335,["303"] = 342,["304"] = 342,["305"] = 342,["306"] = 342,["307"] = 342,["308"] = 342,["309"] = 346,["310"] = 270,["311"] = 348,["312"] = 349,["313"] = 353,["314"] = 353,["315"] = 353,["316"] = 353,["317"] = 353,["318"] = 353,["319"] = 353,["320"] = 360,["321"] = 270,["322"] = 362,["323"] = 363,["324"] = 367,["325"] = 367,["326"] = 367,["327"] = 367,["328"] = 367,["329"] = 367,["330"] = 371,["331"] = 371,["332"] = 371,["333"] = 371,["334"] = 371,["335"] = 371,["336"] = 371,["337"] = 378,["338"] = 270,["339"] = 380,["340"] = 381,["341"] = 386,["342"] = 386,["343"] = 386,["344"] = 386,["345"] = 386,["346"] = 386,["347"] = 386,["348"] = 395,["349"] = 396,["350"] = 270,["351"] = 270});
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
function CustomAI.prototype.Follow(self, origin)
    local target = self:FindEnemy(self.followRange)
    if not target then
        return false
    end
    local distance = CustomEntitiesLegacy:GetDistance(self.unit, target)
    local direction = Vector(0, 0)
    if target:IsAlive() and (distance > self.minFollowRange) then
        direction = target:GetAbsOrigin():__sub(origin):Normalized()
    end
    CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
    return true
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
        ai.unit:SetHullRadius(120)
        return ai
    end
}
return ____exports
