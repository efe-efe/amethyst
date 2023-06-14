local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 88,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 7,["24"] = 8,["25"] = 7,["26"] = 8,["27"] = 9,["28"] = 10,["29"] = 9,["30"] = 13,["31"] = 14,["32"] = 13,["33"] = 17,["34"] = 18,["35"] = 17,["36"] = 21,["37"] = 22,["38"] = 21,["39"] = 25,["40"] = 26,["41"] = 27,["42"] = 28,["43"] = 29,["44"] = 30,["45"] = 31,["46"] = 32,["47"] = 34,["48"] = 34,["49"] = 34,["50"] = 34,["51"] = 34,["52"] = 34,["53"] = 40,["54"] = 41,["55"] = 41,["56"] = 34,["57"] = 42,["58"] = 43,["59"] = 43,["60"] = 43,["61"] = 43,["62"] = 43,["63"] = 43,["64"] = 43,["65"] = 51,["66"] = 52,["67"] = 53,["68"] = 53,["69"] = 53,["70"] = 53,["71"] = 53,["72"] = 53,["73"] = 55,["77"] = 62,["78"] = 63,["79"] = 63,["80"] = 63,["81"] = 63,["82"] = 63,["83"] = 63,["85"] = 34,["86"] = 66,["87"] = 67,["88"] = 34,["89"] = 34,["90"] = 70,["91"] = 25,["92"] = 73,["93"] = 74,["94"] = 75,["95"] = 76,["96"] = 81,["97"] = 82,["98"] = 83,["99"] = 73,["100"] = 8,["101"] = 7,["102"] = 8,["104"] = 8,["105"] = 87,["106"] = 87,["107"] = 88,["108"] = 89,["109"] = 90,["110"] = 91,["112"] = 89,["113"] = 95,["114"] = 96,["115"] = 96,["116"] = 96,["117"] = 96,["118"] = 96,["119"] = 96,["120"] = 102,["121"] = 103,["122"] = 106,["123"] = 106,["124"] = 106,["125"] = 106,["126"] = 106,["127"] = 106,["128"] = 95,["129"] = 88,["130"] = 87,["131"] = 88});
local ____exports = {}
local ModifierStormSecondAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
____exports.StormSecondAttack = __TS__Class()
local StormSecondAttack = ____exports.StormSecondAttack
StormSecondAttack.name = "StormSecondAttack"
__TS__ClassExtends(StormSecondAttack, CustomAbility)
function StormSecondAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function StormSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 1.5
end
function StormSecondAttack.prototype.GetCastingCrawl(self)
    return 10
end
function StormSecondAttack.prototype.GetAnimationTranslate(self)
    return Translate.overload
end
function StormSecondAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local duration = self:GetSpecialValueFor("duration")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/storm/storm_second_attack.vpcf",
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
                attacker = self.caster,
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self
            })
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(
                        nil,
                        projectile:getSource(),
                        manaGainPct,
                        true
                    )
                    if self.caster:HasModifier("modifier_storm_ultimate") then
                    end
                end
            end
            if self:GetLevel() >= 2 then
                ModifierStormSecondAttack:apply(
                    unit,
                    projectile:getSource(),
                    self,
                    {duration = duration}
                )
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("Hero_StormSpirit.Attack", self.caster)
end
function StormSecondAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", self.caster)
    EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/storm/storm_basic_attack_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
StormSecondAttack = __TS__Decorate(
    {registerAbility(nil, "storm_second_attack")},
    StormSecondAttack
)
____exports.StormSecondAttack = StormSecondAttack
ModifierStormSecondAttack = __TS__Class()
ModifierStormSecondAttack.name = "ModifierStormSecondAttack"
__TS__ClassExtends(ModifierStormSecondAttack, CustomModifier)
function ModifierStormSecondAttack.prototype.OnCreated(self)
    if IsServer() then
        self:StartIntervalThink(self:Value("think_interval"))
    end
end
function ModifierStormSecondAttack.prototype.OnIntervalThink(self)
    ApplyDamage({
        attacker = self.parent,
        damage = self:Value("damage_per_tick"),
        damage_type = DAMAGE_TYPE_PURE,
        victim = self.parent
    })
    EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.parent)
    EFX("particles/econ/events/ti9/shivas_guard_ti9_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {release = true})
    self.parent:AddNewModifier(
        self.parent,
        self.ability,
        "modifier_generic_stunned",
        {duration = self:Value("stun_duration")}
    )
end
ModifierStormSecondAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_second_attack"})},
    ModifierStormSecondAttack
)
return ____exports
