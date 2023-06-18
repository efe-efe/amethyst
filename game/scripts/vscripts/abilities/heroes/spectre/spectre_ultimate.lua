local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 104,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 6,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 11,["28"] = 10,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 24,["38"] = 25,["39"] = 25,["40"] = 25,["41"] = 25,["42"] = 25,["43"] = 25,["44"] = 25,["45"] = 25,["46"] = 25,["47"] = 27,["48"] = 27,["49"] = 27,["50"] = 27,["51"] = 27,["52"] = 27,["53"] = 27,["54"] = 27,["55"] = 27,["56"] = 27,["57"] = 27,["58"] = 33,["59"] = 22,["60"] = 9,["61"] = 8,["62"] = 9,["64"] = 39,["65"] = 40,["66"] = 39,["67"] = 40,["68"] = 41,["69"] = 42,["70"] = 43,["71"] = 44,["72"] = 45,["74"] = 47,["77"] = 41,["78"] = 52,["79"] = 53,["80"] = 54,["81"] = 55,["82"] = 57,["83"] = 60,["84"] = 64,["85"] = 65,["86"] = 65,["87"] = 65,["88"] = 65,["89"] = 65,["90"] = 65,["93"] = 73,["96"] = 52,["97"] = 78,["98"] = 79,["99"] = 78,["100"] = 82,["101"] = 83,["102"] = 82,["103"] = 86,["104"] = 87,["105"] = 88,["107"] = 91,["108"] = 86,["109"] = 94,["110"] = 95,["111"] = 96,["113"] = 99,["114"] = 94,["115"] = 40,["116"] = 39,["117"] = 40,["119"] = 40,["120"] = 103,["121"] = 103,["122"] = 104,["123"] = 108,["124"] = 109,["125"] = 108,["126"] = 112,["127"] = 113,["128"] = 112,["129"] = 116,["130"] = 117,["131"] = 116,["132"] = 120,["133"] = 121,["134"] = 120,["135"] = 124,["136"] = 125,["137"] = 124,["138"] = 128,["139"] = 129,["140"] = 128,["141"] = 132,["142"] = 104,["143"] = 135,["144"] = 136,["146"] = 132,["147"] = 140,["148"] = 104,["149"] = 143,["150"] = 144,["151"] = 144,["152"] = 144,["153"] = 144,["154"] = 144,["155"] = 144,["156"] = 144,["157"] = 144,["158"] = 144,["159"] = 154,["160"] = 155,["162"] = 155,["165"] = 158,["166"] = 159,["167"] = 160,["170"] = 140,["171"] = 165,["172"] = 166,["173"] = 171,["174"] = 172,["175"] = 172,["176"] = 172,["177"] = 172,["178"] = 172,["179"] = 173,["180"] = 174,["181"] = 165,["182"] = 104,["183"] = 103,["184"] = 104});
local ____exports = {}
local ModifierSpectreUltimateThinker
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____spectre_special_attack = require("abilities.heroes.spectre.spectre_special_attack")
local ModifierSpectreSpecialAttackBuff = ____spectre_special_attack.ModifierSpectreSpecialAttackBuff
local ModifierSpectreSpecialAttackDebuff = ____spectre_special_attack.ModifierSpectreSpecialAttackDebuff
local SpectreUltimate = __TS__Class()
SpectreUltimate.name = "SpectreUltimate"
__TS__ClassExtends(SpectreUltimate, CustomAbility)
function SpectreUltimate.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SpectreUltimate.prototype.GetPlaybackRateOverride(self)
    return 0.6
end
function SpectreUltimate.prototype.GetCastingCrawl(self)
    return 0
end
function SpectreUltimate.prototype.OnSpellStart(self)
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
    ModifierSpectreUltimateThinker:createThinker(
        self.caster,
        self,
        point,
        {
            delayTime = self:GetSpecialValueFor("delay_time"),
            radius = self:GetSpecialValueFor("radius"),
            duration = self:GetSpecialValueFor("duration"),
            content = "clearout"
        }
    )
    EmitSoundOn("Hero_Spectre.HauntCast", self.caster)
end
SpectreUltimate = __TS__Decorate(
    {registerAbility(nil, "spectre_ultimate")},
    SpectreUltimate
)
____exports.ModifierSpectreUltimate = __TS__Class()
local ModifierSpectreUltimate = ____exports.ModifierSpectreUltimate
ModifierSpectreUltimate.name = "ModifierSpectreUltimate"
__TS__ClassExtends(ModifierSpectreUltimate, CustomModifier)
function ModifierSpectreUltimate.prototype.OnCreated(self)
    if IsServer() then
        if self.caster == self.parent then
            ModifierSpectreSpecialAttackBuff:apply(self.parent, self.parent, self.ability, {})
            self:SetStackCount(1)
        else
            self:SetStackCount(2)
        end
    end
end
function ModifierSpectreUltimate.prototype.OnDestroy(self)
    if IsServer() then
        if self:IsDebuff() and self:GetStackCount() == 2 then
            EmitSoundOn("Hero_Spectre.DaggerImpact", self.parent)
            ModifierSpectreSpecialAttackDebuff:apply(self.parent, self.caster, self.ability, {duration = 5})
            self.parent:AddNewModifier(self.caster, self.ability, "modifier_generic_fading_slow", {duration = 5, max_slow_pct = 50})
            if IsServer() then
                ApplyDamage({
                    victim = self.parent,
                    attacker = self.caster,
                    damage = self:Value("ability_damage"),
                    damage_type = DAMAGE_TYPE_PURE
                })
            end
        else
            self.parent:RemoveModifierByName(ModifierSpectreSpecialAttackBuff.name)
        end
    end
end
function ModifierSpectreUltimate.prototype.IsDebuff(self)
    return self:GetStackCount() == 2 and not CustomEntitiesLegacy:Allies(self.caster, self.parent)
end
function ModifierSpectreUltimate.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
end
function ModifierSpectreUltimate.prototype.GetBonusVisionPercentage(self)
    if self:IsDebuff() then
        return -80
    end
    return 0
end
function ModifierSpectreUltimate.prototype.GetModifierPreAttack_BonusDamage(self)
    if not self:IsDebuff() then
        return self:Value("bonus_damage")
    end
    return 0
end
ModifierSpectreUltimate = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_ultimate"})},
    ModifierSpectreUltimate
)
____exports.ModifierSpectreUltimate = ModifierSpectreUltimate
ModifierSpectreUltimateThinker = __TS__Class()
ModifierSpectreUltimateThinker.name = "ModifierSpectreUltimateThinker"
__TS__ClassExtends(ModifierSpectreUltimateThinker, ModifierThinker)
function ModifierSpectreUltimateThinker.prototype.IsAura(self)
    return self.initialized
end
function ModifierSpectreUltimateThinker.prototype.GetModifierAura(self)
    return ____exports.ModifierSpectreUltimate.name
end
function ModifierSpectreUltimateThinker.prototype.GetAuraRadius(self)
    return self.radius
end
function ModifierSpectreUltimateThinker.prototype.GetAuraDuration(self)
    return 0
end
function ModifierSpectreUltimateThinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierSpectreUltimateThinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierSpectreUltimateThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
    end
end
function ModifierSpectreUltimateThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
            self.caster,
            self.origin,
            self.radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )
        for ____, enemy in ipairs(enemies) do
            local ____opt_0 = ____exports.ModifierSpectreUltimate:findOne(enemy)
            if ____opt_0 ~= nil then
                ____opt_0:SetStackCount(1)
            end
        end
        if self.particleId then
            ParticleManager:DestroyParticle(self.particleId, false)
            ParticleManager:ReleaseParticleIndex(self.particleId)
        end
    end
end
function ModifierSpectreUltimateThinker.prototype.OnReady(self)
    self.particleId = ParticleManager:CreateParticle("particles/spectre/spectre_ultimate.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.particleId, 0, self.origin)
    ParticleManager:SetParticleControl(
        self.particleId,
        1,
        Vector(self.radius, self.radius, 1)
    )
    EmitSoundOn("Hero_Spectre.HauntCast", self.parent)
    EmitSoundOn("Hero_Spectre.Reality", self.parent)
end
ModifierSpectreUltimateThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_ultimate_thinker"})},
    ModifierSpectreUltimateThinker
)
return ____exports
