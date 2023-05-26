local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 8,["20"] = 20,["21"] = 20,["22"] = 20,["23"] = 20,["24"] = 20,["25"] = 20,["26"] = 20,["27"] = 20,["28"] = 20,["29"] = 22,["30"] = 24,["31"] = 25,["32"] = 26,["33"] = 28,["34"] = 29,["37"] = 33,["38"] = 8,["39"] = 38,["40"] = 38,["41"] = 38,["42"] = 38,["44"] = 38,["45"] = 39,["46"] = 38,["47"] = 41,["49"] = 41,["50"] = 46,["51"] = 47,["52"] = 46,["53"] = 50,["54"] = 51,["55"] = 50,["56"] = 54,["57"] = 55,["58"] = 55,["59"] = 55,["60"] = 55,["61"] = 55,["62"] = 55,["63"] = 55,["64"] = 55,["65"] = 55,["66"] = 55,["67"] = 62,["68"] = 63,["69"] = 64,["70"] = 64,["71"] = 64,["72"] = 64,["74"] = 67,["75"] = 54,["76"] = 70,["77"] = 71,["78"] = 73,["79"] = 74,["81"] = 76,["82"] = 70,["83"] = 79,["84"] = 88,["85"] = 79,["86"] = 91,["87"] = 105,["88"] = 105,["89"] = 105,["91"] = 105,["92"] = 106,["93"] = 107,["94"] = 108,["95"] = 109,["96"] = 110,["97"] = 115,["98"] = 116,["99"] = 117,["100"] = 118,["104"] = 131,["105"] = 131,["106"] = 131,["107"] = 131,["108"] = 131,["109"] = 131,["110"] = 131,["111"] = 131,["112"] = 131,["113"] = 131,["114"] = 131,["115"] = 131,["116"] = 143,["117"] = 145,["118"] = 169,["119"] = 170,["120"] = 171,["121"] = 172,["122"] = 175,["126"] = 181,["127"] = 183,["131"] = 198,["132"] = 199,["133"] = 200,["134"] = 201,["138"] = 206,["139"] = 207,["141"] = 210,["142"] = 91,["143"] = 213,["144"] = 226,["145"] = 226,["146"] = 226,["148"] = 226,["149"] = 227,["150"] = 228,["151"] = 229,["152"] = 230,["153"] = 231,["154"] = 233,["155"] = 234,["156"] = 235,["157"] = 236,["161"] = 241,["162"] = 241,["163"] = 241,["164"] = 241,["165"] = 241,["166"] = 241,["167"] = 241,["168"] = 241,["169"] = 241,["170"] = 251,["171"] = 253,["172"] = 277,["173"] = 278,["174"] = 279,["175"] = 280,["176"] = 283,["180"] = 289,["181"] = 291,["185"] = 296,["187"] = 302,["188"] = 303,["189"] = 304,["190"] = 305,["194"] = 310,["195"] = 213,["196"] = 313,["197"] = 324,["198"] = 324,["199"] = 324,["201"] = 324,["202"] = 325,["203"] = 326,["204"] = 327,["205"] = 328,["206"] = 329,["207"] = 331,["208"] = 332,["209"] = 333,["210"] = 334,["214"] = 362,["215"] = 363,["216"] = 364,["217"] = 365,["218"] = 368,["222"] = 374,["223"] = 375,["224"] = 376,["225"] = 377,["229"] = 382,["230"] = 313,["231"] = 385,["232"] = 386,["233"] = 386,["234"] = 386,["236"] = 386,["237"] = 387,["238"] = 388,["239"] = 389,["240"] = 389,["241"] = 389,["242"] = 389,["243"] = 390,["244"] = 392,["246"] = 418,["247"] = 418,["249"] = 418,["251"] = 419,["252"] = 420,["253"] = 421,["254"] = 424,["258"] = 392,["259"] = 432,["261"] = 433,["262"] = 433,["264"] = 433,["266"] = 442,["267"] = 443,["268"] = 444,["269"] = 445,["273"] = 432,["274"] = 452,["275"] = 453,["276"] = 454,["277"] = 455,["281"] = 460,["282"] = 460,["283"] = 460,["284"] = 460,["285"] = 472,["286"] = 385});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local ____modifier_casting = require("modifiers.modifier_casting")
local ModifierCasting = ____modifier_casting.ModifierCasting
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
local ____projectiles = require("projectiles")
local createProjectile = ____projectiles.createProjectile
local ____util = require("util")
local callEntityFuncSafe = ____util.callEntityFuncSafe
local function findUnitsInCone(self, source, direction, minProjection, center, radius, teamFilter, typeFilter, flagFilter, orderFilter)
    local units = CustomEntitiesLegacy:FindUnitsInRadius(
        source,
        center,
        radius,
        teamFilter,
        typeFilter,
        flagFilter,
        orderFilter
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
        self.caster,
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
function CustomAbility.prototype.AoeAttack(self, options)
    local ____options_triggerCounters_1 = options.triggerCounters
    if ____options_triggerCounters_1 == nil then
        ____options_triggerCounters_1 = false
    end
    local triggerCounters = ____options_triggerCounters_1
    local teamFilter = options.teamFilter or DOTA_UNIT_TARGET_TEAM_ENEMY
    local typeFilter = options.typeFilter or DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    local flagFilter = options.flagFilter or DOTA_UNIT_TARGET_FLAG_NONE
    local orderFilter = options.orderFilter or FIND_CLOSEST
    local attackType = options.attackType or "other"
    if options.attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackStarted")
            end
        end
    end
    local units = CustomEntitiesLegacy:FindUnitsInRadius(
        self.caster,
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
    if hitTargets == 0 then
    end
    if attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackEnded")
            end
        end
    end
    return units
end
function CustomAbility.prototype.SingleAttack(self, options)
    local ____options_triggerCounters_2 = options.triggerCounters
    if ____options_triggerCounters_2 == nil then
        ____options_triggerCounters_2 = true
    end
    local triggerCounters = ____options_triggerCounters_2
    local teamFilter = options.teamFilter or DOTA_UNIT_TARGET_TEAM_ENEMY
    local typeFilter = options.typeFilter or DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    local flagFilter = options.flagFilter or DOTA_UNIT_TARGET_FLAG_NONE
    local orderFilter = options.orderFilter or FIND_CLOSEST
    local attackType = options.attackType or "other"
    if options.attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackStarted")
            end
        end
    end
    options:effect(options.target)
    if attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                modifier:OnBasicAttackLanded({target = options.target})
            end
        end
    end
    if attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackEnded")
            end
        end
    end
    return options.target
end
function CustomAbility.prototype.ProjectileAttack(self, options)
    local ____options_triggerCounters_3 = options.triggerCounters
    if ____options_triggerCounters_3 == nil then
        ____options_triggerCounters_3 = true
    end
    local triggerCounters = ____options_triggerCounters_3
    local attackType = options.attackType or "other"
    local valueDistance = self:GetSpecialValueFor("projectile_distance")
    local distance = (options.distance or valueDistance ~= 0) and valueDistance or self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local startRadius = options.startRadius or self:GetSpecialValueFor("hitbox")
    local function onUnitHit(____, unit, projectile)
        local ____this_5
        ____this_5 = options
        local ____opt_4 = ____this_5.onUnitHit
        if ____opt_4 ~= nil then
            ____opt_4(____this_5, unit, projectile)
        end
        if attackType == "basic" then
            for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
                if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                    modifier:OnBasicAttackLanded({target = unit})
                end
            end
        end
    end
    local function onFinish(____, position)
        local ____this_7
        ____this_7 = options
        local ____opt_6 = ____this_7.onFinish
        if ____opt_6 ~= nil then
            ____opt_6(____this_7, position)
        end
        if attackType == "basic" then
            for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
                if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                    callEntityFuncSafe(nil, modifier, "OnBasicAttackEnded")
                end
            end
        end
    end
    if options.attackType == "basic" then
        for ____, modifier in ipairs(self.caster:FindAllModifiers()) do
            if __TS__InstanceOf(modifier, ModifierCombatEvents) then
                callEntityFuncSafe(nil, modifier, "OnBasicAttackStarted")
            end
        end
    end
    local projectile = createProjectile(
        nil,
        __TS__ObjectAssign({}, options, {distance = distance, startRadius = startRadius, onUnitHit = onUnitHit, onFinish = onFinish})
    )
    return projectile
end
return ____exports
