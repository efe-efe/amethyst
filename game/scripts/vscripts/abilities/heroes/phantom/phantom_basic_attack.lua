local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 376,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 10,["21"] = 11,["22"] = 13,["23"] = 13,["24"] = 14,["25"] = 14,["26"] = 16,["27"] = 17,["28"] = 16,["29"] = 17,["30"] = 18,["31"] = 19,["32"] = 20,["34"] = 22,["35"] = 18,["36"] = 25,["37"] = 26,["38"] = 27,["39"] = 28,["40"] = 17,["42"] = 31,["43"] = 25,["44"] = 34,["45"] = 35,["46"] = 34,["47"] = 38,["48"] = 39,["49"] = 38,["50"] = 42,["51"] = 43,["52"] = 42,["53"] = 46,["54"] = 47,["55"] = 46,["56"] = 50,["57"] = 51,["58"] = 52,["59"] = 53,["60"] = 54,["61"] = 55,["62"] = 56,["63"] = 59,["64"] = 59,["65"] = 59,["66"] = 59,["67"] = 59,["68"] = 59,["69"] = 59,["70"] = 59,["71"] = 59,["72"] = 69,["73"] = 70,["74"] = 70,["75"] = 70,["76"] = 70,["77"] = 70,["78"] = 70,["79"] = 76,["81"] = 78,["82"] = 78,["83"] = 78,["84"] = 78,["85"] = 78,["86"] = 78,["87"] = 78,["88"] = 78,["90"] = 50,["91"] = 82,["92"] = 83,["93"] = 85,["94"] = 86,["95"] = 86,["96"] = 86,["97"] = 86,["98"] = 87,["99"] = 92,["100"] = 94,["101"] = 95,["102"] = 96,["103"] = 97,["104"] = 99,["105"] = 99,["106"] = 99,["107"] = 99,["108"] = 99,["109"] = 99,["110"] = 99,["111"] = 101,["112"] = 101,["113"] = 101,["114"] = 101,["115"] = 101,["116"] = 101,["117"] = 107,["118"] = 108,["119"] = 110,["120"] = 111,["121"] = 112,["123"] = 115,["124"] = 116,["126"] = 118,["127"] = 101,["128"] = 101,["129"] = 122,["130"] = 82,["131"] = 125,["132"] = 126,["133"] = 128,["134"] = 129,["135"] = 130,["136"] = 132,["137"] = 133,["139"] = 135,["140"] = 136,["143"] = 125,["144"] = 141,["145"] = 142,["146"] = 145,["147"] = 141,["148"] = 148,["149"] = 149,["150"] = 148,["151"] = 17,["152"] = 16,["153"] = 17,["155"] = 17,["156"] = 153,["157"] = 154,["158"] = 153,["159"] = 154,["161"] = 154,["162"] = 155,["163"] = 153,["164"] = 157,["165"] = 158,["166"] = 157,["167"] = 161,["168"] = 162,["169"] = 161,["170"] = 165,["171"] = 166,["172"] = 165,["173"] = 169,["174"] = 170,["175"] = 171,["177"] = 169,["178"] = 175,["179"] = 176,["180"] = 178,["181"] = 179,["182"] = 181,["183"] = 182,["186"] = 175,["187"] = 187,["188"] = 188,["189"] = 189,["191"] = 187,["192"] = 193,["193"] = 194,["194"] = 193,["195"] = 197,["196"] = 198,["197"] = 199,["199"] = 201,["200"] = 201,["201"] = 202,["202"] = 207,["203"] = 207,["204"] = 207,["205"] = 207,["206"] = 207,["207"] = 207,["208"] = 207,["209"] = 207,["210"] = 207,["211"] = 216,["212"] = 216,["213"] = 216,["214"] = 216,["215"] = 216,["216"] = 216,["217"] = 216,["218"] = 216,["219"] = 216,["220"] = 225,["221"] = 225,["222"] = 201,["225"] = 197,["226"] = 229,["227"] = 230,["228"] = 231,["229"] = 232,["231"] = 229,["232"] = 154,["233"] = 153,["234"] = 154,["236"] = 154,["237"] = 237,["238"] = 238,["239"] = 237,["240"] = 238,["241"] = 239,["242"] = 240,["243"] = 241,["244"] = 242,["245"] = 239,["246"] = 245,["247"] = 246,["248"] = 247,["249"] = 252,["250"] = 252,["251"] = 252,["252"] = 252,["253"] = 252,["254"] = 253,["255"] = 245,["256"] = 238,["257"] = 237,["258"] = 238,["260"] = 238,["261"] = 261,["262"] = 261,["263"] = 262,["264"] = 263,["265"] = 264,["266"] = 265,["268"] = 268,["269"] = 263,["270"] = 271,["271"] = 272,["272"] = 273,["273"] = 274,["274"] = 262,["276"] = 278,["277"] = 271,["278"] = 281,["279"] = 282,["280"] = 281,["281"] = 285,["282"] = 286,["283"] = 285,["284"] = 289,["285"] = 290,["286"] = 289,["287"] = 293,["288"] = 294,["289"] = 293,["290"] = 297,["291"] = 298,["292"] = 299,["293"] = 300,["294"] = 301,["295"] = 302,["296"] = 304,["297"] = 305,["298"] = 307,["299"] = 308,["300"] = 309,["301"] = 310,["302"] = 312,["303"] = 312,["304"] = 312,["305"] = 312,["306"] = 312,["307"] = 312,["308"] = 312,["309"] = 319,["310"] = 320,["311"] = 320,["312"] = 312,["313"] = 321,["314"] = 322,["315"] = 322,["316"] = 322,["317"] = 322,["318"] = 322,["319"] = 322,["320"] = 322,["321"] = 322,["322"] = 328,["323"] = 329,["324"] = 330,["325"] = 331,["326"] = 331,["327"] = 331,["328"] = 331,["329"] = 331,["330"] = 331,["332"] = 334,["333"] = 335,["337"] = 340,["338"] = 345,["339"] = 346,["340"] = 346,["341"] = 346,["342"] = 346,["343"] = 346,["344"] = 346,["346"] = 312,["347"] = 351,["348"] = 352,["349"] = 312,["350"] = 312,["351"] = 356,["352"] = 297,["353"] = 359,["354"] = 360,["355"] = 361,["356"] = 366,["357"] = 367,["358"] = 359,["359"] = 262,["360"] = 261,["361"] = 262,["363"] = 375,["364"] = 375,["365"] = 376,["366"] = 379,["367"] = 380,["368"] = 379,["369"] = 383,["370"] = 384,["371"] = 383,["372"] = 387,["373"] = 388,["374"] = 387,["375"] = 391,["376"] = 392,["377"] = 391,["378"] = 395,["379"] = 396,["380"] = 397,["381"] = 398,["383"] = 395,["384"] = 402,["385"] = 403,["386"] = 404,["387"] = 405,["388"] = 406,["389"] = 411,["390"] = 411,["391"] = 411,["392"] = 411,["393"] = 411,["394"] = 411,["395"] = 411,["396"] = 411,["397"] = 411,["398"] = 420,["399"] = 420,["400"] = 420,["401"] = 420,["402"] = 420,["403"] = 420,["404"] = 420,["405"] = 420,["406"] = 420,["407"] = 429,["409"] = 402,["410"] = 433,["411"] = 434,["412"] = 433,["413"] = 437,["414"] = 438,["415"] = 437,["416"] = 441,["417"] = 442,["418"] = 443,["419"] = 448,["420"] = 448,["421"] = 448,["422"] = 448,["423"] = 448,["424"] = 448,["425"] = 448,["426"] = 448,["427"] = 448,["428"] = 441,["429"] = 459,["430"] = 460,["431"] = 461,["432"] = 459,["433"] = 376,["434"] = 375,["435"] = 376,["437"] = 465,["438"] = 466,["439"] = 465,["440"] = 466,["442"] = 466,["443"] = 468,["444"] = 469,["445"] = 465,["446"] = 471,["447"] = 472,["448"] = 473,["449"] = 474,["450"] = 475,["451"] = 476,["453"] = 471,["454"] = 485,["455"] = 486,["456"] = 487,["457"] = 488,["460"] = 485,["461"] = 493,["462"] = 494,["463"] = 495,["464"] = 496,["466"] = 493,["467"] = 500,["468"] = 501,["469"] = 501,["470"] = 501,["471"] = 501,["472"] = 501,["473"] = 501,["474"] = 507,["475"] = 515,["476"] = 515,["477"] = 515,["478"] = 515,["479"] = 519,["480"] = 519,["481"] = 519,["482"] = 515,["483"] = 515,["484"] = 524,["485"] = 525,["486"] = 526,["487"] = 500,["488"] = 466,["489"] = 465,["490"] = 466,["492"] = 466});
local ____exports = {}
local ModifierPhantomExBasicAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local clampPosition = ____util.clampPosition
local createRadiusMarker = ____util.createRadiusMarker
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
____exports.PhantomBasicAttack = __TS__Class()
local PhantomBasicAttack = ____exports.PhantomBasicAttack
PhantomBasicAttack.name = "PhantomBasicAttack"
__TS__ClassExtends(PhantomBasicAttack, CustomAbility)
function PhantomBasicAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return self.caster:GetAttackAnimationPoint()
    end
    return 0
end
function PhantomBasicAttack.prototype.GetCooldown(self, level)
    if IsServer() then
        local attacks_per_second = self.caster:GetAttacksPerSecond()
        local attack_speed = 1 / attacks_per_second
        return CustomAbility.prototype.GetCooldown(self, level) + attack_speed
    end
    return 0
end
function PhantomBasicAttack.prototype.GetAnimation(self)
    return ACT_DOTA_SPAWN
end
function PhantomBasicAttack.prototype.GetPlaybackRateOverride(self)
    return 1.7
end
function PhantomBasicAttack.prototype.GetCastingCrawl(self)
    return self:GetSpecialValueFor("cast_point_speed_pct")
end
function PhantomBasicAttack.prototype.GetFadeGestureOnCast(self)
    return false
end
function PhantomBasicAttack.prototype.TryThrowKnives(self, modifierName)
    local origin = self.caster:GetAbsOrigin()
    local radius = 300
    local modifier = self.caster:FindModifierByName(modifierName)
    if modifier then
        local stacks = modifier:GetStackCount()
        EFX("particles/phantom/phantom_aoe_daggers_small.vpcf", PATTACH_ABSORIGIN, self.caster, {release = true})
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
                attacker = self.caster,
                damage = self.caster:GetAverageTrueAttackDamage(self.caster) * (0.5 * stacks),
                damage_type = DAMAGE_TYPE_PHYSICAL
            })
            self:PlayEffectsOnImpact(enemy)
        end
        createRadiusMarker(
            nil,
            self.caster,
            origin,
            radius,
            "public",
            0.1
        )
    end
end
function PhantomBasicAttack.prototype.OnSpellStart(self)
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
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local direction = direction2D(nil, origin, point)
    meeleEFX(
        nil,
        self.caster,
        direction,
        radius,
        Vector(43, 100, 125)
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
                ____exports.ModifierPhantomStacks:apply(self.caster, self.caster, self, {})
                self:ReduceCooldown("phantom_second_attack", cooldownReduction)
            end
            self:PlayEffectsOnImpact(target)
        end
    })
    self:PlayEffectsOnCast()
end
function PhantomBasicAttack.prototype.ReduceCooldown(self, abilityName, cooldownReduction)
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
function PhantomBasicAttack.prototype.PlayEffectsOnImpact(self, target)
    EFX("particles/phantom/phantom_basic_attack.vpcf", PATTACH_ABSORIGIN, target, {release = true})
    EmitSoundOn("Hero_PhantomAssassin.Attack", target)
end
function PhantomBasicAttack.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_PhantomAssassin.PreAttack", self.caster)
end
PhantomBasicAttack = __TS__Decorate(
    {registerAbility(nil, "phantom_basic_attack")},
    PhantomBasicAttack
)
____exports.PhantomBasicAttack = PhantomBasicAttack
____exports.ModifierPhantomStacks = __TS__Class()
local ModifierPhantomStacks = ____exports.ModifierPhantomStacks
ModifierPhantomStacks.name = "ModifierPhantomStacks"
__TS__ClassExtends(ModifierPhantomStacks, CustomModifier)
function ModifierPhantomStacks.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.particleIds = {}
end
function ModifierPhantomStacks.prototype.IsHidden(self)
    return false
end
function ModifierPhantomStacks.prototype.IsDebuff(self)
    return false
end
function ModifierPhantomStacks.prototype.IsPurgable(self)
    return true
end
function ModifierPhantomStacks.prototype.OnCreated(self)
    if IsServer() then
        self:SetStackCount(1)
    end
end
function ModifierPhantomStacks.prototype.OnRefresh(self)
    local maxStacks = self:Value("max_stacks")
    if IsServer() and self:GetStackCount() < maxStacks then
        self:IncrementStackCount()
        if self:GetStackCount() == maxStacks then
            self:PlayEffectsCharged()
        end
    end
end
function ModifierPhantomStacks.prototype.OnDestroy(self)
    if IsServer() then
        self:StopEffects()
    end
end
function ModifierPhantomStacks.prototype.GetTexture(self)
    return "phantom_basic_attack"
end
function ModifierPhantomStacks.prototype.PlayEffectsCharged(self)
    replenishEFX(nil, self.parent)
    local origin = self.parent:GetAbsOrigin()
    do
        local i = 0
        while i < 5 do
            local particleId = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_godeater/antimage_godeater_bracer_ambient.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
            ParticleManager:SetParticleControlEnt(
                particleId,
                0,
                self.caster,
                PATTACH_POINT_FOLLOW,
                "attach_attack1",
                origin,
                true
            )
            ParticleManager:SetParticleControlEnt(
                particleId,
                1,
                self.caster,
                PATTACH_POINT_FOLLOW,
                "attach_attack1",
                origin,
                true
            )
            local ____self_particleIds_0 = self.particleIds
            ____self_particleIds_0[#____self_particleIds_0 + 1] = particleId
            i = i + 1
        end
    end
end
function ModifierPhantomStacks.prototype.StopEffects(self)
    for ____, particleId in ipairs(self.particleIds) do
        ParticleManager:DestroyParticle(particleId, false)
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
ModifierPhantomStacks = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_strike_stack"})},
    ModifierPhantomStacks
)
____exports.ModifierPhantomStacks = ModifierPhantomStacks
____exports.PhantomExBasicAttack = __TS__Class()
local PhantomExBasicAttack = ____exports.PhantomExBasicAttack
PhantomExBasicAttack.name = "PhantomExBasicAttack"
__TS__ClassExtends(PhantomExBasicAttack, CustomAbility)
function PhantomExBasicAttack.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    ModifierPhantomExBasicAttack:apply(self.caster, self.caster, self, {duration = duration})
    self:PlayEffects()
end
function PhantomExBasicAttack.prototype.PlayEffects(self)
    EmitSoundOn("Hero_PhantomAssassin.Blur", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf", PATTACH_POINT, self.caster)
    ParticleManager:SetParticleControl(
        particleId,
        3,
        self.caster:GetOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
PhantomExBasicAttack = __TS__Decorate(
    {registerAbility(nil, "phantom_ex_basic_attack")},
    PhantomExBasicAttack
)
____exports.PhantomExBasicAttack = PhantomExBasicAttack
local PhantomBasicAttackRelated = __TS__Class()
PhantomBasicAttackRelated.name = "PhantomBasicAttackRelated"
__TS__ClassExtends(PhantomBasicAttackRelated, CustomAbility)
function PhantomBasicAttackRelated.prototype.GetCastPoint(self)
    if IsServer() then
        return self.caster:GetAttackAnimationPoint()
    end
    return 0
end
function PhantomBasicAttackRelated.prototype.GetCooldown(self, level)
    if IsServer() then
        local attacks_per_second = self.caster:GetAttacksPerSecond()
        local attack_speed = 1 / attacks_per_second
        return CustomAbility.prototype.GetCooldown(self, level) + attack_speed
    end
    return 0
end
function PhantomBasicAttackRelated.prototype.GetAnimation(self)
    return ACT_DOTA_TELEPORT_END
end
function PhantomBasicAttackRelated.prototype.GetPlaybackRateOverride(self)
    return 2
end
function PhantomBasicAttackRelated.prototype.GetCastingCrawl(self)
    return 80
end
function PhantomBasicAttackRelated.prototype.GetFadeGestureOnCast(self)
    return false
end
function PhantomBasicAttackRelated.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local phantomBasicAttack = ____exports.PhantomBasicAttack:findOne(self.caster)
    local phantomExBasicAttack = ____exports.PhantomExBasicAttack:findOne(self.caster)
    local bleedDuration = phantomExBasicAttack and phantomExBasicAttack:GetSpecialValueFor("bleed_duration") or 0
    local fadingSlowPct = phantomExBasicAttack and phantomExBasicAttack:GetSpecialValueFor("fading_slow_pct") or 0
    local fadingSlowDuration = phantomExBasicAttack and phantomExBasicAttack:GetSpecialValueFor("fading_slow_duration") or 0
    local level = phantomExBasicAttack and phantomExBasicAttack:GetLevel() or 0
    self:ProjectileAttack({
        source = self.caster,
        attackType = "basic",
        effectName = "particles/phantom/phantom_special_attack.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            attackWithBaseDamage(
                nil,
                {
                    source = projectile:getSource(),
                    target = unit,
                    ability = self
                }
            )
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) then
                    if not isGem(nil, unit) then
                        giveManaAndEnergyPercent(
                            nil,
                            projectile:getSource(),
                            manaGainPct,
                            true
                        )
                    end
                    if phantomBasicAttack then
                        ____exports.ModifierPhantomStacks:apply(self.caster, self.caster, phantomBasicAttack, {})
                    end
                end
            end
            unit:AddNewModifier(self.caster, self, "modifier_generic_fading_slow", {duration = fadingSlowDuration, max_slow_pct = fadingSlowPct})
            if level >= 2 and phantomExBasicAttack then
                ____exports.ModifierPhantomBleed:apply(
                    unit,
                    projectile:getSource(),
                    phantomExBasicAttack,
                    {duration = bleedDuration}
                )
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self.caster)
end
function PhantomBasicAttackRelated.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/phantom/phantom_special_attack_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
PhantomBasicAttackRelated = __TS__Decorate(
    {registerAbility(nil, "phantom_basic_attack_related")},
    PhantomBasicAttackRelated
)
ModifierPhantomExBasicAttack = __TS__Class()
ModifierPhantomExBasicAttack.name = "ModifierPhantomExBasicAttack"
__TS__ClassExtends(ModifierPhantomExBasicAttack, CustomModifier)
function ModifierPhantomExBasicAttack.prototype.IsHidden(self)
    return false
end
function ModifierPhantomExBasicAttack.prototype.IsDebuff(self)
    return false
end
function ModifierPhantomExBasicAttack.prototype.IsStunDebuff(self)
    return false
end
function ModifierPhantomExBasicAttack.prototype.IsPurgable(self)
    return true
end
function ModifierPhantomExBasicAttack.prototype.OnCreated(self)
    if IsServer() then
        self.parent:SwapAbilities(____exports.PhantomBasicAttack.name, PhantomBasicAttackRelated.name, false, true)
        self:PlayEffectsOnCast()
    end
end
function ModifierPhantomExBasicAttack.prototype.OnDestroy(self)
    if IsServer() then
        self.parent:SwapAbilities(____exports.PhantomBasicAttack.name, PhantomBasicAttackRelated.name, true, false)
        local origin = self.parent:GetAbsOrigin()
        local particleId = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
        ParticleManager:SetParticleControlEnt(
            particleId,
            0,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            origin,
            true
        )
        ParticleManager:SetParticleControlEnt(
            particleId,
            1,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            origin,
            true
        )
        self:StopEffects()
    end
end
function ModifierPhantomExBasicAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
end
function ModifierPhantomExBasicAttack.prototype.GetModifierPreAttack_BonusDamage(self)
    return -1
end
function ModifierPhantomExBasicAttack.prototype.PlayEffectsOnCast(self)
    local origin = self.parent:GetAbsOrigin()
    self.particleId = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_trail_steam.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
    ParticleManager:SetParticleControlEnt(
        self.particleId,
        0,
        self.parent,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        origin,
        true
    )
end
function ModifierPhantomExBasicAttack.prototype.StopEffects(self)
    ParticleManager:DestroyParticle(self.particleId, false)
    ParticleManager:ReleaseParticleIndex(self.particleId)
end
ModifierPhantomExBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_ex_basic_attack"})},
    ModifierPhantomExBasicAttack
)
____exports.ModifierPhantomBleed = __TS__Class()
local ModifierPhantomBleed = ____exports.ModifierPhantomBleed
ModifierPhantomBleed.name = "ModifierPhantomBleed"
__TS__ClassExtends(ModifierPhantomBleed, CustomModifier)
function ModifierPhantomBleed.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.bleedDamagePerStack = 1
    self.maxStacks = 3
end
function ModifierPhantomBleed.prototype.OnCreated(self)
    if IsServer() then
        self:SetStackCount(1)
        self:OnIntervalThink()
        self:StartIntervalThink(1)
        self.particleId = EFX("particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_thirst_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {})
    end
end
function ModifierPhantomBleed.prototype.OnRefresh(self)
    if IsServer() then
        if self:GetStackCount() < self.maxStacks then
            self:IncrementStackCount()
        end
    end
end
function ModifierPhantomBleed.prototype.OnDestroy(self)
    if IsServer() then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierPhantomBleed.prototype.OnIntervalThink(self)
    ApplyDamage({
        damage = self.bleedDamagePerStack * self:GetStackCount(),
        victim = self.parent,
        attacker = self.caster,
        damage_type = DAMAGE_TYPE_PURE
    })
    EFX("particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_eztzhok_ribbon.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {release = true})
    EFX(
        "particles/econ/items/dazzle/dazzle_darkclaw/dazzle_darkclaw_poison_touch_blood.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.parent,
        {
            cp3 = self.parent:GetAbsOrigin(),
            release = true
        }
    )
    EmitSoundOn("Hero_PhantomAssassin.Attack", self.parent)
    EmitSoundOn("Hero_PhantomAssassin.Dagger.Target", self.parent)
    EmitSoundOn("Hero_PhantomAssassin.Spatter", self.parent)
end
ModifierPhantomBleed = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_bleed"})},
    ModifierPhantomBleed
)
____exports.ModifierPhantomBleed = ModifierPhantomBleed
return ____exports
