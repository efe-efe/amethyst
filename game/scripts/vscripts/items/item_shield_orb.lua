local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 10,["20"] = 12,["21"] = 13,["22"] = 7,["23"] = 6,["24"] = 5,["25"] = 6});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_shield = require("modifiers.modifier_shield")
local ModifierShield = ____modifier_shield.ModifierShield
local ItemShieldOrb = __TS__Class()
ItemShieldOrb.name = "ItemShieldOrb"
__TS__ClassExtends(ItemShieldOrb, CustomAbility)
function ItemShieldOrb.prototype.OnSpellStart(self)
    local damage_block = 16
    ModifierShield:apply(self.caster, self.caster, nil, {duration = 6, damageBlock = damage_block})
    EmitSoundOn("Hero_Sven.GodsStrength.Attack", self.caster)
    EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", self.caster)
end
ItemShieldOrb = __TS__Decorate(
    {registerAbility(nil, "item_shield_orb")},
    ItemShieldOrb
)
return ____exports
