local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["19"] = 6,["20"] = 5,["21"] = 4,["22"] = 5,["24"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierRecast = __TS__Class()
local ModifierRecast = ____exports.ModifierRecast
ModifierRecast.name = "ModifierRecast"
__TS__ClassExtends(ModifierRecast, CustomModifier)
function ModifierRecast.prototype.OnCreated(self)
    if IsServer() then
    end
end
ModifierRecast = __TS__Decorate(
    {registerModifier(nil)},
    ModifierRecast
)
____exports.ModifierRecast = ModifierRecast
return ____exports
