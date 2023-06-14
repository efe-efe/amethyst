local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 220,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 3,["20"] = 4,["21"] = 4,["22"] = 5,["23"] = 5,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 7,["28"] = 7,["29"] = 9,["30"] = 9,["31"] = 10,["32"] = 11,["33"] = 12,["34"] = 11,["35"] = 15,["36"] = 16,["37"] = 15,["38"] = 19,["39"] = 20,["40"] = 19,["41"] = 23,["42"] = 10,["43"] = 25,["45"] = 28,["46"] = 23,["47"] = 31,["48"] = 32,["49"] = 33,["50"] = 34,["51"] = 35,["52"] = 35,["53"] = 35,["54"] = 35,["55"] = 35,["56"] = 35,["57"] = 35,["58"] = 35,["59"] = 35,["60"] = 35,["61"] = 35,["62"] = 35,["63"] = 36,["64"] = 37,["65"] = 38,["66"] = 38,["67"] = 40,["68"] = 40,["69"] = 40,["70"] = 40,["71"] = 40,["72"] = 40,["73"] = 40,["74"] = 40,["75"] = 40,["76"] = 40,["77"] = 40,["78"] = 40,["79"] = 40,["80"] = 40,["81"] = 40,["82"] = 51,["83"] = 52,["84"] = 54,["85"] = 31,["86"] = 10,["87"] = 9,["88"] = 10,["90"] = 58,["91"] = 59,["92"] = 58,["93"] = 59,["94"] = 65,["95"] = 59,["96"] = 68,["97"] = 69,["98"] = 70,["99"] = 71,["100"] = 72,["101"] = 74,["102"] = 75,["103"] = 76,["104"] = 78,["105"] = 79,["107"] = 65,["108"] = 83,["109"] = 84,["110"] = 85,["113"] = 89,["114"] = 90,["117"] = 93,["118"] = 94,["121"] = 83,["122"] = 99,["123"] = 100,["124"] = 101,["125"] = 102,["128"] = 106,["129"] = 107,["130"] = 107,["131"] = 107,["132"] = 107,["133"] = 107,["134"] = 107,["136"] = 110,["137"] = 117,["138"] = 118,["140"] = 118,["143"] = 99,["144"] = 122,["145"] = 123,["146"] = 124,["147"] = 124,["148"] = 124,["149"] = 124,["150"] = 124,["151"] = 124,["152"] = 124,["153"] = 124,["154"] = 124,["155"] = 122,["156"] = 130,["157"] = 131,["158"] = 130,["159"] = 134,["160"] = 59,["161"] = 137,["162"] = 138,["163"] = 138,["164"] = 138,["165"] = 138,["166"] = 138,["167"] = 138,["168"] = 138,["169"] = 138,["170"] = 138,["171"] = 148,["172"] = 149,["174"] = 152,["175"] = 152,["176"] = 152,["177"] = 152,["178"] = 152,["179"] = 152,["180"] = 152,["181"] = 152,["182"] = 153,["183"] = 153,["184"] = 153,["185"] = 153,["186"] = 153,["187"] = 153,["188"] = 153,["189"] = 153,["190"] = 153,["191"] = 154,["192"] = 155,["193"] = 157,["194"] = 158,["195"] = 159,["198"] = 134,["199"] = 164,["200"] = 165,["201"] = 166,["202"] = 167,["203"] = 168,["204"] = 169,["206"] = 171,["208"] = 164,["209"] = 175,["210"] = 176,["211"] = 175,["212"] = 179,["213"] = 180,["214"] = 181,["215"] = 179,["216"] = 184,["217"] = 185,["218"] = 190,["219"] = 190,["220"] = 190,["221"] = 190,["222"] = 190,["223"] = 191,["224"] = 191,["225"] = 191,["226"] = 191,["227"] = 191,["228"] = 192,["229"] = 192,["230"] = 192,["231"] = 192,["232"] = 192,["233"] = 184,["234"] = 195,["235"] = 196,["236"] = 195,["237"] = 199,["238"] = 200,["239"] = 200,["240"] = 59,["241"] = 200,["242"] = 200,["243"] = 200,["244"] = 200,["245"] = 200,["246"] = 200,["247"] = 200,["248"] = 200,["249"] = 199,["250"] = 210,["251"] = 211,["252"] = 210,["253"] = 214,["254"] = 215,["255"] = 214,["256"] = 59,["257"] = 58,["258"] = 59,["260"] = 59,["261"] = 219,["262"] = 219,["263"] = 220,["264"] = 220,["265"] = 219,["266"] = 220});
local ____exports = {}
local ModifierStormExtra
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local clampPosition = ____util.clampPosition
local createRadiusMarker = ____util.createRadiusMarker
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____storm_basic_attack = require("abilities.heroes.storm.storm_basic_attack")
local ModifierStormExBasicAttack = ____storm_basic_attack.ModifierStormExBasicAttack
local StormExBasicAttack = ____storm_basic_attack.StormExBasicAttack
local ____storm_second_attack = require("abilities.heroes.storm.storm_second_attack")
local StormSecondAttack = ____storm_second_attack.StormSecondAttack
local StormExtra = __TS__Class()
StormExtra.name = "StormExtra"
__TS__ClassExtends(StormExtra, CustomAbility)
function StormExtra.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_4
end
function StormExtra.prototype.GetPlaybackRateOverride(self)
    return 1
end
function StormExtra.prototype.GetCastingCrawl(self)
    return 0
end
function StormExtra.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        return not ____exports.ModifierStormExtraDisplacement:findOne(self.caster)
    end
    return false
end
function StormExtra.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local minRange = self:GetSpecialValueFor("min_range")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {
            maxRange = self:GetCastRange(
                Vector(0, 0, 0),
                nil
            ),
            minRange = minRange
        }
    )
    local direction = point:__sub(origin):Normalized()
    local distance = point:__sub(origin):Length2D()
    local ____opt_0 = ModifierStormExBasicAttack:findOne(self.caster)
    local level = ____opt_0 and ____opt_0:GetLevel() or 0
    ____exports.ModifierStormExtraDisplacement:apply(
        self.caster,
        self.caster,
        self,
        {
            x = direction.x,
            y = direction.y,
            distance = distance,
            speed = self:GetSpecialValueFor("speed"),
            peak = 1,
            level = level,
            radius = self:GetSpecialValueFor("radius"),
            teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY
        }
    )
    local randomNumber = RandomInt(1, 32)
    local soundName = ("stormspirit_ss_ability_lightning_" .. (randomNumber < 10 and "0" or "")) .. tostring(randomNumber)
    EmitSoundOn(soundName, self.caster)
end
StormExtra = __TS__Decorate(
    {registerAbility(nil, "storm_extra")},
    StormExtra
)
____exports.ModifierStormExtraDisplacement = __TS__Class()
local ModifierStormExtraDisplacement = ____exports.ModifierStormExtraDisplacement
ModifierStormExtraDisplacement.name = "ModifierStormExtraDisplacement"
__TS__ClassExtends(ModifierStormExtraDisplacement, ModifierDisplacement)
function ModifierStormExtraDisplacement.prototype.OnCreated(self, params)
    ModifierDisplacement.prototype.OnCreated(self, params)
    if IsServer() then
        local stormExBasicAttack = StormExBasicAttack:findOne(self.parent)
        local damagePerLevel = stormExBasicAttack and stormExBasicAttack:GetSpecialValueFor("damage_per_level") or 0
        self.stunDuration = stormExBasicAttack and stormExBasicAttack:GetSpecialValueFor("stun_duration") or 0
        self.healMultiplier = stormExBasicAttack and stormExBasicAttack:GetSpecialValueFor("heal_multiplier") or 0
        local extraDamage = damagePerLevel * self:GetStackCount()
        self.damage = self:Value("ability_damage") + extraDamage
        self.damageAoe = self:Value("aoe_damage") + extraDamage
        self:SetStackCount(params.level)
        self:PlayEffectsOnCreated()
    end
end
function ModifierStormExtraDisplacement.prototype.OnCollide(self, event)
    if IsServer() then
        if event.collision ~= "unit" then
            return
        end
        for ____, unit in ipairs(event.units) do
            if ModifierStormExtra:findOne(unit) or unit == self.parent then
                return
            end
            ModifierStormExtra:apply(unit, self.parent, self.ability, {duration = 0.35})
            self:OnImpactEnemyCollision(unit)
        end
    end
end
function ModifierStormExtraDisplacement.prototype.OnImpactEnemy(self, target, damage)
    if self:GetStackCount() >= 1 then
        if not isObstacle(nil, target) and not isGem(nil, target) then
            self.parent:Heal(self.healMultiplier * damage, self.ability)
        end
    end
    if self:GetStackCount() == 2 then
        target:AddNewModifier(
            self.parent,
            self:GetAbility(),
            "modifier_generic_stunned",
            {duration = self.stunDuration}
        )
    end
    ApplyDamage({victim = target, damage = damage, attacker = self.parent, damage_type = DAMAGE_TYPE_PURE})
    if not isObstacle(nil, target) and self.ability:GetLevel() >= 2 then
        local ____opt_8 = StormSecondAttack:findOne(self.parent)
        if ____opt_8 ~= nil then
            ____opt_8:EndCooldown()
        end
    end
end
function ModifierStormExtraDisplacement.prototype.OnImpactEnemyAOE(self, target)
    self:OnImpactEnemy(target, self.damageAoe)
    target:AddNewModifier(
        self.parent,
        self.ability,
        "modifier_generic_fading_slow",
        {
            duration = self:Value("fading_slow_duration"),
            max_slow_pct = self:Value("fading_slow_pct")
        }
    )
end
function ModifierStormExtraDisplacement.prototype.OnImpactEnemyCollision(self, target)
    self:OnImpactEnemy(target, self.damage)
end
function ModifierStormExtraDisplacement.prototype.OnDestroy(self)
    ModifierDisplacement.prototype.OnDestroy(self)
    if IsServer() then
        local units = CustomEntitiesLegacy:FindUnitsInRadius(
            self.parent,
            self.parent:GetAbsOrigin(),
            self.radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )
        for ____, unit in ipairs(units) do
            self:OnImpactEnemyAOE(unit)
        end
        createRadiusMarker(
            nil,
            self.parent,
            self.parent:GetAbsOrigin(),
            self.radius,
            "public",
            0.1
        )
        ScreenShake(
            self.parent:GetAbsOrigin(),
            100,
            300,
            0.45,
            1000,
            0,
            true
        )
        StopSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
        self:PlayEffectsOnDestroy()
        local modifier = ModifierStormExBasicAttack:findOne(self.parent)
        if modifier then
            modifier:SetStackCount(modifier:GetStackCount() - 10)
        end
    end
end
function ModifierStormExtraDisplacement.prototype.GetEffectName(self)
    local stacks = self:GetStackCount()
    if stacks == 0 then
        return "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf"
    elseif stacks == 1 then
        return "particles/econ/items/storm_spirit/storm_spirit_orchid_hat_retro/stormspirit_orchid_retro_ball_lightning.vpcf"
    else
        return "particles/storm/storm_ultimate_level_two.vpcf"
    end
end
function ModifierStormExtraDisplacement.prototype.GetEffectAttachType(self)
    return PATTACH_ROOTBONE_FOLLOW
end
function ModifierStormExtraDisplacement.prototype.PlayEffectsOnCreated(self)
    EmitSoundOn("Hero_StormSpirit.BallLightning", self.parent)
    EmitSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
end
function ModifierStormExtraDisplacement.prototype.PlayEffectsOnDestroy(self)
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        1,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        2,
        self.parent:GetAbsOrigin()
    )
end
function ModifierStormExtraDisplacement.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function ModifierStormExtraDisplacement.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {
            [MODIFIER_STATE_ROOTED] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_OUT_OF_GAME] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true
        }
    )
end
function ModifierStormExtraDisplacement.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_OVERRIDE_ABILITY_4
end
function ModifierStormExtraDisplacement.prototype.GetIsCommandRestricted(self)
    return false
end
ModifierStormExtraDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_extra_displacement"})},
    ModifierStormExtraDisplacement
)
____exports.ModifierStormExtraDisplacement = ModifierStormExtraDisplacement
ModifierStormExtra = __TS__Class()
ModifierStormExtra.name = "ModifierStormExtra"
__TS__ClassExtends(ModifierStormExtra, CustomModifier)
ModifierStormExtra = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_extra"})},
    ModifierStormExtra
)
return ____exports
