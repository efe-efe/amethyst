--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 4,["10"] = 3,["11"] = 4,["12"] = 5,["13"] = 6,["14"] = 7,["16"] = 5,["17"] = 10,["18"] = 11,["19"] = 10,["20"] = 13,["21"] = 14,["22"] = 13,["23"] = 16,["24"] = 17,["25"] = 16,["26"] = 19,["27"] = 20,["28"] = 19,["29"] = 22,["30"] = 23,["31"] = 22,["32"] = 27,["33"] = 28,["34"] = 27,["35"] = 4,["37"] = 3,["39"] = 4});
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
    {
        registerModifier(nil)
    },
    modifier_generic_change_ms
)
return ____exports
