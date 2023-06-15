local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 15,["6"] = 15,["7"] = 93,["8"] = 93,["9"] = 186,["10"] = 186,["11"] = 203,["12"] = 203,["13"] = 249,["14"] = 249,["15"] = 1,["16"] = 1,["18"] = 1,["19"] = 1,["20"] = 2,["21"] = 2,["23"] = 2,["24"] = 2,["25"] = 3,["26"] = 4,["27"] = 5,["28"] = 7,["29"] = 7,["30"] = 7,["31"] = 8,["32"] = 8,["33"] = 8,["34"] = 9,["35"] = 9,["36"] = 9,["37"] = 10,["38"] = 13,["39"] = 15,["40"] = 17,["41"] = 19,["42"] = 19,["43"] = 19,["44"] = 19});
function spectre_extra(self)
end
function spectre_extra_recast(self)
end
function modifier_spectre_extra(self)
end
function modifier_spectre_extra_recast(self)
end
function modifier_spectre_debuff(self)
end
____class_0 = __TS__Class()
____class_0.name = ""
function ____class_0.prototype.____constructor(self)
end
spectre_extra = ____class_0(nil, {})
____class_1 = __TS__Class()
____class_1.name = ""
function ____class_1.prototype.____constructor(self)
end
spectre_extra_recast = ____class_1(nil, {})
LinkLuaModifier("modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_debuff", "abilities/heroes/spectre/spectre_extra/modifier_spectre_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_extra_recast", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra_recast", LUA_MODIFIER_MOTION_NONE)
function spectre_extra(self)
end
local ____ = ____
local ____ = ____local
caster = self
GetCaster(nil)
local ____ = ____local
duration = self
GetSpecialValueFor(nil, "duration")
ResetDamage(nil)
local ____ = ____end
local ____ = ____
local ____ = ____end
function spectre_extra_recast(self)
end
local ____ = ____
return ACT_DOTA_CAST_ABILITY_1
