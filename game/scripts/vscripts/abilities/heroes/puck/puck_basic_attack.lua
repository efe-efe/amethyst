local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 215,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 6,["23"] = 6,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 6,["28"] = 7,["29"] = 7,["30"] = 8,["31"] = 8,["32"] = 10,["33"] = 10,["34"] = 10,["35"] = 11,["36"] = 12,["37"] = 13,["38"] = 14,["39"] = 10,["41"] = 10,["42"] = 11,["43"] = 21,["44"] = 22,["45"] = 23,["46"] = 24,["48"] = 21,["49"] = 29,["50"] = 30,["51"] = 29,["52"] = 30,["53"] = 31,["54"] = 32,["55"] = 30,["57"] = 30,["58"] = 31,["59"] = 39,["60"] = 40,["61"] = 39,["62"] = 43,["63"] = 44,["64"] = 43,["65"] = 47,["66"] = 48,["67"] = 47,["68"] = 51,["69"] = 52,["70"] = 51,["71"] = 55,["72"] = 56,["73"] = 57,["74"] = 59,["75"] = 55,["76"] = 62,["77"] = 63,["78"] = 64,["79"] = 65,["80"] = 67,["81"] = 68,["82"] = 70,["83"] = 70,["84"] = 70,["85"] = 70,["87"] = 70,["88"] = 72,["89"] = 72,["90"] = 72,["91"] = 72,["92"] = 72,["93"] = 72,["94"] = 72,["95"] = 79,["96"] = 80,["97"] = 80,["98"] = 72,["99"] = 81,["100"] = 82,["101"] = 82,["102"] = 82,["103"] = 82,["104"] = 82,["105"] = 82,["106"] = 82,["107"] = 82,["108"] = 88,["109"] = 89,["110"] = 89,["111"] = 89,["112"] = 89,["113"] = 89,["114"] = 89,["116"] = 95,["117"] = 96,["118"] = 97,["119"] = 97,["120"] = 97,["121"] = 97,["122"] = 97,["123"] = 97,["125"] = 100,["126"] = 101,["128"] = 101,["132"] = 72,["133"] = 105,["134"] = 106,["135"] = 106,["136"] = 106,["137"] = 106,["138"] = 72,["139"] = 72,["140"] = 62,["141"] = 111,["142"] = 112,["143"] = 113,["144"] = 116,["145"] = 117,["146"] = 118,["147"] = 111,["148"] = 30,["149"] = 29,["150"] = 30,["152"] = 30,["153"] = 129,["154"] = 130,["155"] = 129,["156"] = 130,["157"] = 131,["158"] = 132,["159"] = 131,["160"] = 135,["161"] = 136,["162"] = 135,["163"] = 139,["164"] = 140,["165"] = 139,["166"] = 143,["167"] = 144,["168"] = 145,["169"] = 146,["170"] = 146,["171"] = 146,["172"] = 146,["173"] = 146,["174"] = 146,["175"] = 146,["176"] = 146,["177"] = 146,["178"] = 148,["179"] = 148,["180"] = 148,["181"] = 149,["182"] = 150,["183"] = 148,["184"] = 148,["185"] = 148,["186"] = 148,["187"] = 148,["188"] = 148,["189"] = 148,["190"] = 148,["191"] = 148,["192"] = 148,["193"] = 148,["194"] = 154,["195"] = 154,["196"] = 154,["197"] = 154,["198"] = 154,["199"] = 154,["200"] = 154,["201"] = 154,["202"] = 154,["203"] = 154,["204"] = 154,["205"] = 143,["206"] = 130,["207"] = 129,["208"] = 130,["210"] = 130,["211"] = 174,["212"] = 175,["213"] = 174,["214"] = 175,["215"] = 176,["216"] = 177,["217"] = 176,["218"] = 180,["219"] = 181,["222"] = 185,["223"] = 186,["225"] = 189,["226"] = 180,["227"] = 192,["228"] = 193,["229"] = 194,["231"] = 197,["232"] = 192,["233"] = 200,["234"] = 201,["235"] = 202,["237"] = 200,["238"] = 206,["239"] = 207,["240"] = 206,["241"] = 175,["242"] = 174,["243"] = 175,["245"] = 175,["246"] = 214,["247"] = 214,["248"] = 215,["249"] = 216,["250"] = 217,["251"] = 216,["252"] = 220,["253"] = 221,["254"] = 220,["255"] = 215,["256"] = 214,["257"] = 215,["259"] = 231,["260"] = 232,["261"] = 231,["262"] = 232,["263"] = 235,["264"] = 236,["265"] = 237,["266"] = 238,["268"] = 235,["269"] = 246,["270"] = 247,["271"] = 248,["272"] = 249,["274"] = 246,["275"] = 253,["276"] = 254,["277"] = 255,["278"] = 256,["281"] = 253,["282"] = 261,["283"] = 262,["284"] = 261,["285"] = 265,["286"] = 266,["287"] = 265,["288"] = 269,["289"] = 270,["290"] = 269,["291"] = 273,["292"] = 274,["293"] = 273,["294"] = 232,["295"] = 231,["296"] = 232,["298"] = 232,["299"] = 284,["300"] = 284,["301"] = 285,["302"] = 286,["303"] = 287,["304"] = 288,["305"] = 289,["306"] = 292,["307"] = 293,["308"] = 294,["309"] = 286,["310"] = 285,["311"] = 284,["312"] = 285,["314"] = 298,["315"] = 298,["316"] = 299,["318"] = 299,["319"] = 300,["320"] = 298,["321"] = 302,["322"] = 303,["323"] = 304,["324"] = 305,["325"] = 305,["326"] = 312,["327"] = 312,["329"] = 302,["330"] = 318,["331"] = 319,["332"] = 320,["333"] = 321,["334"] = 323,["335"] = 324,["336"] = 325,["338"] = 327,["339"] = 334,["341"] = 318,["342"] = 337,["343"] = 338,["344"] = 337,["345"] = 299,["346"] = 298,["347"] = 299,["349"] = 348,["350"] = 348,["351"] = 349,["352"] = 361,["353"] = 349,["354"] = 364,["355"] = 365,["356"] = 366,["357"] = 367,["358"] = 369,["359"] = 370,["360"] = 371,["363"] = 375,["364"] = 376,["365"] = 377,["366"] = 378,["367"] = 379,["368"] = 380,["370"] = 361,["371"] = 384,["372"] = 385,["373"] = 386,["374"] = 387,["375"] = 389,["376"] = 390,["377"] = 390,["378"] = 390,["379"] = 390,["380"] = 394,["381"] = 394,["382"] = 394,["383"] = 394,["384"] = 394,["385"] = 394,["386"] = 394,["387"] = 390,["388"] = 390,["390"] = 405,["391"] = 412,["392"] = 412,["393"] = 412,["394"] = 412,["395"] = 416,["396"] = 417,["397"] = 417,["398"] = 417,["399"] = 417,["400"] = 417,["401"] = 417,["402"] = 417,["403"] = 417,["404"] = 417,["405"] = 417,["406"] = 418,["407"] = 423,["408"] = 424,["410"] = 412,["411"] = 412,["412"] = 429,["413"] = 430,["414"] = 431,["416"] = 431,["419"] = 434,["420"] = 435,["422"] = 438,["423"] = 443,["425"] = 445,["426"] = 384,["427"] = 349,["428"] = 348,["429"] = 349,["431"] = 449,["432"] = 449,["433"] = 450,["434"] = 450,["435"] = 449,["436"] = 450});
local ____exports = {}
local ModifierPuckBasicAttackBuff, ModifierPuckExBasicAttack, ModifierPuckExBasicAttackThinker, ModifierPuckExBasicAttackShield
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
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
local replenishEFX = ____util.replenishEFX
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
____exports.PuckBasicAttack = __TS__Class()
local PuckBasicAttack = ____exports.PuckBasicAttack
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
    return ____exports.ModifierPuckBasicAttack.name
end
function PuckBasicAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    self:LaunchProjectile(origin, point)
end
function PuckBasicAttack.prototype.LaunchProjectile(self, origin, point)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local fairyDustDuration = self:GetSpecialValueFor("fairy_dust_duration")
    local fairyDustSlowPct = self:GetSpecialValueFor("fairy_dust_slow_pct")
    local ____opt_0 = ____exports.ModifierPuckBasicAttack:findOne(self.caster)
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
                ____exports.ModifierPuckFairyDust:apply(
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
                    local ____opt_3 = ____exports.ModifierPuckBasicAttack:findOne(self.caster)
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
____exports.PuckBasicAttack = PuckBasicAttack
____exports.PuckBasicAttackRelated = __TS__Class()
local PuckBasicAttackRelated = ____exports.PuckBasicAttackRelated
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
    local ____opt_5 = ____exports.ModifierPuckBasicAttack:findOne(self.caster)
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
____exports.PuckBasicAttackRelated = PuckBasicAttackRelated
____exports.ModifierPuckBasicAttack = __TS__Class()
local ModifierPuckBasicAttack = ____exports.ModifierPuckBasicAttack
ModifierPuckBasicAttack.name = "ModifierPuckBasicAttack"
__TS__ClassExtends(ModifierPuckBasicAttack, ModifierCooldown)
function ModifierPuckBasicAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
end
function ModifierPuckBasicAttack.prototype.OnBasicAttackStarted(self)
    if self:GetRemainingTime() > 0 then
        return
    end
    if IsServer() then
        ModifierPuckBasicAttackBuff:apply(self.parent, self.parent, self.ability, {})
    end
    self:StartCooldown()
end
function ModifierPuckBasicAttack.prototype.GetModifierPreAttack_BonusDamage(self)
    if not self:IsCooldownReady() then
        return 0
    end
    return self:Value("charged_damage")
end
function ModifierPuckBasicAttack.prototype.OnReplenish(self)
    if IsServer() then
        replenishEFX(nil, self.parent)
    end
end
function ModifierPuckBasicAttack.prototype.GetReplenishTime(self)
    return self:Value("replenish_time")
end
ModifierPuckBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_basic_attack_cooldown"})},
    ModifierPuckBasicAttack
)
____exports.ModifierPuckBasicAttack = ModifierPuckBasicAttack
ModifierPuckBasicAttackBuff = __TS__Class()
ModifierPuckBasicAttackBuff.name = "ModifierPuckBasicAttackBuff"
__TS__ClassExtends(ModifierPuckBasicAttackBuff, ModifierCombatEvents)
function ModifierPuckBasicAttackBuff.prototype.IsHidden(self)
    return true
end
function ModifierPuckBasicAttackBuff.prototype.OnBasicAttackEnded(self)
    self:Destroy()
end
ModifierPuckBasicAttackBuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_basic_attack_buff"})},
    ModifierPuckBasicAttackBuff
)
____exports.ModifierPuckFairyDust = __TS__Class()
local ModifierPuckFairyDust = ____exports.ModifierPuckFairyDust
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
____exports.ModifierPuckFairyDust = ModifierPuckFairyDust
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
        self.parent:SwapAbilities(____exports.PuckBasicAttack.name, ____exports.PuckBasicAttackRelated.name, false, true)
        local ____self_particleIds_11 = self.particleIds
        ____self_particleIds_11[#____self_particleIds_11 + 1] = ParticleManager:CreateParticle("particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_trail_embers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
        local ____self_particleIds_12 = self.particleIds
        ____self_particleIds_12[#____self_particleIds_12 + 1] = ParticleManager:CreateParticle("particles/puck/puck_mobility_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierPuckExBasicAttack.prototype.OnDestroy(self)
    StopSoundOn("Hero_Puck.Phase_Shift", self.parent)
    if IsServer() then
        self.parent:SwapAbilities(____exports.PuckBasicAttack.name, ____exports.PuckBasicAttackRelated.name, true, false)
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
        self.exBasicAttack = PuckExBasicAttack:findOne(self.caster)
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
            ____exports.ModifierPuckFairyDust:apply(self.caster, self.caster, self.ability, {duration = self.fairyDustDuration, slowPct = self.fairyDustSlowPct})
            if not isObstacle(nil, target) then
                giveMana = true
            end
        end
    })
    if giveMana then
        if self.ability:GetLevel() >= 2 then
            local ____opt_13 = ____exports.ModifierPuckBasicAttack:findOne(self.caster)
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
