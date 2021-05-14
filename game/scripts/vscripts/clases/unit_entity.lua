--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 14,["6"] = 14,["7"] = 14,["8"] = 14,["9"] = 21,["10"] = 18,["11"] = 22,["12"] = 23,["13"] = 24,["14"] = 25,["15"] = 25,["16"] = 25,["17"] = 34,["18"] = 35,["20"] = 21,["21"] = 39,["22"] = 40,["23"] = 39,["24"] = 43,["25"] = 44,["26"] = 45,["27"] = 43,["28"] = 48,["29"] = 49,["30"] = 48,["31"] = 52,["32"] = 53,["33"] = 52,["34"] = 56,["35"] = 57,["36"] = 59,["37"] = 60,["38"] = 60,["39"] = 60,["41"] = 56,["42"] = 64,["43"] = 64,["44"] = 14,["45"] = 14});
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
    return UnitEntity
end)()
return ____exports
