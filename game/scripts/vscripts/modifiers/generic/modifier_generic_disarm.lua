--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 4,["10"] = 3,["11"] = 4,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 8,["18"] = 11,["19"] = 12,["20"] = 11,["21"] = 14,["22"] = 15,["23"] = 14,["24"] = 18,["25"] = 19,["26"] = 18,["27"] = 21,["28"] = 22,["29"] = 21,["30"] = 27,["31"] = 28,["32"] = 27,["33"] = 4,["35"] = 3,["37"] = 4});
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
    {
        registerModifier(nil)
    },
    modifier_generic_disarm
)
return ____exports
