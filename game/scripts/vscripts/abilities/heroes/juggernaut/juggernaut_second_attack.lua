local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 3,["20"] = 3,["21"] = 3,["22"] = 4,["23"] = 4,["24"] = 5,["25"] = 5,["26"] = 6,["27"] = 6,["28"] = 8,["29"] = 8,["30"] = 9,["31"] = 12,["32"] = 9,["33"] = 14,["34"] = 20,["35"] = 12,["36"] = 23,["37"] = 9,["38"] = 25,["39"] = 23,["40"] = 28,["41"] = 29,["42"] = 29,["43"] = 30,["44"] = 30,["49"] = 30,["50"] = 28,["51"] = 33,["52"] = 34,["53"] = 33,["54"] = 37,["55"] = 38,["56"] = 37,["57"] = 41,["58"] = 42,["59"] = 41,["60"] = 45,["61"] = 46,["62"] = 53,["63"] = 45,["64"] = 56,["65"] = 57,["66"] = 58,["67"] = 59,["68"] = 59,["69"] = 59,["70"] = 59,["72"] = 62,["73"] = 63,["74"] = 63,["75"] = 63,["76"] = 63,["77"] = 64,["78"] = 65,["79"] = 66,["80"] = 67,["81"] = 69,["82"] = 70,["83"] = 72,["84"] = 73,["85"] = 74,["86"] = 76,["87"] = 77,["88"] = 79,["89"] = 80,["90"] = 80,["91"] = 82,["92"] = 84,["93"] = 86,["94"] = 87,["95"] = 88,["96"] = 88,["97"] = 89,["98"] = 89,["99"] = 89,["100"] = 89,["101"] = 93,["102"] = 94,["103"] = 89,["104"] = 88,["105"] = 88,["106"] = 99,["107"] = 100,["109"] = 102,["110"] = 102,["111"] = 103,["112"] = 103,["113"] = 103,["114"] = 103,["115"] = 107,["116"] = 108,["117"] = 103,["118"] = 102,["119"] = 102,["120"] = 113,["122"] = 116,["123"] = 116,["124"] = 116,["125"] = 116,["126"] = 117,["127"] = 117,["128"] = 117,["129"] = 117,["130"] = 119,["131"] = 120,["133"] = 123,["134"] = 124,["135"] = 125,["137"] = 140,["138"] = 56,["139"] = 144,["140"] = 145,["141"] = 149,["142"] = 150,["143"] = 151,["144"] = 144,["145"] = 154,["146"] = 155,["147"] = 156,["148"] = 158,["149"] = 159,["150"] = 159,["151"] = 159,["152"] = 159,["153"] = 159,["154"] = 159,["155"] = 159,["156"] = 159,["157"] = 159,["158"] = 159,["159"] = 159,["160"] = 154,["161"] = 167,["162"] = 168,["163"] = 170,["164"] = 175,["165"] = 175,["166"] = 175,["167"] = 175,["168"] = 175,["169"] = 176,["170"] = 167,["171"] = 9,["172"] = 8,["173"] = 9,["175"] = 180,["176"] = 181,["177"] = 180,["178"] = 181,["179"] = 184,["180"] = 185,["181"] = 184,["182"] = 188,["183"] = 189,["184"] = 190,["185"] = 192,["186"] = 197,["187"] = 197,["188"] = 197,["189"] = 197,["190"] = 197,["191"] = 198,["192"] = 198,["193"] = 198,["194"] = 198,["195"] = 198,["197"] = 188,["198"] = 202,["199"] = 203,["200"] = 204,["201"] = 205,["202"] = 206,["203"] = 207,["205"] = 202,["206"] = 211,["207"] = 212,["208"] = 211,["209"] = 215,["210"] = 216,["211"] = 215,["212"] = 219,["213"] = 220,["214"] = 219,["215"] = 181,["216"] = 180,["217"] = 181,["219"] = 181,["220"] = 224,["221"] = 224,["222"] = 225,["223"] = 228,["224"] = 229,["225"] = 228,["226"] = 232,["227"] = 233,["228"] = 232,["229"] = 236,["230"] = 237,["231"] = 236,["232"] = 240,["233"] = 241,["234"] = 240,["235"] = 244,["236"] = 225,["237"] = 246,["238"] = 247,["239"] = 249,["240"] = 252,["241"] = 258,["243"] = 260,["244"] = 244,["245"] = 263,["246"] = 225,["247"] = 265,["248"] = 263,["249"] = 268,["250"] = 269,["251"] = 270,["252"] = 271,["253"] = 272,["254"] = 272,["255"] = 272,["256"] = 272,["257"] = 273,["258"] = 274,["259"] = 275,["260"] = 276,["261"] = 277,["262"] = 278,["263"] = 279,["264"] = 280,["265"] = 281,["266"] = 283,["267"] = 283,["268"] = 284,["269"] = 286,["270"] = 286,["271"] = 286,["272"] = 286,["273"] = 290,["274"] = 291,["275"] = 298,["276"] = 299,["277"] = 286,["278"] = 286,["279"] = 286,["280"] = 304,["281"] = 304,["282"] = 304,["283"] = 304,["284"] = 305,["285"] = 307,["286"] = 308,["287"] = 308,["288"] = 308,["289"] = 308,["290"] = 308,["291"] = 308,["293"] = 310,["294"] = 310,["295"] = 311,["296"] = 310,["299"] = 314,["301"] = 320,["302"] = 268,["303"] = 324,["304"] = 325,["305"] = 326,["306"] = 327,["307"] = 327,["308"] = 327,["309"] = 327,["310"] = 327,["311"] = 328,["312"] = 324,["313"] = 331,["314"] = 332,["315"] = 333,["316"] = 334,["317"] = 335,["318"] = 337,["319"] = 342,["320"] = 343,["321"] = 343,["322"] = 343,["323"] = 343,["324"] = 343,["325"] = 344,["326"] = 345,["327"] = 347,["328"] = 352,["329"] = 353,["330"] = 354,["331"] = 331,["332"] = 225,["333"] = 224,["334"] = 225});
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
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____juggernaut_basic_attack = require("abilities.heroes.juggernaut.juggernaut_basic_attack")
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
    local juggernautExSecondAttack = self.caster:FindAbilityByName("juggernaut_ex_second_attack")
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
        function(____, unit) return not isObstacle(nil, unit) end
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
    local juggernautBasicAttack = self.caster:FindAbilityByName("juggernaut_basic_attack")
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
        do
            local i = 0
            while i < 3 do
                ModifierJuggernautStacks:apply(self.caster, self.caster, juggernautBasicAttack, {})
                i = i + 1
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
