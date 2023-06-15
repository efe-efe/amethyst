local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 2,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 7,["22"] = 7,["23"] = 8,["24"] = 9,["25"] = 10,["26"] = 9,["27"] = 13,["28"] = 14,["29"] = 13,["30"] = 17,["31"] = 18,["32"] = 17,["33"] = 21,["34"] = 22,["35"] = 23,["36"] = 24,["37"] = 25,["38"] = 26,["39"] = 27,["40"] = 28,["41"] = 30,["42"] = 30,["43"] = 30,["44"] = 30,["45"] = 30,["46"] = 30,["47"] = 36,["48"] = 37,["49"] = 37,["50"] = 30,["51"] = 38,["52"] = 39,["53"] = 39,["54"] = 39,["55"] = 39,["56"] = 39,["57"] = 39,["58"] = 39,["59"] = 47,["60"] = 48,["61"] = 48,["62"] = 48,["63"] = 48,["64"] = 48,["65"] = 48,["66"] = 49,["67"] = 51,["68"] = 52,["69"] = 57,["71"] = 60,["72"] = 61,["73"] = 62,["74"] = 62,["75"] = 62,["76"] = 62,["77"] = 62,["78"] = 62,["79"] = 64,["80"] = 65,["82"] = 65,["87"] = 30,["88"] = 70,["89"] = 71,["90"] = 30,["91"] = 30,["92"] = 75,["93"] = 21,["94"] = 78,["95"] = 79,["96"] = 84,["97"] = 85,["98"] = 86,["99"] = 78,["100"] = 8,["101"] = 7,["102"] = 8});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____puck_basic_attack = require("abilities.heroes.puck.puck_basic_attack")
local ModifierPuckFairyDust = ____puck_basic_attack.ModifierPuckFairyDust
local ____puck_special_attack = require("abilities.heroes.puck.puck_special_attack")
local PuckSpecialAttack = ____puck_special_attack.PuckSpecialAttack
local PuckSecondAttack = __TS__Class()
PuckSecondAttack.name = "PuckSecondAttack"
__TS__ClassExtends(PuckSecondAttack, CustomAbility)
function PuckSecondAttack.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function PuckSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckSecondAttack.prototype.GetCastingCrawl(self)
    return 10
end
function PuckSecondAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local silenceDuration = self:GetSpecialValueFor("silence_duration")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/puck/puck_second_attack_projectile.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self
            })
            if ModifierPuckFairyDust:findOne(unit) then
                unit:AddNewModifier(
                    projectile:getSource(),
                    self,
                    "modifier_generic_silence",
                    {duration = silenceDuration}
                )
                unit:RemoveModifierByName(ModifierPuckFairyDust.name)
                EmitSoundOn("Hero_Puck.EtherealJaunt", unit)
                local particleId = ParticleManager:CreateParticle("particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                ParticleManager:ReleaseParticleIndex(particleId)
            end
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(
                        nil,
                        projectile:getSource(),
                        manaGainPct,
                        true
                    )
                    if self:GetLevel() >= 2 then
                        local ____opt_0 = PuckSpecialAttack:findOne(self.caster)
                        if ____opt_0 ~= nil then
                            ____opt_0:EndCooldown()
                        end
                    end
                end
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", self.caster)
end
function PuckSecondAttack.prototype.PlayEffectsOnFinish(self, position)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
PuckSecondAttack = __TS__Decorate(
    {registerAbility(nil, "puck_second_attack")},
    PuckSecondAttack
)
return ____exports
