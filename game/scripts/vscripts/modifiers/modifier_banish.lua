local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 6,["16"] = 9,["17"] = 10,["18"] = 11,["19"] = 12,["21"] = 9,["22"] = 16,["23"] = 17,["24"] = 18,["26"] = 16,["27"] = 22,["28"] = 23,["29"] = 22,["30"] = 6,["31"] = 5,["32"] = 6,["34"] = 6});
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
