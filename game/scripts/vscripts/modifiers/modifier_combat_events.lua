local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 2,["8"] = 2,["9"] = 9,["10"] = 9,["11"] = 9,["12"] = 9,["13"] = 10,["14"] = 10,["15"] = 13,["16"] = 13,["17"] = 15,["18"] = 15,["19"] = 18,["20"] = 19,["21"] = 18,["22"] = 22,["23"] = 22,["24"] = 24,["25"] = 25,["26"] = 24});
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
function ModifierCombatEvents.prototype.OnHit(self, event)
    return true
end
function ModifierCombatEvents.prototype.AfterHit(self)
end
function ModifierCombatEvents.prototype.IsHidden(self)
    return true
end
return ____exports
