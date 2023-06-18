local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 211,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 6,["22"] = 6,["23"] = 6,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 7,["28"] = 7,["29"] = 8,["30"] = 8,["31"] = 10,["32"] = 10,["33"] = 11,["34"] = 12,["35"] = 13,["36"] = 12,["37"] = 16,["38"] = 17,["39"] = 16,["40"] = 20,["41"] = 21,["42"] = 20,["43"] = 24,["44"] = 25,["45"] = 26,["46"] = 27,["47"] = 28,["48"] = 29,["49"] = 30,["50"] = 31,["51"] = 32,["52"] = 33,["53"] = 34,["54"] = 35,["55"] = 36,["56"] = 36,["57"] = 36,["58"] = 36,["59"] = 37,["60"] = 39,["61"] = 39,["62"] = 39,["63"] = 39,["64"] = 39,["65"] = 39,["66"] = 39,["67"] = 39,["68"] = 39,["69"] = 39,["70"] = 50,["71"] = 51,["72"] = 51,["73"] = 39,["74"] = 52,["75"] = 53,["76"] = 59,["77"] = 59,["78"] = 59,["79"] = 59,["80"] = 59,["81"] = 59,["82"] = 60,["83"] = 61,["84"] = 62,["87"] = 65,["88"] = 39,["89"] = 67,["90"] = 68,["91"] = 68,["92"] = 68,["93"] = 68,["94"] = 68,["95"] = 68,["96"] = 39,["97"] = 39,["98"] = 77,["99"] = 77,["100"] = 77,["101"] = 77,["102"] = 77,["103"] = 77,["104"] = 77,["105"] = 77,["106"] = 77,["107"] = 77,["108"] = 77,["109"] = 77,["110"] = 77,["111"] = 77,["112"] = 77,["113"] = 77,["114"] = 77,["115"] = 77,["116"] = 77,["117"] = 77,["118"] = 98,["119"] = 99,["120"] = 24,["121"] = 103,["122"] = 104,["123"] = 105,["124"] = 110,["125"] = 103,["126"] = 11,["127"] = 10,["128"] = 11,["130"] = 114,["131"] = 114,["132"] = 115,["133"] = 116,["134"] = 117,["135"] = 116,["136"] = 120,["137"] = 121,["138"] = 120,["139"] = 124,["140"] = 125,["141"] = 124,["142"] = 128,["143"] = 129,["144"] = 130,["145"] = 131,["146"] = 131,["147"] = 131,["148"] = 131,["149"] = 131,["150"] = 131,["151"] = 131,["152"] = 131,["153"] = 131,["154"] = 132,["155"] = 134,["156"] = 134,["157"] = 134,["158"] = 134,["159"] = 134,["160"] = 134,["161"] = 134,["162"] = 134,["163"] = 134,["164"] = 134,["165"] = 134,["166"] = 147,["167"] = 147,["168"] = 147,["169"] = 147,["170"] = 147,["171"] = 147,["172"] = 147,["173"] = 147,["174"] = 147,["175"] = 128,["176"] = 115,["177"] = 114,["178"] = 115,["180"] = 162,["181"] = 162,["182"] = 163,["184"] = 163,["185"] = 164,["186"] = 162,["187"] = 166,["188"] = 167,["189"] = 168,["190"] = 169,["191"] = 169,["192"] = 169,["193"] = 169,["194"] = 169,["195"] = 169,["196"] = 169,["197"] = 169,["198"] = 169,["199"] = 171,["200"] = 172,["201"] = 173,["203"] = 176,["204"] = 176,["205"] = 176,["206"] = 176,["207"] = 176,["208"] = 176,["209"] = 176,["210"] = 176,["211"] = 176,["212"] = 176,["213"] = 176,["214"] = 188,["215"] = 190,["216"] = 166,["217"] = 193,["218"] = 194,["219"] = 194,["220"] = 193,["221"] = 197,["222"] = 198,["223"] = 197,["224"] = 163,["225"] = 162,["226"] = 163,["228"] = 210,["229"] = 210,["230"] = 211,["231"] = 215,["232"] = 216,["233"] = 215,["234"] = 219,["235"] = 220,["236"] = 219,["237"] = 223,["238"] = 224,["239"] = 223,["240"] = 227,["241"] = 228,["242"] = 227,["243"] = 231,["244"] = 232,["245"] = 231,["246"] = 235,["247"] = 236,["248"] = 235,["249"] = 239,["250"] = 240,["251"] = 239,["252"] = 243,["253"] = 211,["254"] = 246,["255"] = 247,["257"] = 243,["258"] = 251,["259"] = 211,["260"] = 254,["261"] = 255,["262"] = 256,["264"] = 251,["265"] = 260,["266"] = 261,["267"] = 266,["268"] = 266,["269"] = 266,["270"] = 266,["271"] = 266,["272"] = 267,["273"] = 267,["274"] = 267,["275"] = 267,["276"] = 267,["277"] = 269,["278"] = 274,["279"] = 274,["280"] = 274,["281"] = 274,["282"] = 274,["283"] = 275,["284"] = 275,["285"] = 275,["286"] = 275,["287"] = 275,["288"] = 260,["289"] = 278,["290"] = 279,["291"] = 280,["292"] = 281,["294"] = 283,["295"] = 284,["296"] = 285,["298"] = 278,["299"] = 211,["300"] = 210,["301"] = 211,["303"] = 290,["304"] = 291,["305"] = 290,["306"] = 291,["307"] = 292,["308"] = 293,["309"] = 294,["311"] = 292,["312"] = 298,["313"] = 299,["314"] = 300,["315"] = 300,["316"] = 300,["317"] = 300,["318"] = 300,["319"] = 300,["320"] = 300,["321"] = 300,["322"] = 300,["323"] = 304,["324"] = 305,["325"] = 306,["326"] = 306,["327"] = 306,["328"] = 306,["329"] = 306,["330"] = 307,["331"] = 307,["332"] = 307,["333"] = 307,["334"] = 307,["335"] = 308,["336"] = 298,["337"] = 311,["338"] = 312,["339"] = 311,["340"] = 315,["341"] = 316,["342"] = 315,["343"] = 291,["344"] = 290,["345"] = 291,["347"] = 291,["348"] = 320,["349"] = 321,["350"] = 320,["351"] = 321,["352"] = 324,["353"] = 325,["354"] = 324,["355"] = 328,["356"] = 329,["357"] = 328,["358"] = 332,["359"] = 333,["360"] = 332,["361"] = 336,["362"] = 337,["363"] = 338,["365"] = 336,["366"] = 342,["367"] = 343,["368"] = 344,["369"] = 344,["370"] = 344,["371"] = 344,["372"] = 344,["373"] = 344,["374"] = 344,["375"] = 344,["376"] = 344,["377"] = 344,["378"] = 349,["380"] = 342,["381"] = 353,["382"] = 354,["383"] = 354,["384"] = 354,["385"] = 354,["386"] = 354,["387"] = 353,["388"] = 361,["389"] = 362,["390"] = 361,["391"] = 365,["392"] = 366,["393"] = 365,["394"] = 369,["395"] = 370,["396"] = 371,["397"] = 372,["400"] = 376,["401"] = 369,["402"] = 379,["403"] = 380,["404"] = 379,["405"] = 383,["406"] = 384,["407"] = 389,["408"] = 389,["409"] = 389,["410"] = 389,["411"] = 389,["412"] = 389,["413"] = 389,["414"] = 389,["415"] = 389,["416"] = 383,["417"] = 400,["418"] = 401,["419"] = 402,["420"] = 403,["422"] = 400,["423"] = 321,["424"] = 320,["425"] = 321,["427"] = 321,["428"] = 408,["429"] = 408,["430"] = 409,["431"] = 413,["432"] = 409,["433"] = 416,["434"] = 417,["435"] = 418,["436"] = 423,["437"] = 423,["438"] = 423,["439"] = 423,["440"] = 423,["441"] = 424,["442"] = 424,["443"] = 424,["444"] = 424,["445"] = 424,["446"] = 425,["447"] = 425,["448"] = 425,["449"] = 425,["450"] = 425,["451"] = 426,["452"] = 426,["453"] = 426,["454"] = 426,["455"] = 426,["457"] = 413,["458"] = 430,["459"] = 431,["460"] = 432,["461"] = 433,["462"] = 433,["464"] = 435,["465"] = 435,["466"] = 435,["467"] = 435,["468"] = 435,["469"] = 435,["470"] = 435,["471"] = 435,["472"] = 435,["473"] = 445,["474"] = 446,["475"] = 446,["476"] = 446,["477"] = 446,["478"] = 446,["479"] = 446,["480"] = 447,["481"] = 447,["483"] = 449,["484"] = 454,["485"] = 454,["486"] = 454,["487"] = 454,["488"] = 454,["489"] = 455,["490"] = 455,["491"] = 455,["492"] = 455,["493"] = 455,["494"] = 456,["496"] = 459,["497"] = 460,["498"] = 460,["499"] = 460,["500"] = 460,["501"] = 460,["502"] = 460,["503"] = 460,["504"] = 460,["505"] = 460,["506"] = 460,["508"] = 466,["509"] = 430,["510"] = 469,["511"] = 470,["512"] = 471,["513"] = 473,["514"] = 474,["515"] = 475,["517"] = 478,["518"] = 478,["519"] = 478,["520"] = 478,["521"] = 478,["522"] = 478,["523"] = 478,["524"] = 478,["525"] = 478,["526"] = 478,["527"] = 478,["529"] = 469,["530"] = 409,["531"] = 408,["532"] = 409,["534"] = 488,["535"] = 488,["536"] = 489,["537"] = 489,["538"] = 488,["539"] = 489,["541"] = 493,["542"] = 493,["543"] = 494,["544"] = 495,["545"] = 496,["546"] = 496,["547"] = 494,["548"] = 496,["549"] = 496,["550"] = 495,["551"] = 502,["552"] = 494,["553"] = 504,["554"] = 505,["555"] = 510,["556"] = 510,["557"] = 510,["558"] = 510,["559"] = 510,["560"] = 511,["561"] = 511,["562"] = 511,["563"] = 511,["564"] = 511,["565"] = 512,["566"] = 513,["567"] = 513,["568"] = 513,["569"] = 513,["570"] = 513,["571"] = 513,["572"] = 513,["573"] = 513,["574"] = 513,["576"] = 502,["577"] = 494,["578"] = 493,["579"] = 494});
local ____exports = {}
local ModifierSpectreSpecialAttackThinker, ModifierSpectreExSpecialAttackThinker, ModifierSpectreExSpecialAttackRecast, ModifierSpectreExSpecialAttackBanish
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
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
local SpectreSpecialAttack = __TS__Class()
SpectreSpecialAttack.name = "SpectreSpecialAttack"
__TS__ClassExtends(SpectreSpecialAttack, CustomAbility)
function SpectreSpecialAttack.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SpectreSpecialAttack.prototype.GetPlaybackRateOverride(self)
    return 0.7
end
function SpectreSpecialAttack.prototype.GetCastingCrawl(self)
    return 20
end
function SpectreSpecialAttack.prototype.OnSpellStart(self)
    local damage = self:GetSpecialValueFor("ability_damage")
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local projectileName = "particles/spectre/spectre_special_attack.vpcf"
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local hitbox = self:GetSpecialValueFor("hitbox")
    local pathDuration = self:GetSpecialValueFor("path_duration")
    local radius = self:GetSpecialValueFor("radius")
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local debuffDuration = self:GetSpecialValueFor("debuff_duration")
    local projectileDirection = direction2D(nil, origin, point)
    local projectileDistance = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local projectileVelocity = projectileDirection:__mul(projectileSpeed)
    self:ProjectileAttack({
        source = self.caster,
        effectName = projectileName,
        spawnOrigin = origin,
        velocity = projectileVelocity,
        groundOffset = 0,
        unitBehavior = ProjectileBehavior.NOTHING,
        wallBehavior = ProjectileBehavior.NOTHING,
        groundLock = true,
        isDestructible = false,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({victim = unit, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
            ____exports.ModifierSpectreSpecialAttackDebuff:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = debuffDuration}
            )
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
                end
            end
            self:PlayEffectsOnImpact(unit)
        end,
        afterUpdate = function(____, projectile)
            ModifierSpectreSpecialAttackThinker:createThinker(
                self.caster,
                self,
                projectile:getPosition(),
                {duration = pathDuration, radius = radius, visibility = "collapse"}
            )
        end
    })
    local info = {
        Source = self.caster,
        Ability = self,
        vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128),
        bDeleteOnHit = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = projectileName,
        fDistance = projectileDistance,
        fStartRadius = hitbox,
        fEndRadius = hitbox,
        vVelocity = projectileVelocity,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        fExpireTime = GameRules:GetGameTime() + 8,
        bProvidesVision = true,
        iVisionTeamNumber = self.caster:GetTeamNumber(),
        iVisionRadius = hitbox
    }
    ProjectileManager:CreateLinearProjectile(info)
    EmitSoundOn("Hero_Spectre.DaggerCast", self.caster)
end
function SpectreSpecialAttack.prototype.PlayEffectsOnImpact(self, target)
    EmitSoundOn("Hero_Spectre.DaggerImpact", target)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner_impact.vpcf", PATTACH_ABSORIGIN, target)
    ParticleManager:ReleaseParticleIndex(particleId)
end
SpectreSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "spectre_special_attack")},
    SpectreSpecialAttack
)
local SpectreExSpecialAttack = __TS__Class()
SpectreExSpecialAttack.name = "SpectreExSpecialAttack"
__TS__ClassExtends(SpectreExSpecialAttack, CustomAbility)
function SpectreExSpecialAttack.prototype.GetAnimation(self)
    return ACT_DOTA_FLAIL
end
function SpectreExSpecialAttack.prototype.GetPlaybackRateOverride(self)
    return 1
end
function SpectreExSpecialAttack.prototype.GetCastingCrawl(self)
    return 0
end
function SpectreExSpecialAttack.prototype.OnSpellStart(self)
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
    EmitSoundOn("Hero_Spectre.Haunt", self.caster)
    EFX(
        "particles/spectre/spectre_illusion_warp.vpcf",
        PATTACH_CUSTOMORIGIN,
        self.caster,
        {
            cp0 = {ent = self.caster, point = "attach_hitloc"},
            cp1 = point:__add(Vector(0, 0, 128)),
            cp2 = {ent = self.caster, point = "attach_hitloc"},
            release = true
        }
    )
    ModifierSpectreExSpecialAttackThinker:createThinker(
        self.caster,
        self,
        point,
        {
            radius = self:GetSpecialValueFor("radius"),
            delayTime = self:GetSpecialValueFor("delay_time")
        }
    )
end
SpectreExSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "spectre_ex_special_attack")},
    SpectreExSpecialAttack
)
local SpectreExSpecialAttackRecast = __TS__Class()
SpectreExSpecialAttackRecast.name = "SpectreExSpecialAttackRecast"
__TS__ClassExtends(SpectreExSpecialAttackRecast, CustomAbility)
function SpectreExSpecialAttackRecast.prototype.____constructor(self, ...)
    CustomAbility.prototype.____constructor(self, ...)
    self.targets = {}
end
function SpectreExSpecialAttackRecast.prototype.OnSpellStart(self)
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
    for ____, target in ipairs(self.targets) do
        target:RemoveModifierByName(ModifierSpectreExSpecialAttackBanish.name)
        FindClearSpaceForUnit(target, point, true)
    end
    EFX(
        "particles/spectre/spectre_illusion_warp.vpcf",
        PATTACH_CUSTOMORIGIN,
        self.caster,
        {
            cp0 = {ent = self.caster, point = "attach_hitloc"},
            cp1 = point:__add(Vector(0, 0, 128)),
            cp2 = {ent = self.caster, point = "attach_hitloc"},
            release = true
        }
    )
    EmitSoundOnLocationWithCaster(point, "Hero_Spectre.Reality", self.caster)
    self:ClearTargets()
end
function SpectreExSpecialAttackRecast.prototype.AddTarget(self, target)
    local ____self_targets_0 = self.targets
    ____self_targets_0[#____self_targets_0 + 1] = target
end
function SpectreExSpecialAttackRecast.prototype.ClearTargets(self)
    self.targets = {}
end
SpectreExSpecialAttackRecast = __TS__Decorate(
    {registerAbility(nil, "spectre_ex_special_attack_recast")},
    SpectreExSpecialAttackRecast
)
ModifierSpectreSpecialAttackThinker = __TS__Class()
ModifierSpectreSpecialAttackThinker.name = "ModifierSpectreSpecialAttackThinker"
__TS__ClassExtends(ModifierSpectreSpecialAttackThinker, ModifierThinker)
function ModifierSpectreSpecialAttackThinker.prototype.IsAura(self)
    return true
end
function ModifierSpectreSpecialAttackThinker.prototype.GetModifierAura(self)
    return ____exports.ModifierSpectreSpecialAttackBuff.name
end
function ModifierSpectreSpecialAttackThinker.prototype.GetAuraRadius(self)
    return self.radius
end
function ModifierSpectreSpecialAttackThinker.prototype.GetAuraDuration(self)
    return self:Value("buff_duration")
end
function ModifierSpectreSpecialAttackThinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierSpectreSpecialAttackThinker.prototype.GetAuraEntityReject(self, unit)
    return not CustomEntitiesLegacy:Allies(self.caster, unit)
end
function ModifierSpectreSpecialAttackThinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierSpectreSpecialAttackThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self:PlayEffects()
    end
end
function ModifierSpectreSpecialAttackThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        self:StopEffects()
        UTIL_Remove(self.parent)
    end
end
function ModifierSpectreSpecialAttackThinker.prototype.PlayEffects(self)
    self.particleIdMain = ParticleManager:CreateParticle("particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_steam.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        self.particleIdMain,
        0,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        self.particleIdMain,
        1,
        self.parent:GetAbsOrigin()
    )
    self.particleIdSecond = ParticleManager:CreateParticle("particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_ground.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        self.particleIdSecond,
        0,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        self.particleIdSecond,
        5,
        self.parent:GetAbsOrigin()
    )
end
function ModifierSpectreSpecialAttackThinker.prototype.StopEffects(self)
    if self.particleIdMain then
        ParticleManager:DestroyParticle(self.particleIdMain, false)
        ParticleManager:ReleaseParticleIndex(self.particleIdMain)
    end
    if self.particleIdSecond then
        ParticleManager:DestroyParticle(self.particleIdSecond, false)
        ParticleManager:ReleaseParticleIndex(self.particleIdSecond)
    end
end
ModifierSpectreSpecialAttackThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_special_attack_thinker"})},
    ModifierSpectreSpecialAttackThinker
)
____exports.ModifierSpectreSpecialAttackDebuff = __TS__Class()
local ModifierSpectreSpecialAttackDebuff = ____exports.ModifierSpectreSpecialAttackDebuff
ModifierSpectreSpecialAttackDebuff.name = "ModifierSpectreSpecialAttackDebuff"
__TS__ClassExtends(ModifierSpectreSpecialAttackDebuff, CustomModifier)
function ModifierSpectreSpecialAttackDebuff.prototype.OnCreated(self)
    if IsServer() then
        self:StartIntervalThink(0.2)
    end
end
function ModifierSpectreSpecialAttackDebuff.prototype.OnIntervalThink(self)
    local origin = self.parent:GetAbsOrigin()
    ModifierSpectreSpecialAttackThinker:createThinker(
        self.caster,
        self.ability,
        origin,
        {
            duration = self:GetRemainingTime(),
            radius = self:Value("radius")
        }
    )
    local particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_pounce_start_spiral.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        3,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ModifierSpectreSpecialAttackDebuff.prototype.GetEffectName(self)
    return "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
end
function ModifierSpectreSpecialAttackDebuff.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierSpectreSpecialAttackDebuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_special_attack_debuff"})},
    ModifierSpectreSpecialAttackDebuff
)
____exports.ModifierSpectreSpecialAttackDebuff = ModifierSpectreSpecialAttackDebuff
____exports.ModifierSpectreSpecialAttackBuff = __TS__Class()
local ModifierSpectreSpecialAttackBuff = ____exports.ModifierSpectreSpecialAttackBuff
ModifierSpectreSpecialAttackBuff.name = "ModifierSpectreSpecialAttackBuff"
__TS__ClassExtends(ModifierSpectreSpecialAttackBuff, CustomModifier)
function ModifierSpectreSpecialAttackBuff.prototype.IsDebuff(self)
    return false
end
function ModifierSpectreSpecialAttackBuff.prototype.IsHidden(self)
    return false
end
function ModifierSpectreSpecialAttackBuff.prototype.IsPurgable(self)
    return false
end
function ModifierSpectreSpecialAttackBuff.prototype.OnCreated(self)
    if IsServer() then
        self:PlayEffects()
    end
end
function ModifierSpectreSpecialAttackBuff.prototype.OnDestroy(self)
    if IsServer() then
        EFX(
            "particles/units/heroes/hero_spectre/spectre_death.vpcf",
            PATTACH_WORLDORIGIN,
            self.parent,
            {
                cp0 = self.parent:GetAbsOrigin(),
                cp3 = self.parent:GetAbsOrigin(),
                release = true
            }
        )
        self:StopEffects()
    end
end
function ModifierSpectreSpecialAttackBuff.prototype.CheckState(self)
    return {
        [MODIFIER_STATE_INVISIBLE] = self:GivesInvisibility(),
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
    }
end
function ModifierSpectreSpecialAttackBuff.prototype.GivesInvisibility(self)
    return self.ability:GetLevel() >= 2 and not self.parent:FindModifierByName("modifier_casting") and self.parent == self.caster
end
function ModifierSpectreSpecialAttackBuff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_INVISIBILITY_LEVEL, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierSpectreSpecialAttackBuff.prototype.GetModifierInvisibilityLevel(self)
    if IsServer() then
        if self.ability:GetLevel() >= 2 and not self.parent:FindModifierByName("modifier_casting") then
            return 2
        end
    end
    return 0
end
function ModifierSpectreSpecialAttackBuff.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("speed_buff_pct")
end
function ModifierSpectreSpecialAttackBuff.prototype.PlayEffects(self)
    self.particleId = ParticleManager:CreateParticle("particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage_swirl.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
    ParticleManager:SetParticleControlEnt(
        self.particleId,
        2,
        self.parent,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.parent:GetAbsOrigin(),
        true
    )
end
function ModifierSpectreSpecialAttackBuff.prototype.StopEffects(self)
    if self.particleId then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
ModifierSpectreSpecialAttackBuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_special_attack_buff"})},
    ModifierSpectreSpecialAttackBuff
)
____exports.ModifierSpectreSpecialAttackBuff = ModifierSpectreSpecialAttackBuff
ModifierSpectreExSpecialAttackThinker = __TS__Class()
ModifierSpectreExSpecialAttackThinker.name = "ModifierSpectreExSpecialAttackThinker"
__TS__ClassExtends(ModifierSpectreExSpecialAttackThinker, ModifierThinker)
function ModifierSpectreExSpecialAttackThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
        self.particleId = ParticleManager:CreateParticle("particles/spectre/spectre_illusion_warp_ground.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(
            self.particleId,
            0,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            self.particleId,
            1,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            self.particleId,
            2,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            self.particleId,
            3,
            Vector(self.radius, 0, 0)
        )
    end
end
function ModifierSpectreExSpecialAttackThinker.prototype.OnReady(self)
    EmitSoundOn("Hero_Spectre.HauntCast", self.parent)
    local spectreExBasicAttackRecast = SpectreExSpecialAttackRecast:findOne(self.caster)
    if spectreExBasicAttackRecast ~= nil then
        spectreExBasicAttackRecast:ClearTargets()
    end
    local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.caster,
        self.origin,
        self.radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    for ____, enemy in ipairs(enemies) do
        ModifierSpectreExSpecialAttackBanish:apply(
            enemy,
            self.caster,
            self.ability,
            {duration = self:Value("banish_duration")}
        )
        if spectreExBasicAttackRecast ~= nil then
            spectreExBasicAttackRecast:AddTarget(enemy)
        end
        local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_death.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(
            particleId,
            0,
            enemy:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            particleId,
            3,
            enemy:GetAbsOrigin()
        )
        ParticleManager:ReleaseParticleIndex(particleId)
    end
    if #enemies > 0 then
        ModifierSpectreExSpecialAttackRecast:apply(
            self.caster,
            self.caster,
            self.ability,
            {
                duration = self:Value("banish_duration"),
                abilityLeft = SpectreExSpecialAttack.name,
                abilityRight = SpectreExSpecialAttackRecast.name
            }
        )
    end
    self:Destroy()
end
function ModifierSpectreExSpecialAttackThinker.prototype.OnDestroy(self)
    if IsServer() then
        UTIL_Remove(self.parent)
        if self.particleId then
            ParticleManager:DestroyParticle(self.particleId, false)
            ParticleManager:ReleaseParticleIndex(self.particleId)
        end
        EFX(
            "particles/spectre/spectre_illusion_warp_radius.vpcf",
            PATTACH_WORLDORIGIN,
            nil,
            {
                cp0 = self.origin,
                cp1 = self.origin,
                cp2 = Vector(self.radius),
                release = true
            }
        )
    end
end
ModifierSpectreExSpecialAttackThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_ex_special_attack_thinker"})},
    ModifierSpectreExSpecialAttackThinker
)
ModifierSpectreExSpecialAttackRecast = __TS__Class()
ModifierSpectreExSpecialAttackRecast.name = "ModifierSpectreExSpecialAttackRecast"
__TS__ClassExtends(ModifierSpectreExSpecialAttackRecast, ModifierRecast)
ModifierSpectreExSpecialAttackRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_ex_special_attack_recast"})},
    ModifierSpectreExSpecialAttackRecast
)
ModifierSpectreExSpecialAttackBanish = __TS__Class()
ModifierSpectreExSpecialAttackBanish.name = "ModifierSpectreExSpecialAttackBanish"
__TS__ClassExtends(ModifierSpectreExSpecialAttackBanish, ModifierBanish)
function ModifierSpectreExSpecialAttackBanish.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierBanish.prototype.CheckState(self),
        {[MODIFIER_STATE_COMMAND_RESTRICTED] = true}
    )
end
function ModifierSpectreExSpecialAttackBanish.prototype.OnDestroy(self)
    ModifierBanish.prototype.OnDestroy(self)
    if IsServer() then
        local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_death.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(
            particleId,
            0,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            particleId,
            3,
            self.parent:GetAbsOrigin()
        )
        ParticleManager:ReleaseParticleIndex(particleId)
        self.parent:AddNewModifier(
            self.caster,
            self.ability,
            "modifier_generic_fading_slow",
            {
                duration = self:Value("fading_slow_duration"),
                max_slow_pct = self:Value("fading_slow_pct")
            }
        )
    end
end
ModifierSpectreExSpecialAttackBanish = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_ex_special_attack_banish"})},
    ModifierSpectreExSpecialAttackBanish
)
return ____exports
