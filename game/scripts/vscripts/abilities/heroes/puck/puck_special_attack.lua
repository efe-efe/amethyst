local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 46,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 7,["24"] = 8,["25"] = 7,["26"] = 8,["27"] = 9,["28"] = 10,["29"] = 9,["30"] = 13,["31"] = 14,["32"] = 13,["33"] = 17,["34"] = 18,["35"] = 17,["36"] = 21,["37"] = 22,["38"] = 23,["39"] = 24,["40"] = 24,["41"] = 24,["42"] = 24,["43"] = 24,["44"] = 24,["45"] = 24,["46"] = 24,["47"] = 24,["48"] = 26,["49"] = 26,["50"] = 26,["51"] = 26,["52"] = 26,["53"] = 26,["54"] = 26,["55"] = 26,["56"] = 26,["57"] = 26,["58"] = 26,["59"] = 26,["60"] = 26,["61"] = 34,["62"] = 34,["63"] = 34,["64"] = 34,["65"] = 34,["66"] = 34,["67"] = 34,["68"] = 34,["69"] = 34,["70"] = 34,["71"] = 34,["72"] = 34,["73"] = 41,["74"] = 21,["75"] = 8,["76"] = 7,["77"] = 8,["79"] = 8,["80"] = 45,["81"] = 45,["82"] = 46,["83"] = 56,["84"] = 46,["85"] = 67,["86"] = 68,["87"] = 69,["89"] = 56,["90"] = 73,["91"] = 46,["92"] = 76,["93"] = 77,["94"] = 79,["95"] = 80,["98"] = 73,["99"] = 85,["100"] = 86,["101"] = 88,["102"] = 88,["103"] = 88,["104"] = 91,["105"] = 92,["106"] = 93,["108"] = 96,["109"] = 97,["111"] = 100,["112"] = 101,["114"] = 107,["115"] = 108,["116"] = 114,["117"] = 115,["119"] = 88,["120"] = 88,["121"] = 120,["122"] = 122,["123"] = 123,["125"] = 126,["126"] = 85,["127"] = 129,["128"] = 130,["129"] = 131,["130"] = 131,["131"] = 131,["132"] = 131,["133"] = 131,["134"] = 131,["135"] = 131,["136"] = 131,["137"] = 131,["138"] = 131,["139"] = 131,["140"] = 137,["141"] = 137,["142"] = 137,["143"] = 137,["144"] = 137,["145"] = 137,["146"] = 137,["147"] = 137,["148"] = 137,["149"] = 137,["150"] = 137,["151"] = 129,["152"] = 46,["153"] = 45,["154"] = 46});
local ____exports = {}
local ModifierPuckSpecialAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____puck_basic_attack = require("abilities.heroes.puck.puck_basic_attack")
local ModifierPuckFairyDust = ____puck_basic_attack.ModifierPuckFairyDust
____exports.PuckSpecialAttack = __TS__Class()
local PuckSpecialAttack = ____exports.PuckSpecialAttack
PuckSpecialAttack.name = "PuckSpecialAttack"
__TS__ClassExtends(PuckSpecialAttack, CustomAbility)
function PuckSpecialAttack.prototype.GetCastAnimationCustom(self)
    return ACT_DOTA_CAST_ABILITY_5
end
function PuckSpecialAttack.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckSpecialAttack.prototype.GetCastingCrawl(self)
    return 0
end
function PuckSpecialAttack.prototype.OnSpellStart(self)
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
    ModifierPuckSpecialAttack:createThinker(
        self.caster,
        self,
        point,
        {
            delayTime = self:GetSpecialValueFor("delay"),
            radius = self:GetSpecialValueFor("radius"),
            damage = self:GetSpecialValueFor("damage"),
            stunDuration = self:GetSpecialValueFor("stun_duration"),
            fairyDustDuration = self:GetSpecialValueFor("fairy_dust_duration"),
            fairyDustSlowPct = self:GetSpecialValueFor("fairy_dust_slow_pct")
        }
    )
    ModifierPuckSpecialAttack:createThinker(
        self.caster,
        self,
        point,
        {
            delayTime = self:GetSpecialValueFor("delay_small"),
            radius = self:GetSpecialValueFor("radius_small"),
            damage = self:GetSpecialValueFor("damage_small"),
            silenceDuration = self:GetSpecialValueFor("silence_duration"),
            stunDuration = self:GetSpecialValueFor("stun_duration_small")
        }
    )
    EmitSoundOn("Hero_Puck.Dream_Coil", self.caster)
end
PuckSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "puck_special_attack")},
    PuckSpecialAttack
)
____exports.PuckSpecialAttack = PuckSpecialAttack
ModifierPuckSpecialAttack = __TS__Class()
ModifierPuckSpecialAttack.name = "ModifierPuckSpecialAttack"
__TS__ClassExtends(ModifierPuckSpecialAttack, ModifierThinker)
function ModifierPuckSpecialAttack.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = self.parent:GetAbsOrigin()
        self.manaGainPct = self.ability:GetSpecialValueFor("mana_gain_pct")
    end
end
function ModifierPuckSpecialAttack.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        StopSoundOn("Hero_Puck.Dream_Coil", self.caster)
        if self.particleId then
            DEFX(self.particleId, false)
        end
    end
end
function ModifierPuckSpecialAttack.prototype.OnReady(self)
    local giveMana = false
    self.ability:AoeAttack({
        origin = self.origin,
        radius = self.radius,
        effect = function(____, target)
            if self.ability:GetLevel() >= 2 then
                target:AddNewModifier(self.caster, self.ability, "modifier_generic_stunned", {duration = self.stunDuration})
            end
            if self.silenceDuration then
                target:AddNewModifier(self.caster, self.ability, "modifier_generic_silence", {duration = self.silenceDuration})
            end
            if self.fairyDustDuration and self.fairyDustSlowPct then
                ModifierPuckFairyDust:apply(target, self.caster, self.ability, {duration = self.fairyDustDuration, slowPct = self.fairyDustSlowPct})
            end
            EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", target)
            ApplyDamage({victim = target, attacker = self.caster, damage = self.damage, damage_type = DAMAGE_TYPE_PURE})
            if not isObstacle(nil, target) and not isGem(nil, target) then
                giveMana = true
            end
        end
    })
    self:PlayEffectsExplode(self.radius, 0)
    if giveMana then
        giveManaAndEnergyPercent(nil, self.caster, self.manaGainPct, true)
    end
    self:Destroy()
end
function ModifierPuckSpecialAttack.prototype.PlayEffectsExplode(self, radius, steam)
    EmitSoundOn("Hero_Puck.Dream_Coil_Snap", self.parent)
    EFX(
        "particles/puck/puck_special_attack_radius.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = self.origin,
            cp1 = self.origin,
            cp2 = Vector(radius),
            release = true
        }
    )
    EFX(
        "particles/puck/puck_special_attack.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = self.origin,
            cp2 = Vector(radius, 0, 0),
            cp6 = Vector(steam, 0, 0),
            release = true
        }
    )
end
ModifierPuckSpecialAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_special_attack_thinker"})},
    ModifierPuckSpecialAttack
)
return ____exports
