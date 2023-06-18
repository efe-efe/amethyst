local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 55,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 6,["22"] = 6,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 11,["28"] = 10,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 24,["39"] = 9,["40"] = 22,["41"] = 29,["42"] = 30,["43"] = 31,["44"] = 32,["45"] = 33,["46"] = 33,["47"] = 33,["48"] = 33,["49"] = 35,["50"] = 35,["51"] = 35,["52"] = 35,["53"] = 35,["54"] = 35,["55"] = 35,["56"] = 35,["57"] = 44,["58"] = 29,["59"] = 47,["60"] = 48,["61"] = 49,["62"] = 50,["63"] = 47,["64"] = 9,["65"] = 8,["66"] = 9,["68"] = 54,["69"] = 54,["70"] = 55,["71"] = 56,["72"] = 55,["73"] = 59,["74"] = 60,["76"] = 56,["77"] = 64,["78"] = 55,["79"] = 67,["80"] = 68,["81"] = 68,["82"] = 68,["83"] = 68,["84"] = 68,["85"] = 68,["86"] = 68,["87"] = 68,["88"] = 68,["89"] = 78,["90"] = 79,["92"] = 82,["93"] = 87,["94"] = 88,["95"] = 88,["96"] = 88,["97"] = 88,["98"] = 88,["99"] = 89,["101"] = 64,["102"] = 93,["103"] = 94,["104"] = 95,["105"] = 96,["108"] = 93,["109"] = 101,["110"] = 102,["111"] = 103,["112"] = 103,["113"] = 105,["114"] = 106,["115"] = 107,["116"] = 107,["117"] = 107,["118"] = 107,["119"] = 107,["120"] = 107,["121"] = 107,["122"] = 107,["123"] = 107,["125"] = 113,["126"] = 115,["127"] = 116,["128"] = 117,["129"] = 119,["130"] = 123,["133"] = 131,["134"] = 131,["135"] = 131,["136"] = 131,["137"] = 131,["138"] = 131,["139"] = 137,["140"] = 103,["141"] = 103,["143"] = 101,["144"] = 143,["145"] = 144,["146"] = 147,["147"] = 143,["148"] = 150,["149"] = 151,["150"] = 150,["151"] = 154,["152"] = 155,["153"] = 154,["154"] = 158,["155"] = 159,["156"] = 158,["157"] = 55,["158"] = 54,["159"] = 55,["161"] = 163,["162"] = 163,["163"] = 164,["164"] = 165,["165"] = 166,["166"] = 165,["167"] = 169,["168"] = 170,["169"] = 169,["170"] = 164,["171"] = 163,["172"] = 164,["174"] = 174,["175"] = 174,["176"] = 175,["177"] = 176,["178"] = 177,["179"] = 176,["180"] = 175,["181"] = 174,["182"] = 175});
local ____exports = {}
local ModifierPhantomExtraDisplacement, ModifierPhantomExtraMark, ModifierPhantomExtraRecast
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____util = require("util")
local direction2D = ____util.direction2D
local isCountering = ____util.isCountering
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local PhantomExtra = __TS__Class()
PhantomExtra.name = "PhantomExtra"
__TS__ClassExtends(PhantomExtra, CustomAbility)
function PhantomExtra.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK_EVENT
end
function PhantomExtra.prototype.GetPlaybackRateOverride(self)
    return 0.7
end
function PhantomExtra.prototype.GetCastingCrawl(self)
    return 0
end
function PhantomExtra.prototype.GetManaCost(self, level)
    if IsServer() and ModifierPhantomExtraRecast:findOne(self.caster) then
        return 0
    end
    return CustomAbility.prototype.GetManaCost(self, level)
end
function PhantomExtra.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local direction = direction2D(nil, origin, point)
    local distance = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    ModifierPhantomExtraDisplacement:apply(self.caster, self.caster, self, {
        x = direction.x,
        y = direction.y,
        distance = distance,
        speed = distance / 0.2,
        peak = 30,
        teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY
    })
    self:PlayEffectsOnCast()
end
function PhantomExtra.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/blink_purple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:ReleaseParticleIndex(particleId)
end
PhantomExtra = __TS__Decorate(
    {registerAbility(nil, "phantom_extra")},
    PhantomExtra
)
ModifierPhantomExtraDisplacement = __TS__Class()
ModifierPhantomExtraDisplacement.name = "ModifierPhantomExtraDisplacement"
__TS__ClassExtends(ModifierPhantomExtraDisplacement, ModifierDisplacement)
function ModifierPhantomExtraDisplacement.prototype.OnCreated(self, params)
    ModifierDisplacement.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
    end
end
function ModifierPhantomExtraDisplacement.prototype.OnDestroy(self)
    ModifierDisplacement.prototype.OnDestroy(self)
    if IsServer() then
        local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
            self.parent,
            self.parent:GetAbsOrigin(),
            self:Value("radius"),
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )
        for ____, enemy in ipairs(enemies) do
            self:OnImpact(enemy)
        end
        local particleId = ParticleManager:CreateParticle("particles/phantom/mobility_trail.vpcf", PATTACH_ABSORIGIN, self.parent)
        ParticleManager:SetParticleControl(particleId, 0, self.origin)
        ParticleManager:SetParticleControl(
            particleId,
            1,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function ModifierPhantomExtraDisplacement.prototype.OnCollide(self, event)
    if IsServer() and event.collision == "unit" then
        for ____, unit in ipairs(event.units) do
            self:OnImpact(unit)
        end
    end
end
function ModifierPhantomExtraDisplacement.prototype.OnImpact(self, target)
    if not ModifierPhantomExtraMark:findOne(target) then
        self.ability:SingleAttack({
            target = target,
            effect = function(____, target)
                if not isCountering(nil, target) then
                    target:AddNewModifier(
                        self.parent,
                        self.ability,
                        "modifier_generic_fading_slow",
                        {
                            duration = self:Value("fading_slow_duration"),
                            max_slow_pct = self:Value("fading_slow_pct")
                        }
                    )
                end
                ModifierPhantomExtraMark:apply(target, self.parent, self.ability, {duration = 0.3})
                if self.ability:GetLevel() >= 2 or self.parent:HasModifier("modifier_upgrade_phantom_quick_recast") then
                    if not ModifierPhantomExtraMark:findOne(self.parent) then
                        local recastDuration = 3
                        ModifierPhantomExtraMark:apply(self.parent, self.parent, self.ability, {duration = recastDuration})
                        ModifierPhantomExtraRecast:apply(self.parent, self.parent, self.ability, {abilityLeft = PhantomExtra.name, duration = recastDuration, charges = 0})
                    end
                end
                ApplyDamage({
                    victim = target,
                    attacker = self.parent,
                    damage = self:Value("ability_damage"),
                    damage_type = DAMAGE_TYPE_PHYSICAL
                })
                self:PlayEffectsOnImpact(target)
            end
        })
    end
end
function ModifierPhantomExtraDisplacement.prototype.PlayEffectsOnImpact(self, target)
    EFX("particles/phantom/phantom_basic_attack.vpcf", PATTACH_ABSORIGIN, target, {release = true})
    EmitSoundOn("Hero_PhantomAssassin.Attack", target)
end
function ModifierPhantomExtraDisplacement.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierPhantomExtraDisplacement.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function ModifierPhantomExtraDisplacement.prototype.GetOverrideAnimationRate(self)
    return 1.5
end
ModifierPhantomExtraDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_extra_displacement"})},
    ModifierPhantomExtraDisplacement
)
ModifierPhantomExtraMark = __TS__Class()
ModifierPhantomExtraMark.name = "ModifierPhantomExtraMark"
__TS__ClassExtends(ModifierPhantomExtraMark, CustomModifier)
function ModifierPhantomExtraMark.prototype.IsPurgable(self)
    return false
end
function ModifierPhantomExtraMark.prototype.IsHidden(self)
    return true
end
ModifierPhantomExtraMark = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_extra"})},
    ModifierPhantomExtraMark
)
ModifierPhantomExtraRecast = __TS__Class()
ModifierPhantomExtraRecast.name = "ModifierPhantomExtraRecast"
__TS__ClassExtends(ModifierPhantomExtraRecast, ModifierRecast)
function ModifierPhantomExtraRecast.prototype.IsHidden(self)
    return false
end
ModifierPhantomExtraRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_extra_recast"})},
    ModifierPhantomExtraRecast
)
return ____exports
