local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 17,["7"] = 17,["8"] = 17,["9"] = 24,["10"] = 21,["11"] = 25,["12"] = 26,["13"] = 27,["14"] = 28,["15"] = 31,["16"] = 31,["17"] = 31,["18"] = 31,["19"] = 31,["20"] = 31,["21"] = 31,["22"] = 33,["23"] = 34,["25"] = 36,["26"] = 36,["27"] = 36,["28"] = 36,["29"] = 36,["30"] = 24,["31"] = 39,["32"] = 40,["33"] = 39,["34"] = 43,["35"] = 44,["36"] = 45,["37"] = 43,["38"] = 48,["39"] = 49,["40"] = 48,["41"] = 52,["42"] = 53,["43"] = 52,["44"] = 56,["45"] = 57,["46"] = 59,["47"] = 60,["48"] = 61,["50"] = 56,["51"] = 65,["52"] = 66,["53"] = 67,["54"] = 68,["56"] = 65,["57"] = 72,["58"] = 72,["59"] = 76,["60"] = 77,["61"] = 76});
local ____exports = {}
____exports.default = __TS__Class()
local UnitEntity = ____exports.default
UnitEntity.name = "UnitEntity"
function UnitEntity.prototype.____constructor(self, options)
    self.destroyed = false
    self.team = options.unit ~= nil and options.unit:GetTeam() or self:InitializeTeam(options.properties.team)
    self.origin = options.unit ~= nil and options.unit:GetAbsOrigin() or options.properties.origin
    self.name = options.unit ~= nil and options.unit:GetName() or options.properties.name
    self.unit = options.unit ~= nil and self:SetUnit(options.unit) or self:SetUnit(CreateUnitByName(
        self.name,
        self.origin,
        true,
        nil,
        nil,
        self.team
    ))
    if options.properties ~= nil then
        self.unit:SetAbsOrigin(self.origin)
    end
    ListenToGameEvent(
        "entity_killed",
        function(event) return self:OnUnitDied(event) end,
        nil
    )
end
function UnitEntity.prototype.InitializeTeam(self, team)
    return team and team or DOTA_TEAM_NOTEAM
end
function UnitEntity.prototype.SetUnit(self, unit)
    CustomEntitiesLegacy:SetParent(unit, self)
    return unit
end
function UnitEntity.prototype.GetUnit(self)
    return self.unit
end
function UnitEntity.prototype.Alive(self)
    return not self.destroyed
end
function UnitEntity.prototype.Destroy(self, remove)
    self.destroyed = true
    if remove then
        GameRules.Addon:RemoveUnit(self.unit)
        UTIL_Remove(self.unit)
    end
end
function UnitEntity.prototype.OnUnitDied(self, event)
    local killed = EntIndexToHScript(event.entindex_killed)
    if killed == self.unit then
        self:OnDeath(event)
    end
end
function UnitEntity.prototype.OnDeath(self, event)
end
function UnitEntity.prototype.AddComponent(self, component)
    component:Activate(self)
end
return ____exports
