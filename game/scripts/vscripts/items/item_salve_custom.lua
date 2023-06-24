local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 19,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 5,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 8,["25"] = 8,["26"] = 8,["27"] = 8,["28"] = 8,["29"] = 8,["30"] = 13,["31"] = 14,["32"] = 7,["33"] = 6,["34"] = 5,["35"] = 6,["37"] = 18,["38"] = 18,["39"] = 19,["40"] = 22,["41"] = 23,["42"] = 24,["43"] = 25,["45"] = 22,["46"] = 29,["47"] = 30,["48"] = 29,["49"] = 33,["50"] = 34,["51"] = 33,["52"] = 37,["53"] = 38,["54"] = 39,["56"] = 41,["57"] = 37,["58"] = 44,["59"] = 45,["60"] = 44,["61"] = 48,["62"] = 49,["63"] = 48,["64"] = 19,["65"] = 18,["66"] = 19});
local ____exports = {}
local ModifierItemSalve
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomItem = ____custom_ability.CustomItem
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ItemSalve = __TS__Class()
ItemSalve.name = "ItemSalve"
__TS__ClassExtends(ItemSalve, CustomItem)
function ItemSalve.prototype.OnSpellStart(self)
    ModifierItemSalve:apply(
        self.caster,
        self.caster,
        self,
        {
            duration = self:GetSpecialValueFor("duration"),
            thinkInterval = self:GetSpecialValueFor("think_interval"),
            healPerTick = self:GetSpecialValueFor("heal_per_tick")
        }
    )
    EmitSoundOn("DOTA_Item.HealingSalve.Activate", self.caster)
    self:SpendCharge()
end
ItemSalve = __TS__Decorate(
    {registerAbility(nil, "item_salve_custom")},
    ItemSalve
)
ModifierItemSalve = __TS__Class()
ModifierItemSalve.name = "ModifierItemSalve"
__TS__ClassExtends(ModifierItemSalve, CustomModifier)
function ModifierItemSalve.prototype.OnCreated(self, params)
    if IsServer() then
        self.healPerTick = params.healPerTick
        self:StartIntervalThink(params.thinkInterval)
    end
end
function ModifierItemSalve.prototype.OnIntervalThink(self)
    self.parent:Heal(self.healPerTick, self.ability)
end
function ModifierItemSalve.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE}
end
function ModifierItemSalve.prototype.GetModifierIncomingDamage_Percentage(self)
    if IsServer() then
        self:Destroy()
    end
    return 0
end
function ModifierItemSalve.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifierItemSalve.prototype.GetStatusEffectName(self)
    return "particles/items_fx/healing_flask.vpcf"
end
ModifierItemSalve = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_salve_custom"})},
    ModifierItemSalve
)
return ____exports
