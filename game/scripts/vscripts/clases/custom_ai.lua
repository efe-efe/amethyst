--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 19,["29"] = 19,["30"] = 20,["31"] = 20,["32"] = 50,["33"] = 50,["34"] = 50,["35"] = 68,["36"] = 51,["37"] = 52,["38"] = 55,["39"] = 56,["40"] = 59,["41"] = 60,["42"] = 69,["43"] = 78,["44"] = 79,["45"] = 80,["46"] = 81,["47"] = 82,["48"] = 83,["49"] = 68,["50"] = 86,["51"] = 87,["52"] = 87,["53"] = 87,["54"] = 87,["55"] = 87,["56"] = 87,["57"] = 87,["58"] = 87,["59"] = 87,["60"] = 87,["61"] = 87,["62"] = 99,["63"] = 100,["65"] = 102,["67"] = 86,["68"] = 106,["69"] = 107,["70"] = 109,["71"] = 110,["74"] = 113,["77"] = 116,["79"] = 106,["80"] = 120,["81"] = 121,["82"] = 123,["83"] = 124,["85"] = 126,["86"] = 127,["87"] = 129,["88"] = 130,["90"] = 133,["91"] = 134,["92"] = 120,["93"] = 137,["94"] = 138,["95"] = 137,["96"] = 141,["97"] = 142,["98"] = 142,["99"] = 142,["100"] = 142,["101"] = 146,["102"] = 147,["103"] = 147,["104"] = 147,["105"] = 147,["106"] = 147,["107"] = 147,["108"] = 147,["109"] = 147,["110"] = 142,["111"] = 154,["112"] = 154,["113"] = 154,["114"] = 154,["115"] = 154,["116"] = 154,["117"] = 154,["118"] = 142,["119"] = 142,["120"] = 163,["121"] = 141,["122"] = 166,["123"] = 167,["124"] = 166,["125"] = 170,["126"] = 171,["127"] = 173,["128"] = 174,["130"] = 177,["131"] = 178,["132"] = 179,["133"] = 170,["134"] = 182,["135"] = 183,["136"] = 184,["138"] = 187,["139"] = 188,["140"] = 189,["141"] = 189,["142"] = 189,["143"] = 190,["144"] = 192,["145"] = 193,["146"] = 194,["147"] = 195,["150"] = 198,["151"] = 199,["152"] = 200,["155"] = 203,["156"] = 204,["157"] = 204,["158"] = 204,["159"] = 204,["160"] = 204,["161"] = 204,["162"] = 205,["163"] = 206,["166"] = 209,["167"] = 210,["168"] = 210,["169"] = 210,["170"] = 211,["171"] = 212,["175"] = 216,["176"] = 217,["178"] = 219,["179"] = 220,["181"] = 189,["182"] = 189,["183"] = 224,["184"] = 225,["185"] = 226,["186"] = 227,["187"] = 228,["189"] = 230,["191"] = 182,["192"] = 234,["193"] = 235,["194"] = 234,["195"] = 238,["196"] = 239,["197"] = 241,["198"] = 242,["200"] = 244,["201"] = 245,["202"] = 246,["204"] = 238,["205"] = 250,["206"] = 251,["207"] = 252,["208"] = 252,["209"] = 252,["210"] = 252,["211"] = 252,["212"] = 253,["213"] = 253,["214"] = 253,["215"] = 253,["216"] = 253,["217"] = 254,["218"] = 250,["219"] = 257,["220"] = 258,["221"] = 257,["222"] = 261,["223"] = 262,["224"] = 261,["225"] = 265,["226"] = 266,["227"] = 268,["228"] = 269,["230"] = 271,["231"] = 272,["233"] = 274,["234"] = 275,["237"] = 278,["238"] = 279,["239"] = 280,["240"] = 281,["241"] = 282,["242"] = 283,["245"] = 286,["246"] = 287,["249"] = 290,["250"] = 291,["254"] = 295,["255"] = 296,["256"] = 297,["258"] = 265,["259"] = 302,["260"] = 305,["261"] = 306,["262"] = 310,["263"] = 310,["264"] = 310,["265"] = 310,["266"] = 310,["267"] = 310,["268"] = 314,["269"] = 314,["270"] = 314,["271"] = 314,["272"] = 314,["273"] = 314,["274"] = 318,["275"] = 318,["276"] = 318,["277"] = 318,["278"] = 318,["279"] = 318,["280"] = 318,["281"] = 325,["282"] = 325,["283"] = 325,["284"] = 325,["285"] = 325,["286"] = 325,["287"] = 329,["288"] = 329,["289"] = 329,["290"] = 329,["291"] = 329,["292"] = 329,["293"] = 329,["294"] = 336,["295"] = 336,["296"] = 336,["297"] = 336,["298"] = 336,["299"] = 336,["300"] = 336,["301"] = 343,["302"] = 304,["303"] = 345,["304"] = 346,["305"] = 348,["306"] = 348,["307"] = 348,["308"] = 348,["309"] = 348,["310"] = 348,["311"] = 348,["312"] = 355,["313"] = 355,["314"] = 355,["315"] = 355,["316"] = 355,["317"] = 355,["318"] = 355,["319"] = 362,["320"] = 362,["321"] = 362,["322"] = 362,["323"] = 362,["324"] = 362,["325"] = 362,["326"] = 369,["327"] = 369,["328"] = 369,["329"] = 369,["330"] = 369,["331"] = 369,["332"] = 369,["333"] = 376,["334"] = 376,["335"] = 376,["336"] = 376,["337"] = 376,["338"] = 376,["339"] = 380,["340"] = 304,["341"] = 382,["342"] = 383,["343"] = 387,["344"] = 387,["345"] = 387,["346"] = 387,["347"] = 387,["348"] = 387,["349"] = 387,["350"] = 394,["351"] = 304,["352"] = 396,["353"] = 397,["354"] = 401,["355"] = 401,["356"] = 401,["357"] = 401,["358"] = 401,["359"] = 401,["360"] = 405,["361"] = 405,["362"] = 405,["363"] = 405,["364"] = 405,["365"] = 405,["366"] = 405,["367"] = 412,["368"] = 304,["369"] = 414,["370"] = 415,["371"] = 421,["372"] = 421,["373"] = 421,["374"] = 421,["375"] = 421,["376"] = 421,["377"] = 421,["378"] = 429,["379"] = 430,["380"] = 431,["381"] = 304,["382"] = 433,["383"] = 434,["384"] = 440,["385"] = 440,["386"] = 440,["387"] = 440,["388"] = 440,["389"] = 440,["390"] = 440,["391"] = 448,["392"] = 304,["393"] = 304});
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
____exports.NPCNames.QUEEN = 3
____exports.NPCNames[____exports.NPCNames.QUEEN] = "QUEEN"
____exports.NPCNames.CENTAUR = 4
____exports.NPCNames[____exports.NPCNames.CENTAUR] = "CENTAUR"
____exports.NPCNames.FLYING_SKULL = 5
____exports.NPCNames[____exports.NPCNames.FLYING_SKULL] = "FLYING_SKULL"
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
