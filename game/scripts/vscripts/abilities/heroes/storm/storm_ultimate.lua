local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 96,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 5,["22"] = 6,["23"] = 6,["24"] = 7,["25"] = 7,["26"] = 9,["27"] = 9,["28"] = 10,["29"] = 13,["30"] = 14,["31"] = 13,["32"] = 17,["33"] = 18,["34"] = 17,["35"] = 21,["36"] = 22,["37"] = 21,["38"] = 25,["39"] = 10,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 28,["47"] = 32,["48"] = 32,["49"] = 32,["50"] = 32,["51"] = 32,["52"] = 32,["53"] = 35,["54"] = 36,["55"] = 37,["56"] = 38,["57"] = 39,["58"] = 43,["60"] = 45,["61"] = 25,["62"] = 48,["63"] = 10,["64"] = 50,["65"] = 51,["67"] = 48,["68"] = 55,["69"] = 56,["70"] = 57,["72"] = 60,["73"] = 61,["74"] = 62,["75"] = 62,["76"] = 62,["77"] = 62,["78"] = 62,["79"] = 62,["80"] = 62,["81"] = 62,["82"] = 62,["83"] = 64,["84"] = 64,["85"] = 64,["86"] = 64,["87"] = 64,["88"] = 64,["89"] = 64,["90"] = 64,["91"] = 64,["92"] = 55,["93"] = 10,["94"] = 9,["95"] = 10,["97"] = 71,["98"] = 72,["99"] = 71,["100"] = 72,["101"] = 73,["102"] = 74,["103"] = 75,["105"] = 73,["106"] = 81,["107"] = 82,["108"] = 81,["109"] = 85,["110"] = 86,["111"] = 85,["112"] = 72,["113"] = 71,["114"] = 72,["116"] = 72,["117"] = 95,["118"] = 95,["119"] = 96,["121"] = 96,["122"] = 98,["123"] = 95,["124"] = 100,["125"] = 96,["126"] = 102,["127"] = 100,["128"] = 105,["129"] = 96,["130"] = 108,["131"] = 109,["133"] = 105,["134"] = 113,["135"] = 114,["136"] = 114,["137"] = 114,["138"] = 114,["139"] = 114,["140"] = 114,["141"] = 114,["142"] = 114,["143"] = 114,["144"] = 114,["145"] = 114,["146"] = 120,["147"] = 125,["148"] = 126,["149"] = 127,["150"] = 127,["151"] = 127,["152"] = 127,["153"] = 127,["154"] = 127,["155"] = 127,["156"] = 127,["157"] = 127,["158"] = 129,["159"] = 129,["160"] = 129,["161"] = 129,["162"] = 129,["163"] = 129,["164"] = 129,["165"] = 129,["166"] = 129,["167"] = 139,["168"] = 140,["169"] = 140,["170"] = 140,["171"] = 140,["172"] = 140,["173"] = 140,["174"] = 147,["175"] = 148,["176"] = 148,["177"] = 148,["178"] = 148,["179"] = 148,["180"] = 150,["181"] = 150,["182"] = 150,["183"] = 150,["184"] = 150,["185"] = 150,["186"] = 150,["189"] = 160,["190"] = 160,["191"] = 160,["192"] = 160,["193"] = 160,["194"] = 160,["195"] = 161,["196"] = 113,["197"] = 96,["198"] = 95,["199"] = 96,["201"] = 165,["202"] = 165,["203"] = 166,["204"] = 167,["205"] = 168,["206"] = 168,["207"] = 166,["208"] = 168,["209"] = 168,["210"] = 167,["211"] = 166,["212"] = 165,["213"] = 166,["215"] = 175,["216"] = 175,["217"] = 176,["218"] = 177,["219"] = 178,["220"] = 177,["221"] = 181,["222"] = 182,["223"] = 181,["224"] = 185,["225"] = 186,["226"] = 185,["227"] = 189,["228"] = 190,["229"] = 190,["230"] = 176,["231"] = 190,["232"] = 190,["233"] = 189,["234"] = 176,["235"] = 175,["236"] = 176});
local ____exports = {}
local ModifierStormUltimateThinker, ModifierStormUltimateBanish, ModifierStormUltimateDisplacement
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local StormUltimate = __TS__Class()
StormUltimate.name = "StormUltimate"
__TS__ClassExtends(StormUltimate, CustomAbility)
function StormUltimate.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function StormUltimate.prototype.GetPlaybackRateOverride(self)
    return 1
end
function StormUltimate.prototype.GetCastingCrawl(self)
    return 0
end
function StormUltimate.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        local origin = self.caster:GetAbsOrigin()
        ModifierStormUltimateBanish:apply(
            self.caster,
            self.caster,
            self,
            {duration = self:GetSpecialValueFor("delay_time") + self:GetCastPoint()}
        )
        self.particleId = EFX(
            "particles/storm/storm_ultimate_casting.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self.caster,
            {cp1 = Vector(100, 0, 0)}
        )
        EmitGlobalSound("stormspirit_ss_spawn_07")
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.caster)
        EmitSoundOn("Hero_Zeus.BlinkDagger.Arcana", self.caster)
        EmitSoundOn("Hero_Zuus.GodsWrath.PreCast.Arcana", self.caster)
        EFX("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_start.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = origin, release = true})
        return true
    end
    return false
end
function StormUltimate.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    if self.particleId then
        DEFX(self.particleId, false)
    end
end
function StormUltimate.prototype.OnSpellStart(self)
    if self.particleId then
        DEFX(self.particleId, false)
    end
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
    ModifierStormUltimateThinker:createThinker(
        self.caster,
        self,
        point,
        {
            delayTime = self:GetSpecialValueFor("delay_time"),
            radius = self:GetSpecialValueFor("radius")
        }
    )
end
StormUltimate = __TS__Decorate(
    {registerAbility(nil, "storm_ultimate")},
    StormUltimate
)
____exports.ModifierStormUltimate = __TS__Class()
local ModifierStormUltimate = ____exports.ModifierStormUltimate
ModifierStormUltimate.name = "ModifierStormUltimate"
__TS__ClassExtends(ModifierStormUltimate, CustomModifier)
function ModifierStormUltimate.prototype.OnDestroy(self)
    if IsServer() then
        EFX("particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {release = true})
    end
end
function ModifierStormUltimate.prototype.GetManaMultiplier(self)
    return self:Value("mana_multiplier")
end
function ModifierStormUltimate.prototype.GetEffectName(self)
    return "particles/storm/storm_ultimate.vpcf"
end
ModifierStormUltimate = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_ultimate"})},
    ModifierStormUltimate
)
____exports.ModifierStormUltimate = ModifierStormUltimate
ModifierStormUltimateThinker = __TS__Class()
ModifierStormUltimateThinker.name = "ModifierStormUltimateThinker"
__TS__ClassExtends(ModifierStormUltimateThinker, ModifierThinker)
function ModifierStormUltimateThinker.prototype.____constructor(self, ...)
    ModifierThinker.prototype.____constructor(self, ...)
    self.knockbackDistance = 500
end
function ModifierStormUltimateThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    self.origin = self.parent:GetAbsOrigin()
end
function ModifierStormUltimateThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        UTIL_Remove(self.parent)
    end
end
function ModifierStormUltimateThinker.prototype.OnReady(self)
    EFX(
        "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = self.origin,
            cp1 = self.origin + Vector(0, 0, 1000),
            cp2 = self.origin,
            release = true
        }
    )
    EFX("particles/storm/storm_ultimate_impact.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = self.origin, cp3 = self.origin, release = true})
    EmitSoundOn("Hero_Zuus.GodsWrath.Target", self.caster)
    FindClearSpaceForUnit(self.caster, self.origin, true)
    ScreenShake(
        self.origin,
        100,
        300,
        0.45,
        1000,
        0,
        true
    )
    local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.parent,
        self.parent:GetAbsOrigin(),
        self:Value("radius"),
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
        if self.caster:HasModifier("modifier_upgrade_storm_unleashed_knockback") then
            local direction = direction2D(
                nil,
                self.origin,
                enemy:GetAbsOrigin()
            )
            ModifierStormUltimateDisplacement:apply(enemy, self.caster, self.ability, {
                x = direction.x,
                y = direction.y,
                distance = self.knockbackDistance,
                speed = self.knockbackDistance / 0.35,
                peak = 50
            })
        end
    end
    ____exports.ModifierStormUltimate:apply(
        self.caster,
        self.caster,
        self.ability,
        {duration = self:Value("duration")}
    )
    self:Destroy()
end
ModifierStormUltimateThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_ultimate_thinker"})},
    ModifierStormUltimateThinker
)
ModifierStormUltimateBanish = __TS__Class()
ModifierStormUltimateBanish.name = "ModifierStormUltimateBanish"
__TS__ClassExtends(ModifierStormUltimateBanish, ModifierBanish)
function ModifierStormUltimateBanish.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierBanish.prototype.CheckState(self),
        {[MODIFIER_STATE_COMMAND_RESTRICTED] = true}
    )
end
ModifierStormUltimateBanish = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_ultimate_banish"})},
    ModifierStormUltimateBanish
)
ModifierStormUltimateDisplacement = __TS__Class()
ModifierStormUltimateDisplacement.name = "ModifierStormUltimateDisplacement"
__TS__ClassExtends(ModifierStormUltimateDisplacement, ModifierDisplacement)
function ModifierStormUltimateDisplacement.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierStormUltimateDisplacement.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierStormUltimateDisplacement.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierStormUltimateDisplacement.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
ModifierStormUltimateDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_ultimate_displacement"})},
    ModifierStormUltimateDisplacement
)
return ____exports
