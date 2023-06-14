local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 78,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 4,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 6,["24"] = 6,["25"] = 8,["26"] = 8,["27"] = 9,["28"] = 10,["29"] = 11,["30"] = 10,["31"] = 14,["32"] = 15,["33"] = 14,["34"] = 18,["35"] = 19,["36"] = 18,["37"] = 22,["38"] = 23,["39"] = 22,["40"] = 26,["41"] = 27,["42"] = 28,["43"] = 29,["45"] = 32,["46"] = 33,["49"] = 9,["50"] = 26,["51"] = 40,["52"] = 9,["53"] = 40,["54"] = 44,["55"] = 45,["56"] = 46,["57"] = 47,["58"] = 47,["59"] = 47,["60"] = 47,["61"] = 48,["62"] = 48,["63"] = 48,["64"] = 48,["65"] = 48,["66"] = 48,["67"] = 52,["68"] = 53,["69"] = 54,["71"] = 67,["72"] = 67,["73"] = 67,["74"] = 67,["75"] = 67,["76"] = 67,["77"] = 67,["78"] = 67,["79"] = 67,["80"] = 67,["81"] = 72,["82"] = 44,["83"] = 9,["84"] = 8,["85"] = 9,["87"] = 77,["88"] = 77,["89"] = 78,["90"] = 79,["91"] = 80,["92"] = 79,["93"] = 83,["94"] = 84,["95"] = 85,["97"] = 88,["98"] = 83,["99"] = 78,["100"] = 77,["101"] = 78,["103"] = 92,["104"] = 92,["105"] = 93,["106"] = 97,["107"] = 93,["108"] = 100,["109"] = 101,["110"] = 102,["112"] = 97,["113"] = 106,["114"] = 93,["115"] = 109,["116"] = 110,["117"] = 112,["118"] = 112,["119"] = 112,["120"] = 115,["121"] = 116,["122"] = 116,["123"] = 116,["124"] = 116,["125"] = 116,["126"] = 116,["127"] = 123,["128"] = 124,["130"] = 127,["131"] = 112,["132"] = 112,["133"] = 131,["134"] = 132,["135"] = 132,["136"] = 132,["137"] = 132,["138"] = 132,["139"] = 132,["140"] = 134,["143"] = 140,["144"] = 141,["146"] = 106,["147"] = 145,["148"] = 93,["149"] = 148,["150"] = 149,["151"] = 150,["152"] = 151,["154"] = 145,["155"] = 155,["156"] = 156,["157"] = 161,["158"] = 169,["159"] = 169,["160"] = 169,["161"] = 169,["162"] = 169,["163"] = 169,["164"] = 169,["165"] = 169,["166"] = 169,["167"] = 178,["168"] = 178,["169"] = 178,["170"] = 178,["171"] = 178,["172"] = 178,["173"] = 178,["174"] = 178,["175"] = 178,["176"] = 179,["177"] = 180,["178"] = 180,["179"] = 180,["180"] = 180,["181"] = 180,["182"] = 155,["183"] = 93,["184"] = 92,["185"] = 93,["187"] = 184,["188"] = 184,["189"] = 185,["190"] = 186,["191"] = 187,["192"] = 186,["193"] = 190,["194"] = 191,["195"] = 190,["196"] = 194,["197"] = 195,["198"] = 194,["199"] = 198,["200"] = 199,["201"] = 200,["202"] = 201,["203"] = 202,["204"] = 202,["205"] = 202,["206"] = 202,["207"] = 203,["208"] = 207,["209"] = 208,["210"] = 208,["211"] = 208,["212"] = 208,["213"] = 208,["214"] = 208,["215"] = 208,["216"] = 208,["217"] = 208,["218"] = 208,["219"] = 208,["220"] = 215,["221"] = 215,["222"] = 215,["223"] = 215,["224"] = 215,["225"] = 215,["226"] = 218,["227"] = 218,["228"] = 218,["229"] = 218,["230"] = 218,["231"] = 218,["232"] = 218,["233"] = 218,["234"] = 218,["235"] = 219,["236"] = 198,["237"] = 185,["238"] = 184,["239"] = 185,["241"] = 224,["242"] = 224,["243"] = 225,["244"] = 229,["245"] = 225,["246"] = 232,["247"] = 233,["249"] = 229,["250"] = 237,["251"] = 238,["252"] = 237,["253"] = 241,["254"] = 225,["255"] = 244,["256"] = 245,["257"] = 245,["258"] = 245,["259"] = 245,["260"] = 245,["261"] = 245,["262"] = 245,["263"] = 245,["264"] = 245,["265"] = 255,["266"] = 256,["267"] = 256,["268"] = 256,["269"] = 256,["270"] = 256,["271"] = 256,["272"] = 262,["273"] = 262,["274"] = 262,["275"] = 262,["276"] = 262,["277"] = 262,["279"] = 265,["280"] = 266,["283"] = 241,["284"] = 271,["285"] = 272,["286"] = 273,["287"] = 274,["288"] = 275,["290"] = 271,["291"] = 279,["292"] = 280,["293"] = 280,["294"] = 280,["295"] = 280,["296"] = 280,["297"] = 280,["298"] = 280,["299"] = 280,["300"] = 280,["301"] = 280,["302"] = 280,["303"] = 286,["304"] = 286,["305"] = 286,["306"] = 286,["307"] = 286,["308"] = 286,["309"] = 288,["310"] = 288,["311"] = 288,["312"] = 288,["313"] = 286,["314"] = 286,["315"] = 286,["316"] = 286,["317"] = 291,["318"] = 291,["319"] = 291,["320"] = 291,["321"] = 291,["322"] = 291,["323"] = 291,["324"] = 291,["325"] = 291,["326"] = 300,["327"] = 279,["328"] = 225,["329"] = 224,["330"] = 225});
local ____exports = {}
local ModifierStormMobility, ModifierStormMobilityThinker, ModifierStormExMobilityThinker
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_charges = require("modifiers.modifier_charges")
local ModifierCharges = ____modifier_charges.ModifierCharges
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____storm_extra = require("abilities.heroes.storm.storm_extra")
local ModifierStormExtraDisplacement = ____storm_extra.ModifierStormExtraDisplacement
local StormMobility = __TS__Class()
StormMobility.name = "StormMobility"
__TS__ClassExtends(StormMobility, CustomAbility)
function StormMobility.prototype.GetIntrinsicModifierName(self)
    return ModifierStormMobility.name
end
function StormMobility.prototype.GetAnimation(self)
    return ACT_DOTA_SPAWN
end
function StormMobility.prototype.GetPlaybackRateOverride(self)
    return 1.5
end
function StormMobility.prototype.GetCastingCrawl(self)
    return 50
end
function StormMobility.prototype.GetCastRange(self, location, target)
    if IsServer() then
        if ModifierStormExtraDisplacement:findOne(self.caster) then
            return 0
        end
        if self.caster:HasModifier("modifier_upgrade_storm_ranged_remnant") then
            return 650
        end
    end
    return CustomAbility.prototype.GetCastRange(self, location, target)
end
function StormMobility.prototype.GetCastPoint(self)
    return ModifierStormExtraDisplacement:findOne(self.caster) and 0 or CustomAbility.prototype.GetCastPoint(self)
end
function StormMobility.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local point = clampPosition(
        nil,
        self.caster:GetAbsOrigin(),
        cursor,
        {maxRange = castRange}
    )
    local groundPosition = GetGroundPosition(point, self.caster)
    if self.caster:HasModifier("modifier_upgrade_storm_ranged_remnant") then
        EFX("particles/spectre/spectre_illusion_warp.vpcf", PATTACH_CUSTOMORIGIN, self.caster, {cp0 = {ent = self.caster, point = "attach_hitloc"}, cp1 = groundPosition, cp2 = {ent = self.caster, point = "attach_hitloc"}, release = true})
    end
    ModifierStormMobilityThinker:createThinker(
        self.caster,
        self,
        groundPosition,
        {
            duration = duration,
            radius = self:GetSpecialValueFor("radius"),
            content = "clearout"
        }
    )
    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", self.caster)
end
StormMobility = __TS__Decorate(
    {registerAbility(nil, "storm_mobility")},
    StormMobility
)
ModifierStormMobility = __TS__Class()
ModifierStormMobility.name = "ModifierStormMobility"
__TS__ClassExtends(ModifierStormMobility, ModifierCharges)
function ModifierStormMobility.prototype.GetMaxCharges(self)
    return self.ability:GetSpecialValueFor("max_charges")
end
function ModifierStormMobility.prototype.GetReplenishTime(self)
    if IsServer() then
        return self.ability:GetCooldown(self.ability:GetLevel())
    end
    return 0
end
ModifierStormMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_mobility_charges"})},
    ModifierStormMobility
)
ModifierStormMobilityThinker = __TS__Class()
ModifierStormMobilityThinker.name = "ModifierStormMobilityThinker"
__TS__ClassExtends(ModifierStormMobilityThinker, ModifierThinker)
function ModifierStormMobilityThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
        self:PlayEffectsOnCreated()
    end
end
function ModifierStormMobilityThinker.prototype.OnIntervalThink(self)
    ModifierThinker.prototype.OnIntervalThink(self)
    local giveMana = false
    local destroy = false
    self.ability:AoeAttack({
        origin = self.origin,
        radius = self.radius,
        effect = function(____, target)
            ApplyDamage({
                victim = target,
                attacker = self.caster,
                damage = self.ability:GetSpecialValueFor("ability_damage"),
                damage_type = DAMAGE_TYPE_PURE
            })
            if not isObstacle(nil, target) and not isGem(nil, target) then
                giveMana = true
            end
            destroy = true
        end
    })
    if giveMana then
        giveManaAndEnergyPercent(
            nil,
            self.caster,
            self:Value("mana_gain_pct"),
            true
        )
        if self.caster:HasModifier("modifier_storm_ultimate") then
        end
    end
    if destroy then
        self:Destroy()
    end
end
function ModifierStormMobilityThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.parent)
        DEFX(self.particleId, false)
        UTIL_Remove(self.parent)
    end
end
function ModifierStormMobilityThinker.prototype.PlayEffectsOnCreated(self)
    self.particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf", PATTACH_WORLDORIGIN, self.caster)
    ParticleManager:SetParticleControl(self.particleId, 0, self.origin)
    ParticleManager:SetParticleControlEnt(
        self.particleId,
        1,
        self.caster,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.origin,
        true
    )
    ParticleManager:SetParticleControl(
        self.particleId,
        2,
        Vector(
            RandomInt(37, 52),
            1,
            100
        )
    )
    ParticleManager:SetParticleControl(self.particleId, 11, self.origin)
    ParticleManager:SetParticleControlForward(
        self.particleId,
        0,
        self.caster:GetForwardVector()
    )
end
ModifierStormMobilityThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_mobility_thinker"})},
    ModifierStormMobilityThinker
)
local StormExMobility = __TS__Class()
StormExMobility.name = "StormExMobility"
__TS__ClassExtends(StormExMobility, CustomAbility)
function StormExMobility.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function StormExMobility.prototype.GetPlaybackRateOverride(self)
    return 1
end
function StormExMobility.prototype.GetCastingCrawl(self)
    return 10
end
function StormExMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local duration = self:GetSpecialValueFor("duration")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange})
    local groundPosition = GetGroundPosition(point, self.caster)
    ModifierStormExMobilityThinker:createThinker(
        self.caster,
        self,
        groundPosition,
        {
            duration = duration,
            radius = self:GetSpecialValueFor("radius"),
            content = "clearout",
            delayTime = self:GetSpecialValueFor("delay")
        }
    )
    local particleId = EFX(
        "particles/storm/storm_ex_mobility_launch.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.caster,
        {cp1 = point + Vector(0, 0, 2000)}
    )
    ParticleManager:SetParticleControlEnt(
        particleId,
        0,
        self.caster,
        PATTACH_POINT_FOLLOW,
        "attach_attack1",
        origin,
        false
    )
    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", self.caster)
end
StormExMobility = __TS__Decorate(
    {registerAbility(nil, "storm_ex_mobility")},
    StormExMobility
)
ModifierStormExMobilityThinker = __TS__Class()
ModifierStormExMobilityThinker.name = "ModifierStormExMobilityThinker"
__TS__ClassExtends(ModifierStormExMobilityThinker, ModifierThinker)
function ModifierStormExMobilityThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
    end
end
function ModifierStormExMobilityThinker.prototype.OnReady(self)
    self:PlayEffectsOnCreated()
end
function ModifierStormExMobilityThinker.prototype.OnIntervalThink(self)
    ModifierThinker.prototype.OnIntervalThink(self)
    if self.initialized then
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
            ApplyDamage({
                victim = enemy,
                attacker = self.caster,
                damage = self:Value("ability_damage"),
                damage_type = DAMAGE_TYPE_PURE
            })
            enemy:AddNewModifier(
                self.caster,
                self.ability,
                "modifier_generic_sleep",
                {duration = self:Value("sleep_duration")}
            )
        end
        if #enemies > 0 then
            self:Destroy()
        end
    end
end
function ModifierStormExMobilityThinker.prototype.OnDestroy(self)
    if IsServer() then
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.parent)
        DEFX(self.particleId, false)
        UTIL_Remove(self.parent)
    end
end
function ModifierStormExMobilityThinker.prototype.PlayEffectsOnCreated(self)
    EFX(
        "particles/storm/storm_ex_mobility_strike.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = self.origin,
            cp1 = self.origin + Vector(0, 0, 1000),
            cp2 = self.origin,
            release = true
        }
    )
    self.particleId = EFX(
        "particles/storm/storm_ex_mobility.vpcf",
        PATTACH_WORLDORIGIN,
        self.caster,
        {
            cp0 = self.origin,
            cp2 = Vector(
                RandomInt(37, 52),
                1,
                100
            ),
            cp11 = self.origin
        }
    )
    ParticleManager:SetParticleControlEnt(
        self.particleId,
        1,
        self.caster,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.origin,
        true
    )
    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", self.parent)
end
ModifierStormExMobilityThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_ex_mobility_thinker"})},
    ModifierStormExMobilityThinker
)
return ____exports
