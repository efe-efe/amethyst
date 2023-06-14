local ____lualib = require("lualib_bundle")
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 8,["20"] = 20,["21"] = 20,["22"] = 20,["23"] = 20,["24"] = 20,["25"] = 20,["26"] = 20,["27"] = 20,["28"] = 20,["29"] = 22,["30"] = 24,["31"] = 25,["32"] = 26,["33"] = 28,["34"] = 29,["37"] = 33,["38"] = 8,["39"] = 36,["40"] = 37,["41"] = 38,["42"] = 39,["45"] = 36,["46"] = 44,["47"] = 45,["48"] = 46,["49"] = 47,["52"] = 44,["53"] = 52,["54"] = 53,["55"] = 54,["56"] = 57,["59"] = 52,["60"] = 62,["61"] = 63,["62"] = 64,["63"] = 65,["64"] = 69,["65"] = 70,["66"] = 71,["69"] = 79,["71"] = 82,["74"] = 85,["75"] = 62,["76"] = 88,["77"] = 90,["78"] = 88,["79"] = 96,["80"] = 96,["81"] = 96,["82"] = 96,["84"] = 96,["85"] = 97,["86"] = 96,["87"] = 101,["89"] = 101,["90"] = 106,["91"] = 107,["92"] = 106,["93"] = 110,["94"] = 111,["95"] = 110,["96"] = 114,["97"] = 115,["98"] = 115,["99"] = 115,["100"] = 115,["101"] = 115,["102"] = 115,["103"] = 115,["104"] = 115,["105"] = 115,["106"] = 115,["107"] = 122,["108"] = 123,["109"] = 124,["110"] = 124,["111"] = 124,["112"] = 124,["114"] = 127,["115"] = 114,["116"] = 130,["117"] = 131,["118"] = 133,["119"] = 134,["121"] = 136,["122"] = 130,["123"] = 139,["124"] = 148,["125"] = 139,["126"] = 151,["127"] = 165,["128"] = 165,["129"] = 165,["131"] = 165,["132"] = 166,["133"] = 167,["134"] = 168,["135"] = 169,["136"] = 170,["137"] = 175,["138"] = 176,["140"] = 187,["141"] = 187,["142"] = 187,["143"] = 187,["144"] = 187,["145"] = 187,["146"] = 187,["147"] = 187,["148"] = 187,["149"] = 187,["150"] = 187,["151"] = 187,["152"] = 199,["153"] = 201,["154"] = 202,["155"] = 204,["156"] = 205,["157"] = 206,["158"] = 207,["161"] = 211,["162"] = 213,["166"] = 222,["167"] = 223,["169"] = 226,["170"] = 227,["172"] = 230,["173"] = 151,["174"] = 233,["175"] = 246,["176"] = 246,["177"] = 246,["179"] = 246,["180"] = 247,["181"] = 248,["182"] = 249,["183"] = 250,["184"] = 251,["185"] = 253,["186"] = 254,["188"] = 257,["189"] = 257,["190"] = 257,["191"] = 257,["192"] = 257,["193"] = 257,["194"] = 257,["195"] = 257,["196"] = 257,["197"] = 267,["198"] = 269,["199"] = 270,["200"] = 272,["201"] = 273,["202"] = 274,["203"] = 275,["206"] = 279,["207"] = 281,["211"] = 286,["212"] = 287,["214"] = 290,["215"] = 233,["216"] = 293,["217"] = 304,["218"] = 304,["219"] = 304,["221"] = 304,["222"] = 305,["223"] = 306,["224"] = 307,["225"] = 308,["226"] = 309,["227"] = 311,["228"] = 312,["230"] = 315,["231"] = 317,["232"] = 318,["233"] = 319,["234"] = 320,["237"] = 324,["238"] = 325,["240"] = 328,["241"] = 293,["242"] = 331,["243"] = 337,["244"] = 337,["245"] = 337,["247"] = 337,["248"] = 338,["249"] = 339,["250"] = 340,["251"] = 340,["252"] = 340,["253"] = 340,["254"] = 341,["255"] = 343,["256"] = 344,["257"] = 344,["258"] = 344,["259"] = 344,["260"] = 344,["261"] = 344,["262"] = 344,["263"] = 346,["265"] = 347,["266"] = 347,["268"] = 347,["270"] = 348,["271"] = 349,["274"] = 353,["275"] = 343,["276"] = 356,["278"] = 357,["279"] = 357,["281"] = 357,["283"] = 359,["284"] = 360,["286"] = 356,["287"] = 364,["288"] = 365,["290"] = 368,["291"] = 368,["292"] = 368,["293"] = 368,["294"] = 380,["295"] = 331,["296"] = 99});
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
local function triggerBasicAttackStarted(self, unit)
    for ____, modifier in ipairs(unit:FindAllModifiers()) do
        if __TS__InstanceOf(modifier, ModifierCombatEvents) then
            callEntityFuncSafe(nil, modifier, "OnBasicAttackStarted")
        end
    end
end
local function triggerBasicAttackEnded(self, unit)
    for ____, modifier in ipairs(unit:FindAllModifiers()) do
        if __TS__InstanceOf(modifier, ModifierCombatEvents) then
            callEntityFuncSafe(nil, modifier, "OnBasicAttackEnded")
        end
    end
end
local function triggerBasicAttackLanded(self, unit, target)
    for ____, modifier in ipairs(unit:FindAllModifiers()) do
        if __TS__InstanceOf(modifier, ModifierCombatEvents) then
            modifier:OnBasicAttackLanded({target = target})
        end
    end
end
local function triggerOnHit(self, unit, attackCategory, triggerCounters, projectile)
    local bypass = false
    for ____, modifier in ipairs(unit:FindAllModifiers()) do
        if __TS__InstanceOf(modifier, ModifierCombatEvents) then
            if attackCategory == "projectile" then
                if projectile then
                    bypass = not modifier:OnHit({source = unit, triggerCounters = triggerCounters, attackCategory = attackCategory, projectile = projectile})
                end
            else
                bypass = not modifier:OnHit({source = unit, triggerCounters = triggerCounters, attackCategory = attackCategory})
            end
            modifier:AfterHit()
        end
    end
    return bypass
end
local function findOne(self, target)
    return target:FindAbilityByName(self.name)
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
        triggerBasicAttackStarted(nil, self.caster)
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
        local bypass = triggerOnHit(nil, unit, "meele", triggerCounters)
        if not bypass then
            options:effect(unit)
            if attackType == "basic" then
                triggerBasicAttackLanded(nil, self.caster, unit)
            end
        end
        hitTargets = hitTargets + 1
        if options.maxTargets == hitTargets then
            break
        end
    end
    if attackType == "basic" then
        triggerBasicAttackEnded(nil, self.caster)
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
        triggerBasicAttackStarted(nil, self.caster)
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
        local bypass = triggerOnHit(nil, unit, "aoe", triggerCounters)
        if not bypass then
            options:effect(unit)
            if attackType == "basic" then
                triggerBasicAttackLanded(nil, self.caster, unit)
            end
        end
        hitTargets = hitTargets + 1
        if options.maxTargets == hitTargets then
            break
        end
    end
    if attackType == "basic" then
        triggerBasicAttackEnded(nil, self.caster)
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
        triggerBasicAttackStarted(nil, self.caster)
    end
    local bypass = triggerOnHit(nil, options.target, "single", triggerCounters)
    if not bypass then
        options:effect(options.target)
        if attackType == "basic" then
            triggerBasicAttackLanded(nil, self.caster, options.target)
        end
    end
    if attackType == "basic" then
        triggerBasicAttackEnded(nil, self.caster)
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
        local bypass = triggerOnHit(
            nil,
            unit,
            "projectile",
            triggerCounters,
            projectile
        )
        if not bypass then
            local ____this_5
            ____this_5 = options
            local ____opt_4 = ____this_5.onUnitHit
            if ____opt_4 ~= nil then
                ____opt_4(____this_5, unit, projectile)
            end
            if attackType == "basic" then
                triggerBasicAttackLanded(nil, self.caster, unit)
            end
        end
        return bypass
    end
    local function onFinish(____, projectile)
        local ____this_7
        ____this_7 = options
        local ____opt_6 = ____this_7.onFinish
        if ____opt_6 ~= nil then
            ____opt_6(____this_7, projectile)
        end
        if attackType == "basic" then
            triggerBasicAttackEnded(nil, self.caster)
        end
    end
    if options.attackType == "basic" then
        triggerBasicAttackStarted(nil, self.caster)
    end
    local projectile = createProjectile(
        nil,
        __TS__ObjectAssign({}, options, {distance = distance, startRadius = startRadius, onUnitHit = onUnitHit, onFinish = onFinish})
    )
    return projectile
end
CustomAbility.findOne = findOne
return ____exports
