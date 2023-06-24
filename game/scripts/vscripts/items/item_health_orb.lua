local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 6,["16"] = 7,["17"] = 9,["18"] = 10,["19"] = 12,["20"] = 6,["21"] = 5,["22"] = 4,["23"] = 5});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ItemHealthOrb = __TS__Class()
ItemHealthOrb.name = "ItemHealthOrb"
__TS__ClassExtends(ItemHealthOrb, CustomAbility)
function ItemHealthOrb.prototype.OnSpellStart(self)
    local heal = 3
    self.caster:Heal(heal, self)
    CustomEntitiesLegacy:TrueHeal(self.caster, heal)
    EmitSoundOn("DOTA_Item.FaerieSpark.Activate", self.caster)
end
ItemHealthOrb = __TS__Decorate(
    {registerAbility(nil, "item_health_orb")},
    ItemHealthOrb
)
return ____exports
