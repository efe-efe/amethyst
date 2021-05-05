--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 4,["8"] = 4,["9"] = 4,["10"] = 4,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 10,["15"] = 10,["16"] = 10,["17"] = 10,["18"] = 10,["20"] = 43,["22"] = 43,["23"] = 57,["24"] = 43,["25"] = 44,["26"] = 45,["27"] = 49,["28"] = 50,["29"] = 59,["30"] = 60,["31"] = 61,["32"] = 62,["33"] = 63,["34"] = 64,["36"] = 67,["37"] = 68,["38"] = 69,["39"] = 70,["41"] = 72,["46"] = 77,["48"] = 80,["49"] = 81,["51"] = 83,["54"] = 87,["55"] = 88,["56"] = 87,["57"] = 91,["58"] = 92,["59"] = 92,["60"] = 92,["61"] = 92,["62"] = 96,["63"] = 97,["64"] = 97,["65"] = 97,["66"] = 97,["67"] = 97,["68"] = 97,["69"] = 97,["70"] = 97,["71"] = 92,["72"] = 104,["73"] = 104,["74"] = 104,["75"] = 104,["76"] = 104,["77"] = 104,["78"] = 104,["79"] = 92,["80"] = 92,["81"] = 113,["82"] = 91,["83"] = 116,["84"] = 117,["85"] = 116,["86"] = 120,["87"] = 121,["88"] = 120,["89"] = 124,["90"] = 125,["91"] = 127,["92"] = 128,["94"] = 131,["95"] = 132,["96"] = 133,["97"] = 124,["98"] = 136,["99"] = 137,["100"] = 138,["102"] = 141,["103"] = 142,["104"] = 143,["105"] = 143,["106"] = 143,["107"] = 144,["108"] = 146,["109"] = 147,["110"] = 148,["111"] = 149,["114"] = 152,["115"] = 153,["116"] = 154,["119"] = 157,["120"] = 158,["121"] = 158,["122"] = 158,["123"] = 158,["124"] = 158,["125"] = 158,["126"] = 159,["127"] = 160,["130"] = 163,["131"] = 164,["132"] = 164,["133"] = 164,["134"] = 165,["135"] = 166,["139"] = 170,["140"] = 171,["142"] = 173,["143"] = 174,["145"] = 143,["146"] = 143,["147"] = 178,["148"] = 179,["149"] = 180,["150"] = 181,["151"] = 182,["153"] = 184,["155"] = 136,["156"] = 188,["157"] = 189,["158"] = 190,["159"] = 191,["161"] = 193,["162"] = 194,["163"] = 196,["164"] = 197,["166"] = 200,["167"] = 201,["168"] = 188,["169"] = 204,["170"] = 205,["171"] = 204,["172"] = 208,["173"] = 209,["174"] = 211,["175"] = 212,["177"] = 214,["178"] = 215,["179"] = 216,["181"] = 208,["182"] = 220,["183"] = 221,["184"] = 222,["185"] = 222,["186"] = 222,["187"] = 222,["188"] = 222,["189"] = 223,["190"] = 223,["191"] = 223,["192"] = 223,["193"] = 223,["194"] = 224,["195"] = 220,["196"] = 227,["197"] = 228,["198"] = 227,["199"] = 231,["200"] = 232,["201"] = 234,["202"] = 235,["204"] = 237,["205"] = 238,["206"] = 239,["207"] = 240,["208"] = 241,["209"] = 242,["210"] = 243,["213"] = 246,["214"] = 247,["217"] = 250,["220"] = 253,["221"] = 254,["222"] = 255,["224"] = 231,["226"] = 359,["228"] = 359,["229"] = 360,["230"] = 359,["231"] = 366,["232"] = 366,["234"] = 367,["236"] = 369,["242"] = 376,["244"] = 376,["245"] = 377,["246"] = 376,["247"] = 380,["248"] = 380,["250"] = 381,["252"] = 383,["256"] = 387,["257"] = 387,["259"] = 388,["261"] = 390,["265"] = 394,["266"] = 394,["268"] = 395,["270"] = 397,["274"] = 401,["275"] = 401,["277"] = 402,["279"] = 404,["283"] = 408,["284"] = 408,["286"] = 409,["293"] = 415,["295"] = 415,["296"] = 416,["297"] = 415,["298"] = 421,["299"] = 421,["301"] = 422,["306"] = 425,["307"] = 425,["309"] = 426,["314"] = 429,["315"] = 429,["317"] = 430,["319"] = 432,["323"] = 436,["324"] = 436,["326"] = 437,["331"] = 440,["332"] = 440,["334"] = 441,["336"] = 443,["340"] = 447,["341"] = 447,["343"] = 448,["345"] = 450});
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
    UnitEntity.prototype.____constructor(self, origin, name, DOTA_TEAM_CUSTOM_1)
    self.state = CustomNPCState.IDLE
    self.abilities = {}
    self.remainingRestTime = 0
    self.rangeOfAction = 3000
    self.unit = self:GetUnit()
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
