local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 6,["16"] = 7,["17"] = 7,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 9,["22"] = 6,["23"] = 12,["24"] = 13,["25"] = 15,["26"] = 16,["27"] = 17,["28"] = 12,["29"] = 5,["30"] = 4,["31"] = 5});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomItem = ____custom_ability.CustomItem
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ItemFaerie = __TS__Class()
ItemFaerie.name = "ItemFaerie"
__TS__ClassExtends(ItemFaerie, CustomItem)
function ItemFaerie.prototype.OnSpellStart(self)
    self.caster:Heal(
        self:GetSpecialValueFor("heal"),
        self
    )
    self:PlayEffects()
    self:SpendCharge()
end
function ItemFaerie.prototype.PlayEffects(self)
    EmitSoundOn("DOTA_Item.FaerieSpark.Activate", self.caster)
    local particle_cast = "particles/items3_fx/fish_bones_active.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemFaerie = __TS__Decorate(
    {registerAbility(nil, "item_faerie_custom")},
    ItemFaerie
)
return ____exports
