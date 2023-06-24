local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 20,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 6,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 9,["24"] = 9,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 9,["29"] = 9,["30"] = 9,["31"] = 9,["32"] = 14,["33"] = 15,["34"] = 8,["35"] = 7,["36"] = 6,["37"] = 7,["39"] = 19,["40"] = 19,["41"] = 20,["42"] = 23,["43"] = 24,["44"] = 25,["45"] = 26,["47"] = 23,["48"] = 30,["49"] = 31,["50"] = 31,["51"] = 31,["52"] = 31,["53"] = 31,["54"] = 31,["55"] = 30,["56"] = 34,["57"] = 35,["58"] = 34,["59"] = 38,["60"] = 39,["61"] = 40,["63"] = 43,["64"] = 38,["65"] = 46,["66"] = 47,["67"] = 46,["68"] = 50,["69"] = 51,["70"] = 50,["71"] = 20,["72"] = 19,["73"] = 20});
local ____exports = {}
local ModifierItemClarity
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomItem = ____custom_ability.CustomItem
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local giveManaAndEnergy = ____util.giveManaAndEnergy
local ItemClarity = __TS__Class()
ItemClarity.name = "ItemClarity"
__TS__ClassExtends(ItemClarity, CustomItem)
function ItemClarity.prototype.OnSpellStart(self)
    ModifierItemClarity:apply(
        self.caster,
        self.caster,
        self,
        {
            duration = self:GetSpecialValueFor("duration"),
            thinkInterval = self:GetSpecialValueFor("think_interval"),
            manaPerTick = self:GetSpecialValueFor("mana_per_tick")
        }
    )
    EmitSoundOn("DOTA_Item.ClarityPotion.Activate", self.caster)
    self:SpendCharge()
end
ItemClarity = __TS__Decorate(
    {registerAbility(nil, "item_clarity_custom")},
    ItemClarity
)
ModifierItemClarity = __TS__Class()
ModifierItemClarity.name = "ModifierItemClarity"
__TS__ClassExtends(ModifierItemClarity, CustomModifier)
function ModifierItemClarity.prototype.OnCreated(self, params)
    if IsServer() then
        self.manaPerTick = params.manaPerTick
        self:StartIntervalThink(params.thinkInterval)
    end
end
function ModifierItemClarity.prototype.OnIntervalThink(self)
    giveManaAndEnergy(
        nil,
        self:GetParent(),
        self.manaPerTick,
        true
    )
end
function ModifierItemClarity.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE}
end
function ModifierItemClarity.prototype.GetModifierIncomingDamage_Percentage(self)
    if IsServer() then
        self:Destroy()
    end
    return 0
end
function ModifierItemClarity.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifierItemClarity.prototype.GetStatusEffectName(self)
    return "particles/items_fx/healing_clarity.vpcf"
end
ModifierItemClarity = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_clarity_custom"})},
    ModifierItemClarity
)
return ____exports
