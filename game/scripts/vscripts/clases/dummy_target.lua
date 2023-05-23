local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 4,["14"] = 3,["15"] = 4,["16"] = 13,["17"] = 3,["18"] = 15,["19"] = 13});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.default = __TS__Class()
local DummyTarget = ____exports.default
DummyTarget.name = "DummyTarget"
__TS__ClassExtends(DummyTarget, UnitEntity)
function DummyTarget.prototype.____constructor(self, origin)
    UnitEntity.prototype.____constructor(self, {properties = {origin = origin, name = "npc_dota_creature_dummy_target"}})
end
function DummyTarget.prototype.OnDeath(self, event)
    UnitEntity.prototype.OnDeath(self, event)
    self:Destroy(false)
end
return ____exports
