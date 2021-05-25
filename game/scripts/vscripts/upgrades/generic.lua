--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 4,["7"] = 4,["8"] = 4,["9"] = 4,["10"] = 4,["11"] = 4,["12"] = 4,["13"] = 11,["14"] = 12,["15"] = 12,["16"] = 12,["17"] = 12,["18"] = 4,["19"] = 3,["20"] = 3,["21"] = 3,["22"] = 3,["23"] = 3,["24"] = 3,["25"] = 3,["26"] = 68});
local ____exports = {}
local genericUpgrades = {
    {
        id = "restore_health",
        name = "Restore health",
        description = "Fully restores your health",
        maxStacks = 1,
        minLevel = 2,
        tier = 0,
        effect = function(____, hero)
            CustomEntitiesLegacy:TrueHeal(
                hero,
                hero:GetMaxHealth()
            )
        end
    },
    {id = "meele_extra_radius", name = "Extra radius", description = "Provides extra radius on your basic attack", maxStacks = 1, attackCapability = DOTA_UNIT_CAP_MELEE_ATTACK, modifier = {name = "modifier_upgrade_meele_extra_radius"}, tier = 0},
    {id = "extra_base_damage", name = "Extra base damage", description = "Increases your base damage by 3.", maxStacks = 3, modifier = {name = "modifier_upgrade_extra_base_damage"}, tier = 1},
    {id = "extra_speed", name = "Extra speed", description = "Increases your movement and attack speed.", maxStacks = 3, modifier = {name = "modifier_upgrade_extra_speed"}, tier = 1},
    {id = "lightining_attack", name = "Lightining attack", description = "Your attacks has a chance to release a bolt of electricity that leaps between enemy targets.", maxStacks = 3, modifier = {name = "modifier_upgrade_lightining_attack"}, tier = 1},
    {id = "stun_attack", name = "Stun attack", description = "Your attacks has a chance to deal extra damage and stun the target.", maxStacks = 3, modifier = {name = "modifier_upgrade_stun_attack"}, tier = 1}
}
____exports.default = genericUpgrades
return ____exports
