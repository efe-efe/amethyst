local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 139,["9"] = 139,["10"] = 148,["11"] = 148,["12"] = 192,["13"] = 192,["14"] = 236,["15"] = 236,["16"] = 1,["17"] = 1,["19"] = 1,["20"] = 1,["21"] = 2,["22"] = 2,["24"] = 2,["25"] = 2,["26"] = 4,["27"] = 5,["28"] = 6,["29"] = 7,["30"] = 9,["31"] = 9,["32"] = 9,["33"] = 10});
function spectre_mobility(self)
end
function spectre_ex_mobility(self)
end
function modifier_spectre_mobility_thinker(self)
end
function modifier_spectre_mobility_charges(self)
end
____class_0 = __TS__Class()
____class_0.name = ""
function ____class_0.prototype.____constructor(self)
end
spectre_mobility = ____class_0(nil, {})
____class_1 = __TS__Class()
____class_1.name = ""
function ____class_1.prototype.____constructor(self)
end
spectre_ex_mobility = ____class_1(nil, {})
LinkLuaModifier("modifier_spectre_banish", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_mobility_charges", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_mobility_thinker", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_mobility_fear", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_ex_mobility_fear", LUA_MODIFIER_MOTION_NONE)
function spectre_mobility(self)
end
local ____ = ____
return "modifier_spectre_mobility_charges"
