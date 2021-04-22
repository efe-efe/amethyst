--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 17,["16"] = 17,["17"] = 29,["18"] = 29,["19"] = 29,["21"] = 17,["22"] = 18,["23"] = 19,["24"] = 20,["25"] = 21,["26"] = 22,["27"] = 23,["28"] = 25,["29"] = 31,["30"] = 32,["32"] = 35,["33"] = 36,["34"] = 37,["35"] = 38,["37"] = 40,["42"] = 45,["44"] = 48,["45"] = 49,["47"] = 51,["50"] = 55,["51"] = 56,["52"] = 55,["53"] = 59,["54"] = 60,["55"] = 61,["56"] = 61,["57"] = 61,["58"] = 61,["59"] = 61,["60"] = 61,["61"] = 61,["62"] = 61,["63"] = 60,["64"] = 68,["65"] = 59,["66"] = 71,["67"] = 72,["68"] = 71,["69"] = 75,["70"] = 76,["71"] = 77,["72"] = 79,["73"] = 80,["75"] = 83,["76"] = 84,["77"] = 85,["78"] = 85,["79"] = 85,["80"] = 85,["81"] = 86,["86"] = 92,["88"] = 95,["89"] = 96,["91"] = 98,["93"] = 101,["94"] = 102,["95"] = 104,["96"] = 105,["97"] = 105,["98"] = 105,["99"] = 106,["101"] = 108,["102"] = 108,["103"] = 108,["106"] = 111,["107"] = 111,["108"] = 111,["109"] = 111,["111"] = 114,["112"] = 116,["113"] = 117,["114"] = 119,["115"] = 120,["116"] = 120,["117"] = 120,["120"] = 124,["121"] = 125,["122"] = 127,["123"] = 128,["124"] = 128,["125"] = 128,["126"] = 129,["127"] = 130,["128"] = 131,["130"] = 133,["131"] = 134,["134"] = 128,["135"] = 128,["136"] = 138,["137"] = 139,["138"] = 140,["141"] = 144,["142"] = 145,["145"] = 75,["147"] = 151,["149"] = 151,["150"] = 152,["151"] = 151,["152"] = 155,["154"] = 156,["155"] = 157,["157"] = 159,["158"] = 160,["159"] = 161,["160"] = 162,["162"] = 164,["164"] = 159,["167"] = 168,["169"] = 169,["170"] = 170,["172"] = 172,["173"] = 173,["174"] = 172,["177"] = 176,["179"] = 177,["180"] = 178,["182"] = 180,["183"] = 181,["184"] = 180,["187"] = 184,["189"] = 185,["190"] = 186,["192"] = 188,["193"] = 189,["194"] = 188,["197"] = 192,["199"] = 193,["200"] = 194,["202"] = 196,["203"] = 197,["204"] = 198,["205"] = 199,["207"] = 201,["209"] = 196,["214"] = 208,["216"] = 208,["217"] = 209,["218"] = 208,["219"] = 212,["221"] = 213,["222"] = 214,["224"] = 216,["225"] = 217,["226"] = 216,["229"] = 220,["231"] = 221,["232"] = 222,["234"] = 224,["235"] = 225,["236"] = 224,["239"] = 228,["241"] = 229,["242"] = 230,["244"] = 232,["245"] = 233,["246"] = 232,["249"] = 236,["251"] = 237,["252"] = 238,["254"] = 240,["255"] = 241,["256"] = 240,["259"] = 244,["261"] = 245,["262"] = 246,["264"] = 248,["265"] = 249,["266"] = 248,["269"] = 252,["271"] = 253,["272"] = 254,["274"] = 256,["275"] = 257,["276"] = 256});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local CustomNPCState = {}
CustomNPCState.READY = 0
CustomNPCState[CustomNPCState.READY] = "READY"
CustomNPCState.CASTING = 1
CustomNPCState[CustomNPCState.CASTING] = "CASTING"
CustomNPCState.RESTING = 2
CustomNPCState[CustomNPCState.RESTING] = "RESTING"
local CustomNPC = __TS__Class()
CustomNPC.name = "CustomNPC"
__TS__ClassExtends(CustomNPC, UnitEntity)
function CustomNPC.prototype.____constructor(self, origin, name, restTime)
    if restTime == nil then
        restTime = 1
    end
    UnitEntity.prototype.____constructor(self, origin, name, DOTA_TEAM_CUSTOM_1)
    self.state = CustomNPCState.READY
    self.abilities = {}
    self.followRange = 750
    self.abilitiesRange = 2500
    self.wanderer = true
    self.backToCenter = true
    self.remainingRestTime = 0
    self.unit = self:GetUnit()
    self.restTime = restTime
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
function CustomNPC.prototype.RegisterAbility(self, npcAbility)
    npcAbility.cast = function(____, ability, target)
        ExecuteOrderFromTable(
            {
                OrderType = npcAbility.orderType,
                UnitIndex = self:GetUnit():GetEntityIndex(),
                AbilityIndex = ability:GetEntityIndex(),
                Position = (target and target:GetAbsOrigin()) or nil
            }
        )
    end
    __TS__ArrayPush(self.abilities, npcAbility)
end
function CustomNPC.prototype.StartRest(self, restTime)
    self.remainingRestTime = restTime * 30
end
function CustomNPC.prototype.Update(self)
    if self.remainingRestTime > 0 then
        self.remainingRestTime = self.remainingRestTime - 1
        if self.state ~= CustomNPCState.RESTING then
            self.state = CustomNPCState.RESTING
        end
        if self.wanderer then
            if self.restDirection == nil then
                self.restDirection = Vector(
                    RandomFloat(-1, 1),
                    RandomFloat(-1, 1)
                )
                CustomEntities:SetDirection(self.unit, self.restDirection.x, self.restDirection.y)
            end
        end
        return
    else
        self.restDirection = nil
    end
    if self.unit:HasModifier("modifier_casting") or CustomEntities:IsChanneling(self.unit) then
        self.state = CustomNPCState.CASTING
    else
        self.state = CustomNPCState.READY
    end
    if self.state == CustomNPCState.READY then
        local direction = Vector(0, 0)
        if self.backToCenter then
            if self.unit:GetAbsOrigin():__sub(
                Vector(0, 0, 0)
            ):Length2D() < 10 then
                direction = Vector(0, 0)
            else
                direction = Vector(0, 0, 0):__sub(
                    self.unit:GetAbsOrigin()
                ):Normalized()
            end
        else
            direction = Vector(
                RandomFloat(-1, 1),
                RandomFloat(-1, 1)
            )
        end
        local target = self:FindEnemy(self.followRange)
        if target then
            local distance = CustomEntities:GetDistance(self.unit, target)
            if target:IsAlive() and (distance > 250) then
                direction = target:GetAbsOrigin():__sub(
                    self.unit:GetAbsOrigin()
                ):Normalized()
            end
        end
        if not CustomEntities:IsDisplacing(self.unit) then
            target = self:FindEnemy(self.abilitiesRange)
            local abilityToExecute = nil
            __TS__ArrayForEach(
                self.abilities,
                function(____, npcAbility)
                    if npcAbility:requirements(npcAbility.ability, target) then
                        if abilityToExecute == nil then
                            abilityToExecute = npcAbility
                        end
                        if npcAbility.priority > abilityToExecute.priority then
                            abilityToExecute = npcAbility
                        end
                    end
                end
            )
            if abilityToExecute then
                abilityToExecute:cast(abilityToExecute.ability, target)
                self:StartRest(self.restTime)
            end
        end
        if self.wanderer then
            CustomEntities:SetDirection(self.unit, direction.x, direction.y)
        end
    end
end
____exports.Centaur = __TS__Class()
local Centaur = ____exports.Centaur
Centaur.name = "Centaur"
__TS__ClassExtends(Centaur, CustomNPC)
function Centaur.prototype.____constructor(self, origin)
    CustomNPC.prototype.____constructor(self, origin, "npc_dota_hero_centaur", 1)
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("centaur_short_attack"),
            priority = 3,
            orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            requirements = function(____, ability, target)
                if target then
                    local distance = CustomEntities:GetDistance(self.unit, target)
                    return (target and (CustomEntities:GetDistance(self.unit, target) <= ability:GetSpecialValueFor("radius"))) and self:IsAbilityReady(ability)
                else
                    return false
                end
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("centaur_range_attack"),
            priority = 1,
            orderType = DOTA_UNIT_ORDER_CAST_POSITION,
            requirements = function(____, ability, target)
                return target and self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("centaur_charge"),
            priority = 4,
            orderType = DOTA_UNIT_ORDER_CAST_POSITION,
            requirements = function(____, ability, target)
                return target and self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("centaur_rage"),
            priority = 5,
            orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            requirements = function(____, ability)
                return self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("centaur_axe_attack"),
            priority = 2,
            orderType = DOTA_UNIT_ORDER_CAST_POSITION,
            requirements = function(____, ability, target)
                if target then
                    local distance = CustomEntities:GetDistance(self.unit, target)
                    return (CustomEntities:GetDistance(self.unit, target) <= ability:GetSpecialValueFor("radius")) and self:IsAbilityReady(ability)
                else
                    return false
                end
            end
        }
    )
end
____exports.Queen = __TS__Class()
local Queen = ____exports.Queen
Queen.name = "Queen"
__TS__ClassExtends(Queen, CustomNPC)
function Queen.prototype.____constructor(self, origin)
    CustomNPC.prototype.____constructor(self, origin, "npc_dota_hero_queenofpain", 1)
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("queen_dodge"),
            priority = 0,
            orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            requirements = function(____, ability)
                return self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("queen_wave"),
            priority = 1,
            orderType = DOTA_UNIT_ORDER_CAST_POSITION,
            requirements = function(____, ability, target)
                return target and self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("queen_blink"),
            priority = 2,
            orderType = DOTA_UNIT_ORDER_CAST_POSITION,
            requirements = function(____, ability, target)
                return target and self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("queen_daggers"),
            priority = 3,
            orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            requirements = function(____, ability)
                return self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("queen_scream"),
            priority = 4,
            orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            requirements = function(____, ability)
                return self:IsAbilityReady(ability)
            end
        }
    )
    self:RegisterAbility(
        {
            ability = self.unit:FindAbilityByName("queen_attack"),
            priority = 5,
            orderType = DOTA_UNIT_ORDER_CAST_POSITION,
            requirements = function(____, ability, target)
                return target and self:IsAbilityReady(ability)
            end
        }
    )
end
return ____exports
