local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 118,["6"] = 118,["7"] = 293,["8"] = 293,["9"] = 1,["10"] = 1,["12"] = 1,["13"] = 1,["14"] = 2,["15"] = 3,["16"] = 5,["17"] = 5,["18"] = 5,["19"] = 6});
function spectre_basic_attack(self)
end
function modifier_spectre_basic_attack_cooldown(self)
end
____class_0 = __TS__Class()
____class_0.name = ""
function ____class_0.prototype.____constructor(self)
end
spectre_basic_attack = ____class_0(nil, {})
LinkLuaModifier("modifier_spectre_desolate_custom", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_custom/modifier_spectre_desolate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_basic_attack_cooldown", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)
function spectre_basic_attack(self)
end
local ____ = ____
return "modifier_spectre_basic_attack_cooldown"
