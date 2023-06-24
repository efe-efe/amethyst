local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 13,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 5,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 7,["22"] = 6,["23"] = 5,["24"] = 6,["26"] = 12,["27"] = 12,["28"] = 13,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 13,["36"] = 12,["37"] = 13});
local ____exports = {}
local ModifierItemBoots
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ItemBoots = __TS__Class()
ItemBoots.name = "ItemBoots"
__TS__ClassExtends(ItemBoots, CustomAbility)
function ItemBoots.prototype.GetIntrinsicModifierName(self)
    return ModifierItemBoots.name
end
ItemBoots = __TS__Decorate(
    {registerAbility(nil, "item_boots_custom")},
    ItemBoots
)
ModifierItemBoots = __TS__Class()
ModifierItemBoots.name = "ModifierItemBoots"
__TS__ClassExtends(ModifierItemBoots, CustomModifier)
function ModifierItemBoots.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierItemBoots.prototype.GetModifierAttackSpeedBonus_Constant(self)
    return self:Value("ms_pct")
end
ModifierItemBoots = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_boots_custom"})},
    ModifierItemBoots
)
return ____exports
