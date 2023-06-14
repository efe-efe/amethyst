local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 167,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 10,["22"] = 11,["23"] = 12,["24"] = 14,["25"] = 14,["26"] = 15,["27"] = 15,["28"] = 17,["29"] = 17,["30"] = 18,["31"] = 19,["32"] = 20,["33"] = 18,["35"] = 18,["36"] = 19,["37"] = 26,["38"] = 27,["39"] = 28,["40"] = 29,["41"] = 18,["43"] = 18,["44"] = 26,["45"] = 37,["46"] = 38,["47"] = 37,["48"] = 41,["49"] = 42,["50"] = 41,["51"] = 45,["52"] = 46,["53"] = 45,["54"] = 49,["55"] = 50,["56"] = 49,["57"] = 53,["58"] = 54,["59"] = 53,["60"] = 57,["61"] = 58,["62"] = 59,["63"] = 60,["64"] = 61,["65"] = 62,["66"] = 64,["67"] = 65,["68"] = 66,["69"] = 68,["70"] = 68,["71"] = 68,["72"] = 68,["74"] = 68,["75"] = 70,["76"] = 70,["77"] = 70,["78"] = 70,["79"] = 70,["80"] = 70,["81"] = 70,["82"] = 77,["83"] = 78,["84"] = 78,["85"] = 70,["86"] = 79,["87"] = 80,["88"] = 80,["89"] = 80,["90"] = 80,["91"] = 80,["92"] = 80,["93"] = 80,["94"] = 80,["95"] = 86,["96"] = 87,["97"] = 88,["98"] = 88,["99"] = 88,["100"] = 88,["101"] = 88,["102"] = 88,["103"] = 90,["107"] = 97,["108"] = 98,["109"] = 98,["110"] = 98,["111"] = 98,["112"] = 98,["113"] = 98,["114"] = 98,["115"] = 98,["116"] = 98,["117"] = 108,["118"] = 109,["119"] = 109,["120"] = 109,["121"] = 109,["122"] = 109,["123"] = 109,["124"] = 114,["125"] = 114,["126"] = 114,["127"] = 114,["128"] = 114,["129"] = 114,["131"] = 122,["132"] = 122,["133"] = 122,["134"] = 122,["135"] = 124,["136"] = 124,["137"] = 124,["138"] = 124,["139"] = 124,["140"] = 124,["141"] = 124,["142"] = 124,["143"] = 125,["144"] = 125,["145"] = 125,["146"] = 125,["147"] = 125,["148"] = 125,["149"] = 125,["150"] = 125,["151"] = 125,["152"] = 127,["153"] = 127,["154"] = 127,["155"] = 127,["156"] = 131,["157"] = 131,["158"] = 131,["159"] = 127,["160"] = 127,["162"] = 70,["163"] = 138,["164"] = 139,["165"] = 70,["166"] = 70,["167"] = 143,["168"] = 57,["169"] = 146,["170"] = 147,["171"] = 148,["172"] = 149,["174"] = 146,["175"] = 153,["176"] = 154,["177"] = 156,["178"] = 161,["179"] = 162,["180"] = 153,["181"] = 18,["182"] = 17,["183"] = 18,["185"] = 166,["186"] = 166,["187"] = 167,["188"] = 170,["189"] = 171,["190"] = 170,["191"] = 174,["192"] = 175,["193"] = 176,["196"] = 179,["197"] = 180,["200"] = 174,["201"] = 185,["202"] = 186,["205"] = 190,["206"] = 192,["207"] = 193,["209"] = 185,["210"] = 197,["211"] = 198,["212"] = 199,["213"] = 205,["214"] = 205,["215"] = 205,["216"] = 205,["217"] = 205,["218"] = 205,["219"] = 205,["220"] = 205,["221"] = 205,["222"] = 214,["223"] = 215,["225"] = 197,["226"] = 219,["227"] = 220,["228"] = 219,["229"] = 167,["230"] = 166,["231"] = 167,["233"] = 224,["234"] = 225,["235"] = 224,["236"] = 225,["237"] = 226,["238"] = 227,["239"] = 228,["240"] = 226,["241"] = 225,["242"] = 224,["243"] = 225,["245"] = 225,["246"] = 232,["247"] = 233,["248"] = 232,["249"] = 233,["250"] = 236,["251"] = 237,["252"] = 236,["253"] = 240,["254"] = 241,["255"] = 242,["256"] = 243,["258"] = 240,["259"] = 247,["260"] = 248,["261"] = 249,["263"] = 247,["264"] = 253,["265"] = 254,["266"] = 255,["268"] = 253,["269"] = 259,["270"] = 260,["271"] = 261,["272"] = 262,["273"] = 268,["274"] = 269,["275"] = 270,["276"] = 271,["277"] = 272,["281"] = 259,["282"] = 278,["283"] = 279,["284"] = 278,["285"] = 233,["286"] = 232,["287"] = 233,["289"] = 233});
local ____exports = {}
local ModifierStormBasicAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____modifier_cooldown = require("modifiers.modifier_cooldown")
local ModifierCooldown = ____modifier_cooldown.ModifierCooldown
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local createRadiusMarker = ____util.createRadiusMarker
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local replenishEFX = ____util.replenishEFX
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local StormBasicAttack = __TS__Class()
StormBasicAttack.name = "StormBasicAttack"
__TS__ClassExtends(StormBasicAttack, CustomAbility)
function StormBasicAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return CustomAbility.prototype.GetCastPoint(self) + self.caster:GetAttackAnimationPoint()
    end
    return CustomAbility.prototype.GetCastPoint(self)
end
function StormBasicAttack.prototype.GetCooldown(self, level)
    if IsServer() then
        local attacks_per_second = self.caster:GetAttacksPerSecond()
        local attack_speed = 1 / attacks_per_second
        return CustomAbility.prototype.GetCooldown(self, level) + attack_speed
    end
    return CustomAbility.prototype.GetCooldown(self, level)
end
function StormBasicAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function StormBasicAttack.prototype.GetPlaybackRateOverride(self)
    return 1.5
end
function StormBasicAttack.prototype.GetCastingCrawl(self)
    return 10
end
function StormBasicAttack.prototype.GetAnimationTranslate(self)
    return Translate.overload
end
function StormBasicAttack.prototype.GetIntrinsicModifierName(self)
    return ModifierStormBasicAttack.name
end
function StormBasicAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local radius = self:GetSpecialValueFor("radius")
    local fadingSlowDuration = self:GetSpecialValueFor("fading_slow_duration")
    local fadingSlowPct = self:GetSpecialValueFor("fading_slow_pct")
    local ____opt_0 = ModifierStormBasicAttack:findOne(self.caster)
    local ____temp_2 = ____opt_0 and ____opt_0:IsCooldownReady()
    if ____temp_2 == nil then
        ____temp_2 = false
    end
    local isCharged = ____temp_2
    self:ProjectileAttack({
        source = self.caster,
        attackType = "basic",
        effectName = isCharged and "particles/storm/storm_basic_attack_charged.vpcf" or "particles/storm/storm_basic_attack.vpcf",
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
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(
                        nil,
                        projectile:getSource(),
                        manaGainPct,
                        true
                    )
                    if self.caster:HasModifier("modifier_storm_ultimate") then
                    end
                end
            end
            if isCharged then
                local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
                    projectile:getSource(),
                    projectile:getPosition(),
                    radius,
                    DOTA_UNIT_TARGET_TEAM_ENEMY,
                    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_ANY_ORDER
                )
                for ____, enemy in ipairs(enemies) do
                    enemy:AddNewModifier(
                        projectile:getSource(),
                        self,
                        "modifier_generic_fading_slow",
                        {duration = fadingSlowDuration, max_slow_pct = fadingSlowPct}
                    )
                    ApplyDamage({
                        attacker = projectile:getSource(),
                        victim = enemy,
                        damage = self:GetSpecialValueFor("aoe_damage"),
                        damage_type = DAMAGE_TYPE_PURE
                    })
                end
                local groundPosition = GetGroundPosition(
                    projectile:getPosition(),
                    projectile:getSource()
                )
                createRadiusMarker(
                    nil,
                    projectile:getSource(),
                    groundPosition,
                    radius,
                    "public",
                    0.1
                )
                ScreenShake(
                    groundPosition,
                    100,
                    300,
                    0.45,
                    1000,
                    0,
                    true
                )
                EFX(
                    "particles/units/heroes/hero_void_spirit/voidspirit_overload_discharge.vpcf",
                    PATTACH_WORLDORIGIN,
                    projectile:getSource(),
                    {
                        cp0 = projectile:getPosition(),
                        release = true
                    }
                )
            end
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    self:PlayEffectsOnCast(isCharged)
end
function StormBasicAttack.prototype.PlayEffectsOnCast(self, charged)
    EmitSoundOn("Hero_StormSpirit.Attack", self.caster)
    if charged then
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.caster)
    end
end
function StormBasicAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
StormBasicAttack = __TS__Decorate(
    {registerAbility(nil, "storm_basic_attack")},
    StormBasicAttack
)
ModifierStormBasicAttack = __TS__Class()
ModifierStormBasicAttack.name = "ModifierStormBasicAttack"
__TS__ClassExtends(ModifierStormBasicAttack, ModifierCooldown)
function ModifierStormBasicAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_ABILITY_FULLY_CAST, MODIFIER_EVENT_ON_ATTACK}
end
function ModifierStormBasicAttack.prototype.OnAbilityFullyCast(self, event)
    if IsServer() then
        if event.unit ~= self.parent then
            return
        end
        if event.ability ~= self.ability then
            self:Replenish()
        end
    end
end
function ModifierStormBasicAttack.prototype.OnBasicAttackStarted(self)
    if self:GetRemainingTime() > 0 then
        return
    end
    self:StartCooldown()
    if self.particleId then
        DEFX(self.particleId, false)
    end
end
function ModifierStormBasicAttack.prototype.OnReplenish(self)
    if IsServer() then
        self.particleId = EFX("particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf", PATTACH_POINT_FOLLOW, self.parent, {})
        ParticleManager:SetParticleControlEnt(
            self.particleId,
            0,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            self.parent:GetAbsOrigin(),
            true
        )
        EmitSoundOn("Hero_StormSpirit.Overload", self.parent)
        replenishEFX(nil, self.parent)
    end
end
function ModifierStormBasicAttack.prototype.GetReplenishTime(self)
    return self:Value("replenish_time")
end
ModifierStormBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_basic_attack_cooldown"})},
    ModifierStormBasicAttack
)
____exports.StormExBasicAttack = __TS__Class()
local StormExBasicAttack = ____exports.StormExBasicAttack
StormExBasicAttack.name = "StormExBasicAttack"
__TS__ClassExtends(StormExBasicAttack, CustomAbility)
function StormExBasicAttack.prototype.OnSpellStart(self)
    self.caster:AddNewModifier(self.caster, self, "modifier_storm_ex_basic_attack", {})
    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", self.caster)
end
StormExBasicAttack = __TS__Decorate(
    {registerAbility(nil, "storm_ex_basic_attack")},
    StormExBasicAttack
)
____exports.StormExBasicAttack = StormExBasicAttack
____exports.ModifierStormExBasicAttack = __TS__Class()
local ModifierStormExBasicAttack = ____exports.ModifierStormExBasicAttack
ModifierStormExBasicAttack.name = "ModifierStormExBasicAttack"
__TS__ClassExtends(ModifierStormExBasicAttack, CustomModifier)
function ModifierStormExBasicAttack.prototype.IsHidden(self)
    return true
end
function ModifierStormExBasicAttack.prototype.OnCreated(self)
    if IsServer() then
        self:SetStackCount(self.ability:GetLevel() >= 2 and 21 or 11)
        self.particleId = EFX("particles/storm/storm_ex_basic_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {})
    end
end
function ModifierStormExBasicAttack.prototype.OnDestroy(self)
    if IsServer() then
        DEFX(self.particleId, false)
    end
end
function ModifierStormExBasicAttack.prototype.OnStackCountChanged(self)
    if self:GetStackCount() <= 2 then
        self:Destroy()
    end
end
function ModifierStormExBasicAttack.prototype.OnRefresh(self)
    if IsServer() then
        DEFX(self.particleId, false)
        self.particleId = EFX("particles/storm/storm_ex_basic_attack_level_two.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {})
        if self.ability:GetLevel() >= 2 then
            if self:GetStackCount() < 22 then
                self:SetStackCount(22)
            elseif self:GetStackCount() < 12 then
                self:IncrementStackCount()
            end
        end
    end
end
function ModifierStormExBasicAttack.prototype.GetLevel(self)
    return self:GetStackCount() % 10
end
ModifierStormExBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_ex_basic_attack"})},
    ModifierStormExBasicAttack
)
____exports.ModifierStormExBasicAttack = ModifierStormExBasicAttack
return ____exports
