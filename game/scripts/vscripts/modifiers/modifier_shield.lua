local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 6,["16"] = 5,["17"] = 6,["18"] = 7,["19"] = 8,["20"] = 9,["21"] = 10,["23"] = 7,["24"] = 6,["25"] = 5,["26"] = 6,["28"] = 6});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local sendOverheadShieldMessage = ____util.sendOverheadShieldMessage
____exports.ModifierShield = __TS__Class()
local ModifierShield = ____exports.ModifierShield
ModifierShield.name = "ModifierShield"
__TS__ClassExtends(ModifierShield, CustomModifier)
function ModifierShield.prototype.OnCreated(self, params)
    if IsServer() then
        sendOverheadShieldMessage(nil, self.parent, params.damageBlock)
        self:SetStackCount(params.damageBlock)
    end
end
ModifierShield = __TS__Decorate(
    {registerModifier(nil)},
    ModifierShield
)
____exports.ModifierShield = ModifierShield
return ____exports
