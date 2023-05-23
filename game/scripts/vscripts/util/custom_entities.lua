local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 3,["8"] = 4,["9"] = 6,["10"] = 7,["11"] = 8,["12"] = 6,["13"] = 10,["14"] = 11,["15"] = 6,["16"] = 13,["17"] = 14,["18"] = 6,["19"] = 16,["20"] = 17,["21"] = 6,["22"] = 19,["23"] = 20,["24"] = 6,["25"] = 6,["26"] = 26});
local ____exports = {}
require("modifiers.generic.modifier_generic_no_health_bar")
require("modifiers.generic.modifier_generic_disarm")
require("modifiers.generic.modifier_generic_use_energy")
require("modifiers.generic.modifier_generic_ignore_ms_limit")
local customEntities = {
    Disarm = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_disarm", {})
    end,
    HideHealthBar = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_no_health_bar", {})
    end,
    SetUseEnergy = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_use_energy", {})
    end,
    IgnoreMSLimit = function(self, entity)
        entity:AddNewModifier(entity, nil, "modifier_generic_ignore_ms_limit", {})
    end,
    ChangeMS = function(self, entity, amount)
        entity:AddNewModifier(entity, nil, "modifier_generic_change_ms", {amount = amount})
    end
}
____exports.default = customEntities
return ____exports
