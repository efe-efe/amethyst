local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 25,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 6,["20"] = 6,["21"] = 7,["22"] = 8,["23"] = 9,["24"] = 9,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 9,["29"] = 10,["30"] = 8,["31"] = 13,["32"] = 14,["33"] = 13,["34"] = 7,["35"] = 6,["36"] = 7,["38"] = 24,["39"] = 24,["40"] = 25,["41"] = 26,["42"] = 27,["43"] = 28,["44"] = 29,["46"] = 26,["47"] = 33,["48"] = 34,["49"] = 34,["50"] = 34,["51"] = 34,["52"] = 34,["53"] = 34,["54"] = 35,["55"] = 35,["56"] = 35,["57"] = 35,["58"] = 35,["59"] = 35,["60"] = 36,["61"] = 33,["62"] = 39,["63"] = 40,["64"] = 39,["65"] = 43,["66"] = 44,["67"] = 43,["68"] = 47,["69"] = 48,["70"] = 47,["71"] = 51,["72"] = 52,["73"] = 51,["74"] = 55,["75"] = 56,["76"] = 55,["77"] = 59,["78"] = 60,["79"] = 62,["80"] = 67,["81"] = 67,["82"] = 67,["83"] = 67,["84"] = 67,["85"] = 68,["86"] = 59,["87"] = 25,["88"] = 24,["89"] = 25,["91"] = 78,["92"] = 78,["93"] = 79,["94"] = 80,["95"] = 79,["96"] = 83,["97"] = 84,["99"] = 80,["100"] = 88,["101"] = 89,["102"] = 91,["103"] = 96,["104"] = 96,["105"] = 96,["106"] = 96,["107"] = 96,["108"] = 97,["109"] = 97,["110"] = 97,["111"] = 97,["112"] = 97,["113"] = 99,["114"] = 88,["115"] = 102,["116"] = 103,["117"] = 103,["118"] = 79,["119"] = 103,["120"] = 103,["121"] = 102,["122"] = 79,["123"] = 78,["124"] = 79});
local ____exports = {}
local ModifeirItemButterfly, ModifierItemButterflyBanish
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ItemButterfly = __TS__Class()
ItemButterfly.name = "ItemButterfly"
__TS__ClassExtends(ItemButterfly, CustomAbility)
function ItemButterfly.prototype.OnSpellStart(self)
    ModifeirItemButterfly:apply(
        self.caster,
        self.caster,
        self,
        {duration = self:GetSpecialValueFor("duration")}
    )
    self:PlayEffectsOnCast()
end
function ItemButterfly.prototype.PlayEffectsOnCast(self)
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/events/ti8/phase_boots_ti8.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster))
end
ItemButterfly = __TS__Decorate(
    {registerAbility(nil, "item_butterfly_custom")},
    ItemButterfly
)
ModifeirItemButterfly = __TS__Class()
ModifeirItemButterfly.name = "ModifeirItemButterfly"
__TS__ClassExtends(ModifeirItemButterfly, CustomModifier)
function ModifeirItemButterfly.prototype.OnCreated(self)
    if IsServer() then
        self:OnIntervalThink()
        self:StartIntervalThink(self:Value("think_duration"))
    end
end
function ModifeirItemButterfly.prototype.OnIntervalThink(self)
    ModifierItemButterflyBanish:apply(
        self.caster,
        self.caster,
        self.ability,
        {duration = self:Value("banish_duration")}
    )
    self.caster:AddNewModifier(
        self.caster,
        self.ability,
        "modifier_hide_bar",
        {duration = self:Value("banish_duration")}
    )
    self:PlayEffectsOnBanish()
end
function ModifeirItemButterfly.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT}
end
function ModifeirItemButterfly.prototype.GetModifierAttackSpeedBonus_Constant(self)
    return self:Value("aspd")
end
function ModifeirItemButterfly.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("ms_pct")
end
function ModifeirItemButterfly.prototype.GetEffectName(self)
    return "particles/items2_fx/butterfly_buff.vpcf"
end
function ModifeirItemButterfly.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifeirItemButterfly.prototype.PlayEffectsOnBanish(self)
    EmitSoundOn("DOTA_Item.Butterfly", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/butterfly_effect/pa_arcana_event_glitch.vpcf", PATTACH_WORLDORIGIN, self.caster)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.caster:GetOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
ModifeirItemButterfly = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_butterfly_custom"})},
    ModifeirItemButterfly
)
ModifierItemButterflyBanish = __TS__Class()
ModifierItemButterflyBanish.name = "ModifierItemButterflyBanish"
__TS__ClassExtends(ModifierItemButterflyBanish, ModifierBanish)
function ModifierItemButterflyBanish.prototype.OnDestroy(self)
    ModifierBanish.prototype.OnDestroy(self)
    if IsServer() then
        self:PlayEffectsOnDestroy()
    end
end
function ModifierItemButterflyBanish.prototype.PlayEffectsOnDestroy(self)
    EmitSoundOn("Hero_PhantomAssassin.Blur.Break", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/butterfly_effect/pa_arcana_event_glitch.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.caster:GetOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        3,
        self.caster:GetOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ModifierItemButterflyBanish.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierBanish.prototype.CheckState(self),
        {[MODIFIER_STATE_COMMAND_RESTRICTED] = true}
    )
end
ModifierItemButterflyBanish = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_butterfly_custom_banish"})},
    ModifierItemButterflyBanish
)
return ____exports
