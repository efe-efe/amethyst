local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 13,["28"] = 14,["30"] = 7,["31"] = 6,["32"] = 5,["33"] = 6});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomItem = ____custom_ability.CustomItem
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____util = require("util")
local giveManaAndEnergy = ____util.giveManaAndEnergy
local ItemDeathOrb = __TS__Class()
ItemDeathOrb.name = "ItemDeathOrb"
__TS__ClassExtends(ItemDeathOrb, CustomItem)
function ItemDeathOrb.prototype.OnSpellStart(self)
    local charges = self:GetCurrentCharges()
    local heal = 24
    giveManaAndEnergy(
        nil,
        self.caster,
        charges,
        true,
        true
    )
    if charges == 100 then
        CustomEntitiesLegacy:TrueHeal(self.caster, heal)
    end
end
ItemDeathOrb = __TS__Decorate(
    {registerAbility(nil, "item_death_orb")},
    ItemDeathOrb
)
return ____exports
