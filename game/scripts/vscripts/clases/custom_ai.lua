--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 41,["18"] = 41,["19"] = 41,["20"] = 55,["21"] = 42,["22"] = 43,["23"] = 47,["24"] = 48,["25"] = 56,["26"] = 65,["27"] = 66,["28"] = 67,["29"] = 68,["30"] = 69,["31"] = 55,["32"] = 72,["33"] = 73,["34"] = 73,["35"] = 73,["36"] = 73,["37"] = 73,["38"] = 73,["39"] = 73,["40"] = 73,["41"] = 73,["42"] = 73,["43"] = 73,["44"] = 85,["45"] = 86,["47"] = 88,["49"] = 72,["50"] = 92,["51"] = 93,["52"] = 92,["53"] = 96,["54"] = 97,["55"] = 97,["56"] = 97,["57"] = 97,["58"] = 101,["59"] = 102,["60"] = 102,["61"] = 102,["62"] = 102,["63"] = 102,["64"] = 102,["65"] = 102,["66"] = 102,["67"] = 97,["68"] = 109,["69"] = 109,["70"] = 109,["71"] = 109,["72"] = 109,["73"] = 109,["74"] = 109,["75"] = 97,["76"] = 97,["77"] = 118,["78"] = 96,["79"] = 121,["80"] = 122,["81"] = 121,["82"] = 125,["83"] = 126,["84"] = 125,["85"] = 129,["86"] = 130,["87"] = 132,["88"] = 133,["90"] = 136,["91"] = 137,["92"] = 138,["93"] = 129,["94"] = 141,["95"] = 142,["96"] = 143,["98"] = 146,["99"] = 147,["100"] = 148,["101"] = 148,["102"] = 148,["103"] = 149,["104"] = 151,["105"] = 152,["106"] = 153,["107"] = 154,["110"] = 157,["111"] = 158,["112"] = 159,["115"] = 162,["116"] = 163,["117"] = 163,["118"] = 163,["119"] = 163,["120"] = 163,["121"] = 163,["122"] = 164,["123"] = 165,["126"] = 168,["127"] = 169,["128"] = 169,["129"] = 169,["130"] = 170,["131"] = 171,["135"] = 175,["136"] = 176,["138"] = 178,["139"] = 179,["141"] = 148,["142"] = 148,["143"] = 183,["144"] = 184,["145"] = 185,["146"] = 186,["147"] = 187,["149"] = 189,["151"] = 141,["152"] = 193,["153"] = 194,["154"] = 195,["155"] = 196,["157"] = 198,["158"] = 199,["159"] = 201,["160"] = 202,["162"] = 205,["163"] = 206,["164"] = 193,["165"] = 209,["166"] = 210,["167"] = 209,["168"] = 213,["169"] = 214,["170"] = 216,["171"] = 217,["173"] = 219,["174"] = 220,["175"] = 221,["177"] = 213,["178"] = 225,["179"] = 226,["180"] = 227,["181"] = 227,["182"] = 227,["183"] = 227,["184"] = 227,["185"] = 228,["186"] = 228,["187"] = 228,["188"] = 228,["189"] = 228,["190"] = 229,["191"] = 225,["192"] = 232,["193"] = 233,["194"] = 232,["195"] = 236,["196"] = 237,["197"] = 239,["198"] = 240,["200"] = 242,["201"] = 243,["202"] = 244,["203"] = 245,["204"] = 246,["205"] = 247,["206"] = 248,["209"] = 251,["210"] = 252,["213"] = 255,["216"] = 258,["217"] = 259,["218"] = 260,["220"] = 236,["221"] = 264,["222"] = 264,["223"] = 264,["224"] = 264,["225"] = 265,["226"] = 264,["227"] = 270,["228"] = 270,["229"] = 270,["230"] = 270,["231"] = 270,["232"] = 270,["233"] = 270,["234"] = 270,["235"] = 270,["236"] = 265,["237"] = 279,["238"] = 279,["239"] = 279,["240"] = 279,["241"] = 280,["242"] = 279,["243"] = 283,["244"] = 283,["245"] = 283,["246"] = 283,["247"] = 283,["248"] = 283,["249"] = 283,["250"] = 283,["251"] = 283,["252"] = 290,["253"] = 290,["254"] = 290,["255"] = 290,["256"] = 290,["257"] = 290,["258"] = 290,["259"] = 290,["260"] = 290,["261"] = 297,["262"] = 297,["263"] = 297,["264"] = 297,["265"] = 297,["266"] = 297,["267"] = 297,["268"] = 297,["269"] = 297,["270"] = 304,["271"] = 304,["272"] = 304,["273"] = 304,["274"] = 304,["275"] = 304,["276"] = 304,["277"] = 304,["278"] = 304,["279"] = 311,["280"] = 311,["281"] = 311,["282"] = 311,["283"] = 311,["284"] = 311,["285"] = 311,["286"] = 311,["287"] = 280,["288"] = 317,["289"] = 317,["290"] = 317,["291"] = 317,["292"] = 318,["293"] = 317,["294"] = 323,["295"] = 323,["296"] = 323,["297"] = 323,["298"] = 323,["299"] = 323,["300"] = 323,["301"] = 323,["302"] = 327,["303"] = 327,["304"] = 327,["305"] = 327,["306"] = 327,["307"] = 327,["308"] = 327,["309"] = 327,["310"] = 331,["311"] = 331,["312"] = 331,["313"] = 331,["314"] = 331,["315"] = 331,["316"] = 331,["317"] = 331,["318"] = 331,["319"] = 338,["320"] = 338,["321"] = 338,["322"] = 338,["323"] = 338,["324"] = 338,["325"] = 338,["326"] = 338,["327"] = 342,["328"] = 342,["329"] = 342,["330"] = 342,["331"] = 342,["332"] = 342,["333"] = 342,["334"] = 342,["335"] = 342,["336"] = 349,["337"] = 349,["338"] = 349,["339"] = 349,["340"] = 349,["341"] = 349,["342"] = 349,["343"] = 349,["344"] = 349,["345"] = 318});
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
function CustomAI.prototype.AbilityFactory(self, options)
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
    return npcAbility
end
function CustomAI.prototype.AddAbility(self, npcAbility)
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
____exports.DireZombie = __TS__Class()
local DireZombie = ____exports.DireZombie
DireZombie.name = "DireZombie"
__TS__ClassExtends(DireZombie, ____exports.CustomAI)
function DireZombie.prototype.____constructor(self, origin)
    DireZombie.____super.prototype.____constructor(self, "dire_zombie", origin, {behavior = CustomAIBehavior.WANDERER})
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("dire_zombie_attack"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInCastRange = true}
            }
        )
    )
end
____exports.Centaur = __TS__Class()
local Centaur = ____exports.Centaur
Centaur.name = "Centaur"
__TS__ClassExtends(Centaur, ____exports.CustomAI)
function Centaur.prototype.____constructor(self, origin)
    Centaur.____super.prototype.____constructor(self, "npc_dota_hero_centaur", origin, {})
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("centaur_axe_attack"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInRadius = true}
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("centaur_range_attack"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInCastRange = true}
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("centaur_short_attack"),
                orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                requirements = {targetInRadius = true}
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("centaur_charge"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInCastRange = true}
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("centaur_rage"),
                orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
            }
        )
    )
end
____exports.Queen = __TS__Class()
local Queen = ____exports.Queen
Queen.name = "Queen"
__TS__ClassExtends(Queen, ____exports.CustomAI)
function Queen.prototype.____constructor(self, origin)
    Queen.____super.prototype.____constructor(self, "npc_dota_hero_queenofpain", origin, {minFollowRange = 500})
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("queen_scream"),
                orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("queen_dodge"),
                orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("queen_blink"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInCastRange = true}
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("queen_daggers"),
                orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("queen_attack"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInCastRange = true}
            }
        )
    )
    self:AddAbility(
        self:AbilityFactory(
            {
                ability = self.unit:FindAbilityByName("queen_wave"),
                orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                requirements = {targetInCastRange = true}
            }
        )
    )
end
return ____exports
