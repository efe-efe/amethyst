--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 57});
local ____exports = {}
local genericUpgrades = {{id = "meele_extra_radius", name = "Extra radius", description = "Provides extra radius on your basic attack", maxStacks = 1, attackCapability = DOTA_UNIT_CAP_MELEE_ATTACK, modifier = {name = "modifier_upgrade_meele_extra_radius"}, tier = 0}, {id = "extra_base_damage", name = "Extra base damage", description = "Increases your base damage by 3.", maxStacks = 3, modifier = {name = "modifier_upgrade_extra_base_damage"}, tier = 1}, {id = "extra_speed", name = "Extra speed", description = "Increases your movement and attack speed.", maxStacks = 3, modifier = {name = "modifier_upgrade_extra_speed"}, tier = 1}, {id = "lightining_attack", name = "Lightining attack", description = "Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.", maxStacks = 3, modifier = {name = "modifier_upgrade_lightining_attack"}, tier = 1}, {id = "stun_attack", name = "Stun attack", description = "Your attacks has a chance to deal extra damage and stun the target.", maxStacks = 3, modifier = {name = "modifier_upgrade_stun_attack"}, tier = 1}}
____exports.default = genericUpgrades
return ____exports
