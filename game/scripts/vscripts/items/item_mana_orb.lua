local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 9,["21"] = 9,["22"] = 9,["23"] = 9,["24"] = 9,["25"] = 9,["26"] = 11,["27"] = 12,["28"] = 7,["29"] = 6,["30"] = 5,["31"] = 6});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomItem = ____custom_ability.CustomItem
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____util = require("util")
local giveManaAndEnergy = ____util.giveManaAndEnergy
local ItemManaOrb = __TS__Class()
ItemManaOrb.name = "ItemManaOrb"
__TS__ClassExtends(ItemManaOrb, CustomItem)
function ItemManaOrb.prototype.OnSpellStart(self)
    local mana = 8
    giveManaAndEnergy(
        nil,
        self.caster,
        mana,
        true,
        true
    )
    EmitSoundOn("DOTA_Item.ClarityPotion.Activate", self.caster)
    self:SpendCharge()
end
ItemManaOrb = __TS__Decorate(
    {registerAbility(nil, "item_mana_orb")},
    ItemManaOrb
)
return ____exports
