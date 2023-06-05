local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 73,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 6,["20"] = 6,["21"] = 8,["22"] = 8,["23"] = 9,["24"] = 10,["25"] = 11,["26"] = 10,["27"] = 14,["28"] = 15,["29"] = 14,["30"] = 18,["31"] = 19,["32"] = 20,["33"] = 21,["34"] = 22,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 22,["41"] = 22,["42"] = 22,["43"] = 22,["44"] = 22,["45"] = 22,["46"] = 24,["47"] = 25,["48"] = 27,["49"] = 27,["50"] = 27,["51"] = 27,["52"] = 27,["53"] = 27,["54"] = 27,["55"] = 44,["56"] = 44,["57"] = 44,["58"] = 44,["59"] = 44,["60"] = 44,["61"] = 44,["62"] = 44,["63"] = 44,["64"] = 44,["65"] = 50,["67"] = 54,["68"] = 18,["69"] = 57,["70"] = 58,["71"] = 59,["72"] = 64,["73"] = 64,["74"] = 64,["75"] = 64,["76"] = 64,["77"] = 65,["78"] = 65,["79"] = 65,["80"] = 65,["81"] = 65,["82"] = 66,["83"] = 57,["84"] = 9,["85"] = 8,["86"] = 9,["88"] = 72,["89"] = 72,["90"] = 73,["91"] = 131,["92"] = 132,["93"] = 131,["94"] = 135,["95"] = 136,["96"] = 135,["97"] = 139,["98"] = 140,["99"] = 139,["100"] = 143,["101"] = 144,["102"] = 144,["103"] = 73,["104"] = 144,["105"] = 144,["106"] = 143,["107"] = 73,["108"] = 72,["109"] = 73});
local ____exports = {}
local ModifierSniperMobility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____sniper_special_attack = require("abilities.heroes.sniper.sniper_special_attack")
local ModifierSniperSpecialAttackThinker = ____sniper_special_attack.ModifierSniperSpecialAttackThinker
local SniperMobility = __TS__Class()
SniperMobility.name = "SniperMobility"
__TS__ClassExtends(SniperMobility, CustomAbility)
function SniperMobility.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SniperMobility.prototype.GetPlaybackRateOverride(self)
    return 2
end
function SniperMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local minRange = self:GetSpecialValueFor("min_range")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {
            maxRange = self:GetCastRange(
                Vector(0, 0, 0),
                nil
            ),
            minRange = minRange
        }
    )
    local direction = point:__sub(origin):Normalized()
    local distance = point:__sub(origin):Length2D()
    ModifierSniperMobility:apply(self.caster, self.caster, self, {
        x = direction.x,
        y = direction.y,
        distance = distance,
        speed = distance / 0.5,
        peak = 400
    })
    ModifierSniperSpecialAttackThinker:createThinker(
        self.caster,
        self,
        origin,
        {
            duration = self:GetSpecialValueFor("duration"),
            delayTime = self:GetSpecialValueFor("delay_time"),
            radius = self:GetSpecialValueFor("radius")
        }
    )
    if self:GetLevel() == 2 then
    end
    self:PlayEffectsOnCast()
end
function SniperMobility.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_Techies.LandMine.Detonate", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
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
SniperMobility = __TS__Decorate(
    {registerAbility(nil, "sniper_mobility")},
    SniperMobility
)
ModifierSniperMobility = __TS__Class()
ModifierSniperMobility.name = "ModifierSniperMobility"
__TS__ClassExtends(ModifierSniperMobility, ModifierDisplacement)
function ModifierSniperMobility.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierSniperMobility.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierSniperMobility.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierSniperMobility.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
ModifierSniperMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_mobility_displacement"})},
    ModifierSniperMobility
)
return ____exports
