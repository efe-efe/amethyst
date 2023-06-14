local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 169,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 5,["21"] = 5,["22"] = 5,["23"] = 5,["24"] = 5,["25"] = 6,["26"] = 6,["27"] = 7,["28"] = 7,["29"] = 9,["30"] = 9,["31"] = 9,["32"] = 10,["33"] = 11,["34"] = 12,["35"] = 13,["36"] = 9,["38"] = 9,["39"] = 10,["40"] = 20,["41"] = 21,["42"] = 22,["43"] = 23,["45"] = 20,["46"] = 28,["47"] = 28,["48"] = 29,["49"] = 30,["50"] = 31,["51"] = 29,["53"] = 29,["54"] = 30,["55"] = 38,["56"] = 39,["57"] = 38,["58"] = 42,["59"] = 43,["60"] = 42,["61"] = 46,["62"] = 47,["63"] = 46,["64"] = 50,["65"] = 51,["66"] = 50,["67"] = 54,["68"] = 55,["69"] = 56,["70"] = 57,["71"] = 58,["72"] = 59,["73"] = 61,["74"] = 62,["75"] = 64,["76"] = 64,["77"] = 64,["78"] = 64,["80"] = 64,["81"] = 66,["82"] = 66,["83"] = 66,["84"] = 66,["85"] = 66,["86"] = 66,["87"] = 66,["88"] = 73,["89"] = 74,["90"] = 74,["91"] = 66,["92"] = 75,["93"] = 76,["94"] = 76,["95"] = 76,["96"] = 76,["97"] = 76,["98"] = 76,["99"] = 76,["100"] = 76,["101"] = 82,["102"] = 83,["103"] = 83,["104"] = 83,["105"] = 83,["106"] = 83,["107"] = 83,["109"] = 89,["110"] = 90,["111"] = 91,["112"] = 91,["113"] = 91,["114"] = 91,["115"] = 91,["116"] = 91,["118"] = 94,["119"] = 95,["121"] = 95,["125"] = 66,["126"] = 99,["127"] = 100,["128"] = 100,["129"] = 100,["130"] = 100,["131"] = 66,["132"] = 66,["133"] = 54,["134"] = 105,["135"] = 106,["136"] = 107,["137"] = 110,["138"] = 111,["139"] = 112,["140"] = 105,["141"] = 29,["142"] = 28,["143"] = 29,["145"] = 123,["146"] = 123,["147"] = 124,["148"] = 125,["149"] = 126,["150"] = 125,["151"] = 129,["152"] = 130,["153"] = 129,["154"] = 133,["155"] = 134,["156"] = 133,["157"] = 137,["158"] = 138,["159"] = 139,["160"] = 140,["161"] = 140,["162"] = 140,["163"] = 140,["164"] = 140,["165"] = 140,["166"] = 140,["167"] = 140,["168"] = 140,["169"] = 142,["170"] = 142,["171"] = 142,["172"] = 143,["173"] = 144,["174"] = 142,["175"] = 142,["176"] = 142,["177"] = 142,["178"] = 142,["179"] = 142,["180"] = 142,["181"] = 142,["182"] = 142,["183"] = 142,["184"] = 142,["185"] = 148,["186"] = 148,["187"] = 148,["188"] = 148,["189"] = 148,["190"] = 148,["191"] = 148,["192"] = 148,["193"] = 148,["194"] = 148,["195"] = 148,["196"] = 137,["197"] = 124,["198"] = 123,["199"] = 124,["201"] = 168,["202"] = 168,["203"] = 169,["204"] = 169,["205"] = 168,["206"] = 169,["208"] = 204,["209"] = 204,["210"] = 205,["211"] = 205,["212"] = 204,["213"] = 205,["215"] = 221,["216"] = 221,["217"] = 222,["218"] = 225,["219"] = 226,["220"] = 227,["221"] = 228,["223"] = 225,["224"] = 236,["225"] = 237,["226"] = 238,["227"] = 239,["229"] = 236,["230"] = 243,["231"] = 244,["232"] = 245,["233"] = 246,["236"] = 243,["237"] = 251,["238"] = 252,["239"] = 251,["240"] = 255,["241"] = 256,["242"] = 255,["243"] = 259,["244"] = 260,["245"] = 259,["246"] = 263,["247"] = 264,["248"] = 263,["249"] = 222,["250"] = 221,["251"] = 222,["253"] = 274,["254"] = 274,["255"] = 275,["256"] = 276,["257"] = 277,["258"] = 278,["259"] = 279,["260"] = 282,["261"] = 283,["262"] = 284,["263"] = 276,["264"] = 275,["265"] = 274,["266"] = 275,["268"] = 288,["269"] = 288,["270"] = 289,["272"] = 289,["273"] = 290,["274"] = 288,["275"] = 292,["276"] = 293,["277"] = 294,["278"] = 295,["279"] = 295,["280"] = 302,["281"] = 302,["283"] = 292,["284"] = 308,["285"] = 309,["286"] = 310,["287"] = 311,["288"] = 313,["289"] = 314,["290"] = 315,["292"] = 317,["293"] = 324,["295"] = 308,["296"] = 327,["297"] = 328,["298"] = 327,["299"] = 289,["300"] = 288,["301"] = 289,["303"] = 338,["304"] = 338,["305"] = 339,["306"] = 351,["307"] = 339,["308"] = 354,["309"] = 355,["310"] = 356,["311"] = 357,["312"] = 359,["313"] = 360,["314"] = 361,["317"] = 365,["318"] = 366,["319"] = 367,["320"] = 368,["321"] = 369,["322"] = 370,["324"] = 351,["325"] = 374,["326"] = 375,["327"] = 376,["328"] = 377,["329"] = 379,["330"] = 380,["331"] = 380,["332"] = 380,["333"] = 380,["334"] = 384,["335"] = 384,["336"] = 384,["337"] = 384,["338"] = 384,["339"] = 384,["340"] = 384,["341"] = 380,["342"] = 380,["344"] = 395,["345"] = 402,["346"] = 402,["347"] = 402,["348"] = 402,["349"] = 406,["350"] = 407,["351"] = 407,["352"] = 407,["353"] = 407,["354"] = 407,["355"] = 407,["356"] = 407,["357"] = 407,["358"] = 407,["359"] = 407,["360"] = 408,["361"] = 413,["362"] = 414,["364"] = 402,["365"] = 402,["366"] = 419,["367"] = 420,["368"] = 421,["370"] = 421,["373"] = 424,["374"] = 425,["376"] = 428,["377"] = 433,["379"] = 435,["380"] = 374,["381"] = 339,["382"] = 338,["383"] = 339,["385"] = 439,["386"] = 439,["387"] = 440,["388"] = 440,["389"] = 439,["390"] = 440});
local ____exports = {}
local ModifierPuckBasicAttack, ModifierPuckFairyDust, ModifierPuckExBasicAttack, ModifierPuckExBasicAttackThinker, ModifierPuckExBasicAttackShield
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_cooldown = require("modifiers.modifier_cooldown")
local ModifierCooldown = ____modifier_cooldown.ModifierCooldown
local ____modifier_shield = require("modifiers.modifier_shield")
local ModifierShield = ____modifier_shield.ModifierShield
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local PuckBasicAttackCommon = __TS__Class()
PuckBasicAttackCommon.name = "PuckBasicAttackCommon"
__TS__ClassExtends(PuckBasicAttackCommon, CustomAbility)
function PuckBasicAttackCommon.prototype.GetCooldown(self, level)
    if IsServer() then
        local attacksPerSecond = self.caster:GetAttacksPerSecond()
        local attackSpeed = 1 / attacksPerSecond
        return CustomAbility.prototype.GetCooldown(self, level) + attackSpeed
    end
    return CustomAbility.prototype.GetCooldown(self, level)
end
function PuckBasicAttackCommon.prototype.PlayEffectsOnCast(self, charged)
    EmitSoundOn("Hero_Puck.Attack", self.caster)
    if charged then
        EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", self.caster)
    end
end
local PuckBasicAttack = __TS__Class()
PuckBasicAttack.name = "PuckBasicAttack"
__TS__ClassExtends(PuckBasicAttack, PuckBasicAttackCommon)
function PuckBasicAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return PuckBasicAttackCommon.prototype.GetCastPoint(self) + self.caster:GetAttackAnimationPoint()
    end
    return PuckBasicAttackCommon.prototype.GetCastPoint(self)
end
function PuckBasicAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function PuckBasicAttack.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckBasicAttack.prototype.GetCastingCrawl(self)
    return 10
end
function PuckBasicAttack.prototype.GetIntrinsicModifierName(self)
    return ModifierPuckBasicAttack.name
end
function PuckBasicAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local fairyDustDuration = self:GetSpecialValueFor("fairy_dust_duration")
    local fairyDustSlowPct = self:GetSpecialValueFor("fairy_dust_slow_pct")
    local ____opt_0 = ModifierPuckBasicAttack:findOne(self.caster)
    local ____temp_2 = ____opt_0 and ____opt_0:IsCooldownReady()
    if ____temp_2 == nil then
        ____temp_2 = false
    end
    local isCharged = ____temp_2
    self:ProjectileAttack({
        source = self.caster,
        attackType = "basic",
        effectName = isCharged and "particles/puck/puck_base_attack_alternative.vpcf" or "particles/puck/puck_base_attack.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
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
            if isCharged then
                ModifierPuckFairyDust:apply(
                    unit,
                    projectile:getSource(),
                    self,
                    {duration = fairyDustDuration, slowPct = fairyDustSlowPct}
                )
            end
            if projectile:getSource() == self.caster and not isObstacle(nil, unit) then
                if not isGem(nil, unit) then
                    giveManaAndEnergyPercent(
                        nil,
                        projectile:getSource(),
                        manaGainPct,
                        true
                    )
                end
                if self:GetLevel() >= 2 then
                    local ____opt_3 = ModifierPuckBasicAttack:findOne(self.caster)
                    if ____opt_3 ~= nil then
                        ____opt_3:Replenish()
                    end
                end
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(
                projectile:getPosition(),
                isCharged
            )
        end
    })
end
function PuckBasicAttack.prototype.PlayEffectsOnFinish(self, position, charged)
    EmitSoundOnLocationWithCaster(position, "Hero_Puck.ProjectileImpact", self.caster)
    local path = charged and "particles/puck/puck_base_attack_alternative_explosion.vpcf" or "particles/puck/puck_base_attack_explosion.vpcf"
    local particleId = ParticleManager:CreateParticle(path, PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
PuckBasicAttack = __TS__Decorate(
    {registerAbility(nil, "puck_basic_attack")},
    PuckBasicAttack
)
local PuckBasicAttackRelated = __TS__Class()
PuckBasicAttackRelated.name = "PuckBasicAttackRelated"
__TS__ClassExtends(PuckBasicAttackRelated, PuckBasicAttackCommon)
function PuckBasicAttackRelated.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function PuckBasicAttackRelated.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckBasicAttackRelated.prototype.GetCastingCrawl(self)
    return 10
end
function PuckBasicAttackRelated.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {maxRange = self:GetCastRange(
            Vector(0, 0, 0),
            nil
        )}
    )
    local ____ModifierPuckExBasicAttackThinker_9 = ModifierPuckExBasicAttackThinker
    local ____ModifierPuckExBasicAttackThinker_createThinker_10 = ModifierPuckExBasicAttackThinker.createThinker
    local ____self_caster_8 = self.caster
    local ____temp_7 = self:GetSpecialValueFor("radius")
    local ____opt_5 = ModifierPuckBasicAttack:findOne(self.caster)
    ____ModifierPuckExBasicAttackThinker_createThinker_10(
        ____ModifierPuckExBasicAttackThinker_9,
        ____self_caster_8,
        self,
        point,
        {
            radius = ____temp_7,
            status = ____opt_5 and ____opt_5:IsCooldownReady() and "charged" or "notCharged",
            delayTime = self:GetSpecialValueFor("delay_time")
        }
    )
    EFX(
        "particles/econ/items/invoker/invoker_ti7/invoker_ti7_alacrity_cast.vpcf",
        PATTACH_CUSTOMORIGIN,
        self.caster,
        {
            cp0 = {ent = self.caster, point = "attach_hitloc"},
            cp1 = point + Vector(0, 0, 1000),
            cp2 = point + Vector(0, 0, 1000),
            release = true
        }
    )
end
PuckBasicAttackRelated = __TS__Decorate(
    {registerAbility(nil, "puck_basic_attack_related")},
    PuckBasicAttackRelated
)
ModifierPuckBasicAttack = __TS__Class()
ModifierPuckBasicAttack.name = "ModifierPuckBasicAttack"
__TS__ClassExtends(ModifierPuckBasicAttack, ModifierCooldown)
ModifierPuckBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_basic_attack_cooldown"})},
    ModifierPuckBasicAttack
)
local ModifierPuckBasicAttackBuff = __TS__Class()
ModifierPuckBasicAttackBuff.name = "ModifierPuckBasicAttackBuff"
__TS__ClassExtends(ModifierPuckBasicAttackBuff, CustomModifier)
ModifierPuckBasicAttackBuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_basic_attack_buff"})},
    ModifierPuckBasicAttackBuff
)
ModifierPuckFairyDust = __TS__Class()
ModifierPuckFairyDust.name = "ModifierPuckFairyDust"
__TS__ClassExtends(ModifierPuckFairyDust, CustomModifier)
function ModifierPuckFairyDust.prototype.OnCreated(self, params)
    if IsServer() then
        self:SetStackCount(params.slowPct)
        self.particleId = ParticleManager:CreateParticle("particles/puck/puck_mobility_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierPuckFairyDust.prototype.OnDestroy(self)
    if IsServer() and self.particleId then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierPuckFairyDust.prototype.OnRefresh(self, params)
    if IsServer() then
        if params.slowPct > self:GetStackCount() then
            self:SetStackCount(params.slowPct)
        end
    end
end
function ModifierPuckFairyDust.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierPuckFairyDust.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return -self:GetStackCount()
end
function ModifierPuckFairyDust.prototype.GetStatusEffectName(self)
    return "particles/status_fx/status_effect_combo_breaker.vpcf"
end
function ModifierPuckFairyDust.prototype.GetTexture(self)
    return "modifier_puck_fairy_dust"
end
ModifierPuckFairyDust = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_fairy_dust"})},
    ModifierPuckFairyDust
)
local PuckExBasicAttack = __TS__Class()
PuckExBasicAttack.name = "PuckExBasicAttack"
__TS__ClassExtends(PuckExBasicAttack, CustomAbility)
function PuckExBasicAttack.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    ModifierPuckExBasicAttack:apply(self.caster, self.caster, self, {duration = duration})
    EFX("particles/puck/puck_ex_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {release = true})
    EmitSoundOn("puck_puck_laugh_01", self.caster)
    EmitSoundOn("Hero_Puck.EtherealJaunt", self.caster)
    EmitSoundOn("Hero_Puck.Phase_Shift", self.caster)
end
PuckExBasicAttack = __TS__Decorate(
    {registerAbility(nil, "puck_ex_basic_attack")},
    PuckExBasicAttack
)
ModifierPuckExBasicAttack = __TS__Class()
ModifierPuckExBasicAttack.name = "ModifierPuckExBasicAttack"
__TS__ClassExtends(ModifierPuckExBasicAttack, CustomModifier)
function ModifierPuckExBasicAttack.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.particleIds = {}
end
function ModifierPuckExBasicAttack.prototype.OnCreated(self)
    if IsServer() then
        self.parent:SwapAbilities(PuckBasicAttack.name, PuckBasicAttackRelated.name, false, true)
        local ____self_particleIds_11 = self.particleIds
        ____self_particleIds_11[#____self_particleIds_11 + 1] = ParticleManager:CreateParticle("particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_trail_embers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
        local ____self_particleIds_12 = self.particleIds
        ____self_particleIds_12[#____self_particleIds_12 + 1] = ParticleManager:CreateParticle("particles/puck/puck_mobility_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierPuckExBasicAttack.prototype.OnDestroy(self)
    StopSoundOn("Hero_Puck.Phase_Shift", self.parent)
    if IsServer() then
        self.parent:SwapAbilities(PuckBasicAttack.name, PuckBasicAttackRelated.name, true, false)
        for ____, particleId in ipairs(self.particleIds) do
            ParticleManager:DestroyParticle(particleId, false)
            ParticleManager:ReleaseParticleIndex(particleId)
        end
        ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent))
        self.ability:StartCooldown(self.ability:GetCooldown(0))
    end
end
function ModifierPuckExBasicAttack.prototype.GetStatusEffectName(self)
    return "particles/status_fx/status_effect_ghost.vpcf"
end
ModifierPuckExBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ex_basic_attack"})},
    ModifierPuckExBasicAttack
)
ModifierPuckExBasicAttackThinker = __TS__Class()
ModifierPuckExBasicAttackThinker.name = "ModifierPuckExBasicAttackThinker"
__TS__ClassExtends(ModifierPuckExBasicAttackThinker, ModifierThinker)
function ModifierPuckExBasicAttackThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
        self.manaGainPct = self.ability:GetSpecialValueFor("mana_gain_pct")
        self.exBasicAttack = PuckExBasicAttack:findOne(self.parent)
        if not self.exBasicAttack then
            print("[ERROR] On PuckBasicAttackRelated: Can't find PuckExBasicAttack to get the values!")
            self:Destroy()
            return
        end
        self.duration = self.exBasicAttack:GetSpecialValueFor("duration")
        self.shieldPerHit = self.exBasicAttack:GetSpecialValueFor("shield_per_hit")
        self.healPerHit = self.exBasicAttack:GetSpecialValueFor("heal_per_hit")
        self.fairyDustDuration = self.exBasicAttack:GetSpecialValueFor("fairy_dust_duration")
        self.fairyDustSlowPct = self.exBasicAttack:GetSpecialValueFor("fairy_dust_slow_pct")
        self.charged = params.status == "charged"
    end
end
function ModifierPuckExBasicAttackThinker.prototype.OnReady(self)
    EmitSoundOn("Hero_Leshrac.Lightning_Storm", self.parent)
    local color = self.charged and Vector(100, 0, 0) or Vector(0, 0, 0)
    local giveMana = false
    if self.charged then
        EFX(
            "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf",
            PATTACH_WORLDORIGIN,
            nil,
            {
                cp0 = self.origin,
                cp1 = Vector(200, 0, 0),
                cp2 = Vector(2, 1, 1),
                cp3 = Vector(255, 0, 229),
                cp4 = Vector(250, 0, 255),
                release = true
            }
        )
    end
    EFX("particles/puck/puck_basic_attack_related.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = self.origin, cp1 = self.origin, cp6 = color, release = true})
    self.ability:AoeAttack({
        attackType = "basic",
        origin = self.origin,
        radius = self.radius,
        effect = function(____, target)
            self.caster:PerformAttack(
                target,
                true,
                true,
                true,
                true,
                false,
                false,
                true
            )
            ModifierPuckFairyDust:apply(self.caster, self.caster, self.ability, {duration = self.fairyDustDuration, slowPct = self.fairyDustSlowPct})
            if not isObstacle(nil, target) then
                giveMana = true
            end
        end
    })
    if giveMana then
        if self.ability:GetLevel() >= 2 then
            local ____opt_13 = ModifierPuckBasicAttack:findOne(self.caster)
            if ____opt_13 ~= nil then
                ____opt_13:Replenish()
            end
        end
        if self.exBasicAttack and self.exBasicAttack:GetLevel() >= 2 then
            self.caster:Heal(self.healPerHit, self.ability)
        end
        ModifierPuckExBasicAttackShield:apply(self.caster, self.caster, nil, {duration = 6, damageBlock = self.shieldPerHit})
        giveManaAndEnergyPercent(nil, self.caster, self.manaGainPct, true)
    end
    self:Destroy()
end
ModifierPuckExBasicAttackThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_basic_attack_thinker"})},
    ModifierPuckExBasicAttackThinker
)
ModifierPuckExBasicAttackShield = __TS__Class()
ModifierPuckExBasicAttackShield.name = "ModifierPuckExBasicAttackShield"
__TS__ClassExtends(ModifierPuckExBasicAttackShield, ModifierShield)
ModifierPuckExBasicAttackShield = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ex_basic_attack_shield"})},
    ModifierPuckExBasicAttackShield
)
return ____exports
