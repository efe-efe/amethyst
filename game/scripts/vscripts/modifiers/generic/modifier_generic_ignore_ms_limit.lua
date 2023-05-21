--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 4,["10"] = 3,["11"] = 4,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 8,["18"] = 11,["19"] = 12,["20"] = 11,["21"] = 14,["22"] = 15,["23"] = 14,["24"] = 17,["25"] = 18,["26"] = 17,["27"] = 20,["28"] = 21,["29"] = 20,["30"] = 4,["32"] = 3,["34"] = 4});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_generic_ignore_ms_limit = __TS__Class()
local modifier_generic_ignore_ms_limit = ____exports.modifier_generic_ignore_ms_limit
modifier_generic_ignore_ms_limit.name = "modifier_generic_ignore_ms_limit"
__TS__ClassExtends(modifier_generic_ignore_ms_limit, BaseModifier)
function modifier_generic_ignore_ms_limit.prototype.IsHidden(self)
    return true
end
function modifier_generic_ignore_ms_limit.prototype.IsDebuff(self)
    return false
end
function modifier_generic_ignore_ms_limit.prototype.IsPurgable(self)
    return false
end
function modifier_generic_ignore_ms_limit.prototype.RemoveOnDeath(self)
    return false
end
function modifier_generic_ignore_ms_limit.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT}
end
function modifier_generic_ignore_ms_limit.prototype.GetModifierIgnoreMovespeedLimit(self)
    return 1
end
modifier_generic_ignore_ms_limit = __TS__Decorate(
    {
        registerModifier(nil)
    },
    modifier_generic_ignore_ms_limit
)
return ____exports
