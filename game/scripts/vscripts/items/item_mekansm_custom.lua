local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 62,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 6,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 8,["24"] = 12,["25"] = 13,["26"] = 12,["27"] = 16,["28"] = 17,["29"] = 18,["30"] = 19,["31"] = 21,["32"] = 21,["33"] = 21,["34"] = 21,["35"] = 21,["36"] = 21,["37"] = 21,["38"] = 21,["39"] = 21,["40"] = 31,["41"] = 32,["42"] = 33,["43"] = 34,["45"] = 37,["46"] = 37,["47"] = 37,["48"] = 37,["49"] = 37,["50"] = 37,["51"] = 37,["52"] = 37,["53"] = 38,["54"] = 16,["55"] = 41,["56"] = 42,["57"] = 43,["58"] = 41,["59"] = 48,["60"] = 49,["61"] = 51,["62"] = 56,["63"] = 56,["64"] = 56,["65"] = 56,["66"] = 56,["67"] = 57,["68"] = 48,["69"] = 7,["70"] = 6,["71"] = 7,["73"] = 61,["74"] = 61,["75"] = 62,["76"] = 63,["77"] = 64,["78"] = 65,["80"] = 63,["81"] = 69,["82"] = 70,["83"] = 70,["84"] = 70,["85"] = 70,["86"] = 69,["87"] = 62,["88"] = 61,["89"] = 62});
local ____exports = {}
local ModifierItemMekansm
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local createRadiusMarker = ____util.createRadiusMarker
local ItemMekansm = __TS__Class()
ItemMekansm.name = "ItemMekansm"
__TS__ClassExtends(ItemMekansm, CustomAbility)
function ItemMekansm.prototype.GetCastingCrawl(self)
    return 0
end
function ItemMekansm.prototype.GetAnimation(self)
    return ACT_DOTA_GENERIC_CHANNEL_1
end
function ItemMekansm.prototype.OnSpellStart(self)
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")
    local heal = self:GetSpecialValueFor("heal")
    local allies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.caster,
        self.caster:GetAbsOrigin(),
        radius,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    for ____, ally in ipairs(allies) do
        ModifierItemMekansm:apply(ally, self.caster, self, {duration = duration})
        ally:Heal(heal, self)
        self:PlayEffectsTarget(ally)
    end
    createRadiusMarker(
        nil,
        self.caster,
        self.caster:GetAbsOrigin(),
        radius,
        "public",
        0.1
    )
    self:PlayEffects()
end
function ItemMekansm.prototype.PlayEffects(self)
    EmitSoundOn("DOTA_Item.Mekansm.Activate", self.caster)
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/items2_fx/mekanism.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster))
end
function ItemMekansm.prototype.PlayEffectsTarget(self, target)
    EmitSoundOn("DOTA_Item.Mekansm.Target", target)
    local particleId = ParticleManager:CreateParticle("particles/items2_fx/mekanism_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemMekansm = __TS__Decorate(
    {registerAbility(nil, "item_mekansm_custom")},
    ItemMekansm
)
ModifierItemMekansm = __TS__Class()
ModifierItemMekansm.name = "ModifierItemMekansm"
__TS__ClassExtends(ModifierItemMekansm, CustomModifier)
function ModifierItemMekansm.prototype.OnCreated(self)
    if IsServer() then
        self:StartIntervalThink(self:Value("think_interval"))
    end
end
function ModifierItemMekansm.prototype.OnIntervalThink(self)
    self.parent:Heal(
        self:Value("heal_per_tick"),
        self.ability
    )
end
ModifierItemMekansm = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_mekansm_custom"})},
    ModifierItemMekansm
)
return ____exports
