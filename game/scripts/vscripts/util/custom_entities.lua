--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 3,["8"] = 5,["9"] = 6,["10"] = 7,["11"] = 5,["12"] = 9,["13"] = 10,["14"] = 5,["15"] = 12,["16"] = 13,["17"] = 5,["18"] = 5,["19"] = 17});
local ____exports = {}
require("abilities.generic.modifier_generic_no_health_bar")
require("abilities.generic.modifier_generic_disarm")
require("abilities.generic.modifier_generic_use_energy")
local customEntities = {
    Disarm = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_disarm", {})
    end,
    HideHealthBar = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_no_health_bar", {})
    end,
    SetUseEnergy = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_use_energy", {})
    end
}
____exports.default = customEntities
return ____exports
