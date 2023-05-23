local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 3,["14"] = 3,["15"] = 4,["16"] = 3});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
____exports.CustomAbility = __TS__Class()
local CustomAbility = ____exports.CustomAbility
CustomAbility.name = "CustomAbility"
__TS__ClassExtends(CustomAbility, BaseAbility)
function CustomAbility.prototype.____constructor(self, ...)
    BaseAbility.prototype.____constructor(self, ...)
    self.caster = self:GetCaster()
end
return ____exports
