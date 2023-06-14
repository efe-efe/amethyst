local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 49,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 7,["23"] = 7,["24"] = 8,["25"] = 8,["26"] = 10,["27"] = 10,["28"] = 11,["29"] = 12,["30"] = 13,["31"] = 12,["32"] = 15,["33"] = 16,["34"] = 17,["35"] = 18,["36"] = 19,["37"] = 19,["38"] = 19,["39"] = 19,["40"] = 20,["41"] = 21,["42"] = 23,["43"] = 23,["44"] = 23,["45"] = 23,["46"] = 23,["47"] = 23,["48"] = 23,["49"] = 23,["50"] = 32,["51"] = 33,["53"] = 35,["54"] = 15,["55"] = 37,["56"] = 38,["57"] = 38,["58"] = 38,["59"] = 38,["60"] = 39,["61"] = 39,["62"] = 39,["63"] = 39,["64"] = 39,["65"] = 44,["66"] = 37,["67"] = 11,["68"] = 10,["69"] = 11,["71"] = 48,["72"] = 48,["73"] = 49,["74"] = 50,["75"] = 52,["76"] = 50,["77"] = 55,["78"] = 56,["79"] = 57,["81"] = 60,["82"] = 55,["83"] = 49,["84"] = 48,["85"] = 49,["87"] = 64,["88"] = 64,["89"] = 65,["90"] = 66,["91"] = 65,["92"] = 68,["93"] = 69,["95"] = 66,["96"] = 73,["97"] = 74,["98"] = 75,["99"] = 80,["100"] = 81,["101"] = 81,["102"] = 81,["103"] = 81,["104"] = 81,["105"] = 82,["106"] = 82,["107"] = 82,["108"] = 82,["109"] = 82,["110"] = 83,["111"] = 83,["112"] = 83,["113"] = 83,["114"] = 83,["115"] = 84,["117"] = 73,["118"] = 88,["119"] = 89,["120"] = 90,["121"] = 91,["122"] = 92,["123"] = 93,["124"] = 95,["125"] = 96,["126"] = 97,["132"] = 88,["133"] = 109,["134"] = 110,["135"] = 109,["136"] = 113,["137"] = 114,["138"] = 113,["139"] = 116,["140"] = 117,["141"] = 116,["142"] = 120,["143"] = 121,["144"] = 120,["145"] = 65,["146"] = 64,["147"] = 65,["149"] = 125,["150"] = 125,["151"] = 126,["152"] = 127,["153"] = 128,["154"] = 127,["155"] = 131,["156"] = 132,["157"] = 131,["158"] = 126,["159"] = 125,["160"] = 126,["162"] = 136,["163"] = 136,["164"] = 137,["165"] = 137,["166"] = 136,["167"] = 137});
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
local ____phantom_basic_attack = require("abilities.heroes.phantom.phantom_basic_attack")
local PhantomBasicAttack = ____phantom_basic_attack.PhantomBasicAttack
local PhantomMobility = __TS__Class()
PhantomMobility.name = "PhantomMobility"
__TS__ClassExtends(PhantomMobility, CustomAbility)
function PhantomMobility.prototype.GetIntrinsicModifierName(self)
    return ModifierPhantomMobilityCharges.name
end
function PhantomMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local phantomBasicAttack = PhantomBasicAttack:findOne(self.caster)
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
