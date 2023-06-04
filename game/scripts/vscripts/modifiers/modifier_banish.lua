local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["21"] = 8,["22"] = 15,["23"] = 16,["24"] = 17,["26"] = 15,["27"] = 21,["28"] = 22,["29"] = 21,["30"] = 5,["31"] = 4,["32"] = 5,["34"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierBanish = __TS__Class()
local ModifierBanish = ____exports.ModifierBanish
ModifierBanish.name = "ModifierBanish"
__TS__ClassExtends(ModifierBanish, CustomModifier)
function ModifierBanish.prototype.OnCreated(self)
    if IsServer() then
        self.originalScale = self.parent:GetModelScale()
        self.parent:SetModelScale(0.05)
    end
end
function ModifierBanish.prototype.OnDestroy(self)
    if IsServer() then
        self.parent:SetModelScale(self.originalScale)
    end
end
function ModifierBanish.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_OUT_OF_GAME] = true}
end
ModifierBanish = __TS__Decorate(
    {registerModifier(nil)},
    ModifierBanish
)
____exports.ModifierBanish = ModifierBanish
return ____exports
