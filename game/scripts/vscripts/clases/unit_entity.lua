local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 20,["7"] = 20,["8"] = 20,["9"] = 27,["10"] = 24,["11"] = 28,["12"] = 33,["13"] = 36,["14"] = 39,["15"] = 42,["16"] = 42,["17"] = 42,["18"] = 42,["19"] = 42,["20"] = 42,["21"] = 41,["22"] = 52,["23"] = 53,["25"] = 55,["26"] = 55,["27"] = 55,["28"] = 55,["29"] = 55,["30"] = 27,["31"] = 62,["32"] = 63,["33"] = 62,["34"] = 66,["35"] = 67,["36"] = 68,["37"] = 66,["38"] = 71,["39"] = 72,["40"] = 71,["41"] = 75,["42"] = 76,["43"] = 75,["44"] = 79,["45"] = 80,["46"] = 82,["47"] = 83,["48"] = 84,["50"] = 79,["51"] = 88,["52"] = 89,["53"] = 90,["54"] = 91,["56"] = 88,["57"] = 95,["58"] = 95,["59"] = 99,["60"] = 100,["61"] = 99});
local ____exports = {}
____exports.default = __TS__Class()
local UnitEntity = ____exports.default
UnitEntity.name = "UnitEntity"
function UnitEntity.prototype.____constructor(self, options)
    self.destroyed = false
    self.team = options.unit and options.unit:GetTeam() or self:InitializeTeam(options.properties.team)
    self.origin = options.unit and options.unit:GetAbsOrigin() or options.properties.origin
    self.name = options.unit and options.unit:GetName() or options.properties.name
    self.unit = options.unit and self:SetUnit(options.unit) or self:SetUnit(CreateUnitByName(
        self.name,
        self.origin,
        true,
        nil,
        nil,
        self.team
    ))
    if options.properties then
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
