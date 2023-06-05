local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 6,["19"] = 9,["20"] = 10,["21"] = 9,["22"] = 12,["23"] = 13,["24"] = 12,["25"] = 18,["26"] = 19,["27"] = 18,["28"] = 22,["29"] = 23,["30"] = 22,["31"] = 5,["32"] = 4,["33"] = 5,["35"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierRoot = __TS__Class()
local ModifierRoot = ____exports.ModifierRoot
ModifierRoot.name = "ModifierRoot"
__TS__ClassExtends(ModifierRoot, CustomModifier)
function ModifierRoot.prototype.IsDebuff(self)
    return true
end
function ModifierRoot.prototype.IsStunDebuff(self)
    return true
end
function ModifierRoot.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true}
end
function ModifierRoot.prototype.GetEffectName(self)
    return "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_purge_root_pnt.vpcf"
end
function ModifierRoot.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierRoot = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_generic_root"})},
    ModifierRoot
)
____exports.ModifierRoot = ModifierRoot
return ____exports
