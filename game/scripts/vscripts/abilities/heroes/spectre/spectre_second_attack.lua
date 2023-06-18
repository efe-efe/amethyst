local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 142,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 3,["20"] = 4,["21"] = 4,["22"] = 6,["23"] = 6,["24"] = 7,["25"] = 10,["26"] = 11,["27"] = 10,["28"] = 14,["29"] = 15,["30"] = 14,["31"] = 18,["32"] = 19,["33"] = 18,["34"] = 22,["35"] = 7,["36"] = 24,["37"] = 25,["39"] = 27,["40"] = 22,["41"] = 30,["42"] = 7,["43"] = 32,["44"] = 33,["46"] = 30,["47"] = 37,["48"] = 38,["49"] = 39,["51"] = 42,["52"] = 43,["53"] = 44,["54"] = 45,["55"] = 46,["56"] = 47,["57"] = 49,["58"] = 49,["59"] = 49,["60"] = 49,["61"] = 49,["62"] = 49,["63"] = 55,["64"] = 56,["65"] = 56,["66"] = 49,["67"] = 57,["68"] = 58,["69"] = 59,["70"] = 60,["71"] = 62,["72"] = 63,["74"] = 67,["75"] = 67,["76"] = 67,["77"] = 67,["78"] = 67,["79"] = 67,["80"] = 67,["81"] = 67,["82"] = 67,["84"] = 72,["85"] = 72,["86"] = 72,["87"] = 72,["88"] = 72,["89"] = 72,["90"] = 72,["91"] = 72,["92"] = 72,["93"] = 72,["94"] = 72,["95"] = 72,["96"] = 79,["97"] = 79,["98"] = 79,["99"] = 79,["100"] = 79,["101"] = 79,["102"] = 83,["103"] = 83,["104"] = 83,["105"] = 83,["106"] = 83,["107"] = 83,["108"] = 89,["109"] = 89,["110"] = 89,["111"] = 89,["112"] = 89,["113"] = 89,["114"] = 89,["115"] = 89,["116"] = 89,["117"] = 90,["118"] = 91,["120"] = 49,["121"] = 94,["122"] = 95,["123"] = 96,["124"] = 97,["125"] = 97,["126"] = 97,["127"] = 97,["128"] = 97,["129"] = 97,["130"] = 97,["131"] = 97,["132"] = 97,["134"] = 102,["135"] = 102,["136"] = 102,["137"] = 102,["138"] = 102,["140"] = 104,["142"] = 49,["143"] = 49,["144"] = 108,["145"] = 109,["146"] = 37,["147"] = 112,["148"] = 113,["149"] = 114,["150"] = 119,["151"] = 119,["152"] = 119,["153"] = 119,["154"] = 119,["155"] = 119,["156"] = 119,["157"] = 119,["158"] = 119,["159"] = 112,["160"] = 130,["161"] = 131,["162"] = 132,["163"] = 130,["164"] = 7,["165"] = 6,["166"] = 7,["168"] = 141,["169"] = 141,["170"] = 142,["171"] = 143,["172"] = 144,["173"] = 143,["174"] = 147,["175"] = 148,["176"] = 147,["177"] = 151,["178"] = 152,["179"] = 151,["180"] = 155,["181"] = 156,["182"] = 156,["183"] = 142,["184"] = 156,["185"] = 156,["186"] = 155,["187"] = 142,["188"] = 141,["189"] = 142});
local ____exports = {}
local ModifierSpectreSecondAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local SpectreSecondAttack = __TS__Class()
SpectreSecondAttack.name = "SpectreSecondAttack"
__TS__ClassExtends(SpectreSecondAttack, CustomAbility)
function SpectreSecondAttack.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SpectreSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 0.25
end
function SpectreSecondAttack.prototype.GetCastingCrawl(self)
    return 0
end
function SpectreSecondAttack.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        self:PlayEffectsOnPhase()
        return true
    end
    return false
end
function SpectreSecondAttack.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    if self.particleId then
        DEFX(self.particleId, true)
    end
end
function SpectreSecondAttack.prototype.OnSpellStart(self)
    if self.particleId then
        DEFX(self.particleId, false)
    end
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/spectre/spectre_second_attack.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            local knockbackDistance = self:GetLevel() >= 2 and 100 or 75
            local fadingSlowDuration = self:GetLevel() >= 2 and 0.7 or 0.5
            local fadingSlowPct = 100
            if self:GetLevel() >= 2 then
                EFX("particles/spectre/spectre_second_attack_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
            else
                EFX(
                    "particles/spectre/spectre_second_attack_impact.vpcf",
                    PATTACH_ABSORIGIN_FOLLOW,
                    unit,
                    {
                        cp1 = unit:GetAbsOrigin(),
                        release = true
                    }
                )
            end
            ModifierSpectreSecondAttack:apply(
                unit,
                projectile:getSource(),
                self,
                {
                    x = projectile:getVelocity():Normalized().x,
                    y = projectile:getVelocity():Normalized().y,
                    distance = knockbackDistance,
                    speed = knockbackDistance / 0.125,
                    peak = 0
                }
            )
            unit:AddNewModifier(
                projectile:getSource(),
                self,
                "modifier_generic_fading_slow",
                {duration = fadingSlowDuration, max_slow_pct = fadingSlowPct}
            )
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            ScreenShake(
                unit:GetAbsOrigin(),
                100,
                300,
                0.7,
                1000,
                0,
                true
            )
            if not isObstacle(nil, unit) and not isGem(nil, unit) then
                giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
            end
        end,
        onFinish = function(____, projectile)
            if self:GetLevel() >= 2 then
                if projectile.hitLog.size == 0 then
                    EFX(
                        "particles/spectre/spectre_second_attack_explosion.vpcf",
                        PATTACH_WORLDORIGIN,
                        nil,
                        {
                            cp0 = projectile:getPosition(),
                            release = true
                        }
                    )
                end
                EmitSoundOnLocationWithCaster(
                    projectile:getPosition(),
                    "Hero_Nevermore.Attack",
                    self.caster
                )
            else
                self:PlayEffectsOnFinish(projectile:getPosition())
            end
        end
    })
    self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
    EmitSoundOn("Hero_Nevermore.Raze_Flames", self.caster)
end
function SpectreSecondAttack.prototype.PlayEffectsOnPhase(self)
    EmitSoundOn("Hero_Spectre.Haunt", self.caster)
    self.particleId = ParticleManager:CreateParticle("particles/spectre/spectre_second_attack_casting.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
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
function SpectreSecondAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.RequiemOfSouls.Damage", self.caster)
    EFX("particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf", PATTACH_ABSORIGIN, self.caster, {cp0 = position, cp1 = position, cp2 = position, release = true})
end
SpectreSecondAttack = __TS__Decorate(
    {registerAbility(nil, "spectre_second_attack")},
    SpectreSecondAttack
)
ModifierSpectreSecondAttack = __TS__Class()
ModifierSpectreSecondAttack.name = "ModifierSpectreSecondAttack"
__TS__ClassExtends(ModifierSpectreSecondAttack, ModifierDisplacement)
function ModifierSpectreSecondAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierSpectreSecondAttack.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierSpectreSecondAttack.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierSpectreSecondAttack.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
ModifierSpectreSecondAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_second_attack_displacement"})},
    ModifierSpectreSecondAttack
)
return ____exports
