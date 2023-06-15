local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 10,["9"] = 10,["10"] = 29,["11"] = 29,["12"] = 163,["13"] = 163,["14"] = 242,["15"] = 242,["16"] = 257,["17"] = 257,["18"] = 294,["19"] = 294,["20"] = 313,["21"] = 313,["22"] = 450,["23"] = 450,["24"] = 1,["25"] = 1,["27"] = 1,["28"] = 1,["29"] = 2,["30"] = 2,["32"] = 2,["33"] = 2,["34"] = 4,["35"] = 5,["36"] = 6,["37"] = 7,["38"] = 8,["39"] = 10,["40"] = 11,["41"] = 11,["42"] = 11,["43"] = 12,["44"] = 12,["45"] = 12,["46"] = 21,["47"] = 23,["48"] = 23,["49"] = 23,["50"] = 26,["51"] = 27,["52"] = 29,["53"] = 30,["54"] = 30,["55"] = 30,["56"] = 31,["57"] = 31,["58"] = 31,["59"] = 33,["60"] = 34,["61"] = 35,["62"] = 37,["63"] = 37,["65"] = 37,["66"] = 37,["67"] = 39,["68"] = 39,["69"] = 39,["70"] = 39});
function spectre_counter(self)
end
function spectre_ex_counter(self)
end
function spectre_counter_recast(self)
end
function modifier_spectre_ex_counter(self)
end
function modifier_spectre_ex_counter_debuff(self)
end
function modifier_spectre_counter(self)
end
function modifier_spectre_counter_recast(self)
end
function modifier_spectre_counter_countering(self)
end
____class_0 = __TS__Class()
____class_0.name = ""
function ____class_0.prototype.____constructor(self)
end
spectre_counter = ____class_0(nil, {})
____class_1 = __TS__Class()
____class_1.name = ""
function ____class_1.prototype.____constructor(self)
end
spectre_ex_counter = ____class_1(nil, {})
LinkLuaModifier("modifier_spectre_counter_countering", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_counter_recast", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_ex_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_counter_debuff", "abilities/heroes/spectre/spectre_counter/modifier_spectre_ex_counter_debuff", LUA_MODIFIER_MOTION_NONE)
local ____ = ____
local ____ = ____local
caster = self
GetCaster(nil)
local ____ = ____local
duration = self
GetSpecialValueFor(nil, "counter_duration")
EmitSoundOn("Hero_Spectre.HauntCast", caster)
local ____ = ____local
effect_cast = ParticleManager
CreateParticle(nil, "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
LinkAbilityCooldowns(nil, caster, "spectre_ex_counter")
local ____ = ____end
local ____ = ____
local ____ = ____local
caster = self
GetCaster(nil)
local ____ = ____local
delay_time = self
GetSpecialValueFor(nil, "delay_time")
LinkAbilityCooldowns(nil, caster, "spectre_counter")
EmitSoundOn("Hero_Spectre.HauntCast", caster)
local ____ = ____end
____class_2 = __TS__Class()
____class_2.name = ""
function ____class_2.prototype.____constructor(self)
end
spectre_counter_recast = ____class_2(nil, {})
function spectre_counter_recast(self)
end
local ____ = ____
return ACT_DOTA_CAST_ABILITY_1
