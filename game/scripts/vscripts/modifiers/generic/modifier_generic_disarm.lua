local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 3,["12"] = 4,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 5,["18"] = 8,["19"] = 9,["20"] = 8,["21"] = 11,["22"] = 12,["23"] = 11,["24"] = 14,["25"] = 15,["26"] = 14,["27"] = 18,["28"] = 19,["29"] = 18,["30"] = 21,["31"] = 22,["32"] = 21,["33"] = 27,["34"] = 28,["35"] = 27,["36"] = 4,["37"] = 3,["38"] = 4,["40"] = 4});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_generic_disarm = __TS__Class()
local modifier_generic_disarm = ____exports.modifier_generic_disarm
modifier_generic_disarm.name = "modifier_generic_disarm"
__TS__ClassExtends(modifier_generic_disarm, BaseModifier)
function modifier_generic_disarm.prototype.IsHidden(self)
    return true
end
function modifier_generic_disarm.prototype.IsDebuff(self)
    return false
end
function modifier_generic_disarm.prototype.IsPurgable(self)
    return false
end
function modifier_generic_disarm.prototype.RemoveOnDeath(self)
    return false
end
function modifier_generic_disarm.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_DISABLE_AUTOATTACK}
end
function modifier_generic_disarm.prototype.CheckState(self)
    return {[MODIFIER_STATE_DISARMED] = true}
end
function modifier_generic_disarm.prototype.GetDisableAutoAttack(self)
    return 1
end
modifier_generic_disarm = __TS__Decorate(
    {registerModifier(nil)},
    modifier_generic_disarm
)
____exports.modifier_generic_disarm = modifier_generic_disarm
return ____exports
