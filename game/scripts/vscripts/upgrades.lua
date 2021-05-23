--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 19,["6"] = 101});
local ____exports = {}
local Upgrades = {{id = "meele_extra_radius", name = "Extra radius", description = "Provides extra radius on your basic attack", maxLevel = 1, attackCapability = DOTA_UNIT_CAP_MELEE_ATTACK, modifier = {name = "modifier_upgrade_meele_extra_radius"}, tier = 0}, {id = "phantom_extra_daggers", name = "Extra daggers", description = "Your stiffling daggers throws 3 daggers.", hero = "npc_dota_hero_phantom_assassin", ability = "phantom_special_attack", maxLevel = 1, modifier = {name = "modifier_upgrade_phantom_extra_daggers"}, tier = 1}, {id = "phantom_dash_damage", name = "Swift damage", description = "Your Swift deals damage when passing through enemies.", hero = "npc_dota_hero_phantom_assassin", ability = "phantom_mobility", maxLevel = 1, modifier = {name = "modifier_upgrade_phantom_dash_damage"}, tier = 1}, {id = "phantom_dash_invulnerability", name = "Swift invulnerability", description = "Your Swift gives you invulnerability for a short period of time after passing through enemies.", hero = "npc_dota_hero_phantom_assassin", ability = "phantom_mobility", maxLevel = 1, modifier = {name = "modifier_upgrade_phantom_dash_invulnerability"}, tier = 1}, {id = "extra_base_damage", name = "Extra base damage", description = "Increases your base damage by 3.", maxLevel = 3, modifier = {name = "modifier_upgrade_extra_base_damage"}, tier = 1}, {id = "juggernaut_refresh_dagger", name = "Refreshing dagger", description = "Your dagger cooldown is recharged when succesfully hitting enemies", hero = "npc_dota_hero_juggernaut", ability = "juggernaut_special_attack", maxLevel = 1, modifier = {name = "modifier_upgrade_juggernaut_refresh_dagger"}, tier = 1}, {id = "lightining_attack", name = "Lightining attack", description = "Your attacks has a chance to release a bolt of electricity that leaps between enemy targets ", maxLevel = 3, modifier = {name = "modifier_upgrade_lightining_attack"}, tier = 1}}
____exports.default = Upgrades
return ____exports
