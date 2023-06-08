local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 6,["22"] = 7,["23"] = 6,["24"] = 7,["25"] = 8,["26"] = 9,["27"] = 8,["28"] = 12,["29"] = 13,["30"] = 7,["32"] = 17,["33"] = 12,["34"] = 20,["35"] = 21,["36"] = 20,["37"] = 24,["38"] = 25,["39"] = 24,["40"] = 28,["41"] = 29,["42"] = 28,["43"] = 32,["44"] = 33,["45"] = 34,["46"] = 35,["47"] = 36,["48"] = 37,["49"] = 39,["51"] = 39,["53"] = 41,["54"] = 41,["55"] = 41,["56"] = 41,["57"] = 41,["58"] = 41,["59"] = 41,["60"] = 48,["61"] = 49,["62"] = 49,["63"] = 41,["64"] = 50,["65"] = 51,["66"] = 51,["67"] = 51,["68"] = 51,["69"] = 51,["70"] = 51,["71"] = 51,["72"] = 51,["73"] = 57,["74"] = 58,["75"] = 59,["76"] = 59,["77"] = 59,["78"] = 59,["79"] = 59,["80"] = 59,["83"] = 41,["84"] = 63,["85"] = 64,["86"] = 41,["87"] = 41,["88"] = 67,["89"] = 32,["90"] = 70,["91"] = 71,["92"] = 70,["93"] = 74,["94"] = 75,["95"] = 76,["96"] = 81,["97"] = 82,["98"] = 74,["99"] = 7,["100"] = 6,["101"] = 7,["103"] = 7,["104"] = 86,["105"] = 87,["106"] = 86,["107"] = 87,["108"] = 88,["109"] = 89,["110"] = 88,["111"] = 92,["112"] = 93,["113"] = 94,["114"] = 95,["116"] = 97,["117"] = 92,["118"] = 87,["119"] = 86,["120"] = 87,["122"] = 87});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_charges = require("modifiers.modifier_charges")
local ModifierCharges = ____modifier_charges.ModifierCharges
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
____exports.SniperBasicAttack = __TS__Class()
local SniperBasicAttack = ____exports.SniperBasicAttack
SniperBasicAttack.name = "SniperBasicAttack"
__TS__ClassExtends(SniperBasicAttack, CustomAbility)
function SniperBasicAttack.prototype.GetIntrinsicModifierName(self)
    return ____exports.ModifierSniperCharges.name
end
function SniperBasicAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return CustomAbility.prototype.GetCastPoint(self) + self.caster:GetAttackAnimationPoint()
    end
    return 0
end
function SniperBasicAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function SniperBasicAttack.prototype.GetPlaybackRateOverride(self)
    return 1.5
end
function SniperBasicAttack.prototype.GetCastingCrawl(self)
    return 10
end
function SniperBasicAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local ____opt_0 = ____exports.ModifierSniperCharges:findOne(self.caster)
    if ____opt_0 ~= nil then
        ____opt_0:ResetCooldown()
    end
    self:ProjectileAttack({
        source = self.caster,
        attackType = "basic",
        effectName = "particles/sniper/sniper_basic_attack.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            attackWithBaseDamage(
                nil,
                {
                    source = projectile:getSource(),
                    target = unit,
                    ability = self
                }
            )
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(
                        nil,
                        projectile:getSource(),
                        manaGainPct,
                        true
                    )
                end
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    self:PlayEffectsOnCast()
end
function SniperBasicAttack.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_Sniper.MKG_attack", self.caster)
end
function SniperBasicAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_Sniper.ProjectileImpact", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/sniper/sniper_basic_attack_explosion.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
SniperBasicAttack = __TS__Decorate(
    {registerAbility(nil, "sniper_basic_attack")},
    SniperBasicAttack
)
____exports.SniperBasicAttack = SniperBasicAttack
____exports.ModifierSniperCharges = __TS__Class()
local ModifierSniperCharges = ____exports.ModifierSniperCharges
ModifierSniperCharges.name = "ModifierSniperCharges"
__TS__ClassExtends(ModifierSniperCharges, ModifierCharges)
function ModifierSniperCharges.prototype.GetMaxCharges(self)
    return self:Value("max_charges")
end
function ModifierSniperCharges.prototype.GetReplenishTime(self)
    if IsServer() then
        local attacksPerSecond = self.parent:GetAttacksPerSecond()
        return 1 / (attacksPerSecond <= 0 and 1 or attacksPerSecond)
    end
    return 0
end
ModifierSniperCharges = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_basic_attack_charges"})},
    ModifierSniperCharges
)
____exports.ModifierSniperCharges = ModifierSniperCharges
return ____exports
