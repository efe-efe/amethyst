local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 124,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 4,["16"] = 5,["17"] = 6,["18"] = 7,["19"] = 8,["20"] = 9,["21"] = 10,["22"] = 11,["23"] = 13,["24"] = 13,["25"] = 14,["26"] = 14,["27"] = 16,["28"] = 16,["29"] = 17,["30"] = 18,["31"] = 19,["32"] = 18,["33"] = 22,["34"] = 23,["35"] = 24,["36"] = 17,["37"] = 22,["38"] = 29,["39"] = 30,["40"] = 29,["41"] = 33,["42"] = 34,["43"] = 33,["44"] = 37,["45"] = 38,["46"] = 37,["47"] = 41,["48"] = 42,["49"] = 41,["50"] = 45,["51"] = 46,["52"] = 48,["53"] = 50,["54"] = 50,["55"] = 50,["56"] = 50,["57"] = 51,["58"] = 56,["59"] = 58,["60"] = 59,["61"] = 60,["62"] = 61,["63"] = 62,["64"] = 63,["65"] = 65,["66"] = 65,["67"] = 65,["68"] = 65,["69"] = 65,["70"] = 65,["71"] = 65,["72"] = 67,["73"] = 67,["74"] = 67,["75"] = 67,["76"] = 67,["77"] = 67,["78"] = 73,["79"] = 74,["80"] = 76,["81"] = 77,["82"] = 78,["84"] = 81,["85"] = 83,["86"] = 84,["87"] = 86,["88"] = 87,["89"] = 88,["92"] = 92,["93"] = 67,["94"] = 67,["95"] = 67,["96"] = 45,["97"] = 98,["98"] = 99,["99"] = 101,["100"] = 102,["101"] = 103,["102"] = 105,["103"] = 106,["105"] = 108,["106"] = 109,["109"] = 98,["110"] = 114,["111"] = 115,["112"] = 119,["113"] = 114,["114"] = 17,["115"] = 16,["116"] = 17,["118"] = 123,["119"] = 123,["120"] = 124,["122"] = 124,["123"] = 125,["124"] = 123,["125"] = 127,["126"] = 128,["127"] = 127,["128"] = 131,["129"] = 132,["130"] = 131,["131"] = 135,["132"] = 136,["133"] = 135,["134"] = 139,["135"] = 140,["136"] = 139,["137"] = 143,["138"] = 144,["139"] = 145,["141"] = 143,["142"] = 149,["143"] = 150,["144"] = 152,["145"] = 153,["146"] = 155,["147"] = 156,["150"] = 149,["151"] = 161,["152"] = 162,["153"] = 163,["155"] = 161,["156"] = 167,["157"] = 168,["158"] = 168,["159"] = 168,["160"] = 168,["162"] = 170,["163"] = 170,["164"] = 171,["165"] = 171,["166"] = 170,["169"] = 167,["170"] = 181,["171"] = 182,["172"] = 183,["173"] = 184,["175"] = 181,["176"] = 188,["177"] = 189,["178"] = 188,["179"] = 124,["180"] = 123,["181"] = 124});
local ____exports = {}
local ModifierJuggernautStacks
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local meeleEFX = ____util.meeleEFX
local replenishEFX = ____util.replenishEFX
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local JuggernautBasicAttack = __TS__Class()
JuggernautBasicAttack.name = "JuggernautBasicAttack"
__TS__ClassExtends(JuggernautBasicAttack, CustomAbility)
function JuggernautBasicAttack.prototype.GetCastPoint(self)
    return self.caster:GetAttackAnimationPoint()
end
function JuggernautBasicAttack.prototype.GetCooldown(self, level)
    local attacksPerSecond = self.caster:GetAttacksPerSecond()
    local attackSpeed = 1 / attacksPerSecond
    return CustomAbility.prototype.GetCooldown(self, level) + attackSpeed
end
function JuggernautBasicAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK_EVENT
end
function JuggernautBasicAttack.prototype.GetPlaybackRateOverride(self)
    return 1.2
end
function JuggernautBasicAttack.prototype.GetAnimationTranslate(self)
    return Translate.odachi
end
function JuggernautBasicAttack.prototype.GetCastPointSpeed(self)
    return self:GetSpecialValueFor("cast_point_speed_pct")
end
function JuggernautBasicAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange, minRange = castRange})
    local meeleExtraRadius = 0
    local radius = self:GetSpecialValueFor("radius") + meeleExtraRadius
    local cooldownReduction = self:GetSpecialValueFor("cooldown_reduction")
    local cooldownReductionCounter = self:GetSpecialValueFor("cooldown_reduction_counter")
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local direction = direction2D(nil, origin, point)
    local modifier = self.caster:FindModifierByName("modifier_juggernaut_ex_counter")
    meeleEFX(
        nil,
        self.caster,
        direction,
        radius,
        modifier and Vector(0, 255, 0) or nil
    )
    self:MeeleAttack({
        direction = direction,
        origin = origin,
        radius = radius,
        maxTargets = 1,
        attackType = "basic",
        effect = function(____, target)
            attackWithBaseDamage(nil, {source = self.caster, target = target})
            if not isObstacle(nil, target) then
                if not isGem(nil, target) then
                    giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
                end
                ModifierJuggernautStacks:apply(self.caster, self.caster, self, {})
                self:ReduceCooldown("juggernaut_second_attack", cooldownReduction)
                self:ReduceCooldown("juggernaut_ex_second_attack", cooldownReduction)
                if self:GetLevel() >= 2 then
                    self:ReduceCooldown("juggernaut_counter", cooldownReductionCounter)
                    self:ReduceCooldown("juggernaut_ex_counter", cooldownReductionCounter)
                end
            end
            self:PlayEffectsOnImpact(target)
        end,
        baseSound = "Hero_Juggernaut.PreAttack"
    })
end
function JuggernautBasicAttack.prototype.ReduceCooldown(self, abilityName, cooldownReduction)
    local ability = self.caster:FindAbilityByName(abilityName)
    if ability then
        local abilityCooldown = ability:GetCooldownTimeRemaining()
        local newCooldown = abilityCooldown - cooldownReduction
        if newCooldown < 0 then
            ability:EndCooldown()
        else
            ability:EndCooldown()
            ability:StartCooldown(newCooldown)
        end
    end
end
function JuggernautBasicAttack.prototype.PlayEffectsOnImpact(self, target)
    EFX("particles/juggernaut/juggernaut_basic_attack_impact.vpcf", PATTACH_ABSORIGIN, target, {release = true})
    EmitSoundOn("Hero_Juggernaut.Attack", target)
end
JuggernautBasicAttack = __TS__Decorate(
    {registerAbility(nil, "juggernaut_basic_attack")},
    JuggernautBasicAttack
)
ModifierJuggernautStacks = __TS__Class()
ModifierJuggernautStacks.name = "ModifierJuggernautStacks"
__TS__ClassExtends(ModifierJuggernautStacks, CustomModifier)
function ModifierJuggernautStacks.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.particleIds = {}
end
function ModifierJuggernautStacks.prototype.IsHidden(self)
    return false
end
function ModifierJuggernautStacks.prototype.IsDebuff(self)
    return false
end
function ModifierJuggernautStacks.prototype.IsStunDebuff(self)
    return false
end
function ModifierJuggernautStacks.prototype.IsPurgable(self)
    return true
end
function ModifierJuggernautStacks.prototype.OnCreated(self)
    if IsServer() then
        self:SetStackCount(1)
    end
end
function ModifierJuggernautStacks.prototype.OnRefresh(self)
    local maxStacks = self:Value("max_stacks")
    if IsServer() and self:GetStackCount() < maxStacks then
        self:IncrementStackCount()
        if self:GetStackCount() == maxStacks then
            self:PlayEffectsCharged()
        end
    end
end
function ModifierJuggernautStacks.prototype.OnDestroy(self)
    if IsServer() then
        self:StopEffects()
    end
end
function ModifierJuggernautStacks.prototype.PlayEffectsCharged(self)
    replenishEFX(
        nil,
        self:GetParent()
    )
    do
        local i = 0
        while i < 5 do
            local ____self_particleIds_0 = self.particleIds
            ____self_particleIds_0[#____self_particleIds_0 + 1] = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
            i = i + 1
        end
    end
end
function ModifierJuggernautStacks.prototype.StopEffects(self)
    for ____, particleId in ipairs(self.particleIds) do
        ParticleManager:DestroyParticle(particleId, false)
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function ModifierJuggernautStacks.prototype.GetTexture(self)
    return "juggernaut_blade_dance"
end
ModifierJuggernautStacks = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_basic_attack_stacks"})},
    ModifierJuggernautStacks
)
return ____exports
