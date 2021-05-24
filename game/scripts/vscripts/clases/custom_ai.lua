--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 19,["29"] = 19,["30"] = 20,["31"] = 20,["32"] = 21,["33"] = 21,["34"] = 22,["35"] = 22,["36"] = 52,["37"] = 52,["38"] = 52,["39"] = 70,["40"] = 53,["41"] = 54,["42"] = 57,["43"] = 58,["44"] = 61,["45"] = 62,["46"] = 71,["47"] = 80,["48"] = 81,["49"] = 82,["50"] = 83,["51"] = 84,["52"] = 85,["53"] = 70,["54"] = 88,["55"] = 89,["56"] = 89,["57"] = 89,["58"] = 89,["59"] = 89,["60"] = 89,["61"] = 89,["62"] = 89,["63"] = 89,["64"] = 89,["65"] = 89,["66"] = 101,["67"] = 102,["69"] = 104,["71"] = 88,["72"] = 108,["73"] = 109,["74"] = 111,["75"] = 112,["78"] = 115,["81"] = 118,["83"] = 108,["84"] = 122,["85"] = 123,["86"] = 125,["87"] = 126,["89"] = 128,["90"] = 129,["91"] = 131,["92"] = 132,["94"] = 135,["95"] = 136,["96"] = 122,["97"] = 139,["98"] = 140,["99"] = 139,["100"] = 143,["101"] = 144,["102"] = 144,["103"] = 144,["104"] = 144,["105"] = 148,["106"] = 149,["107"] = 149,["108"] = 149,["109"] = 149,["110"] = 149,["111"] = 149,["112"] = 149,["113"] = 149,["114"] = 144,["115"] = 156,["116"] = 156,["117"] = 156,["118"] = 156,["119"] = 156,["120"] = 156,["121"] = 156,["122"] = 144,["123"] = 144,["124"] = 165,["125"] = 143,["126"] = 168,["127"] = 169,["128"] = 168,["129"] = 172,["130"] = 173,["131"] = 175,["132"] = 176,["134"] = 179,["135"] = 180,["136"] = 181,["137"] = 172,["138"] = 184,["139"] = 185,["140"] = 186,["142"] = 189,["143"] = 190,["144"] = 191,["145"] = 191,["146"] = 191,["147"] = 192,["148"] = 194,["149"] = 195,["150"] = 196,["151"] = 197,["154"] = 200,["155"] = 201,["156"] = 202,["159"] = 205,["160"] = 206,["161"] = 206,["162"] = 206,["163"] = 206,["164"] = 206,["165"] = 206,["166"] = 207,["167"] = 208,["170"] = 211,["171"] = 212,["172"] = 212,["173"] = 212,["174"] = 213,["175"] = 214,["179"] = 218,["180"] = 219,["182"] = 221,["183"] = 222,["185"] = 191,["186"] = 191,["187"] = 226,["188"] = 227,["189"] = 228,["190"] = 229,["191"] = 230,["193"] = 232,["195"] = 184,["196"] = 236,["197"] = 237,["198"] = 236,["199"] = 240,["200"] = 241,["201"] = 243,["202"] = 244,["204"] = 246,["205"] = 247,["206"] = 248,["208"] = 240,["209"] = 252,["210"] = 253,["211"] = 254,["212"] = 254,["213"] = 254,["214"] = 254,["215"] = 254,["216"] = 255,["217"] = 255,["218"] = 255,["219"] = 255,["220"] = 255,["221"] = 256,["222"] = 252,["223"] = 259,["224"] = 260,["225"] = 259,["226"] = 263,["227"] = 264,["228"] = 263,["229"] = 267,["230"] = 268,["231"] = 270,["232"] = 271,["234"] = 273,["235"] = 274,["237"] = 276,["238"] = 277,["241"] = 280,["242"] = 281,["243"] = 282,["244"] = 283,["245"] = 284,["246"] = 285,["249"] = 288,["250"] = 289,["253"] = 292,["254"] = 293,["258"] = 297,["259"] = 298,["260"] = 299,["262"] = 267,["263"] = 304,["264"] = 307,["265"] = 308,["266"] = 312,["267"] = 312,["268"] = 312,["269"] = 312,["270"] = 312,["271"] = 312,["272"] = 316,["273"] = 316,["274"] = 316,["275"] = 316,["276"] = 316,["277"] = 316,["278"] = 320,["279"] = 320,["280"] = 320,["281"] = 320,["282"] = 320,["283"] = 320,["284"] = 320,["285"] = 327,["286"] = 327,["287"] = 327,["288"] = 327,["289"] = 327,["290"] = 327,["291"] = 331,["292"] = 331,["293"] = 331,["294"] = 331,["295"] = 331,["296"] = 331,["297"] = 331,["298"] = 338,["299"] = 338,["300"] = 338,["301"] = 338,["302"] = 338,["303"] = 338,["304"] = 338,["305"] = 345,["306"] = 306,["307"] = 347,["308"] = 348,["309"] = 350,["310"] = 350,["311"] = 350,["312"] = 350,["313"] = 350,["314"] = 350,["315"] = 350,["316"] = 357,["317"] = 357,["318"] = 357,["319"] = 357,["320"] = 357,["321"] = 357,["322"] = 357,["323"] = 364,["324"] = 364,["325"] = 364,["326"] = 364,["327"] = 364,["328"] = 364,["329"] = 364,["330"] = 371,["331"] = 371,["332"] = 371,["333"] = 371,["334"] = 371,["335"] = 371,["336"] = 371,["337"] = 378,["338"] = 378,["339"] = 378,["340"] = 378,["341"] = 378,["342"] = 378,["343"] = 382,["344"] = 306,["345"] = 384,["346"] = 385,["347"] = 389,["348"] = 389,["349"] = 389,["350"] = 389,["351"] = 389,["352"] = 389,["353"] = 393,["354"] = 393,["355"] = 393,["356"] = 393,["357"] = 393,["358"] = 393,["359"] = 393,["360"] = 400,["361"] = 306,["362"] = 402,["363"] = 403,["364"] = 407,["365"] = 407,["366"] = 407,["367"] = 407,["368"] = 407,["369"] = 407,["370"] = 407,["371"] = 414,["372"] = 306,["373"] = 416,["374"] = 417,["375"] = 421,["376"] = 421,["377"] = 421,["378"] = 421,["379"] = 421,["380"] = 421,["381"] = 425,["382"] = 425,["383"] = 425,["384"] = 425,["385"] = 425,["386"] = 425,["387"] = 425,["388"] = 432,["389"] = 306,["390"] = 434,["391"] = 435,["392"] = 441,["393"] = 441,["394"] = 441,["395"] = 441,["396"] = 441,["397"] = 441,["398"] = 441,["399"] = 449,["400"] = 450,["401"] = 451,["402"] = 306,["403"] = 453,["404"] = 454,["405"] = 460,["406"] = 460,["407"] = 460,["408"] = 460,["409"] = 460,["410"] = 460,["411"] = 460,["412"] = 468,["413"] = 469,["414"] = 470,["415"] = 306,["416"] = 472,["417"] = 473,["418"] = 479,["419"] = 479,["420"] = 479,["421"] = 479,["422"] = 479,["423"] = 479,["424"] = 479,["425"] = 487,["426"] = 306,["427"] = 306});
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
____exports.NPCNames.QUEEN = 6
____exports.NPCNames[____exports.NPCNames.QUEEN] = "QUEEN"
____exports.NPCNames.CENTAUR = 7
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
    end
}
return ____exports
