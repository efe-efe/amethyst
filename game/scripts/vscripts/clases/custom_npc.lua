--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 4,["8"] = 4,["9"] = 4,["10"] = 4,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 10,["15"] = 10,["16"] = 10,["17"] = 10,["18"] = 10,["20"] = 43,["22"] = 43,["23"] = 56,["24"] = 43,["25"] = 44,["26"] = 45,["27"] = 49,["28"] = 50,["29"] = 62,["30"] = 63,["31"] = 64,["32"] = 65,["33"] = 66,["35"] = 69,["36"] = 70,["37"] = 71,["38"] = 72,["40"] = 74,["45"] = 79,["47"] = 82,["48"] = 83,["50"] = 85,["53"] = 89,["54"] = 90,["55"] = 89,["56"] = 93,["57"] = 94,["58"] = 94,["59"] = 94,["60"] = 94,["61"] = 98,["62"] = 99,["63"] = 99,["64"] = 99,["65"] = 99,["66"] = 99,["67"] = 99,["68"] = 99,["69"] = 99,["70"] = 94,["71"] = 106,["72"] = 106,["73"] = 106,["74"] = 106,["75"] = 106,["76"] = 106,["77"] = 106,["78"] = 94,["79"] = 94,["80"] = 115,["81"] = 93,["82"] = 118,["83"] = 119,["84"] = 118,["85"] = 122,["86"] = 123,["87"] = 122,["88"] = 126,["89"] = 127,["90"] = 129,["91"] = 130,["93"] = 133,["94"] = 134,["95"] = 135,["96"] = 126,["97"] = 138,["98"] = 139,["99"] = 140,["101"] = 143,["102"] = 144,["103"] = 145,["104"] = 145,["105"] = 145,["106"] = 146,["107"] = 148,["108"] = 149,["109"] = 150,["110"] = 151,["113"] = 154,["114"] = 155,["115"] = 156,["118"] = 159,["119"] = 160,["120"] = 160,["121"] = 160,["122"] = 160,["123"] = 160,["124"] = 160,["125"] = 161,["126"] = 162,["129"] = 165,["130"] = 166,["131"] = 166,["132"] = 166,["133"] = 167,["134"] = 168,["138"] = 172,["139"] = 173,["141"] = 175,["142"] = 176,["144"] = 145,["145"] = 145,["146"] = 180,["147"] = 181,["148"] = 182,["149"] = 183,["150"] = 184,["152"] = 186,["154"] = 138,["155"] = 190,["156"] = 191,["157"] = 192,["158"] = 193,["160"] = 195,["161"] = 196,["162"] = 198,["163"] = 199,["165"] = 202,["166"] = 203,["167"] = 190,["168"] = 206,["169"] = 207,["170"] = 206,["171"] = 210,["172"] = 211,["173"] = 213,["174"] = 214,["176"] = 216,["177"] = 217,["178"] = 218,["180"] = 210,["181"] = 222,["182"] = 223,["183"] = 224,["184"] = 224,["185"] = 224,["186"] = 224,["187"] = 224,["188"] = 225,["189"] = 225,["190"] = 225,["191"] = 225,["192"] = 225,["193"] = 226,["194"] = 222,["195"] = 229,["196"] = 230,["197"] = 229,["198"] = 233,["199"] = 234,["200"] = 236,["201"] = 237,["203"] = 239,["204"] = 240,["205"] = 241,["206"] = 242,["207"] = 243,["208"] = 244,["209"] = 245,["212"] = 248,["213"] = 249,["216"] = 252,["219"] = 255,["220"] = 256,["221"] = 257,["223"] = 233,["225"] = 360,["227"] = 360,["228"] = 361,["229"] = 360,["230"] = 367,["231"] = 367,["233"] = 368,["235"] = 370,["241"] = 376,["243"] = 376,["244"] = 377,["245"] = 376,["246"] = 380,["247"] = 380,["249"] = 381,["251"] = 383,["255"] = 387,["256"] = 387,["258"] = 388,["260"] = 390,["264"] = 394,["265"] = 394,["267"] = 395,["269"] = 397,["273"] = 401,["274"] = 401,["276"] = 402,["278"] = 404,["282"] = 408,["283"] = 408,["285"] = 409,["292"] = 414,["294"] = 414,["295"] = 415,["296"] = 414,["297"] = 420,["298"] = 420,["300"] = 421,["305"] = 424,["306"] = 424,["308"] = 425,["313"] = 428,["314"] = 428,["316"] = 429,["318"] = 431,["322"] = 435,["323"] = 435,["325"] = 436,["330"] = 439,["331"] = 439,["333"] = 440,["335"] = 442,["339"] = 446,["340"] = 446,["342"] = 447,["344"] = 449});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local CustomNPCState = {}
CustomNPCState.IDLE = 0
CustomNPCState[CustomNPCState.IDLE] = "IDLE"
CustomNPCState.WANDERING = 1
CustomNPCState[CustomNPCState.WANDERING] = "WANDERING"
CustomNPCState.RESTING = 2
CustomNPCState[CustomNPCState.RESTING] = "RESTING"
local CustomNPCBehavior = {}
CustomNPCBehavior.FOLLOWER = 0
CustomNPCBehavior[CustomNPCBehavior.FOLLOWER] = "FOLLOWER"
CustomNPCBehavior.WANDERER = 1
CustomNPCBehavior[CustomNPCBehavior.WANDERER] = "WANDERER"
____exports.CustomNPC = __TS__Class()
local CustomNPC = ____exports.CustomNPC
CustomNPC.name = "CustomNPC"
__TS__ClassExtends(CustomNPC, UnitEntity)
function CustomNPC.prototype.____constructor(self, origin, name, options)
    UnitEntity.prototype.____constructor(self, {properties = {origin = origin, name = name, team = DOTA_TEAM_CUSTOM_1}})
    self.state = CustomNPCState.IDLE
    self.abilities = {}
    self.remainingRestTime = 0
    self.rangeOfAction = 3000
    self.restTime = options.restTime or 1
    self.followRange = options.followRange or 2500
    self.minFollowRange = options.minFollowRange or 0
    self.behavior = options.behavior or CustomNPCBehavior.FOLLOWER
    self.originalPosition = origin
end
function CustomNPC.prototype.FindEnemy(self, radius)
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
function CustomNPC.prototype.IsAbilityReady(self, ability)
    return ability:IsCooldownReady() and (not ability:IsInAbilityPhase())
end
function CustomNPC.prototype.AbilityFactory(self, options)
    local npcAbility = {
        ability = options.ability,
        orderType = options.orderType,
        priority = #self.abilities + 1,
        cast = function(____, ability, target)
            ExecuteOrderFromTable(
                {
                    OrderType = options.orderType,
                    UnitIndex = self:GetUnit():GetEntityIndex(),
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
function CustomNPC.prototype.AddAbility(self, npcAbility)
    __TS__ArrayPush(self.abilities, npcAbility)
end
function CustomNPC.prototype.StartRest(self, restTime)
    self.remainingRestTime = restTime * 30
end
function CustomNPC.prototype.BackToOrigin(self, origin)
    local distanceFromOrigin = self.originalPosition:__sub(origin):Length2D()
    if self.rangeOfAction > distanceFromOrigin then
        return false
    end
    local direction = self.originalPosition:__sub(origin):Normalized()
    CustomEntities:SetDirection(self.unit, direction.x, direction.y)
    return true
end
function CustomNPC.prototype.Cast(self)
    if ((CustomEntities:IsDisplacing(self.unit) or CustomEntities:IsCasting(self.unit)) or CustomEntities:IsChanneling(self.unit)) or (self.remainingRestTime > 0) then
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
function CustomNPC.prototype.Follow(self, origin)
    local target = self:FindEnemy(self.followRange)
    if not target then
        return false
    end
    local distance = CustomEntities:GetDistance(self.unit, target)
    local direction = Vector(0, 0)
    if target:IsAlive() and (distance > self.minFollowRange) then
        direction = target:GetAbsOrigin():__sub(origin):Normalized()
    end
    CustomEntities:SetDirection(self.unit, direction.x, direction.y)
    return true
end
function CustomNPC.prototype.StopMoving(self)
    CustomEntities:SetDirection(self.unit, 0, 0)
end
function CustomNPC.prototype.MoveTowards(self, origin, point)
    local distance = point:__sub(origin):Length2D()
    if distance < 10 then
        return false
    else
        local direction = point:__sub(origin):Normalized()
        CustomEntities:SetDirection(self.unit, direction.x, direction.y)
        return true
    end
end
function CustomNPC.prototype.PickTargetPosition(self, origin)
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
function CustomNPC.prototype.ClearTargetPosition(self)
    self.targetPosition = nil
end
function CustomNPC.prototype.Update(self)
    local origin = self.unit:GetAbsOrigin()
    if self.remainingRestTime > 0 then
        self.remainingRestTime = self.remainingRestTime - 1
    end
    if not self:Cast() then
        if self.behavior == CustomNPCBehavior.WANDERER then
            if (self.state == CustomNPCState.WANDERING) and self.targetPosition then
                if not self:MoveTowards(origin, self.targetPosition) then
                    self.state = CustomNPCState.IDLE
                    self:ClearTargetPosition()
                    self:StopMoving()
                end
            else
                self.state = CustomNPCState.WANDERING
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
__TS__ClassExtends(DireZombie, ____exports.CustomNPC)
function DireZombie.prototype.____constructor(self, origin)
    DireZombie.____super.prototype.____constructor(self, origin, "dire_zombie", {minFollowRange = 500, behavior = CustomNPCBehavior.WANDERER})
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
__TS__ClassExtends(Centaur, ____exports.CustomNPC)
function Centaur.prototype.____constructor(self, origin)
    Centaur.____super.prototype.____constructor(self, origin, "npc_dota_hero_centaur", {})
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
__TS__ClassExtends(Queen, ____exports.CustomNPC)
function Queen.prototype.____constructor(self, origin)
    Queen.____super.prototype.____constructor(self, origin, "npc_dota_hero_queenofpain", {minFollowRange = 500})
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
