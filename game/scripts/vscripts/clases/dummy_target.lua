--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 4,["13"] = 3,["14"] = 4,["15"] = 11,["16"] = 3,["17"] = 13,["18"] = 11,["19"] = 3,["20"] = 3});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.default = (function()
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
    return DummyTarget
end)()
return ____exports
