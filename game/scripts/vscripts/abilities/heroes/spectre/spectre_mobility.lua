local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 210,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 6,["22"] = 6,["23"] = 6,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 7,["28"] = 7,["29"] = 8,["30"] = 8,["31"] = 9,["32"] = 9,["33"] = 10,["34"] = 10,["35"] = 12,["36"] = 12,["37"] = 13,["38"] = 14,["39"] = 15,["40"] = 14,["41"] = 18,["42"] = 19,["43"] = 19,["44"] = 20,["46"] = 13,["47"] = 18,["48"] = 25,["49"] = 26,["50"] = 27,["51"] = 28,["52"] = 28,["53"] = 28,["54"] = 28,["55"] = 28,["56"] = 29,["57"] = 29,["58"] = 29,["59"] = 28,["60"] = 28,["61"] = 28,["62"] = 28,["63"] = 32,["64"] = 33,["65"] = 34,["66"] = 36,["67"] = 37,["68"] = 38,["69"] = 39,["70"] = 41,["71"] = 41,["72"] = 41,["73"] = 41,["74"] = 41,["75"] = 41,["76"] = 41,["77"] = 41,["78"] = 41,["79"] = 52,["80"] = 53,["81"] = 53,["82"] = 53,["83"] = 53,["84"] = 53,["85"] = 53,["86"] = 53,["87"] = 53,["88"] = 53,["89"] = 63,["90"] = 64,["91"] = 64,["92"] = 64,["93"] = 64,["94"] = 64,["95"] = 64,["96"] = 64,["98"] = 73,["99"] = 73,["100"] = 73,["101"] = 73,["102"] = 74,["104"] = 74,["106"] = 75,["107"] = 75,["108"] = 75,["109"] = 75,["110"] = 76,["113"] = 79,["114"] = 80,["115"] = 81,["116"] = 81,["117"] = 81,["118"] = 81,["119"] = 81,["120"] = 41,["121"] = 41,["122"] = 85,["123"] = 86,["124"] = 25,["125"] = 95,["126"] = 96,["127"] = 97,["128"] = 102,["129"] = 102,["130"] = 102,["131"] = 102,["132"] = 102,["133"] = 103,["134"] = 103,["135"] = 103,["136"] = 103,["137"] = 103,["138"] = 104,["139"] = 104,["140"] = 104,["141"] = 104,["142"] = 104,["143"] = 105,["144"] = 105,["145"] = 105,["146"] = 105,["147"] = 105,["148"] = 106,["149"] = 95,["150"] = 109,["151"] = 110,["152"] = 110,["153"] = 110,["154"] = 110,["155"] = 110,["156"] = 110,["157"] = 110,["158"] = 110,["159"] = 110,["160"] = 110,["161"] = 115,["162"] = 118,["163"] = 118,["164"] = 118,["165"] = 118,["166"] = 118,["167"] = 118,["168"] = 118,["169"] = 118,["170"] = 118,["171"] = 109,["172"] = 13,["173"] = 12,["174"] = 13,["176"] = 125,["177"] = 125,["178"] = 126,["179"] = 127,["180"] = 128,["181"] = 127,["182"] = 131,["183"] = 132,["184"] = 131,["185"] = 135,["186"] = 136,["187"] = 135,["188"] = 126,["189"] = 125,["190"] = 126,["192"] = 162,["193"] = 162,["194"] = 163,["195"] = 163,["196"] = 162,["197"] = 163,["199"] = 209,["200"] = 209,["201"] = 210,["202"] = 211,["203"] = 212,["204"] = 211,["205"] = 215,["206"] = 216,["207"] = 217,["209"] = 220,["210"] = 215,["211"] = 210,["212"] = 209,["213"] = 210,["215"] = 224,["216"] = 224,["217"] = 225,["218"] = 225,["219"] = 224,["220"] = 225,["222"] = 229,["223"] = 229,["224"] = 230,["225"] = 230,["226"] = 229,["227"] = 230});
local ____exports = {}
local ModifierSpectreMobility, ModifierSpectreMobilityBanish
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ____modifier_charges = require("modifiers.modifier_charges")
local ModifierCharges = ____modifier_charges.ModifierCharges
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____projectiles = require("projectiles")
local ProjectileBehavior = ____projectiles.ProjectileBehavior
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____spectre_basic_attack = require("abilities.heroes.spectre.spectre_basic_attack")
local ModifierSpectreBasicAttack = ____spectre_basic_attack.ModifierSpectreBasicAttack
local ____spectre_ultimate = require("abilities.heroes.spectre.spectre_ultimate")
local ModifierSpectreUltimate = ____spectre_ultimate.ModifierSpectreUltimate
local SpectreMobility = __TS__Class()
SpectreMobility.name = "SpectreMobility"
__TS__ClassExtends(SpectreMobility, CustomAbility)
function SpectreMobility.prototype.GetIntrinsicModifierName(self)
    return ModifierSpectreMobility.name
end
function SpectreMobility.prototype.GetCooldown(self, level)
    local ____opt_0 = ModifierSpectreUltimate:findOne(self.caster)
    if (____opt_0 and ____opt_0.caster) == self.caster then
        return 1
    end
    return CustomAbility.prototype.GetCooldown(self, level)
end
function SpectreMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {
            maxRange = self:GetCastRange(
                Vector(0, 0, 0),
                nil
            ),
            minRange = self:GetSpecialValueFor("min_range")
        }
    )
    local projectileDirection = direction2D(nil, origin, point)
    local projetileDistance = point:__sub(origin):Length2D()
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local damage = self:GetSpecialValueFor("ability_damage")
    local cooldownReduction = self:GetSpecialValueFor("cooldown_reduction")
    local radius = self:GetSpecialValueFor("radius")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
        spawnOrigin = origin:__add(Vector(0, 0, 80)),
        velocity = projectileDirection:__mul(projectileSpeed),
        distance = projetileDistance,
        groundOffset = 0,
        unitBehavior = ProjectileBehavior.NOTHING,
        wallBehavior = ProjectileBehavior.NOTHING,
        onFinish = function(____, projectile)
            local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
                self.caster,
                origin,
                radius,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER
            )
            for ____, enemy in ipairs(enemies) do
                ApplyDamage({
                    victim = enemy,
                    attacker = projectile:getSource(),
                    damage = damage,
                    damage_type = DAMAGE_TYPE_PURE,
                    ability = self
                })
            end
            if __TS__ArraySome(
                enemies,
                function(____, enemy) return not isObstacle(nil, enemy) end
            ) then
                local ____opt_2 = ModifierSpectreBasicAttack:findOne(self.caster)
                if ____opt_2 ~= nil then
                    ____opt_2:ReduceCooldown(cooldownReduction)
                end
                if __TS__ArraySome(
                    enemies,
                    function(____, enemy) return not isGem(nil, enemy) end
                ) then
                    giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
                end
            end
            self:PlayEffectsOnFinish(radius)
            self.caster:RemoveModifierByName(ModifierSpectreMobilityBanish.name)
            FindClearSpaceForUnit(
                self.caster,
                projectile:getPosition(),
                true
            )
        end
    })
    self:PlayEffectsOnCast()
    ModifierSpectreMobilityBanish:apply(self.caster, self.caster, self, {duration = projetileDistance / projectileSpeed})
end
function SpectreMobility.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_Spectre.HauntCast", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        2,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        3,
        Vector(250, 0, 0)
    )
    ParticleManager:SetParticleControl(
        particleId,
        4,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function SpectreMobility.prototype.PlayEffectsOnFinish(self, radius)
    EFX(
        "particles/units/heroes/hero_spectre/spectre_death.vpcf",
        PATTACH_WORLDORIGIN,
        self.caster,
        {
            cp0 = self.caster:GetAbsOrigin(),
            cp3 = self.caster:GetAbsOrigin(),
            release = true
        }
    )
    EFX("particles/sweep_generic/sweep_3.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {release = true})
    EFX(
        "particles/spectre/spectre_mobility.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.caster,
        {
            cp2 = Vector(radius, 1, 1),
            release = true
        }
    )
end
SpectreMobility = __TS__Decorate(
    {registerAbility(nil, "spectre_mobility")},
    SpectreMobility
)
local SpectreExMobility = __TS__Class()
SpectreExMobility.name = "SpectreExMobility"
__TS__ClassExtends(SpectreExMobility, CustomAbility)
function SpectreExMobility.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function SpectreExMobility.prototype.GetPlaybackRateOverride(self)
    return 1
end
function SpectreExMobility.prototype.GetCastingCrawl(self)
    return 0
end
SpectreExMobility = __TS__Decorate(
    {registerAbility(nil, "spectre_ex_mobility")},
    SpectreExMobility
)
local ModifierSpectreMobilityThinker = __TS__Class()
ModifierSpectreMobilityThinker.name = "ModifierSpectreMobilityThinker"
__TS__ClassExtends(ModifierSpectreMobilityThinker, ModifierThinker)
ModifierSpectreMobilityThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_mobility_thinker"})},
    ModifierSpectreMobilityThinker
)
ModifierSpectreMobility = __TS__Class()
ModifierSpectreMobility.name = "ModifierSpectreMobility"
__TS__ClassExtends(ModifierSpectreMobility, ModifierCharges)
function ModifierSpectreMobility.prototype.GetMaxCharges(self)
    return self.ability:GetSpecialValueFor("max_charges")
end
function ModifierSpectreMobility.prototype.GetReplenishTime(self)
    if IsServer() then
        return self.ability:GetCooldown(self.ability:GetLevel())
    end
    return 0
end
ModifierSpectreMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_mobility_charges"})},
    ModifierSpectreMobility
)
local ModifierSpectreExMobility = __TS__Class()
ModifierSpectreExMobility.name = "ModifierSpectreExMobility"
__TS__ClassExtends(ModifierSpectreExMobility, CustomModifier)
ModifierSpectreExMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_ex_mobility_fear"})},
    ModifierSpectreExMobility
)
ModifierSpectreMobilityBanish = __TS__Class()
ModifierSpectreMobilityBanish.name = "ModifierSpectreMobilityBanish"
__TS__ClassExtends(ModifierSpectreMobilityBanish, ModifierBanish)
ModifierSpectreMobilityBanish = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_banish"})},
    ModifierSpectreMobilityBanish
)
return ____exports
