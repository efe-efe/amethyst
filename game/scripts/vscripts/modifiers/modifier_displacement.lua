local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 22,["13"] = 23,["14"] = 22,["15"] = 23,["17"] = 23,["18"] = 41,["19"] = 42,["20"] = 22,["21"] = 44,["22"] = 45,["23"] = 44,["24"] = 48,["25"] = 49,["26"] = 48,["27"] = 52,["28"] = 53,["29"] = 54,["30"] = 55,["31"] = 56,["32"] = 57,["33"] = 58,["34"] = 59,["35"] = 60,["36"] = 61,["37"] = 62,["38"] = 63,["39"] = 64,["40"] = 65,["41"] = 66,["42"] = 68,["43"] = 69,["44"] = 71,["45"] = 72,["47"] = 74,["48"] = 75,["51"] = 52,["52"] = 80,["53"] = 81,["54"] = 82,["55"] = 83,["56"] = 84,["57"] = 84,["58"] = 84,["59"] = 84,["60"] = 84,["63"] = 80,["64"] = 89,["65"] = 91,["66"] = 92,["67"] = 93,["69"] = 97,["70"] = 100,["71"] = 101,["73"] = 104,["74"] = 105,["75"] = 106,["76"] = 106,["77"] = 106,["78"] = 106,["79"] = 106,["80"] = 106,["81"] = 106,["82"] = 106,["83"] = 106,["84"] = 116,["85"] = 116,["86"] = 116,["87"] = 116,["88"] = 117,["89"] = 117,["90"] = 117,["91"] = 117,["92"] = 118,["93"] = 118,["94"] = 118,["95"] = 118,["96"] = 119,["97"] = 119,["98"] = 119,["99"] = 119,["100"] = 120,["101"] = 121,["102"] = 122,["103"] = 122,["104"] = 122,["106"] = 122,["108"] = 122,["109"] = 124,["110"] = 125,["112"] = 130,["113"] = 131,["115"] = 137,["116"] = 138,["118"] = 143,["119"] = 89,["120"] = 149,["121"] = 150,["122"] = 151,["123"] = 152,["124"] = 149,["125"] = 155,["126"] = 156,["127"] = 157,["129"] = 155,["130"] = 161,["131"] = 162,["132"] = 163,["133"] = 164,["134"] = 164,["135"] = 164,["136"] = 164,["137"] = 164,["138"] = 161,["139"] = 167,["140"] = 168,["141"] = 169,["143"] = 167,["144"] = 173,["145"] = 174,["146"] = 173,["147"] = 178,["148"] = 178,["149"] = 184,["150"] = 185,["151"] = 184,["152"] = 188,["153"] = 189,["154"] = 188,["155"] = 23,["156"] = 22,["157"] = 23,["159"] = 23});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifierMotionBoth = ____custom_modifier.CustomModifierMotionBoth
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierDisplacement = __TS__Class()
local ModifierDisplacement = ____exports.ModifierDisplacement
ModifierDisplacement.name = "ModifierDisplacement"
__TS__ClassExtends(ModifierDisplacement, CustomModifierMotionBoth)
function ModifierDisplacement.prototype.____constructor(self, ...)
    CustomModifierMotionBoth.prototype.____constructor(self, ...)
    self.elapsedTime = 0
    self.motionTick = {0, 0, 0}
end
function ModifierDisplacement.prototype.IsHidden(self)
    return false
end
function ModifierDisplacement.prototype.IsPurgable(self)
    return false
end
function ModifierDisplacement.prototype.OnCreated(self, params)
    if IsServer() then
        self.distance = params.distance or 0
        self.speed = params.speed == 0 and 1 or params.speed
        self.peak = params.peak or 0
        self.direction = Vector(params.x, params.y, 0):Normalized()
        self.origin = self.parent:GetAbsOrigin()
        self.previousOrigin = nil
        self.duration = self.distance / self.speed
        self.gravity = -self.peak / (self.duration * self.duration * 0.125)
        self.offset = params.offset or 80
        self.radius = params.radius or 80
        self.teamFilter = params.teamFilter or DOTA_UNIT_TARGET_TEAM_BOTH
        self.targetType = params.targetType or DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
        self.flagFilter = params.flagFilter or DOTA_UNIT_TARGET_FLAG_NONE
        self.horizontalSpeed = self.speed
        self.verticalSpeed = -0.5 * self.gravity * self.duration
        if self:ApplyVerticalMotionController() == false then
            self:Destroy()
        end
        if self:ApplyHorizontalMotionController() == false then
            self:Destroy()
        end
    end
end
function ModifierDisplacement.prototype.OnDestroy(self)
    if IsServer() then
        self.parent:InterruptMotionControllers(true)
        if self:GetFindClearSpace() then
            FindClearSpaceForUnit(
                self.parent,
                self.parent:GetAbsOrigin(),
                true
            )
        end
    end
end
function ModifierDisplacement.prototype.SyncTime(self, tickIndex, dt)
    if self.motionTick[2] == self.motionTick[3] then
        self.motionTick[1] = self.motionTick[1] + 1
        self.elapsedTime = self.elapsedTime + dt
    end
    self.motionTick[tickIndex + 1] = self.motionTick[1]
    if self.elapsedTime > self.duration and self.motionTick[2] == self.motionTick[3] then
        self:Destroy()
    end
    local origin = Vector(self.direction.x, self.direction.y, 0):__mul(self.offset):__add(self.parent:GetAbsOrigin())
    local trees = GridNav:GetAllTreesAroundPoint(origin, self.radius / 2, true)
    local units = CustomEntitiesLegacy:FindUnitsInRadius(
        self.parent,
        origin,
        self.radius,
        self.teamFilter,
        self.targetType,
        self.flagFilter,
        FIND_ANY_ORDER
    )
    local zLeft = GetGroundPosition(
        origin:__add(Vector(-1, 0, 0)),
        self.parent
    ).z
    local zRight = GetGroundPosition(
        origin:__add(Vector(1, 0, 0)),
        self.parent
    ).z
    local zUp = GetGroundPosition(
        origin:__add(Vector(0, 1, 0)),
        self.parent
    ).z
    local zDown = GetGroundPosition(
        origin:__add(Vector(0, -1, 0)),
        self.parent
    ).z
    local normal = Vector(zLeft - zRight, zDown - zUp, 2):Normalized()
    local ground = GetGroundPosition(origin, self.parent)
    local ____table_previousOrigin_0
    if self.previousOrigin then
        ____table_previousOrigin_0 = ground.z > self.previousOrigin.z
    else
        ____table_previousOrigin_0 = true
    end
    local groundConnect = ____table_previousOrigin_0
    if normal.z < 0.8 and groundConnect then
        self:OnCollide({collision = "wall"})
    end
    if #units > 0 then
        self:OnCollide({units = units, collision = "unit"})
    end
    if #trees > 0 then
        self:OnCollide({collision = "tree"})
    end
    self.previousOrigin = self.parent:GetAbsOrigin()
end
function ModifierDisplacement.prototype.UpdateHorizontalMotion(self, me, dt)
    self:SyncTime(1, dt)
    local target = self.direction:__mul(self.horizontalSpeed):__mul(self.elapsedTime)
    self.parent:SetAbsOrigin(self.origin:__add(target))
end
function ModifierDisplacement.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function ModifierDisplacement.prototype.UpdateVerticalMotion(self, me, dt)
    self:SyncTime(2, dt)
    local target = self.verticalSpeed * self.elapsedTime + 0.5 * self.gravity * self.elapsedTime * self.elapsedTime
    self.parent:SetAbsOrigin(Vector(
        self.parent:GetAbsOrigin().x,
        self.parent:GetAbsOrigin().y,
        self.origin.z + target
    ))
end
function ModifierDisplacement.prototype.OnVerticalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function ModifierDisplacement.prototype.CheckState(self)
    return {[MODIFIER_STATE_COMMAND_RESTRICTED] = self:GetIsCommandRestricted()}
end
function ModifierDisplacement.prototype.OnCollide(self, params)
end
function ModifierDisplacement.prototype.GetIsCommandRestricted(self)
    return true
end
function ModifierDisplacement.prototype.GetFindClearSpace(self)
    return true
end
ModifierDisplacement = __TS__Decorate(
    {registerModifier(nil)},
    ModifierDisplacement
)
____exports.ModifierDisplacement = ModifierDisplacement
return ____exports
