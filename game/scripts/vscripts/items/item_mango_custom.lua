local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 8,["20"] = 8,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 9,["25"] = 10,["26"] = 7,["27"] = 13,["28"] = 14,["29"] = 16,["30"] = 17,["31"] = 18,["32"] = 13,["33"] = 6,["34"] = 5,["35"] = 6});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomItem = ____custom_ability.CustomItem
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____util = require("util")
local giveManaAndEnergy = ____util.giveManaAndEnergy
local ItemMango = __TS__Class()
ItemMango.name = "ItemMango"
__TS__ClassExtends(ItemMango, CustomItem)
function ItemMango.prototype.OnSpellStart(self)
    giveManaAndEnergy(
        nil,
        self.caster,
        self:GetSpecialValueFor("mana"),
        true
    )
    self:PlayEffects()
    self:SpendCharge()
end
function ItemMango.prototype.PlayEffects(self)
    EmitSoundOn("DOTA_Item.Mango.Activate", self.caster)
    local particle_cast = "particles/items3_fx/mango_active.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemMango = __TS__Decorate(
    {registerAbility(nil, "item_mango_custom")},
    ItemMango
)
return ____exports
