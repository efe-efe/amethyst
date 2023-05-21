--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 20,["6"] = 20,["7"] = 20,["8"] = 20,["9"] = 27,["10"] = 24,["11"] = 28,["12"] = 33,["13"] = 36,["14"] = 39,["15"] = 41,["16"] = 41,["17"] = 52,["18"] = 53,["20"] = 55,["21"] = 55,["22"] = 55,["23"] = 55,["24"] = 55,["25"] = 27,["26"] = 62,["27"] = 63,["28"] = 62,["29"] = 66,["30"] = 67,["31"] = 68,["32"] = 66,["33"] = 71,["34"] = 72,["35"] = 71,["36"] = 75,["37"] = 76,["38"] = 75,["39"] = 79,["40"] = 80,["41"] = 82,["42"] = 83,["43"] = 84,["45"] = 79,["46"] = 88,["47"] = 89,["48"] = 90,["49"] = 91,["51"] = 88,["52"] = 95,["53"] = 95,["54"] = 99,["55"] = 100,["56"] = 99,["57"] = 20,["58"] = 20});
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
        ListenToGameEvent(
            "entity_killed",
            function(event) return self:OnUnitDied(event) end,
            nil
        )
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
    return UnitEntity
end)()
return ____exports
