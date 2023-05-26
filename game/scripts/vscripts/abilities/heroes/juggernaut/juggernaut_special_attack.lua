local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 206,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 206,["21"] = 10,["22"] = 10,["23"] = 11,["24"] = 12,["25"] = 13,["26"] = 12,["27"] = 16,["28"] = 17,["29"] = 16,["30"] = 20,["31"] = 21,["32"] = 20,["33"] = 24,["34"] = 25,["35"] = 24,["36"] = 28,["37"] = 29,["38"] = 30,["39"] = 31,["40"] = 32,["41"] = 33,["42"] = 34,["43"] = 35,["44"] = 36,["45"] = 37,["46"] = 39,["47"] = 39,["48"] = 39,["49"] = 39,["50"] = 39,["51"] = 39,["52"] = 39,["53"] = 39,["54"] = 39,["55"] = 39,["56"] = 50,["57"] = 51,["58"] = 57,["59"] = 62,["60"] = 63,["61"] = 64,["65"] = 39,["66"] = 74,["67"] = 75,["68"] = 39,["69"] = 39,["70"] = 91,["71"] = 11,["72"] = 28,["73"] = 95,["74"] = 96,["75"] = 97,["76"] = 102,["77"] = 103,["78"] = 95,["79"] = 106,["80"] = 107,["81"] = 108,["82"] = 109,["83"] = 106,["84"] = 11,["85"] = 10,["86"] = 11,["88"] = 184,["89"] = 184,["91"] = 184,["92"] = 184,["93"] = 186,["94"] = 186,["95"] = 186,["96"] = 187,["97"] = 187,["99"] = 188,["100"] = 189,["101"] = 190,["102"] = 192,["103"] = 192,["104"] = 192,["105"] = 193});
local ____exports = {}
local modifier_juggernaut_special_attack_recast
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____projectiles = require("projectiles")
local ProjectileBehavior = ____projectiles.ProjectileBehavior
local ____util = require("util")
local direction2D = ____util.direction2D
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
function modifier_juggernaut_special_attack_recast(self)
end
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
local ____class_0 = __TS__Class()
____class_0.name = ""
function ____class_0.prototype.____constructor(self)
end
modifier_juggernaut_special_attack_recast = ____class_0(nil, {})
local function modifier_juggernaut_special_attack_recast(self)
end
local ____ = params
if IsServer() then
    local ____ = ____then
end
self.target_index = params.target_index
local ____ = ____end
local ____ = ____end
local function modifier_juggernaut_special_attack_recast(self)
end
local ____ = ____
return self.target_index
