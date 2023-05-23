local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 3,["12"] = 4,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 5,["18"] = 8,["19"] = 9,["20"] = 8,["21"] = 11,["22"] = 12,["23"] = 11,["24"] = 14,["25"] = 15,["26"] = 14,["27"] = 17,["28"] = 18,["29"] = 17,["30"] = 20,["31"] = 21,["32"] = 20,["33"] = 4,["34"] = 3,["35"] = 4,["37"] = 4});
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
    {registerModifier(nil)},
    modifier_generic_ignore_ms_limit
)
____exports.modifier_generic_ignore_ms_limit = modifier_generic_ignore_ms_limit
return ____exports
