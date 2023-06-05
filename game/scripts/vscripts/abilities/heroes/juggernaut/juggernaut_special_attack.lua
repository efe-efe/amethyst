local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 4,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 10,["24"] = 9,["25"] = 13,["26"] = 14,["27"] = 13,["28"] = 17,["29"] = 18,["30"] = 17,["31"] = 21,["32"] = 22,["33"] = 21,["34"] = 25,["35"] = 26,["36"] = 27,["37"] = 28,["38"] = 29,["39"] = 30,["40"] = 31,["41"] = 32,["42"] = 33,["43"] = 34,["44"] = 36,["45"] = 36,["46"] = 36,["47"] = 36,["48"] = 36,["49"] = 36,["50"] = 36,["51"] = 43,["52"] = 44,["53"] = 44,["54"] = 36,["55"] = 45,["56"] = 46,["57"] = 46,["58"] = 46,["59"] = 46,["60"] = 46,["61"] = 46,["62"] = 52,["63"] = 57,["64"] = 58,["65"] = 59,["68"] = 65,["69"] = 66,["70"] = 66,["71"] = 66,["72"] = 66,["73"] = 66,["74"] = 66,["77"] = 36,["78"] = 70,["79"] = 71,["80"] = 36,["81"] = 36,["82"] = 87,["83"] = 8,["84"] = 25,["85"] = 91,["86"] = 92,["87"] = 93,["88"] = 98,["89"] = 99,["90"] = 91,["91"] = 102,["92"] = 103,["93"] = 104,["94"] = 105,["95"] = 102,["96"] = 8,["97"] = 7,["98"] = 8});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
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
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local damage = self:GetSpecialValueFor("ability_damage")
    local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
    local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local recastTime = self:GetSpecialValueFor("recast_time")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    self:ProjectileAttack({
        source = self.caster,
        velocity = projectileDirection:__mul(projectileSpeed),
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
        effectName = "particles/juggernaut/juggernaut_special_attack.vpcf",
        groundOffset = 0,
        draw = true,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            unit:AddNewModifier(self.caster, self, "modifier_generic_fading_slow", {duration = fading_slow_duration, max_slow_pct = fading_slow_pct})
            if projectile:getSource() == self.caster then
                if self:GetLevel() == 2 then
                    if unit:IsAlive() then
                    end
                end
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
