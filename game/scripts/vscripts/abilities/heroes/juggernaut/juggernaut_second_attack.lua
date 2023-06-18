local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 3,["20"] = 3,["21"] = 3,["22"] = 3,["23"] = 4,["24"] = 4,["25"] = 5,["26"] = 5,["27"] = 6,["28"] = 6,["29"] = 6,["30"] = 8,["31"] = 8,["32"] = 9,["33"] = 12,["34"] = 9,["35"] = 14,["36"] = 20,["37"] = 12,["38"] = 23,["39"] = 9,["40"] = 25,["41"] = 23,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["51"] = 30,["52"] = 28,["53"] = 33,["54"] = 34,["55"] = 33,["56"] = 37,["57"] = 38,["58"] = 37,["59"] = 41,["60"] = 42,["61"] = 41,["62"] = 45,["63"] = 46,["64"] = 53,["65"] = 45,["66"] = 56,["67"] = 57,["68"] = 58,["69"] = 59,["70"] = 59,["71"] = 59,["72"] = 59,["74"] = 62,["75"] = 63,["76"] = 63,["77"] = 63,["78"] = 63,["79"] = 64,["80"] = 65,["81"] = 66,["82"] = 67,["83"] = 69,["84"] = 70,["85"] = 72,["86"] = 73,["87"] = 75,["88"] = 76,["89"] = 78,["90"] = 79,["91"] = 79,["92"] = 81,["93"] = 83,["94"] = 85,["95"] = 86,["96"] = 87,["97"] = 87,["98"] = 88,["99"] = 88,["100"] = 88,["101"] = 88,["102"] = 92,["103"] = 93,["104"] = 88,["105"] = 87,["106"] = 87,["107"] = 98,["108"] = 99,["110"] = 101,["111"] = 101,["112"] = 102,["113"] = 102,["114"] = 102,["115"] = 102,["116"] = 106,["117"] = 107,["118"] = 102,["119"] = 101,["120"] = 101,["121"] = 112,["123"] = 115,["124"] = 115,["125"] = 115,["126"] = 115,["127"] = 116,["128"] = 116,["129"] = 116,["130"] = 116,["131"] = 118,["132"] = 119,["134"] = 122,["135"] = 123,["136"] = 124,["138"] = 139,["139"] = 56,["140"] = 143,["141"] = 144,["142"] = 148,["143"] = 149,["144"] = 150,["145"] = 143,["146"] = 153,["147"] = 154,["148"] = 155,["149"] = 157,["150"] = 158,["151"] = 158,["152"] = 158,["153"] = 158,["154"] = 158,["155"] = 158,["156"] = 158,["157"] = 158,["158"] = 158,["159"] = 158,["160"] = 158,["161"] = 153,["162"] = 166,["163"] = 167,["164"] = 169,["165"] = 174,["166"] = 174,["167"] = 174,["168"] = 174,["169"] = 174,["170"] = 175,["171"] = 166,["172"] = 9,["173"] = 8,["174"] = 9,["176"] = 179,["177"] = 180,["178"] = 179,["179"] = 180,["180"] = 183,["181"] = 184,["182"] = 183,["183"] = 187,["184"] = 188,["185"] = 189,["186"] = 191,["187"] = 196,["188"] = 196,["189"] = 196,["190"] = 196,["191"] = 196,["192"] = 197,["193"] = 197,["194"] = 197,["195"] = 197,["196"] = 197,["198"] = 187,["199"] = 201,["200"] = 202,["201"] = 203,["202"] = 204,["203"] = 205,["204"] = 206,["206"] = 201,["207"] = 210,["208"] = 211,["209"] = 210,["210"] = 214,["211"] = 215,["212"] = 214,["213"] = 218,["214"] = 219,["215"] = 218,["216"] = 180,["217"] = 179,["218"] = 180,["220"] = 180,["221"] = 223,["222"] = 223,["223"] = 224,["224"] = 227,["225"] = 228,["226"] = 227,["227"] = 231,["228"] = 232,["229"] = 231,["230"] = 235,["231"] = 236,["232"] = 235,["233"] = 239,["234"] = 240,["235"] = 239,["236"] = 243,["237"] = 224,["238"] = 245,["239"] = 246,["240"] = 248,["241"] = 251,["242"] = 257,["244"] = 259,["245"] = 243,["246"] = 262,["247"] = 224,["248"] = 264,["249"] = 262,["250"] = 267,["251"] = 268,["252"] = 269,["253"] = 270,["254"] = 271,["255"] = 271,["256"] = 271,["257"] = 271,["258"] = 272,["259"] = 273,["260"] = 274,["261"] = 275,["262"] = 276,["263"] = 277,["264"] = 278,["265"] = 279,["266"] = 280,["267"] = 282,["268"] = 282,["269"] = 283,["270"] = 285,["271"] = 285,["272"] = 285,["273"] = 285,["274"] = 289,["275"] = 290,["276"] = 297,["277"] = 298,["278"] = 285,["279"] = 285,["280"] = 285,["281"] = 303,["282"] = 303,["283"] = 303,["284"] = 303,["285"] = 304,["286"] = 306,["287"] = 307,["288"] = 307,["289"] = 307,["290"] = 307,["291"] = 307,["292"] = 307,["293"] = 309,["295"] = 310,["296"] = 310,["297"] = 311,["298"] = 310,["302"] = 315,["304"] = 321,["305"] = 267,["306"] = 325,["307"] = 326,["308"] = 327,["309"] = 328,["310"] = 328,["311"] = 328,["312"] = 328,["313"] = 328,["314"] = 329,["315"] = 325,["316"] = 332,["317"] = 333,["318"] = 334,["319"] = 335,["320"] = 336,["321"] = 338,["322"] = 343,["323"] = 344,["324"] = 344,["325"] = 344,["326"] = 344,["327"] = 344,["328"] = 345,["329"] = 346,["330"] = 348,["331"] = 353,["332"] = 354,["333"] = 355,["334"] = 332,["335"] = 224,["336"] = 223,["337"] = 224});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveManaAndEnergy = ____util.giveManaAndEnergy
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isCountering = ____util.isCountering
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____juggernaut_basic_attack = require("abilities.heroes.juggernaut.juggernaut_basic_attack")
local JuggernautBasicAttack = ____juggernaut_basic_attack.JuggernautBasicAttack
local ModifierJuggernautStacks = ____juggernaut_basic_attack.ModifierJuggernautStacks
local JuggernautSecondAttack = __TS__Class()
JuggernautSecondAttack.name = "JuggernautSecondAttack"
__TS__ClassExtends(JuggernautSecondAttack, CustomAbility)
function JuggernautSecondAttack.prototype.OnAbilityPhaseStart(self)
    CustomAbility.prototype.OnAbilityPhaseStart(self)
    self.particleId = EFX("particles/econ/items/windrunner/windranger_arcana/windranger_arcana_javelin_tgt_v2.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {})
    return true
end
function JuggernautSecondAttack.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    DEFX(self.particleId, true)
end
function JuggernautSecondAttack.prototype.GetAnimation(self)
    local ____opt_0 = self.caster:FindModifierByName("modifier_juggernaut_basic_attack_stacks")
    local stacks = ____opt_0 and ____opt_0:GetStackCount() or 0
    local ____temp_2
    if stacks >= 4 then
        ____temp_2 = ACT_DOTA_ATTACK
    else
        ____temp_2 = ACT_DOTA_ATTACK_EVENT
    end
    return ____temp_2
end
function JuggernautSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 1.5
end
function JuggernautSecondAttack.prototype.GetCastingCrawl(self)
    return 40
end
function JuggernautSecondAttack.prototype.GetAnimationTranslate(self)
    return Translate.ti8
end
function JuggernautSecondAttack.prototype.OnUnitImpact(self, target, damage)
    ApplyDamage({victim = target, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
    self:PlayEffectsOnImpact(target)
end
function JuggernautSecondAttack.prototype.OnSpellStart(self)
    local randomNumber = RandomInt(0, 4)
    if randomNumber > 0 then
        EmitSoundOn(
            "juggernaut_jug_attack_0" .. tostring(randomNumber),
            self.caster
        )
    end
    local origin = self.caster:GetOrigin()
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange, minRange = castRange})
    local damage = self.caster:GetAverageTrueAttackDamage(self.caster)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local meeleExtraRadius = 0
    local radius = self:GetSpecialValueFor("radius") + meeleExtraRadius
    local duration = self:GetSpecialValueFor("duration")
    local shieldPerStack = self:GetSpecialValueFor("shield_per_stack")
    local damageMultiplier = self:GetSpecialValueFor("damage_multiplier")
    local damageMultiplierPerStack = self:GetSpecialValueFor("damage_multiplier_per_stack")
    local direction = direction2D(nil, origin, point)
    local ____opt_3 = ModifierJuggernautStacks:findOne(self.caster)
    local stacks = ____opt_3 and ____opt_3:GetStackCount() or 0
    local finalDamage = damage * damageMultiplier * ((stacks + 1) * damageMultiplierPerStack)
    local units = {}
    if stacks == 4 then
        local aoeRadius = radius * 1.15
        __TS__ArrayPushArray(
            units,
            self:AoeAttack({
                origin = origin,
                radius = aoeRadius,
                triggerCounters = true,
                effect = function(____, target)
                    self:OnUnitImpact(target, finalDamage)
                end
            })
        )
        ____exports.ModifierJuggernautSpin:apply(self.caster, self.caster, nil, {duration = 0.3})
        self:PlayEffectsAoe(aoeRadius)
    else
        __TS__ArrayPushArray(
            units,
            self:MeeleAttack({
                direction = direction,
                origin = origin,
                radius = radius,
                effect = function(____, target)
                    self:OnUnitImpact(target, finalDamage)
                end
            })
        )
        self:PlayEffectsOnFinish(direction, radius)
    end
    local giveMana = #__TS__ArrayFilter(
        units,
        function(____, unit) return not isGem(nil, unit) and not isObstacle(nil, unit) end
    ) > 0
    local shieldProviders = #__TS__ArrayFilter(
        units,
        function(____, unit) return not isObstacle(nil, unit) and not isCountering(nil, unit) end
    )
    if giveMana then
        giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
    end
    if self:GetLevel() >= 2 and stacks > 0 and shieldProviders > 0 then
        local final_shield = stacks * shieldPerStack * shieldProviders
        self.caster:AddNewModifier(self.caster, self, "modifier_juggernaut_second_attack", {damage_block = final_shield, duration = duration})
    end
    self.caster:RemoveModifierByName(ModifierJuggernautStacks.name)
end
function JuggernautSecondAttack.prototype.PlayEffectsOnImpact(self, target)
    EFX("particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinda_slow.vpcf", PATTACH_ABSORIGIN, target, {release = true})
    EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", target)
    EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", target)
    EmitSoundOn("Hero_Juggernaut.Attack", target)
end
function JuggernautSecondAttack.prototype.PlayEffectsOnFinish(self, direction, radius)
    local caster = self.caster
    local origin = self.caster:GetOrigin()
    EmitSoundOnLocationWithCaster(origin, "Hero_Juggernaut.BladeDance", caster)
    EFX(
        "particles/juggernaut/juggernaut_second_attack_parent.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = origin,
            cp0f = direction,
            cp3 = Vector(radius, 0, 0),
            release = true
        }
    )
end
function JuggernautSecondAttack.prototype.PlayEffectsAoe(self, radius)
    EmitSoundOn("juggernaut_jugsc_arc_ability_bladefury_12", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControl(
        particleId,
        2,
        Vector(radius, 1, 1)
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
JuggernautSecondAttack = __TS__Decorate(
    {registerAbility(nil, "juggernaut_second_attack")},
    JuggernautSecondAttack
)
____exports.ModifierJuggernautSpin = __TS__Class()
local ModifierJuggernautSpin = ____exports.ModifierJuggernautSpin
ModifierJuggernautSpin.name = "ModifierJuggernautSpin"
__TS__ClassExtends(ModifierJuggernautSpin, CustomModifier)
function ModifierJuggernautSpin.prototype.IsHidden(self)
    return true
end
function ModifierJuggernautSpin.prototype.OnCreated(self)
    if IsServer() then
        EmitSoundOn("Hero_Juggernaut.BladeFuryStart", self.parent)
        self.particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
        ParticleManager:SetParticleControl(
            self.particleId,
            5,
            Vector(200, 1, 1)
        )
        ParticleManager:SetParticleControl(
            self.particleId,
            2,
            self.parent:GetOrigin()
        )
    end
end
function ModifierJuggernautSpin.prototype.OnDestroy(self)
    if IsServer() then
        StopSoundOn("Hero_Juggernaut.BladeFuryStart", self.parent)
        EmitSoundOn("Hero_Juggernaut.BladeFuryStop", self.parent)
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierJuggernautSpin.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierJuggernautSpin.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_OVERRIDE_ABILITY_1
end
function ModifierJuggernautSpin.prototype.GetOverrideAnimationRate(self)
    return 1.5
end
ModifierJuggernautSpin = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_spin_animation"})},
    ModifierJuggernautSpin
)
____exports.ModifierJuggernautSpin = ModifierJuggernautSpin
local JuggernautExSecondAttack = __TS__Class()
JuggernautExSecondAttack.name = "JuggernautExSecondAttack"
__TS__ClassExtends(JuggernautExSecondAttack, CustomAbility)
function JuggernautExSecondAttack.prototype.GetAnimation(self)
    return ACT_DOTA_OVERRIDE_ABILITY_1
end
function JuggernautExSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 0.5
end
function JuggernautExSecondAttack.prototype.GetAnimationTranslate(self)
    return Translate.odachi
end
function JuggernautExSecondAttack.prototype.GetCastingCrawl(self)
    return 10
end
function JuggernautExSecondAttack.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        ____exports.ModifierJuggernautSpin:apply(self.caster, self.caster, nil, {duration = 0.3})
        EmitSoundOn("juggernaut_jugg_ability_bladefury_12", self.caster)
        EFX("particles/juggernaut/juggernaut_ex_second_attack_casting_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {release = true})
        self.particleId = EFX("particles/juggernaut/juggernaut_ex_second_attack_casting.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {})
        return true
    end
    return false
end
function JuggernautExSecondAttack.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    DEFX(self.particleId, true)
end
function JuggernautExSecondAttack.prototype.OnSpellStart(self)
    DEFX(self.particleId, true)
    local origin = self.caster:GetOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange, minRange = castRange})
    local abilityDamage = self:GetSpecialValueFor("ability_damage")
    local duration = self:GetSpecialValueFor("duration")
    local duration_per_stack = self:GetSpecialValueFor("duration_per_stack")
    local radius = self:GetSpecialValueFor("radius")
    local swiftnessDuration = self:GetSpecialValueFor("swiftness_duration")
    local swiftnessPct = self:GetSpecialValueFor("swiftness_pct")
    local juggernautBasicAttack = JuggernautBasicAttack:findOne(self.caster)
    local direction = direction2D(nil, origin, point)
    local ____opt_5 = self.caster:FindModifierByName("modifier_juggernaut_basic_attack_stacks")
    local stacks = ____opt_5 and ____opt_5:GetStackCount() or 0
    local finalDebuffDuration = duration + stacks * duration_per_stack
    local units = self:MeeleAttack({
        direction = direction,
        origin = origin,
        radius = radius,
        effect = function(____, target)
            ApplyDamage({victim = target, attacker = self.caster, damage = abilityDamage, damage_type = DAMAGE_TYPE_PHYSICAL})
            target:AddNewModifier(self.caster, self, "modifier_generic_sleep", {duration = finalDebuffDuration})
            self:PlayEffectsOnImpact(target)
        end,
        baseSound = "DOTA_Item.SkullBasher"
    })
    local giveMana = #__TS__ArrayFilter(
        units,
        function(____, unit) return not isGem(nil, unit) and not isObstacle(nil, unit) end
    ) > 0
    self.caster:RemoveModifierByName(ModifierJuggernautStacks.name)
    if self:GetLevel() >= 2 and giveMana then
        giveManaAndEnergy(
            nil,
            self.caster,
            self:GetManaCost(self:GetLevel()),
            true
        )
        if juggernautBasicAttack then
            do
                local i = 0
                while i < 3 do
                    ModifierJuggernautStacks:apply(self.caster, self.caster, juggernautBasicAttack, {})
                    i = i + 1
                end
            end
        end
        self.caster:AddNewModifier(self.caster, self, "modifier_juggernaut_swiftness", {duration = swiftnessDuration, swiftness_pct = swiftnessPct})
    end
    self:PlayEffectsOnFinish(point, radius)
end
function JuggernautExSecondAttack.prototype.PlayEffectsOnImpact(self, target)
    local particle_cast = "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(
        effect_cast,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(effect_cast)
end
function JuggernautExSecondAttack.prototype.PlayEffectsOnFinish(self, position, radius)
    local offset = 40
    local origin = self.caster:GetAbsOrigin()
    local direction = position:__sub(origin):Normalized()
    local finalPosition = origin:__add(Vector(direction.x * offset, direction.y * offset, 0))
    local particleId = ParticleManager:CreateParticle("particles/juggernaut/juggernaut_ex_second_attack.vpcf", PATTACH_WORLDORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, origin)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(radius, radius, radius)
    )
    ParticleManager:SetParticleControlForward(particleId, 0, direction)
    ParticleManager:ReleaseParticleIndex(particleId)
    particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", PATTACH_POINT, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, finalPosition)
    ParticleManager:SetParticleControlForward(particleId, 0, direction)
    ParticleManager:ReleaseParticleIndex(particleId)
end
JuggernautExSecondAttack = __TS__Decorate(
    {registerAbility(nil, "juggernaut_ex_second_attack")},
    JuggernautExSecondAttack
)
return ____exports
