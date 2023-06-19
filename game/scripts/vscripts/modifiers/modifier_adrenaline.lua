local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 4,["22"] = 10,["23"] = 11,["24"] = 10,["25"] = 13,["26"] = 14,["27"] = 13,["28"] = 16,["29"] = 17,["30"] = 16,["31"] = 20,["32"] = 21,["33"] = 22,["35"] = 20,["36"] = 26,["37"] = 27,["38"] = 26,["39"] = 30,["40"] = 31,["41"] = 32,["44"] = 36,["45"] = 40,["47"] = 30,["48"] = 44,["49"] = 45,["50"] = 44,["51"] = 48,["52"] = 49,["53"] = 50,["56"] = 54,["59"] = 61,["61"] = 48,["62"] = 65,["63"] = 66,["64"] = 65,["65"] = 69,["66"] = 70,["67"] = 69,["68"] = 73,["69"] = 74,["70"] = 73,["71"] = 77,["72"] = 78,["73"] = 78,["74"] = 78,["75"] = 78,["76"] = 80,["77"] = 77,["78"] = 89,["79"] = 90,["80"] = 89,["81"] = 5,["82"] = 4,["83"] = 5,["85"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierAdrenaline = __TS__Class()
local ModifierAdrenaline = ____exports.ModifierAdrenaline
ModifierAdrenaline.name = "ModifierAdrenaline"
__TS__ClassExtends(ModifierAdrenaline, CustomModifier)
function ModifierAdrenaline.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.speedBuffPct = 20
    self.slowDuration = 2
    self.maxSlowPct = 100
end
function ModifierAdrenaline.prototype.IsHidden(self)
    return false
end
function ModifierAdrenaline.prototype.IsDebuff(self)
    return false
end
function ModifierAdrenaline.prototype.IsPurgable(self)
    return true
end
function ModifierAdrenaline.prototype.OnDestroy(self)
    if IsServer() then
        self:PlayEffects()
    end
end
function ModifierAdrenaline.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_TAKEDAMAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_EVENT_ON_ABILITY_EXECUTED}
end
function ModifierAdrenaline.prototype.OnTakeDamage(self, event)
    if IsServer() then
        if event.unit ~= self.caster then
            return
        end
        event.unit:AddNewModifier(event.unit, nil, "modifier_generic_fading_slow", {duration = self.slowDuration, max_slow_pct = self.maxSlowPct})
        self:Destroy()
    end
end
function ModifierAdrenaline.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self.speedBuffPct
end
function ModifierAdrenaline.prototype.OnAbilityExecuted(self, event)
    if IsServer() then
        if event.unit ~= self.parent then
            return
        end
        if event.ability:GetName() == "item_death_orb" or event.ability:GetName() == "item_mana_orb" or event.ability:GetName() == "item_health_orb" or event.ability:GetName() == "item_shield_orb" then
            return
        end
        self:Destroy()
    end
end
function ModifierAdrenaline.prototype.GetEffectName(self)
    return "particles/adrenaline/adrenaline_owner.vpcf"
end
function ModifierAdrenaline.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifierAdrenaline.prototype.GetTexture(self)
    return "modifier_adrenaline"
end
function ModifierAdrenaline.prototype.PlayEffects(self)
    EmitSoundOn(
        "DOTA_Item.Sheepstick.Activate",
        self:GetParent()
    )
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", PATTACH_ABSORIGIN, self.parent))
end
function ModifierAdrenaline.prototype.GetStatusEffectName(self)
    return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf"
end
ModifierAdrenaline = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_adrenaline"})},
    ModifierAdrenaline
)
____exports.ModifierAdrenaline = ModifierAdrenaline
return ____exports
