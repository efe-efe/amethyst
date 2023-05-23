local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 3,["12"] = 4,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["19"] = 5,["20"] = 10,["21"] = 11,["22"] = 10,["23"] = 13,["24"] = 14,["25"] = 13,["26"] = 16,["27"] = 17,["28"] = 16,["29"] = 19,["30"] = 20,["31"] = 19,["32"] = 22,["33"] = 23,["34"] = 22,["35"] = 25,["36"] = 26,["37"] = 25,["38"] = 4,["39"] = 3,["40"] = 4,["42"] = 4});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_generic_change_ms = __TS__Class()
local modifier_generic_change_ms = ____exports.modifier_generic_change_ms
modifier_generic_change_ms.name = "modifier_generic_change_ms"
__TS__ClassExtends(modifier_generic_change_ms, BaseModifier)
function modifier_generic_change_ms.prototype.OnCreated(self, data)
    if IsServer() then
        self:SetStackCount(data.amount)
    end
end
function modifier_generic_change_ms.prototype.IsHidden(self)
    return true
end
function modifier_generic_change_ms.prototype.IsDebuff(self)
    return false
end
function modifier_generic_change_ms.prototype.IsPurgable(self)
    return false
end
function modifier_generic_change_ms.prototype.RemoveOnDeath(self)
    return false
end
function modifier_generic_change_ms.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT_UNIQUE}
end
function modifier_generic_change_ms.prototype.GetModifierMoveSpeedBonus_Constant_Unique(self)
    return self:GetStackCount()
end
modifier_generic_change_ms = __TS__Decorate(
    {registerModifier(nil)},
    modifier_generic_change_ms
)
____exports.modifier_generic_change_ms = modifier_generic_change_ms
return ____exports
