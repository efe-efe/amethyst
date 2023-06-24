local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 13,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 5,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 7,["22"] = 6,["23"] = 5,["24"] = 6,["26"] = 12,["27"] = 12,["28"] = 13,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 22,["38"] = 26,["39"] = 27,["40"] = 26,["41"] = 13,["42"] = 12,["43"] = 13});
local ____exports = {}
local ModifierItemVitalityBooster
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ItemVitalityBooster = __TS__Class()
ItemVitalityBooster.name = "ItemVitalityBooster"
__TS__ClassExtends(ItemVitalityBooster, CustomAbility)
function ItemVitalityBooster.prototype.GetIntrinsicModifierName(self)
    return ModifierItemVitalityBooster.name
end
ItemVitalityBooster = __TS__Decorate(
    {registerAbility(nil, "item_vitality_custom")},
    ItemVitalityBooster
)
ModifierItemVitalityBooster = __TS__Class()
ModifierItemVitalityBooster.name = "ModifierItemVitalityBooster"
__TS__ClassExtends(ModifierItemVitalityBooster, CustomModifier)
function ModifierItemVitalityBooster.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS}
end
function ModifierItemVitalityBooster.prototype.GetModifierExtraHealthBonus(self)
    return self:Value("extra_health")
end
function ModifierItemVitalityBooster.prototype.GetEffectName(self)
    return "particles/vitality_effect/omniknight_repel_buff_ti8_glyph.vpcf"
end
function ModifierItemVitalityBooster.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierItemVitalityBooster = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_vitality_custom"})},
    ModifierItemVitalityBooster
)
return ____exports
