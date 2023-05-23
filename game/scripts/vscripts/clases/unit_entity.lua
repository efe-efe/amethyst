local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 18,["7"] = 18,["8"] = 18,["9"] = 25,["10"] = 22,["11"] = 26,["12"] = 29,["13"] = 32,["14"] = 35,["15"] = 37,["16"] = 37,["17"] = 37,["18"] = 37,["19"] = 37,["20"] = 37,["21"] = 37,["22"] = 39,["23"] = 40,["25"] = 42,["26"] = 42,["27"] = 42,["28"] = 42,["29"] = 42,["30"] = 25,["31"] = 45,["32"] = 46,["33"] = 45,["34"] = 49,["35"] = 50,["36"] = 51,["37"] = 49,["38"] = 54,["39"] = 55,["40"] = 54,["41"] = 58,["42"] = 59,["43"] = 58,["44"] = 62,["45"] = 63,["46"] = 65,["47"] = 66,["48"] = 67,["50"] = 62,["51"] = 71,["52"] = 72,["53"] = 73,["54"] = 74,["56"] = 71,["57"] = 78,["58"] = 78,["59"] = 82,["60"] = 83,["61"] = 82});
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
