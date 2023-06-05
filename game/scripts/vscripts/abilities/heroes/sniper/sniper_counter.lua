local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 49,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 5,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 9,["22"] = 10,["23"] = 11,["24"] = 12,["25"] = 13,["26"] = 13,["27"] = 13,["28"] = 13,["29"] = 13,["30"] = 13,["31"] = 13,["32"] = 13,["33"] = 13,["34"] = 13,["35"] = 7,["36"] = 20,["37"] = 21,["38"] = 22,["39"] = 23,["41"] = 20,["42"] = 27,["43"] = 28,["44"] = 29,["45"] = 30,["46"] = 35,["47"] = 35,["48"] = 35,["49"] = 35,["50"] = 35,["51"] = 36,["52"] = 38,["53"] = 27,["54"] = 6,["55"] = 5,["56"] = 6,["58"] = 48,["59"] = 48,["60"] = 49,["61"] = 50,["62"] = 51,["63"] = 50,["64"] = 54,["65"] = 55,["66"] = 54,["67"] = 58,["68"] = 59,["69"] = 58,["70"] = 62,["71"] = 63,["72"] = 64,["74"] = 62,["75"] = 68,["76"] = 69,["77"] = 68,["78"] = 72,["79"] = 73,["80"] = 72,["81"] = 76,["82"] = 77,["83"] = 76,["84"] = 80,["85"] = 81,["86"] = 80,["87"] = 49,["88"] = 48,["89"] = 49});
local ____exports = {}
local ModifierSniperCounter
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local SniperCounter = __TS__Class()
SniperCounter.name = "SniperCounter"
__TS__ClassExtends(SniperCounter, CustomAbility)
function SniperCounter.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    ModifierSniperCounter:apply(self.caster, self.caster, self, {duration = duration})
    self:RefreshAbility("sniper_second_attack")
    self:RefreshAbility("sniper_ex_second_attack")
    self:PlayEffects()
    EFX(
        "particles/items2_fx/smoke_of_deceit.vpcf",
        PATTACH_WORLDORIGIN,
        self.caster,
        {
            cp0 = self.caster:GetAbsOrigin(),
            cp1 = Vector(500, 500, 500),
            release = true
        }
    )
end
function SniperCounter.prototype.RefreshAbility(self, abilityName)
    local ability = self.caster:FindAbilityByName(abilityName)
    if ability then
        ability:EndCooldown()
    end
end
function SniperCounter.prototype.PlayEffects(self)
    local origin = self.caster:GetAbsOrigin()
    EmitSoundOn("DOTA_Item.SmokeOfDeceit.Activate", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/sniper/sniper_counter.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        3,
        Vector(origin.x, origin.y, origin.z + 64)
    )
    ParticleManager:SetParticleControl(particleId, 0, origin)
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf", PATTACH_WORLDORIGIN, nil))
end
SniperCounter = __TS__Decorate(
    {registerAbility(nil, "sniper_counter")},
    SniperCounter
)
ModifierSniperCounter = __TS__Class()
ModifierSniperCounter.name = "ModifierSniperCounter"
__TS__ClassExtends(ModifierSniperCounter, CustomModifier)
function ModifierSniperCounter.prototype.IsHidden(self)
    return false
end
function ModifierSniperCounter.prototype.IsDebuff(self)
    return false
end
function ModifierSniperCounter.prototype.IsPurgable(self)
    return true
end
function ModifierSniperCounter.prototype.OnDestroy(self)
    if IsServer() then
        self.ability:StartCooldown(self.ability:GetCooldown(0))
    end
end
function ModifierSniperCounter.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_INVISIBILITY_LEVEL, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierSniperCounter.prototype.GetModifierInvisibilityLevel(self)
    return 2
end
function ModifierSniperCounter.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("speed_buff_pct")
end
function ModifierSniperCounter.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVISIBLE] = true, [MODIFIER_STATE_TRUESIGHT_IMMUNE] = false}
end
ModifierSniperCounter = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_counter "})},
    ModifierSniperCounter
)
return ____exports
