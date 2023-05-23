local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 4,["15"] = 4,["16"] = 5,["17"] = 6,["18"] = 7,["19"] = 6,["20"] = 5,["21"] = 4,["22"] = 5,["24"] = 11,["25"] = 11,["26"] = 12,["27"] = 12,["28"] = 11,["29"] = 12});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local JuggernautBasicAttack = __TS__Class()
JuggernautBasicAttack.name = "JuggernautBasicAttack"
__TS__ClassExtends(JuggernautBasicAttack, CustomAbility)
function JuggernautBasicAttack.prototype.GetCastPoint(self)
    return self.caster
end
JuggernautBasicAttack = __TS__Decorate(
    {registerAbility(nil)},
    JuggernautBasicAttack
)
local ModifierJuggernautStacks = __TS__Class()
ModifierJuggernautStacks.name = "ModifierJuggernautStacks"
__TS__ClassExtends(ModifierJuggernautStacks, BaseModifier)
ModifierJuggernautStacks = __TS__Decorate(
    {registerModifier(nil)},
    ModifierJuggernautStacks
)
return ____exports
