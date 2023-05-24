local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 4,["14"] = 4,["15"] = 7,["16"] = 7,["17"] = 9,["18"] = 9,["19"] = 11,["20"] = 12,["21"] = 11});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
____exports.ModifierCombatEvents = __TS__Class()
local ModifierCombatEvents = ____exports.ModifierCombatEvents
ModifierCombatEvents.name = "ModifierCombatEvents"
__TS__ClassExtends(ModifierCombatEvents, CustomModifier)
function ModifierCombatEvents.prototype.OnBasicAttackStarted(self)
end
function ModifierCombatEvents.prototype.OnBasicAttackLanded(self, event)
end
function ModifierCombatEvents.prototype.OnBasicAttackEnded(self)
end
function ModifierCombatEvents.prototype.IsHidden(self)
    return true
end
return ____exports
