local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 149,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 4,["19"] = 4,["20"] = 4,["21"] = 4,["22"] = 5,["23"] = 5,["24"] = 6,["25"] = 6,["26"] = 8,["27"] = 8,["28"] = 8,["29"] = 11,["30"] = 12,["31"] = 11,["32"] = 15,["33"] = 16,["34"] = 15,["35"] = 19,["36"] = 20,["37"] = 21,["38"] = 22,["39"] = 23,["40"] = 24,["41"] = 26,["42"] = 27,["43"] = 28,["44"] = 29,["45"] = 30,["47"] = 19,["48"] = 34,["49"] = 35,["50"] = 36,["51"] = 36,["52"] = 36,["53"] = 36,["54"] = 36,["55"] = 37,["56"] = 38,["57"] = 39,["59"] = 34,["60"] = 44,["61"] = 44,["62"] = 45,["63"] = 46,["64"] = 47,["65"] = 46,["66"] = 50,["67"] = 51,["68"] = 50,["69"] = 54,["70"] = 55,["71"] = 56,["72"] = 57,["73"] = 58,["74"] = 59,["75"] = 60,["76"] = 61,["77"] = 62,["78"] = 64,["79"] = 64,["80"] = 64,["81"] = 64,["82"] = 64,["83"] = 64,["84"] = 64,["85"] = 64,["86"] = 64,["87"] = 74,["88"] = 75,["89"] = 75,["90"] = 64,["91"] = 76,["92"] = 77,["93"] = 77,["94"] = 77,["95"] = 77,["96"] = 77,["97"] = 77,["98"] = 83,["99"] = 84,["100"] = 85,["101"] = 86,["103"] = 88,["106"] = 64,["107"] = 92,["108"] = 93,["109"] = 93,["110"] = 93,["111"] = 93,["112"] = 93,["113"] = 93,["114"] = 93,["115"] = 93,["116"] = 93,["117"] = 103,["118"] = 104,["119"] = 104,["120"] = 104,["121"] = 104,["122"] = 104,["123"] = 104,["125"] = 111,["126"] = 111,["127"] = 111,["128"] = 111,["129"] = 111,["130"] = 111,["131"] = 111,["132"] = 111,["133"] = 111,["134"] = 112,["135"] = 112,["136"] = 112,["137"] = 112,["138"] = 112,["139"] = 112,["140"] = 112,["141"] = 112,["142"] = 113,["143"] = 113,["144"] = 113,["145"] = 113,["146"] = 114,["147"] = 114,["148"] = 114,["149"] = 114,["150"] = 114,["151"] = 115,["152"] = 115,["153"] = 115,["154"] = 115,["155"] = 116,["156"] = 116,["157"] = 116,["158"] = 116,["159"] = 121,["160"] = 64,["161"] = 64,["162"] = 125,["163"] = 125,["164"] = 125,["165"] = 125,["166"] = 127,["167"] = 133,["168"] = 54,["169"] = 45,["170"] = 44,["171"] = 45,["173"] = 148,["174"] = 148,["175"] = 149,["176"] = 149,["177"] = 148,["178"] = 149,["180"] = 151,["181"] = 151,["182"] = 152,["183"] = 153,["184"] = 154,["185"] = 153,["186"] = 157,["187"] = 158,["189"] = 158,["191"] = 157,["192"] = 152,["193"] = 151,["194"] = 152,["196"] = 165,["197"] = 165,["198"] = 166,["199"] = 167,["200"] = 168,["201"] = 167,["202"] = 171,["203"] = 172,["204"] = 171,["205"] = 175,["206"] = 176,["207"] = 177,["208"] = 178,["209"] = 179,["210"] = 180,["211"] = 181,["212"] = 182,["213"] = 183,["214"] = 185,["215"] = 185,["216"] = 185,["217"] = 185,["218"] = 185,["219"] = 185,["220"] = 185,["221"] = 185,["222"] = 185,["223"] = 195,["224"] = 196,["225"] = 196,["226"] = 185,["227"] = 197,["228"] = 198,["229"] = 198,["230"] = 198,["231"] = 198,["232"] = 198,["233"] = 198,["234"] = 185,["235"] = 205,["236"] = 206,["237"] = 206,["238"] = 206,["239"] = 206,["240"] = 206,["241"] = 206,["242"] = 206,["243"] = 206,["244"] = 206,["245"] = 216,["246"] = 217,["247"] = 217,["248"] = 217,["249"] = 217,["250"] = 217,["251"] = 217,["252"] = 224,["253"] = 224,["254"] = 224,["255"] = 224,["256"] = 224,["257"] = 224,["259"] = 229,["260"] = 229,["261"] = 229,["262"] = 229,["263"] = 229,["264"] = 229,["265"] = 229,["266"] = 229,["267"] = 229,["268"] = 230,["269"] = 230,["270"] = 230,["271"] = 230,["272"] = 230,["273"] = 230,["274"] = 230,["275"] = 230,["276"] = 231,["277"] = 231,["278"] = 231,["279"] = 231,["280"] = 232,["281"] = 232,["282"] = 232,["283"] = 232,["284"] = 232,["285"] = 233,["286"] = 233,["287"] = 233,["288"] = 233,["289"] = 234,["290"] = 234,["291"] = 234,["292"] = 234,["293"] = 234,["294"] = 240,["295"] = 185,["296"] = 185,["297"] = 244,["298"] = 244,["299"] = 244,["300"] = 244,["301"] = 246,["302"] = 252,["303"] = 175,["304"] = 166,["305"] = 165,["306"] = 166,["308"] = 266,["309"] = 266,["310"] = 267,["311"] = 268,["312"] = 269,["313"] = 268,["314"] = 272,["315"] = 273,["316"] = 272,["317"] = 276,["318"] = 277,["320"] = 277,["322"] = 276,["323"] = 267,["324"] = 266,["325"] = 267,["327"] = 285,["328"] = 285,["329"] = 286,["330"] = 286,["331"] = 285,["332"] = 286,["334"] = 288,["335"] = 288,["336"] = 289,["337"] = 289,["338"] = 288,["339"] = 289});
local ____exports = {}
local ModifierPuckMobilityRecast, PuckMobilityRecast, PuckExMobilityRecast, ModifierPuckExMobilityRecast, ModifierPuckExMobility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____projectiles = require("projectiles")
local ProjectileBehavior = ____projectiles.ProjectileBehavior
local ____util = require("util")
local createRadiusMarker = ____util.createRadiusMarker
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local PuckMobilityCommon = __TS__Class()
PuckMobilityCommon.name = "PuckMobilityCommon"
__TS__ClassExtends(PuckMobilityCommon, CustomAbility)
function PuckMobilityCommon.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function PuckMobilityCommon.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_Puck.Illusory_Orb", self.caster)
end
function PuckMobilityCommon.prototype.PlayEffectsOnFinish(self, position, path, secondPath)
    StopSoundOn("Hero_Puck.Illusory_Orb", self.caster)
    local particleId = ParticleManager:CreateParticle(path, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
    if secondPath then
        particleId = ParticleManager:CreateParticle(secondPath, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particleId, 0, position)
        ParticleManager:SetParticleControl(particleId, 1, position)
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function PuckMobilityCommon.prototype.Jump(self)
    if self.projectile then
        FindClearSpaceForUnit(
            self.caster,
            self.projectile:getPosition(),
            true
        )
        EmitSoundOn("Hero_Puck.EtherealJaunt", self.caster)
        StopSoundOn("Hero_Puck.Illusory_Orb", self.caster)
        self.projectile:scheduleDestroy()
    end
end
local PuckMobility = __TS__Class()
PuckMobility.name = "PuckMobility"
__TS__ClassExtends(PuckMobility, PuckMobilityCommon)
function PuckMobility.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckMobility.prototype.GetCastingCrawl(self)
    return 10
end
function PuckMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local damageAoe = self:GetSpecialValueFor("damage_aoe")
    local radius = self:GetSpecialValueFor("radius")
    self.projectile = self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_aproset.vpcf",
        spawnOrigin = origin:__add(Vector(0, 0, 80)),
        velocity = projectileDirection:__mul(projectileSpeed),
        isDestructible = false,
        groundOffset = 0,
        wallBehavior = ProjectileBehavior.NOTHING,
        unitBehavior = ProjectileBehavior.NOTHING,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    if self:GetLevel() >= 2 then
                        self:EndCooldown()
                    end
                    giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
                end
            end
        end,
        onFinish = function(____, projectile)
            local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
                projectile:getSource(),
                point,
                radius,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER
            )
            for ____, enemy in ipairs(enemies) do
                ApplyDamage({
                    victim = enemy,
                    attacker = projectile:getSource(),
                    damage = damageAoe,
                    damage_type = DAMAGE_TYPE_MAGICAL
                })
            end
            ScreenShake(
                projectile:getPosition(),
                100,
                300,
                0.45,
                1000,
                0,
                true
            )
            createRadiusMarker(
                nil,
                projectile:getSource(),
                projectile:getPosition(),
                radius,
                "public",
                0.1
            )
            EmitSoundOn(
                "Hero_Puck.EtherealJaunt",
                projectile:getSource()
            )
            EmitSoundOnLocationWithCaster(
                projectile:getPosition(),
                "Hero_Puck.Waning_Rift",
                projectile:getSource()
            )
            StopSoundOn(
                "Hero_Puck.Illusory_Orb",
                projectile:getSource()
            )
            self:PlayEffectsOnFinish(
                projectile:getPosition(),
                "particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf"
            )
            self.projectile = nil
        end
    })
    local time = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    ) / projectileSpeed
    ModifierPuckMobilityRecast:apply(self.caster, self.caster, self, {abilityLeft = PuckMobility.name, abilityRight = PuckMobilityRecast.name, duration = time})
    self:PlayEffectsOnCast()
end
PuckMobility = __TS__Decorate(
    {registerAbility(nil, "puck_mobility")},
    PuckMobility
)
ModifierPuckMobilityRecast = __TS__Class()
ModifierPuckMobilityRecast.name = "ModifierPuckMobilityRecast"
__TS__ClassExtends(ModifierPuckMobilityRecast, ModifierRecast)
ModifierPuckMobilityRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_mobility_recast"})},
    ModifierPuckMobilityRecast
)
PuckMobilityRecast = __TS__Class()
PuckMobilityRecast.name = "PuckMobilityRecast"
__TS__ClassExtends(PuckMobilityRecast, CustomAbility)
function PuckMobilityRecast.prototype.GetCastingCrawl(self)
    return 0
end
function PuckMobilityRecast.prototype.OnSpellStart(self)
    local ____opt_0 = PuckMobility:findOne(self.caster)
    if ____opt_0 ~= nil then
        ____opt_0:Jump()
    end
end
PuckMobilityRecast = __TS__Decorate(
    {registerAbility(nil, "puck_mobility_recast")},
    PuckMobilityRecast
)
local PuckExMobility = __TS__Class()
PuckExMobility.name = "PuckExMobility"
__TS__ClassExtends(PuckExMobility, PuckMobilityCommon)
function PuckExMobility.prototype.GetPlaybackRateOverride(self)
    return 0.5
end
function PuckExMobility.prototype.GetCastingCrawl(self)
    return 10
end
function PuckExMobility.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local damageAoe = self:GetSpecialValueFor("damage_aoe")
    local radius = self:GetSpecialValueFor("radius")
    local fearDuration = self:GetSpecialValueFor("fear_duration")
    self.projectile = self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/puck/puck_ex_mobility.vpcf",
        spawnOrigin = origin:__add(Vector(0, 0, 80)),
        velocity = projectileDirection:__mul(projectileSpeed),
        isDestructible = false,
        groundOffset = 0,
        wallBehavior = ProjectileBehavior.NOTHING,
        unitBehavior = ProjectileBehavior.NOTHING,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = damage,
                damage_type = DAMAGE_TYPE_PURE
            })
        end,
        onFinish = function(____, projectile)
            local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
                projectile:getSource(),
                point,
                radius,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER
            )
            for ____, enemy in ipairs(enemies) do
                ApplyDamage({
                    victim = enemy,
                    attacker = projectile:getSource(),
                    damage = damageAoe,
                    damage_type = DAMAGE_TYPE_MAGICAL
                })
                ModifierPuckExMobility:apply(
                    enemy,
                    projectile:getSource(),
                    self,
                    {duration = fearDuration}
                )
            end
            ScreenShake(
                projectile:getPosition(),
                100,
                300,
                0.45,
                1000,
                0,
                true
            )
            createRadiusMarker(
                nil,
                projectile:getSource(),
                projectile:getPosition(),
                radius,
                "public",
                0.1
            )
            EmitSoundOn(
                "Hero_Puck.EtherealJaunt",
                projectile:getSource()
            )
            EmitSoundOnLocationWithCaster(
                projectile:getPosition(),
                "Hero_Puck.Waning_Rift",
                projectile:getSource()
            )
            StopSoundOn(
                "Hero_Puck.Illusory_Orb",
                projectile:getSource()
            )
            self:PlayEffectsOnFinish(
                projectile:getPosition(),
                "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_explode_aproset.vpcf",
                "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf"
            )
            self.projectile = nil
        end
    })
    local time = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    ) / projectileSpeed
    ModifierPuckExMobilityRecast:apply(self.caster, self.caster, self, {abilityLeft = PuckExMobility.name, abilityRight = PuckExMobilityRecast.name, duration = time})
    self:PlayEffectsOnCast()
end
PuckExMobility = __TS__Decorate(
    {registerAbility(nil, "puck_ex_mobility")},
    PuckExMobility
)
PuckExMobilityRecast = __TS__Class()
PuckExMobilityRecast.name = "PuckExMobilityRecast"
__TS__ClassExtends(PuckExMobilityRecast, CustomAbility)
function PuckExMobilityRecast.prototype.GetCastingCrawl(self)
    return 0
end
function PuckExMobilityRecast.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function PuckExMobilityRecast.prototype.OnSpellStart(self)
    local ____opt_2 = PuckExMobility:findOne(self.caster)
    if ____opt_2 ~= nil then
        ____opt_2:Jump()
    end
end
PuckExMobilityRecast = __TS__Decorate(
    {registerAbility(nil, "puck_ex_mobility_recast")},
    PuckExMobilityRecast
)
ModifierPuckExMobilityRecast = __TS__Class()
ModifierPuckExMobilityRecast.name = "ModifierPuckExMobilityRecast"
__TS__ClassExtends(ModifierPuckExMobilityRecast, ModifierRecast)
ModifierPuckExMobilityRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ex_mobility_recast"})},
    ModifierPuckExMobilityRecast
)
ModifierPuckExMobility = __TS__Class()
ModifierPuckExMobility.name = "ModifierPuckExMobility"
__TS__ClassExtends(ModifierPuckExMobility, CustomModifier)
ModifierPuckExMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ex_mobility_fear"})},
    ModifierPuckExMobility
)
return ____exports
