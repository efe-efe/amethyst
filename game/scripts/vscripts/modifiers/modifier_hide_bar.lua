local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 6,["19"] = 10,["20"] = 11,["21"] = 10,["22"] = 5,["23"] = 4,["24"] = 5,["26"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierHideBar = __TS__Class()
local ModifierHideBar = ____exports.ModifierHideBar
ModifierHideBar.name = "ModifierHideBar"
__TS__ClassExtends(ModifierHideBar, CustomModifier)
function ModifierHideBar.prototype.IsHidden(self)
    return true
end
function ModifierHideBar.prototype.IsPurgable(self)
    return false
end
ModifierHideBar = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_hide_bar"})},
    ModifierHideBar
)
____exports.ModifierHideBar = ModifierHideBar
return ____exports
