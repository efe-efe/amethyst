local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 49,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 7,["23"] = 7,["24"] = 10,["25"] = 10,["26"] = 11,["27"] = 12,["28"] = 13,["29"] = 12,["30"] = 15,["31"] = 16,["32"] = 17,["33"] = 18,["34"] = 19,["35"] = 19,["36"] = 19,["37"] = 19,["38"] = 20,["39"] = 21,["40"] = 23,["41"] = 23,["42"] = 23,["43"] = 23,["44"] = 23,["45"] = 23,["46"] = 23,["47"] = 23,["48"] = 32,["49"] = 33,["51"] = 35,["52"] = 15,["53"] = 37,["54"] = 38,["55"] = 38,["56"] = 38,["57"] = 38,["58"] = 39,["59"] = 39,["60"] = 39,["61"] = 39,["62"] = 39,["63"] = 44,["64"] = 37,["65"] = 11,["66"] = 10,["67"] = 11,["69"] = 48,["70"] = 48,["71"] = 49,["72"] = 50,["73"] = 52,["74"] = 50,["75"] = 55,["76"] = 56,["77"] = 57,["79"] = 60,["80"] = 55,["81"] = 49,["82"] = 48,["83"] = 49,["85"] = 64,["86"] = 64,["87"] = 65,["88"] = 66,["89"] = 65,["90"] = 68,["91"] = 69,["93"] = 66,["94"] = 73,["95"] = 74,["96"] = 75,["97"] = 80,["98"] = 81,["99"] = 81,["100"] = 81,["101"] = 81,["102"] = 81,["103"] = 82,["104"] = 82,["105"] = 82,["106"] = 82,["107"] = 82,["108"] = 83,["109"] = 83,["110"] = 83,["111"] = 83,["112"] = 83,["113"] = 84,["115"] = 73,["116"] = 88,["117"] = 89,["118"] = 90,["119"] = 91,["120"] = 92,["121"] = 93,["122"] = 95,["123"] = 96,["124"] = 97,["130"] = 88,["131"] = 109,["132"] = 110,["133"] = 109,["134"] = 113,["135"] = 114,["136"] = 113,["137"] = 116,["138"] = 117,["139"] = 116,["140"] = 120,["141"] = 121,["142"] = 120,["143"] = 65,["144"] = 64,["145"] = 65,["147"] = 125,["148"] = 125,["149"] = 126,["150"] = 127,["151"] = 128,["152"] = 127,["153"] = 131,["154"] = 132,["155"] = 131,["156"] = 126,["157"] = 125,["158"] = 126,["160"] = 136,["161"] = 136,["162"] = 137,["163"] = 137,["164"] = 136,["165"] = 137});
local ____exports = {}
local ModifierPhantomMobilityCharges, ModifierPhantomMobilityDisplacement, ModifierPhantomMobility, ModifierPhantomMobilityShield
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_charges = require("modifiers.modifier_charges")
local ModifierCharges = ____modifier_charges.ModifierCharges
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____modifier_shield = require("modifiers.modifier_shield")
local ModifierShield = ____modifier_shield.ModifierShield
local ____util = require("util")
local direction2D = ____util.direction2D
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local PhantomMobility = __TS__Class()
PhantomMobility.name = "PhantomMobility"
__TS__ClassExtends(PhantomMobility, CustomAbility)
function PhantomMobility.prototype.GetIntrinsicModifierName(self)
    return ModifierPhantomMobilityCharges.name
end
function PhantomMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local phantomBasicAttack = self.caster:FindAbilityByName("phantom_basic_attack")
    local distance = self:GetCastRange(
        Vector(0, 0, 0),
        self.caster
    ) + self.caster:GetCastRangeBonus()
    local casterDirection = CustomEntitiesLegacy:GetDirection(self.caster)
    local direction = (casterDirection.x ~= 0 or casterDirection.y ~= 0) and casterDirection or direction2D(nil, origin, point)
    ModifierPhantomMobilityDisplacement:apply(self.caster, self.caster, self, {
        x = direction.x,
        y = direction.y,
        distance = distance,
        speed = distance / 0.15,
        peak = 30,
        teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY
    })
    if phantomBasicAttack then
        phantomBasicAttack:TryThrowKnives("modifier_upgrade_phantom_dash_damage")
    end
    self:PlayEffectsOnCast()
end
function PhantomMobility.prototype.PlayEffectsOnCast(self)
    EmitSoundOn(
        "Hero_PhantomAssassin.Strike.Start",
        self:GetCaster()
    )
    local effect_cast = ParticleManager:CreateParticle(
        "particles/blink_purple.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self:GetCaster()
    )
    ParticleManager:ReleaseParticleIndex(effect_cast)
end
PhantomMobility = __TS__Decorate(
    {registerAbility(nil, "phantom_mobility")},
    PhantomMobility
)
ModifierPhantomMobilityCharges = __TS__Class()
ModifierPhantomMobilityCharges.name = "ModifierPhantomMobilityCharges"
__TS__ClassExtends(ModifierPhantomMobilityCharges, ModifierCharges)
function ModifierPhantomMobilityCharges.prototype.GetMaxCharges(self)
    return self:Value("max_charges")
end
function ModifierPhantomMobilityCharges.prototype.GetReplenishTime(self)
    if IsServer() then
        return self.ability:GetCooldown(self.ability:GetLevel())
    end
    return 0
end
ModifierPhantomMobilityCharges = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_mobility_charges"})},
    ModifierPhantomMobilityCharges
)
ModifierPhantomMobilityDisplacement = __TS__Class()
ModifierPhantomMobilityDisplacement.name = "ModifierPhantomMobilityDisplacement"
__TS__ClassExtends(ModifierPhantomMobilityDisplacement, ModifierDisplacement)
function ModifierPhantomMobilityDisplacement.prototype.OnCreated(self, params)
    ModifierDisplacement.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
    end
end
function ModifierPhantomMobilityDisplacement.prototype.OnDestroy(self)
    if IsServer() then
        local particleId = ParticleManager:CreateParticle("particles/phantom/mobility_trail.vpcf", PATTACH_ABSORIGIN, self.parent)
        ParticleManager:SetParticleControl(particleId, 0, self.origin)
        ParticleManager:SetParticleControl(
            particleId,
            1,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            particleId,
            60,
            Vector(188, 7, 229)
        )
        ParticleManager:SetParticleControl(
            particleId,
            61,
            Vector(1, 0, 0)
        )
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function ModifierPhantomMobilityDisplacement.prototype.OnCollide(self, event)
    if IsServer() then
        if event.collision == "unit" then
            for ____, unit in ipairs(event.units) do
                if not ModifierPhantomMobility:findOne(unit) then
                    ModifierPhantomMobility:apply(unit, self.parent, self.ability, {duration = 5})
                    local shieldModifier = self.parent:FindModifierByName("modifier_upgrade_phantom_dash_shield")
                    if shieldModifier then
                        ModifierPhantomMobilityShield:apply(self.parent, self.parent, nil, {duration = 5, damageBlock = 0})
                    end
                end
            end
        end
    end
end
function ModifierPhantomMobilityDisplacement.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierPhantomMobilityDisplacement.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function ModifierPhantomMobilityDisplacement.prototype.GetOverrideAnimationRate(self)
    return 1.5
end
function ModifierPhantomMobilityDisplacement.prototype.GetCollisionRadius(self)
    return 120
end
ModifierPhantomMobilityDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_mobility_displacement"})},
    ModifierPhantomMobilityDisplacement
)
ModifierPhantomMobility = __TS__Class()
ModifierPhantomMobility.name = "ModifierPhantomMobility"
__TS__ClassExtends(ModifierPhantomMobility, CustomModifier)
function ModifierPhantomMobility.prototype.IsHidden(self)
    return true
end
function ModifierPhantomMobility.prototype.IsPurgable(self)
    return false
end
ModifierPhantomMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_mobility_debuff"})},
    ModifierPhantomMobility
)
ModifierPhantomMobilityShield = __TS__Class()
ModifierPhantomMobilityShield.name = "ModifierPhantomMobilityShield"
__TS__ClassExtends(ModifierPhantomMobilityShield, ModifierShield)
ModifierPhantomMobilityShield = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_mobility_shield"})},
    ModifierPhantomMobilityShield
)
return ____exports
