--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 18,["6"] = 18,["7"] = 18,["8"] = 18,["9"] = 25,["10"] = 22,["11"] = 26,["12"] = 27,["13"] = 28,["14"] = 29,["15"] = 29,["16"] = 29,["17"] = 38,["18"] = 39,["20"] = 41,["21"] = 41,["22"] = 41,["23"] = 41,["24"] = 41,["25"] = 25,["26"] = 44,["27"] = 45,["28"] = 44,["29"] = 48,["30"] = 49,["31"] = 50,["32"] = 48,["33"] = 53,["34"] = 54,["35"] = 53,["36"] = 57,["37"] = 58,["38"] = 57,["39"] = 61,["40"] = 62,["41"] = 64,["42"] = 65,["43"] = 66,["45"] = 61,["46"] = 70,["47"] = 71,["48"] = 72,["49"] = 73,["51"] = 70,["52"] = 77,["53"] = 77,["54"] = 81,["55"] = 82,["56"] = 81,["57"] = 18,["58"] = 18});
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
