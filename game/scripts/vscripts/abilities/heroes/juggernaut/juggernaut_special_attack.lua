local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 7,["22"] = 7,["23"] = 8,["24"] = 9,["25"] = 10,["26"] = 9,["27"] = 13,["28"] = 14,["29"] = 13,["30"] = 17,["31"] = 18,["32"] = 17,["33"] = 21,["34"] = 22,["35"] = 21,["36"] = 25,["37"] = 26,["38"] = 27,["39"] = 28,["40"] = 29,["41"] = 30,["42"] = 31,["43"] = 32,["44"] = 33,["45"] = 34,["46"] = 36,["47"] = 36,["48"] = 36,["49"] = 36,["50"] = 36,["51"] = 36,["52"] = 36,["53"] = 36,["54"] = 36,["55"] = 36,["56"] = 46,["57"] = 47,["58"] = 53,["59"] = 58,["60"] = 59,["61"] = 60,["64"] = 66,["65"] = 67,["68"] = 36,["69"] = 71,["70"] = 72,["71"] = 36,["72"] = 36,["73"] = 88,["74"] = 8,["75"] = 25,["76"] = 92,["77"] = 93,["78"] = 94,["79"] = 99,["80"] = 100,["81"] = 92,["82"] = 103,["83"] = 104,["84"] = 105,["85"] = 106,["86"] = 103,["87"] = 8,["88"] = 7,["89"] = 8});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____projectiles = require("projectiles")
local ProjectileBehavior = ____projectiles.ProjectileBehavior
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local JuggernautSpecialAttack = __TS__Class()
JuggernautSpecialAttack.name = "JuggernautSpecialAttack"
__TS__ClassExtends(JuggernautSpecialAttack, CustomAbility)
function JuggernautSpecialAttack.prototype.GetAnimation(self)
    return ACT_DOTA_TAUNT
end
function JuggernautSpecialAttack.prototype.GetPlaybackRateOverride(self)
    return 2
end
function JuggernautSpecialAttack.prototype.GetCastingCrawl(self)
    return 10
end
function JuggernautSpecialAttack.prototype.GetAnimationTranslate(self)
    return Translate.odachi
end
function JuggernautSpecialAttack.prototype.OnSpellStart(self)
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = self.caster:GetAbsOrigin()
    local damage = self:GetSpecialValueFor("ability_damage")
    local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
    local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local recastTime = self:GetSpecialValueFor("recast_time")
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    local projectile_direction = direction2D(nil, origin, point)
    self:ProjectileAttack({
        source = self.caster,
        velocity = projectile_direction:__mul(projectile_speed),
        spawnOrigin = origin:__add(Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96)),
        effectName = "particles/juggernaut/juggernaut_special_attack.vpcf",
        treeBehavior = ProjectileBehavior.NOTHING,
        groundBehavior = ProjectileBehavior.NOTHING,
        groundOffset = 0,
        draw = true,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(projectile.source, unit) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({victim = unit, attacker = projectile.source, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
            unit:AddNewModifier(self.caster, self, "modifier_generic_fading_slow", {duration = fading_slow_duration, max_slow_pct = fading_slow_pct})
            if projectile.source == self.caster then
                if self:GetLevel() == 2 then
                    if unit:IsAlive() then
                    end
                end
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(nil, projectile.source, manaGainPct, true)
                end
            end
        end,
        onFinish = function(____, position)
            self:PlayEffectsOnFinish(position)
        end
    })
    self:PlayEffectsOnCast()
    CustomAbility.prototype.OnSpellStart(self)
end
function JuggernautSpecialAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_Juggernaut.Attack", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_impact_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function JuggernautSpecialAttack.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("juggernaut_jug_spawn_02", self.caster)
    EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", self.caster)
    EmitSoundOn("Hero_Juggernaut.BladeDance", self.caster)
end
JuggernautSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "juggernaut_special_attack")},
    JuggernautSpecialAttack
)
return ____exports
