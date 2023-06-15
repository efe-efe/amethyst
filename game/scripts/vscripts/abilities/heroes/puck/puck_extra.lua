local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 73,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 7,["21"] = 7,["22"] = 8,["23"] = 9,["24"] = 10,["25"] = 9,["26"] = 13,["27"] = 14,["28"] = 13,["29"] = 17,["30"] = 18,["31"] = 17,["32"] = 21,["33"] = 22,["34"] = 21,["35"] = 25,["36"] = 26,["37"] = 27,["39"] = 8,["40"] = 25,["41"] = 32,["42"] = 33,["43"] = 34,["44"] = 35,["45"] = 35,["46"] = 35,["47"] = 35,["48"] = 35,["49"] = 35,["50"] = 35,["51"] = 35,["52"] = 35,["53"] = 36,["54"] = 37,["55"] = 39,["56"] = 41,["57"] = 41,["58"] = 41,["59"] = 41,["60"] = 41,["61"] = 41,["62"] = 41,["63"] = 41,["64"] = 41,["65"] = 51,["66"] = 52,["68"] = 55,["69"] = 32,["70"] = 59,["71"] = 60,["72"] = 61,["73"] = 61,["74"] = 61,["75"] = 61,["76"] = 62,["77"] = 67,["78"] = 67,["79"] = 67,["80"] = 67,["81"] = 67,["82"] = 68,["83"] = 59,["84"] = 8,["85"] = 7,["86"] = 8,["88"] = 72,["89"] = 72,["90"] = 73,["91"] = 74,["92"] = 75,["93"] = 74,["94"] = 78,["95"] = 79,["96"] = 80,["97"] = 81,["98"] = 82,["99"] = 83,["100"] = 84,["101"] = 88,["103"] = 92,["106"] = 96,["107"] = 96,["108"] = 96,["109"] = 96,["110"] = 96,["111"] = 96,["112"] = 99,["113"] = 100,["114"] = 105,["115"] = 105,["116"] = 105,["117"] = 105,["118"] = 105,["119"] = 106,["120"] = 107,["123"] = 78,["124"] = 73,["125"] = 72,["126"] = 73,["128"] = 119,["129"] = 119,["130"] = 120,["131"] = 120,["132"] = 119,["133"] = 120,["135"] = 122,["136"] = 122,["137"] = 123,["138"] = 123,["139"] = 122,["140"] = 123});
local ____exports = {}
local ModifierPuckExtra, ModifierPuckExtraRecast, ModifierPuckExtraMark
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local PuckExtra = __TS__Class()
PuckExtra.name = "PuckExtra"
__TS__ClassExtends(PuckExtra, CustomAbility)
function PuckExtra.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function PuckExtra.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckExtra.prototype.GetCastingCrawl(self)
    return 0
end
function PuckExtra.prototype.GetFadeGestureOnCast(self)
    return false
end
function PuckExtra.prototype.GetManaCost(self, level)
    if IsServer() and ModifierPuckExtraRecast:findOne(self.caster) then
        return 0
    end
    return CustomAbility.prototype.GetManaCost(self, level)
end
function PuckExtra.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {maxRange = self:GetCastRange(
            Vector(0, 0, 0),
            nil
        )}
    )
    local preSilenceDuration = self:GetSpecialValueFor("pre_silence_duration")
    local radius = self:GetSpecialValueFor("radius")
    FindClearSpaceForUnit(self.caster, point, true)
    local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.caster,
        point,
        radius,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    for ____, enemy in ipairs(enemies) do
        ModifierPuckExtra:apply(enemy, self.caster, self, {duration = preSilenceDuration})
    end
    self:PlayEffectsOnCast(radius)
end
function PuckExtra.prototype.PlayEffectsOnCast(self, radius)
    EmitSoundOn("Hero_Puck.Waning_Rift", self.caster)
    EmitSoundOn(
        "puck_puck_ability_rift_0" .. tostring(RandomInt(1, 3)),
        self.caster
    )
    local particleId = ParticleManager:CreateParticle("particles/econ/items/puck/puck_fairy_wing/puck_waning_rift_fairy_wing.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(radius, radius, radius)
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
PuckExtra = __TS__Decorate(
    {registerAbility(nil, "puck_extra")},
    PuckExtra
)
ModifierPuckExtra = __TS__Class()
ModifierPuckExtra.name = "ModifierPuckExtra"
__TS__ClassExtends(ModifierPuckExtra, CustomModifier)
function ModifierPuckExtra.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_ORDER}
end
function ModifierPuckExtra.prototype.OnOrder(self, event)
    if event.unit == self.parent then
        if event.order_type == DOTA_UNIT_ORDER_CAST_POSITION or event.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET then
            if self.ability:GetLevel() >= 2 then
                if not ModifierPuckExtraMark:findOne(self.caster) then
                    ModifierPuckExtraMark:apply(self.caster, self.caster, self.ability, {duration = 5})
                    ModifierPuckExtraRecast:apply(self.caster, self.caster, self.ability, {abilityLeft = PuckExtra.name, duration = 5})
                    EFX("particles/puck/puck_ex_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {release = true})
                else
                    self.caster:RemoveModifierByName(ModifierPuckExtraMark.name)
                end
            end
            self.parent:AddNewModifier(
                self.caster,
                self.ability,
                "modifier_generic_silence",
                {duration = self:Value("silence_duration")}
            )
            EmitSoundOn("Hero_Puck.IIllusory_Orb_Damage", self.parent)
            local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_waning_rift.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControl(
                particleId,
                1,
                Vector(100, 100, 100)
            )
            ParticleManager:ReleaseParticleIndex(particleId)
            self:Destroy()
        end
    end
end
ModifierPuckExtra = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_extra_debuff"})},
    ModifierPuckExtra
)
ModifierPuckExtraRecast = __TS__Class()
ModifierPuckExtraRecast.name = "ModifierPuckExtraRecast"
__TS__ClassExtends(ModifierPuckExtraRecast, ModifierRecast)
ModifierPuckExtraRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_extra_recast"})},
    ModifierPuckExtraRecast
)
ModifierPuckExtraMark = __TS__Class()
ModifierPuckExtraMark.name = "ModifierPuckExtraMark"
__TS__ClassExtends(ModifierPuckExtraMark, CustomModifier)
ModifierPuckExtraMark = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_extra_recast_used"})},
    ModifierPuckExtraMark
)
return ____exports
