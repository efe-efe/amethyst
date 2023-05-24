local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 7,["17"] = 19,["18"] = 19,["19"] = 19,["20"] = 19,["21"] = 19,["22"] = 19,["23"] = 19,["24"] = 19,["25"] = 19,["26"] = 19,["27"] = 19,["28"] = 21,["29"] = 23,["30"] = 24,["31"] = 25,["32"] = 27,["33"] = 28,["36"] = 32,["37"] = 7,["38"] = 37,["39"] = 37,["40"] = 37,["41"] = 37,["43"] = 37,["44"] = 38,["45"] = 37,["46"] = 40,["48"] = 40,["49"] = 45,["50"] = 46,["51"] = 45,["52"] = 49,["53"] = 50,["54"] = 49,["55"] = 53,["56"] = 54,["57"] = 54,["58"] = 54,["59"] = 54,["60"] = 54,["61"] = 54,["62"] = 54,["63"] = 54,["64"] = 54,["65"] = 54,["66"] = 61,["67"] = 62,["68"] = 63,["69"] = 63,["70"] = 63,["71"] = 63,["73"] = 67,["74"] = 53,["75"] = 70,["76"] = 71,["77"] = 73,["78"] = 74,["80"] = 76,["81"] = 70,["82"] = 79,["83"] = 88,["84"] = 79,["85"] = 91,["86"] = 105,["87"] = 105,["88"] = 105,["90"] = 105,["91"] = 106,["92"] = 107,["93"] = 108,["94"] = 109,["95"] = 110,["96"] = 115,["97"] = 116,["98"] = 117,["99"] = 118,["103"] = 131,["104"] = 131,["105"] = 131,["106"] = 131,["107"] = 131,["108"] = 131,["109"] = 131,["110"] = 131,["111"] = 131,["112"] = 131,["113"] = 131,["114"] = 131,["115"] = 143,["116"] = 145,["117"] = 169,["118"] = 170,["119"] = 171,["120"] = 172,["121"] = 175,["125"] = 181,["126"] = 183,["130"] = 198,["131"] = 199,["132"] = 200,["133"] = 201,["137"] = 206,["138"] = 207,["140"] = 210,["141"] = 91});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local ____modifier_casting = require("modifiers.modifier_casting")
local ModifierCasting = ____modifier_casting.ModifierCasting
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
local ____util = require("util")
local callEntityFuncSafe = ____util.callEntityFuncSafe
local function findUnitsInCone(self, team, direction, minProjection, center, radius, teamFilter, typeFilter, flagFilter, orderFilter)
    local units = FindUnitsInRadius(
        team,
        center,
        nil,
        radius,
        teamFilter,
        typeFilter,
        flagFilter,
        orderFilter,
        false
    )
    local targets = {}
    for ____, unit in ipairs(units) do
        local directionToUnit = unit:GetAbsOrigin():__sub(center):Normalized()
        local projection = directionToUnit.x * direction.x + directionToUnit.y * direction.y
        if projection >= minProjection then
            targets[#targets + 1] = unit
        end
    end
    return targets
end
____exports.CustomAbility = __TS__Class()
local CustomAbility = ____exports.CustomAbility
CustomAbility.name = "CustomAbility"
__TS__ClassExtends(CustomAbility, BaseAbility)
function CustomAbility.prototype.____constructor(self, ...)
    BaseAbility.prototype.____constructor(self, ...)
    self.caster = self:GetCaster()
end
function CustomAbility.prototype.GetCastingCrawl(self)
    return
end
function CustomAbility.prototype.GetAnimation(self)
    return nil
end
function CustomAbility.prototype.GetAnimationTranslate(self)
    return nil
end
function CustomAbility.prototype.OnAbilityPhaseStart(self)
    ModifierCasting:apply(
        self.caster,
        self.caster,
        self,
        {
            duration = self:GetCastPoint(),
            movementSpeed = self:GetCastingCrawl(),
            translate = self:GetAnimationTranslate()
        }
    )
    local animation = self:GetAnimation()
    if animation then
        self.caster:StartGestureWithPlaybackRate(
            animation,
            self:GetPlaybackRateOverride()
        )
    end
    return true
end
function CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    local animation = self:GetAnimation()
    if animation then
        self.caster:FadeGesture(animation)
    end
    self:GetCaster():RemoveModifierByName(ModifierCasting.name)
end
function CustomAbility.prototype.OnSpellStart(self)
    self.caster:Stop()
end
function CustomAbility.prototype.MeeleAttack(self, options)
    local ____options_triggerCounters_0 = options.triggerCounters
    if ____options_triggerCounters_0 == nil then
        ____options_triggerCounters_0 = true
    end
    local triggerCounters = ____options_triggerCounters_0
    local teamFilter = options.teamFilter or DOTA_UNIT_TARGET_TEAM_ENEMY
    local typeFilter = options.typeFilter or DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    local flagFilter = options.flagFilter or DOTA_UNIT_TARGET_FLAG_NONE
    local orderFilter = options.orderFilter or FIND_CLOSEST
    local attackType = options.attackType or "other"
    if attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackStarted")
            end
        end
    end
    local units = findUnitsInCone(
        nil,
        self.caster:GetTeam(),
        options.direction,
        0,
        options.origin,
        options.radius,
        teamFilter,
        typeFilter,
        flagFilter,
        orderFilter
    )
    local hitTargets = 0
    for ____, unit in ipairs(units) do
        options:effect(unit)
        if attackType == "basic" then
            for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
                if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                    modifier:OnBasicAttackLanded({target = unit})
                end
            end
        end
        hitTargets = hitTargets + 1
        if options.maxTargets == hitTargets then
            break
        end
    end
    if attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackEnded")
            end
        end
    end
    if options.baseSound then
        EmitSoundOn(options.baseSound, self.caster)
    end
    return units
end
return ____exports
