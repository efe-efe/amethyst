--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["9"] = 7,["10"] = 7,["11"] = 7,["13"] = 4,["14"] = 8,["15"] = 9,["16"] = 11,["17"] = 11,["18"] = 11,["19"] = 20,["21"] = 23,["22"] = 24,["23"] = 25,["24"] = 23,["25"] = 28,["26"] = 29,["27"] = 28,["28"] = 32,["29"] = 33,["30"] = 32,["31"] = 36,["32"] = 37,["33"] = 39,["34"] = 40,["35"] = 40,["36"] = 40,["38"] = 36,["39"] = 44,["40"] = 44,["41"] = 1});
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local UnitEntity = ____exports.default
    UnitEntity.name = "UnitEntity"
    function UnitEntity.prototype.____constructor(self, origin, name, team)
        if team == nil then
            team = DOTA_TEAM_NOTEAM
        end
        self.destroyed = false
        self.origin = origin
        self.team = team
        self:SetUnit(
            CreateUnitByName(name, self.origin, true, nil, nil, self.team)
        )
        self:GetUnit():SetAbsOrigin(self.origin)
    end
    function UnitEntity.prototype.SetUnit(self, unit)
        self.unit = unit
        CustomEntities:SetParent(self.unit, self)
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
