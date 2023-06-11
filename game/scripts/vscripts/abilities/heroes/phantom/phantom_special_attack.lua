local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 139,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 5,["24"] = 5,["25"] = 5,["26"] = 7,["27"] = 7,["28"] = 8,["29"] = 9,["30"] = 10,["31"] = 9,["32"] = 13,["33"] = 14,["34"] = 13,["35"] = 17,["36"] = 18,["37"] = 17,["38"] = 21,["39"] = 22,["40"] = 21,["41"] = 25,["42"] = 26,["43"] = 25,["44"] = 29,["45"] = 30,["46"] = 31,["47"] = 32,["48"] = 33,["50"] = 8,["52"] = 29,["53"] = 39,["54"] = 40,["55"] = 41,["56"] = 42,["57"] = 43,["58"] = 45,["59"] = 46,["60"] = 46,["61"] = 46,["62"] = 46,["63"] = 46,["64"] = 47,["65"] = 47,["66"] = 47,["67"] = 47,["68"] = 47,["70"] = 50,["71"] = 51,["73"] = 54,["74"] = 39,["75"] = 57,["76"] = 58,["77"] = 59,["78"] = 61,["79"] = 62,["80"] = 64,["81"] = 65,["82"] = 66,["83"] = 68,["84"] = 69,["85"] = 70,["86"] = 72,["87"] = 72,["88"] = 72,["89"] = 72,["90"] = 72,["91"] = 72,["92"] = 72,["93"] = 79,["94"] = 80,["95"] = 80,["96"] = 72,["97"] = 81,["98"] = 82,["99"] = 89,["100"] = 90,["101"] = 91,["102"] = 92,["103"] = 92,["104"] = 92,["105"] = 92,["106"] = 92,["107"] = 92,["109"] = 95,["110"] = 96,["114"] = 101,["115"] = 102,["116"] = 102,["117"] = 102,["118"] = 102,["119"] = 102,["120"] = 102,["122"] = 108,["123"] = 109,["124"] = 109,["125"] = 109,["126"] = 109,["127"] = 109,["128"] = 109,["130"] = 72,["131"] = 114,["132"] = 115,["133"] = 72,["134"] = 72,["135"] = 57,["136"] = 126,["137"] = 127,["138"] = 128,["139"] = 133,["140"] = 134,["141"] = 126,["142"] = 8,["143"] = 7,["144"] = 8,["146"] = 138,["147"] = 138,["148"] = 139,["149"] = 140,["150"] = 141,["151"] = 140,["152"] = 144,["153"] = 145,["154"] = 146,["156"] = 149,["157"] = 144,["158"] = 139,["159"] = 138,["160"] = 139});
local ____exports = {}
local ModifierPhantomSpecialAttackCharges
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_charges = require("modifiers.modifier_charges")
local ModifierCharges = ____modifier_charges.ModifierCharges
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____phantom_basic_attack = require("abilities.heroes.phantom.phantom_basic_attack")
local ModifierPhantomBleed = ____phantom_basic_attack.ModifierPhantomBleed
local ModifierPhantomStacks = ____phantom_basic_attack.ModifierPhantomStacks
local PhantomBasicAttack = ____phantom_basic_attack.PhantomBasicAttack
local PhantomExBasicAttack = ____phantom_basic_attack.PhantomExBasicAttack
local PhantomSpecialAttack = __TS__Class()
PhantomSpecialAttack.name = "PhantomSpecialAttack"
__TS__ClassExtends(PhantomSpecialAttack, CustomAbility)
function PhantomSpecialAttack.prototype.GetIntrinsicModifierName(self)
    return ModifierPhantomSpecialAttackCharges.name
end
function PhantomSpecialAttack.prototype.GetAnimation(self)
    return ACT_DOTA_TELEPORT_END
end
function PhantomSpecialAttack.prototype.GetPlaybackRateOverride(self)
    return 2
end
function PhantomSpecialAttack.prototype.GetCastingCrawl(self)
    return 80
end
function PhantomSpecialAttack.prototype.GetFadeGestureOnCast(self)
    return false
end
function PhantomSpecialAttack.prototype.GetCooldown(self, level)
    if self.caster:HasModifier("modifier_upgrade_phantom_fast_daggers") then
        local attacksPerSecond = self.caster:GetAttacksPerSecond()
        local attackSpeed = 1 / attacksPerSecond
        return attackSpeed * 2
    else
        return CustomAbility.prototype.GetCooldown(self, level)
    end
end
function PhantomSpecialAttack.prototype.OnSpellStart(self)
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = self.caster:GetAbsOrigin()
    local straightDirection = direction2D(nil, origin, point)
    local directions = {straightDirection}
    if self.caster:HasModifier("modifier_upgrade_phantom_extra_daggers") then
        directions[#directions + 1] = RotatePoint(
            Vector(0, 0, 0),
            straightDirection,
            -30
        ):Normalized()
        directions[#directions + 1] = RotatePoint(
            Vector(0, 0, 0),
            straightDirection,
            30
        ):Normalized()
    end
    for ____, direction in ipairs(directions) do
        self:ThrowProjectile(origin, direction)
    end
    EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self.caster)
end
function PhantomSpecialAttack.prototype.ThrowProjectile(self, origin, direction)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local phantomBasicAttack = self.caster:FindAbilityByName(PhantomBasicAttack.name)
    local phantomExBasicAttack = self.caster:FindAbilityByName(PhantomExBasicAttack.name)
    local bleedDuration = phantomExBasicAttack and phantomExBasicAttack:GetSpecialValueFor("bleed_duration") or 0
    local fadingSlowPct = phantomExBasicAttack and phantomExBasicAttack:GetSpecialValueFor("fading_slow_pct") or 0
    local fadingSlowDuration = phantomExBasicAttack and phantomExBasicAttack:GetSpecialValueFor("fading_slow_duration") or 0
    local damageModifier = self:GetSpecialValueFor("damage_modifier")
    local damage = self.caster:GetAverageTrueAttackDamage(self.caster)
    local finalDamage = damage + damageModifier
    self:ProjectileAttack({
        source = self.caster,
        attackType = "basic",
        effectName = "particles/phantom/phantom_special_attack.vpcf",
        spawnOrigin = origin:__add(Vector(direction.x * 30, direction.y * 30, 96)),
        velocity = direction:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({victim = unit, attacker = self.caster, damage = finalDamage, damage_type = DAMAGE_TYPE_PHYSICAL})
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) then
                    if not isGem(nil, unit) then
                        giveManaAndEnergyPercent(
                            nil,
                            projectile:getSource(),
                            manaGainPct,
                            true
                        )
                    end
                    if phantomBasicAttack then
                        ModifierPhantomStacks:apply(self.caster, self.caster, phantomBasicAttack, {})
                    end
                end
            end
            if not projectile:getSource():HasModifier("modifier_upgrade_phantom_fast_daggers") then
                unit:AddNewModifier(
                    projectile:getSource(),
                    self,
                    "modifier_generic_fading_slow",
                    {duration = fadingSlowDuration, max_slow_pct = fadingSlowPct}
                )
            end
            if self:GetLevel() >= 2 then
                ModifierPhantomBleed:apply(
                    unit,
                    projectile:getSource(),
                    phantomExBasicAttack,
                    {duration = bleedDuration}
                )
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
end
function PhantomSpecialAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/phantom/phantom_special_attack_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
PhantomSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "phantom_special_attack")},
    PhantomSpecialAttack
)
ModifierPhantomSpecialAttackCharges = __TS__Class()
ModifierPhantomSpecialAttackCharges.name = "ModifierPhantomSpecialAttackCharges"
__TS__ClassExtends(ModifierPhantomSpecialAttackCharges, ModifierCharges)
function ModifierPhantomSpecialAttackCharges.prototype.GetMaxCharges(self)
    return self.caster:HasModifier("modifier_upgrade_phantom_fast_daggers") and 1 or self:Value("max_charges")
end
function ModifierPhantomSpecialAttackCharges.prototype.GetReplenishTime(self)
    if IsServer() then
        return self.ability:GetCooldown(self.ability:GetLevel())
    end
    return 0
end
ModifierPhantomSpecialAttackCharges = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_special_attack_charges"})},
    ModifierPhantomSpecialAttackCharges
)
return ____exports
