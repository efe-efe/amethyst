local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 55,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 8,["23"] = 8,["24"] = 9,["25"] = 10,["26"] = 11,["27"] = 10,["28"] = 14,["29"] = 15,["30"] = 14,["31"] = 18,["32"] = 19,["33"] = 18,["34"] = 22,["35"] = 23,["36"] = 24,["38"] = 9,["39"] = 22,["40"] = 29,["41"] = 30,["42"] = 31,["43"] = 32,["44"] = 33,["45"] = 33,["46"] = 33,["47"] = 33,["48"] = 35,["49"] = 35,["50"] = 35,["51"] = 35,["52"] = 35,["53"] = 35,["54"] = 35,["55"] = 35,["56"] = 44,["57"] = 29,["58"] = 47,["59"] = 48,["60"] = 49,["61"] = 50,["62"] = 47,["63"] = 9,["64"] = 8,["65"] = 9,["67"] = 54,["68"] = 54,["69"] = 55,["70"] = 56,["71"] = 55,["72"] = 59,["73"] = 60,["75"] = 56,["76"] = 64,["77"] = 55,["78"] = 67,["79"] = 68,["80"] = 68,["81"] = 68,["82"] = 68,["83"] = 68,["84"] = 68,["85"] = 68,["86"] = 68,["87"] = 68,["88"] = 78,["89"] = 79,["91"] = 82,["92"] = 87,["93"] = 88,["94"] = 88,["95"] = 88,["96"] = 88,["97"] = 88,["98"] = 89,["100"] = 64,["101"] = 93,["102"] = 94,["103"] = 95,["104"] = 96,["107"] = 93,["108"] = 101,["109"] = 102,["110"] = 103,["111"] = 103,["112"] = 105,["113"] = 111,["114"] = 113,["115"] = 114,["116"] = 115,["117"] = 117,["118"] = 121,["121"] = 129,["122"] = 129,["123"] = 129,["124"] = 129,["125"] = 129,["126"] = 129,["127"] = 135,["128"] = 103,["129"] = 103,["131"] = 101,["132"] = 141,["133"] = 142,["134"] = 145,["135"] = 141,["136"] = 148,["137"] = 149,["138"] = 148,["139"] = 152,["140"] = 153,["141"] = 152,["142"] = 156,["143"] = 157,["144"] = 156,["145"] = 55,["146"] = 54,["147"] = 55,["149"] = 161,["150"] = 161,["151"] = 162,["152"] = 163,["153"] = 164,["154"] = 163,["155"] = 167,["156"] = 168,["157"] = 167,["158"] = 162,["159"] = 161,["160"] = 162,["162"] = 172,["163"] = 172,["164"] = 173,["165"] = 174,["166"] = 175,["167"] = 174,["168"] = 173,["169"] = 172,["170"] = 173});
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
