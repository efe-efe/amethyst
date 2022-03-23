--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 4,["10"] = 3,["11"] = 4,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 8,["18"] = 11,["19"] = 12,["20"] = 11,["21"] = 14,["22"] = 15,["23"] = 14,["24"] = 4,["26"] = 3,["28"] = 4});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_generic_flying = __TS__Class()
local modifier_generic_flying = ____exports.modifier_generic_flying
modifier_generic_flying.name = "modifier_generic_flying"
__TS__ClassExtends(modifier_generic_flying, BaseModifier)
function modifier_generic_flying.prototype.IsHidden(self)
    return true
end
function modifier_generic_flying.prototype.IsDebuff(self)
    return false
end
function modifier_generic_flying.prototype.IsPurgable(self)
    return false
end
function modifier_generic_flying.prototype.CheckState(self)
    return {[MODIFIER_STATE_FLYING] = true}
end
modifier_generic_flying = __TS__Decorate(
    {
        registerModifier(nil)
    },
    modifier_generic_flying
)
return ____exports
