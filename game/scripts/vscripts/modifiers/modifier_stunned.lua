local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["20"] = 6,["21"] = 12,["22"] = 13,["23"] = 12,["24"] = 16,["25"] = 17,["26"] = 16,["27"] = 20,["28"] = 21,["29"] = 20,["30"] = 27,["31"] = 28,["32"] = 27,["33"] = 31,["34"] = 32,["35"] = 31,["36"] = 35,["37"] = 36,["38"] = 35,["39"] = 39,["40"] = 40,["41"] = 39,["42"] = 5,["43"] = 4,["44"] = 5,["46"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierStun = __TS__Class()
local ModifierStun = ____exports.ModifierStun
ModifierStun.name = "ModifierStun"
__TS__ClassExtends(ModifierStun, CustomModifier)
function ModifierStun.prototype.OnCreated(self)
    if IsServer() then
        self.parent:Stop()
    end
end
function ModifierStun.prototype.IsDebuff(self)
    return true
end
function ModifierStun.prototype.IsStunDebuff(self)
    return true
end
function ModifierStun.prototype.CheckState(self)
    return {[MODIFIER_STATE_COMMAND_RESTRICTED] = true, [MODIFIER_STATE_STUNNED] = true}
end
function ModifierStun.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function ModifierStun.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_DISABLED
end
function ModifierStun.prototype.GetEffectName(self)
    return "particles/generic_gameplay/generic_stunned.vpcf"
end
function ModifierStun.prototype.GetEffectAttachType(self)
    return PATTACH_OVERHEAD_FOLLOW
end
ModifierStun = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_generic_stunned"})},
    ModifierStun
)
____exports.ModifierStun = ModifierStun
return ____exports
