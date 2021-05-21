--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 19,["29"] = 19,["30"] = 20,["31"] = 20,["32"] = 21,["33"] = 21,["34"] = 51,["35"] = 51,["36"] = 51,["37"] = 69,["38"] = 52,["39"] = 53,["40"] = 56,["41"] = 57,["42"] = 60,["43"] = 61,["44"] = 70,["45"] = 79,["46"] = 80,["47"] = 81,["48"] = 82,["49"] = 83,["50"] = 84,["51"] = 69,["52"] = 87,["53"] = 88,["54"] = 88,["55"] = 88,["56"] = 88,["57"] = 88,["58"] = 88,["59"] = 88,["60"] = 88,["61"] = 88,["62"] = 88,["63"] = 88,["64"] = 100,["65"] = 101,["67"] = 103,["69"] = 87,["70"] = 107,["71"] = 108,["72"] = 110,["73"] = 111,["76"] = 114,["79"] = 117,["81"] = 107,["82"] = 121,["83"] = 122,["84"] = 124,["85"] = 125,["87"] = 127,["88"] = 128,["89"] = 130,["90"] = 131,["92"] = 134,["93"] = 135,["94"] = 121,["95"] = 138,["96"] = 139,["97"] = 138,["98"] = 142,["99"] = 143,["100"] = 143,["101"] = 143,["102"] = 143,["103"] = 147,["104"] = 148,["105"] = 148,["106"] = 148,["107"] = 148,["108"] = 148,["109"] = 148,["110"] = 148,["111"] = 148,["112"] = 143,["113"] = 155,["114"] = 155,["115"] = 155,["116"] = 155,["117"] = 155,["118"] = 155,["119"] = 155,["120"] = 143,["121"] = 143,["122"] = 164,["123"] = 142,["124"] = 167,["125"] = 168,["126"] = 167,["127"] = 171,["128"] = 172,["129"] = 174,["130"] = 175,["132"] = 178,["133"] = 179,["134"] = 180,["135"] = 171,["136"] = 183,["137"] = 184,["138"] = 185,["140"] = 188,["141"] = 189,["142"] = 190,["143"] = 190,["144"] = 190,["145"] = 191,["146"] = 193,["147"] = 194,["148"] = 195,["149"] = 196,["152"] = 199,["153"] = 200,["154"] = 201,["157"] = 204,["158"] = 205,["159"] = 205,["160"] = 205,["161"] = 205,["162"] = 205,["163"] = 205,["164"] = 206,["165"] = 207,["168"] = 210,["169"] = 211,["170"] = 211,["171"] = 211,["172"] = 212,["173"] = 213,["177"] = 217,["178"] = 218,["180"] = 220,["181"] = 221,["183"] = 190,["184"] = 190,["185"] = 225,["186"] = 226,["187"] = 227,["188"] = 228,["189"] = 229,["191"] = 231,["193"] = 183,["194"] = 235,["195"] = 236,["196"] = 235,["197"] = 239,["198"] = 240,["199"] = 242,["200"] = 243,["202"] = 245,["203"] = 246,["204"] = 247,["206"] = 239,["207"] = 251,["208"] = 252,["209"] = 253,["210"] = 253,["211"] = 253,["212"] = 253,["213"] = 253,["214"] = 254,["215"] = 254,["216"] = 254,["217"] = 254,["218"] = 254,["219"] = 255,["220"] = 251,["221"] = 258,["222"] = 259,["223"] = 258,["224"] = 262,["225"] = 263,["226"] = 262,["227"] = 266,["228"] = 267,["229"] = 269,["230"] = 270,["232"] = 272,["233"] = 273,["235"] = 275,["236"] = 276,["239"] = 279,["240"] = 280,["241"] = 281,["242"] = 282,["243"] = 283,["244"] = 284,["247"] = 287,["248"] = 288,["251"] = 291,["252"] = 292,["256"] = 296,["257"] = 297,["258"] = 298,["260"] = 266,["261"] = 303,["262"] = 306,["263"] = 307,["264"] = 311,["265"] = 311,["266"] = 311,["267"] = 311,["268"] = 311,["269"] = 311,["270"] = 315,["271"] = 315,["272"] = 315,["273"] = 315,["274"] = 315,["275"] = 315,["276"] = 319,["277"] = 319,["278"] = 319,["279"] = 319,["280"] = 319,["281"] = 319,["282"] = 319,["283"] = 326,["284"] = 326,["285"] = 326,["286"] = 326,["287"] = 326,["288"] = 326,["289"] = 330,["290"] = 330,["291"] = 330,["292"] = 330,["293"] = 330,["294"] = 330,["295"] = 330,["296"] = 337,["297"] = 337,["298"] = 337,["299"] = 337,["300"] = 337,["301"] = 337,["302"] = 337,["303"] = 344,["304"] = 305,["305"] = 346,["306"] = 347,["307"] = 349,["308"] = 349,["309"] = 349,["310"] = 349,["311"] = 349,["312"] = 349,["313"] = 349,["314"] = 356,["315"] = 356,["316"] = 356,["317"] = 356,["318"] = 356,["319"] = 356,["320"] = 356,["321"] = 363,["322"] = 363,["323"] = 363,["324"] = 363,["325"] = 363,["326"] = 363,["327"] = 363,["328"] = 370,["329"] = 370,["330"] = 370,["331"] = 370,["332"] = 370,["333"] = 370,["334"] = 370,["335"] = 377,["336"] = 377,["337"] = 377,["338"] = 377,["339"] = 377,["340"] = 377,["341"] = 381,["342"] = 305,["343"] = 383,["344"] = 384,["345"] = 388,["346"] = 388,["347"] = 388,["348"] = 388,["349"] = 388,["350"] = 388,["351"] = 392,["352"] = 392,["353"] = 392,["354"] = 392,["355"] = 392,["356"] = 392,["357"] = 392,["358"] = 399,["359"] = 305,["360"] = 401,["361"] = 402,["362"] = 406,["363"] = 406,["364"] = 406,["365"] = 406,["366"] = 406,["367"] = 406,["368"] = 406,["369"] = 413,["370"] = 305,["371"] = 415,["372"] = 416,["373"] = 420,["374"] = 420,["375"] = 420,["376"] = 420,["377"] = 420,["378"] = 420,["379"] = 424,["380"] = 424,["381"] = 424,["382"] = 424,["383"] = 424,["384"] = 424,["385"] = 424,["386"] = 431,["387"] = 305,["388"] = 433,["389"] = 434,["390"] = 440,["391"] = 440,["392"] = 440,["393"] = 440,["394"] = 440,["395"] = 440,["396"] = 440,["397"] = 448,["398"] = 449,["399"] = 450,["400"] = 305,["401"] = 452,["402"] = 453,["403"] = 459,["404"] = 459,["405"] = 459,["406"] = 459,["407"] = 459,["408"] = 459,["409"] = 459,["410"] = 467,["411"] = 305,["412"] = 305});
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
____exports.NPCNames.FLYING_SKULL = 4
____exports.NPCNames[____exports.NPCNames.FLYING_SKULL] = "FLYING_SKULL"
____exports.NPCNames.QUEEN = 5
____exports.NPCNames[____exports.NPCNames.QUEEN] = "QUEEN"
____exports.NPCNames.CENTAUR = 6
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
    end
}
return ____exports
