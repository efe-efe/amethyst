--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 18,["6"] = 18,["7"] = 18,["8"] = 18,["9"] = 25,["10"] = 22,["11"] = 26,["12"] = 27,["13"] = 28,["14"] = 29,["15"] = 29,["16"] = 29,["17"] = 38,["18"] = 39,["20"] = 25,["21"] = 43,["22"] = 44,["23"] = 43,["24"] = 47,["25"] = 48,["26"] = 49,["27"] = 47,["28"] = 52,["29"] = 53,["30"] = 52,["31"] = 56,["32"] = 57,["33"] = 56,["34"] = 60,["35"] = 61,["36"] = 63,["37"] = 64,["38"] = 64,["39"] = 64,["41"] = 60,["42"] = 68,["43"] = 68,["44"] = 72,["45"] = 73,["46"] = 72,["47"] = 18,["48"] = 18});
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local UnitEntity = ____exports.default
    UnitEntity.name = "UnitEntity"
    function UnitEntity.prototype.____constructor(self, options)
        self.destroyed = false
        self.team = (options.unit and options.unit:GetTeam()) or self:InitializeTeam(options.properties.team)
        self.origin = (options.unit and options.unit:GetAbsOrigin()) or options.properties.origin
        self.name = (options.unit and options.unit:GetName()) or options.properties.name
        self.unit = (options.unit and self:SetUnit(options.unit)) or self:SetUnit(
            CreateUnitByName(self.name, self.origin, true, nil, nil, self.team)
        )
        if options.properties then
            self.unit:SetAbsOrigin(self.origin)
        end
    end
    function UnitEntity.prototype.InitializeTeam(self, team)
        return (team and team) or DOTA_TEAM_NOTEAM
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
            UTIL_Remove(
                self:GetUnit()
            )
        end
    end
    function UnitEntity.prototype.OnDeath(self, params)
    end
    function UnitEntity.prototype.AddComponent(self, component)
        component:Activate(self)
    end
    return UnitEntity
end)()
return ____exports
