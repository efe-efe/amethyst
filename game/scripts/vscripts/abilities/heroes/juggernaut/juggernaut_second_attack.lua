local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 3,["20"] = 3,["21"] = 3,["22"] = 4,["23"] = 4,["24"] = 5,["25"] = 5,["26"] = 6,["27"] = 6,["28"] = 17,["29"] = 17,["30"] = 18,["31"] = 21,["32"] = 18,["33"] = 23,["34"] = 29,["35"] = 21,["36"] = 32,["37"] = 18,["38"] = 34,["39"] = 32,["40"] = 37,["41"] = 38,["42"] = 38,["43"] = 39,["44"] = 39,["49"] = 39,["50"] = 37,["51"] = 42,["52"] = 43,["53"] = 42,["54"] = 46,["55"] = 47,["56"] = 46,["57"] = 50,["58"] = 51,["59"] = 50,["60"] = 54,["61"] = 55,["62"] = 62,["63"] = 54,["64"] = 65,["65"] = 66,["66"] = 67,["67"] = 68,["68"] = 68,["69"] = 68,["70"] = 68,["72"] = 71,["73"] = 72,["74"] = 72,["75"] = 72,["76"] = 72,["77"] = 73,["78"] = 74,["79"] = 75,["80"] = 76,["81"] = 78,["82"] = 79,["83"] = 81,["84"] = 82,["85"] = 83,["86"] = 85,["87"] = 86,["88"] = 88,["89"] = 89,["90"] = 89,["91"] = 91,["92"] = 93,["93"] = 95,["94"] = 96,["95"] = 97,["96"] = 97,["97"] = 98,["98"] = 98,["99"] = 98,["100"] = 98,["101"] = 102,["102"] = 103,["103"] = 98,["104"] = 97,["105"] = 97,["106"] = 108,["107"] = 109,["109"] = 111,["110"] = 111,["111"] = 112,["112"] = 112,["113"] = 112,["114"] = 112,["115"] = 116,["116"] = 117,["117"] = 112,["118"] = 111,["119"] = 111,["120"] = 122,["122"] = 125,["123"] = 125,["124"] = 125,["125"] = 125,["126"] = 126,["127"] = 126,["128"] = 126,["129"] = 126,["130"] = 128,["131"] = 129,["133"] = 132,["134"] = 133,["135"] = 134,["137"] = 149,["138"] = 65,["139"] = 153,["140"] = 154,["141"] = 158,["142"] = 159,["143"] = 160,["144"] = 153,["145"] = 163,["146"] = 164,["147"] = 165,["148"] = 167,["149"] = 168,["150"] = 168,["151"] = 168,["152"] = 168,["153"] = 168,["154"] = 168,["155"] = 168,["156"] = 168,["157"] = 168,["158"] = 168,["159"] = 168,["160"] = 163,["161"] = 176,["162"] = 177,["163"] = 179,["164"] = 184,["165"] = 184,["166"] = 184,["167"] = 184,["168"] = 184,["169"] = 185,["170"] = 176,["171"] = 18,["172"] = 17,["173"] = 18,["175"] = 189,["176"] = 190,["177"] = 189,["178"] = 190,["179"] = 193,["180"] = 194,["181"] = 193,["182"] = 197,["183"] = 198,["184"] = 199,["185"] = 201,["186"] = 206,["187"] = 206,["188"] = 206,["189"] = 206,["190"] = 206,["191"] = 207,["192"] = 207,["193"] = 207,["194"] = 207,["195"] = 207,["197"] = 197,["198"] = 211,["199"] = 212,["200"] = 213,["201"] = 214,["202"] = 215,["203"] = 216,["205"] = 211,["206"] = 220,["207"] = 221,["208"] = 220,["209"] = 224,["210"] = 225,["211"] = 224,["212"] = 228,["213"] = 229,["214"] = 228,["215"] = 190,["216"] = 189,["217"] = 190,["219"] = 190,["220"] = 234,["221"] = 234,["222"] = 235,["223"] = 238,["224"] = 239,["225"] = 238,["226"] = 242,["227"] = 243,["228"] = 242,["229"] = 246,["230"] = 247,["231"] = 246,["232"] = 250,["233"] = 251,["234"] = 250,["235"] = 254,["236"] = 235,["237"] = 257,["238"] = 258,["239"] = 260,["240"] = 263,["241"] = 269,["242"] = 254,["243"] = 272,["244"] = 273,["245"] = 272,["246"] = 276,["247"] = 277,["248"] = 278,["249"] = 279,["250"] = 280,["251"] = 280,["252"] = 280,["253"] = 280,["254"] = 281,["255"] = 282,["256"] = 283,["257"] = 284,["258"] = 285,["259"] = 286,["260"] = 287,["261"] = 288,["262"] = 289,["263"] = 291,["264"] = 291,["265"] = 292,["266"] = 294,["267"] = 294,["268"] = 294,["269"] = 294,["270"] = 298,["271"] = 299,["272"] = 306,["273"] = 307,["274"] = 294,["275"] = 294,["276"] = 294,["277"] = 312,["278"] = 312,["279"] = 312,["280"] = 312,["281"] = 313,["282"] = 315,["283"] = 316,["284"] = 316,["285"] = 316,["286"] = 316,["287"] = 316,["288"] = 316,["290"] = 318,["291"] = 318,["292"] = 319,["293"] = 318,["296"] = 322,["298"] = 328,["299"] = 276,["300"] = 332,["301"] = 333,["302"] = 334,["303"] = 335,["304"] = 335,["305"] = 335,["306"] = 335,["307"] = 335,["308"] = 336,["309"] = 332,["310"] = 339,["311"] = 340,["312"] = 341,["313"] = 342,["314"] = 343,["315"] = 345,["316"] = 350,["317"] = 351,["318"] = 351,["319"] = 351,["320"] = 351,["321"] = 351,["322"] = 352,["323"] = 353,["324"] = 355,["325"] = 360,["326"] = 361,["327"] = 362,["328"] = 339,["329"] = 235,["330"] = 234,["331"] = 235});
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
    CustomAbility.prototype.OnAbilityPhaseStart(self)
    ____exports.ModifierJuggernautSpin:apply(self.caster, self.caster, nil, {duration = 0.3})
    EmitSoundOn("juggernaut_jugg_ability_bladefury_12", self.caster)
    EFX("particles/juggernaut/juggernaut_ex_second_attack_casting_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {release = true})
    self.particleId = EFX("particles/juggernaut/juggernaut_ex_second_attack_casting.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {})
    return true
end
function JuggernautExSecondAttack.prototype.OnAbilityPhaseInterrupted(self)
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
