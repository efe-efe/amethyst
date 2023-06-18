local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 118,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 4,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 6,["24"] = 6,["25"] = 8,["26"] = 8,["27"] = 9,["28"] = 10,["29"] = 11,["30"] = 10,["31"] = 14,["32"] = 15,["33"] = 14,["34"] = 18,["35"] = 19,["36"] = 18,["37"] = 22,["38"] = 23,["39"] = 22,["40"] = 26,["41"] = 27,["42"] = 28,["43"] = 29,["44"] = 30,["45"] = 31,["46"] = 32,["47"] = 33,["48"] = 34,["49"] = 35,["50"] = 37,["51"] = 37,["52"] = 37,["53"] = 37,["54"] = 37,["55"] = 37,["56"] = 43,["57"] = 44,["58"] = 44,["59"] = 37,["60"] = 45,["61"] = 46,["62"] = 46,["63"] = 46,["64"] = 46,["65"] = 46,["66"] = 46,["67"] = 52,["68"] = 57,["69"] = 58,["70"] = 59,["71"] = 60,["72"] = 61,["75"] = 69,["76"] = 70,["77"] = 70,["78"] = 70,["79"] = 70,["80"] = 70,["81"] = 70,["84"] = 37,["85"] = 74,["86"] = 75,["87"] = 37,["88"] = 37,["89"] = 91,["90"] = 9,["91"] = 26,["92"] = 95,["93"] = 96,["94"] = 97,["95"] = 102,["96"] = 103,["97"] = 95,["98"] = 106,["99"] = 107,["100"] = 108,["101"] = 109,["102"] = 106,["103"] = 9,["104"] = 8,["105"] = 9,["107"] = 117,["108"] = 117,["109"] = 118,["110"] = 119,["111"] = 120,["112"] = 121,["113"] = 121,["114"] = 122,["115"] = 124,["116"] = 125,["117"] = 126,["118"] = 126,["119"] = 126,["120"] = 126,["122"] = 129,["123"] = 129,["124"] = 129,["125"] = 129,["126"] = 129,["127"] = 130,["128"] = 135,["129"] = 136,["130"] = 137,["131"] = 138,["132"] = 139,["134"] = 119,["135"] = 118,["136"] = 117,["137"] = 118,["139"] = 152,["140"] = 152,["141"] = 153,["142"] = 153,["143"] = 152,["144"] = 153,["146"] = 155,["147"] = 155,["148"] = 156,["149"] = 156,["150"] = 155,["151"] = 156});
local ____exports = {}
local JuggernautSpecialAttackRecast, ModifierJuggernautSpecialAttackRecast, ModifierJuggernautSpecialAttackMark
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
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
                        ModifierJuggernautSpecialAttackMark:apply(self.caster, unit, self, {duration = recastTime})
                        ModifierJuggernautSpecialAttackRecast:apply(self.caster, self.caster, nil, {duration = recastTime, abilityLeft = JuggernautSpecialAttack.name, abilityRight = JuggernautSpecialAttackRecast.name})
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
JuggernautSpecialAttackRecast = __TS__Class()
JuggernautSpecialAttackRecast.name = "JuggernautSpecialAttackRecast"
__TS__ClassExtends(JuggernautSpecialAttackRecast, CustomAbility)
function JuggernautSpecialAttackRecast.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local ____opt_0 = ModifierJuggernautSpecialAttackMark:findOne(self.caster)
    local target = ____opt_0 and ____opt_0.caster
    local randomNumber = RandomInt(1, 9)
    if target then
        if randomNumber > 1 then
            EmitSoundOn(
                "juggernaut_jug_ability_bladefury_0" .. tostring(randomNumber),
                self.caster
            )
        end
        FindClearSpaceForUnit(
            self.caster,
            target:GetAbsOrigin():__add(target:GetForwardVector():__mul(Vector(-80, -80, -80))),
            true
        )
        local particleId = ParticleManager:CreateParticle("particles/juggernaut/special_attack_recast.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particleId, 0, origin)
        ParticleManager:SetParticleControl(particleId, 1, origin)
        ParticleManager:SetParticleControl(particleId, 3, origin)
        ParticleManager:ReleaseParticleIndex(particleId)
        self.caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2)
    end
end
JuggernautSpecialAttackRecast = __TS__Decorate(
    {registerAbility(nil, "juggernaut_special_attack_recast")},
    JuggernautSpecialAttackRecast
)
ModifierJuggernautSpecialAttackRecast = __TS__Class()
ModifierJuggernautSpecialAttackRecast.name = "ModifierJuggernautSpecialAttackRecast"
__TS__ClassExtends(ModifierJuggernautSpecialAttackRecast, ModifierRecast)
ModifierJuggernautSpecialAttackRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_special_attack_recast"})},
    ModifierJuggernautSpecialAttackRecast
)
ModifierJuggernautSpecialAttackMark = __TS__Class()
ModifierJuggernautSpecialAttackMark.name = "ModifierJuggernautSpecialAttackMark"
__TS__ClassExtends(ModifierJuggernautSpecialAttackMark, CustomModifier)
ModifierJuggernautSpecialAttackMark = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_special_attack_mark"})},
    ModifierJuggernautSpecialAttackMark
)
return ____exports
