--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 4,["10"] = 3,["11"] = 4,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 8,["18"] = 11,["19"] = 12,["20"] = 11,["21"] = 14,["22"] = 15,["23"] = 14,["24"] = 17,["25"] = 18,["26"] = 17,["27"] = 4,["29"] = 3,["31"] = 4});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_generic_no_health_bar = __TS__Class()
local modifier_generic_no_health_bar = ____exports.modifier_generic_no_health_bar
modifier_generic_no_health_bar.name = "modifier_generic_no_health_bar"
__TS__ClassExtends(modifier_generic_no_health_bar, BaseModifier)
function modifier_generic_no_health_bar.prototype.IsHidden(self)
    return true
end
function modifier_generic_no_health_bar.prototype.IsDebuff(self)
    return false
end
function modifier_generic_no_health_bar.prototype.IsPurgable(self)
    return false
end
function modifier_generic_no_health_bar.prototype.RemoveOnDeath(self)
    return false
end
function modifier_generic_no_health_bar.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_HEALTH_BAR] = true}
end
modifier_generic_no_health_bar = __TS__Decorate(
    {
        registerModifier(nil)
    },
    modifier_generic_no_health_bar
)
return ____exports
