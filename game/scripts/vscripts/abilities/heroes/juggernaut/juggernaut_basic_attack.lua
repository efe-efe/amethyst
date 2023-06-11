local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 10,["21"] = 11,["22"] = 13,["23"] = 13,["24"] = 14,["25"] = 14,["26"] = 16,["27"] = 17,["28"] = 16,["29"] = 17,["30"] = 18,["31"] = 19,["32"] = 20,["34"] = 22,["35"] = 18,["36"] = 25,["37"] = 26,["38"] = 27,["39"] = 17,["40"] = 25,["41"] = 32,["42"] = 33,["43"] = 32,["44"] = 36,["45"] = 37,["46"] = 36,["47"] = 40,["48"] = 41,["49"] = 40,["50"] = 44,["51"] = 45,["52"] = 44,["53"] = 48,["54"] = 49,["55"] = 51,["56"] = 52,["57"] = 52,["58"] = 52,["59"] = 52,["60"] = 53,["61"] = 58,["62"] = 60,["63"] = 61,["64"] = 62,["65"] = 63,["66"] = 64,["67"] = 65,["68"] = 67,["69"] = 67,["70"] = 67,["71"] = 67,["72"] = 67,["73"] = 67,["74"] = 67,["75"] = 69,["76"] = 69,["77"] = 69,["78"] = 69,["79"] = 69,["80"] = 69,["81"] = 75,["82"] = 76,["83"] = 78,["84"] = 79,["85"] = 80,["87"] = 83,["88"] = 85,["89"] = 86,["90"] = 88,["91"] = 89,["92"] = 90,["95"] = 94,["96"] = 69,["97"] = 69,["98"] = 69,["99"] = 48,["100"] = 100,["101"] = 101,["102"] = 103,["103"] = 104,["104"] = 105,["105"] = 107,["106"] = 108,["108"] = 110,["109"] = 111,["112"] = 100,["113"] = 116,["114"] = 117,["115"] = 121,["116"] = 116,["117"] = 17,["118"] = 16,["119"] = 17,["121"] = 17,["122"] = 125,["123"] = 126,["124"] = 125,["125"] = 126,["127"] = 126,["128"] = 127,["129"] = 125,["130"] = 129,["131"] = 130,["132"] = 129,["133"] = 133,["134"] = 134,["135"] = 133,["136"] = 137,["137"] = 138,["138"] = 137,["139"] = 141,["140"] = 142,["141"] = 141,["142"] = 145,["143"] = 146,["144"] = 147,["146"] = 145,["147"] = 151,["148"] = 152,["149"] = 154,["150"] = 155,["151"] = 157,["152"] = 158,["155"] = 151,["156"] = 163,["157"] = 164,["158"] = 165,["160"] = 163,["161"] = 169,["162"] = 170,["163"] = 170,["164"] = 170,["165"] = 170,["167"] = 172,["168"] = 172,["169"] = 173,["170"] = 173,["171"] = 172,["174"] = 169,["175"] = 183,["176"] = 184,["177"] = 185,["178"] = 186,["180"] = 183,["181"] = 190,["182"] = 191,["183"] = 190,["184"] = 126,["185"] = 125,["186"] = 126,["188"] = 126});
local ____exports = {}
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
____exports.JuggernautBasicAttack = __TS__Class()
local JuggernautBasicAttack = ____exports.JuggernautBasicAttack
JuggernautBasicAttack.name = "JuggernautBasicAttack"
__TS__ClassExtends(JuggernautBasicAttack, CustomAbility)
function JuggernautBasicAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return self.caster:GetAttackAnimationPoint()
    end
    return 0
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
    local origin = self.caster:GetAbsOrigin()
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
                ____exports.ModifierJuggernautStacks:apply(self.caster, self.caster, self, {})
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
____exports.JuggernautBasicAttack = JuggernautBasicAttack
____exports.ModifierJuggernautStacks = __TS__Class()
local ModifierJuggernautStacks = ____exports.ModifierJuggernautStacks
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
____exports.ModifierJuggernautStacks = ModifierJuggernautStacks
return ____exports
