local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 5,["17"] = 5,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 11,["22"] = 12,["23"] = 11,["24"] = 15,["25"] = 16,["26"] = 17,["28"] = 19,["29"] = 15,["30"] = 22,["31"] = 23,["32"] = 22,["33"] = 26,["34"] = 27,["35"] = 28,["37"] = 30,["38"] = 26,["39"] = 33,["40"] = 8,["41"] = 35,["42"] = 36,["44"] = 38,["45"] = 33,["46"] = 41,["47"] = 8,["48"] = 43,["49"] = 41,["50"] = 46,["51"] = 47,["52"] = 48,["53"] = 49,["54"] = 50,["55"] = 51,["56"] = 53,["57"] = 54,["58"] = 55,["59"] = 55,["60"] = 57,["61"] = 57,["62"] = 57,["63"] = 57,["64"] = 57,["65"] = 57,["66"] = 57,["67"] = 57,["68"] = 57,["69"] = 57,["70"] = 68,["71"] = 69,["72"] = 69,["73"] = 57,["74"] = 70,["75"] = 71,["76"] = 73,["77"] = 73,["78"] = 73,["79"] = 73,["80"] = 73,["81"] = 73,["82"] = 80,["83"] = 81,["84"] = 81,["85"] = 81,["86"] = 81,["87"] = 81,["88"] = 82,["89"] = 57,["90"] = 84,["91"] = 85,["92"] = 57,["93"] = 57,["94"] = 89,["95"] = 90,["96"] = 91,["97"] = 46,["98"] = 94,["99"] = 95,["100"] = 96,["101"] = 94,["102"] = 99,["103"] = 100,["104"] = 101,["105"] = 102,["106"] = 107,["107"] = 107,["108"] = 107,["109"] = 107,["110"] = 107,["111"] = 108,["112"] = 108,["113"] = 108,["114"] = 108,["115"] = 108,["116"] = 109,["117"] = 111,["118"] = 116,["119"] = 116,["120"] = 116,["121"] = 116,["122"] = 116,["123"] = 117,["124"] = 99,["125"] = 120,["126"] = 121,["127"] = 126,["128"] = 126,["129"] = 126,["130"] = 126,["131"] = 126,["132"] = 127,["133"] = 120,["134"] = 130,["135"] = 131,["136"] = 132,["137"] = 137,["138"] = 139,["139"] = 144,["140"] = 144,["141"] = 144,["142"] = 144,["143"] = 144,["144"] = 144,["145"] = 144,["146"] = 144,["147"] = 144,["148"] = 130,["149"] = 155,["150"] = 156,["151"] = 157,["152"] = 158,["154"] = 155,["155"] = 8,["156"] = 7,["157"] = 8});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____projectiles = require("projectiles")
local ProjectileBehavior = ____projectiles.ProjectileBehavior
local ____util = require("util")
local direction2D = ____util.direction2D
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____phantom_basic_attack = require("abilities.heroes.phantom.phantom_basic_attack")
local ModifierPhantomStacks = ____phantom_basic_attack.ModifierPhantomStacks
local PhantomUltimate = __TS__Class()
PhantomUltimate.name = "PhantomUltimate"
__TS__ClassExtends(PhantomUltimate, CustomAbility)
function PhantomUltimate.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_3
end
function PhantomUltimate.prototype.GetPlaybackRateOverride(self)
    if self.caster:HasModifier("modifier_upgrade_phantom_coup_cast_fast") then
        return 1.2
    end
    return 0.7
end
function PhantomUltimate.prototype.GetCastingCrawl(self)
    return 0
end
function PhantomUltimate.prototype.GetCastPoint(self)
    if self.caster:HasModifier("modifier_upgrade_phantom_coup_cast_fast") then
        return 0.3
    end
    return 1
end
function PhantomUltimate.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        self:PlayEffectsOnCastPoint()
        return true
    end
    return false
end
function PhantomUltimate.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    self:StopEffectsOnCastPoint()
end
function PhantomUltimate.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self.caster:GetAverageTrueAttackDamage(self.caster)
    local damageMultiplier = self:GetSpecialValueFor("damage_multiplier")
    local damageMultiplierPerStack = self:GetSpecialValueFor("damage_multiplier_per_stack")
    local ____opt_0 = ModifierPhantomStacks:findOne(self.caster)
    local stacks = ____opt_0 and ____opt_0:GetStackCount() or 0
    self:ProjectileAttack({
        source = self.caster,
        startRadius = self:GetSpecialValueFor("start_hitbox"),
        endRadius = self:GetSpecialValueFor("end_hitbox"),
        effectName = "particles/phantom/phantom_ultimate.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        wallBehavior = ProjectileBehavior.NOTHING,
        isReflectable = false,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            local finalDamage = damage * (damageMultiplier + stacks * damageMultiplierPerStack)
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = finalDamage,
                damage_type = DAMAGE_TYPE_PHYSICAL
            })
            self:PlayEffectsOnCast()
            FindClearSpaceForUnit(
                projectile:getSource(),
                unit:GetAbsOrigin(),
                true
            )
            self:PlayEffectsOnImpact(unit)
        end,
        onFinish = function()
            self:PlayEffectsOnFinish()
        end
    })
    self.caster:RemoveModifierByName(ModifierPhantomStacks.name)
    self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 3)
    self:StopEffectsOnCastPoint()
end
function PhantomUltimate.prototype.PlayEffectsOnFinish(self)
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self.caster)
    EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", self.caster)
end
function PhantomUltimate.prototype.PlayEffectsOnImpact(self, target)
    EmitSoundOn("Hero_PhantomAssassin.Spatter", target)
    EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:SetParticleControlForward(
        particleId,
        1,
        target:GetForwardVector()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
    particleId = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function PhantomUltimate.prototype.PlayEffectsOnCast(self)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function PhantomUltimate.prototype.PlayEffectsOnCastPoint(self)
    EmitGlobalSound("phantom_assassin_phass_ability_coupdegrace_03")
    local particleId = ParticleManager:CreateParticle("particles/econ/items/monkey_king/arcana/water/mk_spring_arcana_water_channel_powertrails.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:ReleaseParticleIndex(particleId)
    self.particleId = ParticleManager:CreateParticle("particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControlEnt(
        self.particleId,
        1,
        self.caster,
        PATTACH_ABSORIGIN_FOLLOW,
        "attach_hitloc",
        self.caster:GetAbsOrigin(),
        false
    )
end
function PhantomUltimate.prototype.StopEffectsOnCastPoint(self)
    if self.particleId then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
PhantomUltimate = __TS__Decorate(
    {registerAbility(nil, "phantom_ultimate")},
    PhantomUltimate
)
return ____exports
