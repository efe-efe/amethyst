local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 29,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 5,["22"] = 7,["23"] = 8,["24"] = 7,["25"] = 8,["26"] = 9,["27"] = 10,["28"] = 9,["29"] = 13,["30"] = 14,["31"] = 15,["32"] = 16,["33"] = 18,["34"] = 20,["35"] = 21,["37"] = 21,["40"] = 24,["42"] = 24,["44"] = 13,["45"] = 8,["46"] = 7,["47"] = 8,["49"] = 8,["50"] = 28,["51"] = 28,["52"] = 29,["53"] = 32,["54"] = 29,["55"] = 34,["56"] = 35,["57"] = 37,["59"] = 32,["60"] = 45,["61"] = 29,["62"] = 47,["63"] = 48,["64"] = 50,["65"] = 51,["66"] = 52,["69"] = 45,["70"] = 57,["71"] = 58,["72"] = 57,["73"] = 61,["74"] = 61,["75"] = 74,["76"] = 75,["77"] = 75,["78"] = 29,["79"] = 75,["80"] = 75,["81"] = 74,["82"] = 29,["83"] = 28,["84"] = 29,["86"] = 89,["87"] = 89,["88"] = 90,["89"] = 91,["90"] = 92,["91"] = 91,["92"] = 95,["93"] = 96,["94"] = 97,["96"] = 100,["97"] = 95,["98"] = 90,["99"] = 89,["100"] = 90});
local ____exports = {}
local ModifierPuckCounter, ModifierPuckCounterCharges
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ____modifier_charges = require("modifiers.modifier_charges")
local ModifierCharges = ____modifier_charges.ModifierCharges
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____puck_basic_attack = require("abilities.heroes.puck.puck_basic_attack")
local ModifierPuckBasicAttack = ____puck_basic_attack.ModifierPuckBasicAttack
local PuckBasicAttack = ____puck_basic_attack.PuckBasicAttack
____exports.PuckCounter = __TS__Class()
local PuckCounter = ____exports.PuckCounter
PuckCounter.name = "PuckCounter"
__TS__ClassExtends(PuckCounter, CustomAbility)
function PuckCounter.prototype.GetIntrinsicModifierName(self)
    return ModifierPuckCounterCharges.name
end
function PuckCounter.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local banishDuration = self:GetSpecialValueFor("banish_duration")
    ModifierPuckCounter:apply(self.caster, self.caster, self, {duration = banishDuration})
    if self:GetLevel() >= 2 then
        local ____opt_0 = ModifierPuckBasicAttack:findOne(self.caster)
        if ____opt_0 ~= nil then
            ____opt_0:Replenish()
        end
    end
    local ____opt_2 = PuckBasicAttack:findOne(self.caster)
    if ____opt_2 ~= nil then
        ____opt_2:LaunchProjectile(origin, point)
    end
end
PuckCounter = __TS__Decorate(
    {registerAbility(nil, "puck_counter")},
    PuckCounter
)
____exports.PuckCounter = PuckCounter
ModifierPuckCounter = __TS__Class()
ModifierPuckCounter.name = "ModifierPuckCounter"
__TS__ClassExtends(ModifierPuckCounter, ModifierBanish)
function ModifierPuckCounter.prototype.OnCreated(self)
    ModifierBanish.prototype.OnCreated(self)
    if IsServer() then
        EmitSoundOn("Hero_Puck.Phase_Shift", self.parent)
        self.particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_phase_shift.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierPuckCounter.prototype.OnDestroy(self)
    ModifierBanish.prototype.OnDestroy(self)
    if IsServer() then
        StopSoundOn("Hero_Puck.Phase_Shift", self.parent)
        if self.particleId then
            ParticleManager:DestroyParticle(self.particleId, false)
            ParticleManager:ReleaseParticleIndex(self.particleId)
        end
    end
end
function ModifierPuckCounter.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_ORDER}
end
function ModifierPuckCounter.prototype.OnOrder(self, params)
end
function ModifierPuckCounter.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierBanish.prototype.CheckState(self),
        {[MODIFIER_STATE_ROOTED] = true}
    )
end
ModifierPuckCounter = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_counter_banish"})},
    ModifierPuckCounter
)
ModifierPuckCounterCharges = __TS__Class()
ModifierPuckCounterCharges.name = "ModifierPuckCounterCharges"
__TS__ClassExtends(ModifierPuckCounterCharges, ModifierCharges)
function ModifierPuckCounterCharges.prototype.GetMaxCharges(self)
    return self:Value("max_charges")
end
function ModifierPuckCounterCharges.prototype.GetReplenishTime(self)
    if IsServer() then
        return self.ability:GetCooldown(self.ability:GetLevel())
    end
    return 0
end
ModifierPuckCounterCharges = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_counter_charges"})},
    ModifierPuckCounterCharges
)
return ____exports
