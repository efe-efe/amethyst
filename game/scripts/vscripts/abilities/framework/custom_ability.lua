local ____lualib = require("lualib_bundle")
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 8,["20"] = 20,["21"] = 20,["22"] = 20,["23"] = 20,["24"] = 20,["25"] = 20,["26"] = 20,["27"] = 20,["28"] = 20,["29"] = 22,["30"] = 24,["31"] = 25,["32"] = 26,["33"] = 28,["34"] = 29,["37"] = 33,["38"] = 8,["39"] = 36,["40"] = 37,["41"] = 38,["42"] = 39,["45"] = 36,["46"] = 44,["47"] = 45,["48"] = 46,["49"] = 47,["52"] = 44,["53"] = 52,["54"] = 53,["55"] = 54,["56"] = 57,["59"] = 52,["60"] = 62,["61"] = 63,["62"] = 64,["63"] = 65,["64"] = 69,["65"] = 70,["66"] = 71,["69"] = 79,["71"] = 82,["74"] = 85,["75"] = 62,["76"] = 91,["77"] = 91,["78"] = 91,["79"] = 91,["81"] = 91,["82"] = 92,["83"] = 91,["84"] = 94,["86"] = 94,["87"] = 99,["88"] = 100,["89"] = 99,["90"] = 103,["91"] = 104,["92"] = 103,["93"] = 107,["94"] = 108,["95"] = 108,["96"] = 108,["97"] = 108,["98"] = 108,["99"] = 108,["100"] = 108,["101"] = 108,["102"] = 108,["103"] = 108,["104"] = 115,["105"] = 116,["106"] = 117,["107"] = 117,["108"] = 117,["109"] = 117,["111"] = 120,["112"] = 107,["113"] = 123,["114"] = 124,["115"] = 126,["116"] = 127,["118"] = 129,["119"] = 123,["120"] = 132,["121"] = 141,["122"] = 132,["123"] = 144,["124"] = 158,["125"] = 158,["126"] = 158,["128"] = 158,["129"] = 159,["130"] = 160,["131"] = 161,["132"] = 162,["133"] = 163,["134"] = 168,["135"] = 169,["137"] = 180,["138"] = 180,["139"] = 180,["140"] = 180,["141"] = 180,["142"] = 180,["143"] = 180,["144"] = 180,["145"] = 180,["146"] = 180,["147"] = 180,["148"] = 180,["149"] = 192,["150"] = 194,["151"] = 195,["152"] = 197,["153"] = 198,["154"] = 199,["155"] = 200,["158"] = 204,["159"] = 206,["163"] = 215,["164"] = 216,["166"] = 219,["167"] = 220,["169"] = 223,["170"] = 144,["171"] = 226,["172"] = 239,["173"] = 239,["174"] = 239,["176"] = 239,["177"] = 240,["178"] = 241,["179"] = 242,["180"] = 243,["181"] = 244,["182"] = 246,["183"] = 247,["185"] = 250,["186"] = 250,["187"] = 250,["188"] = 250,["189"] = 250,["190"] = 250,["191"] = 250,["192"] = 250,["193"] = 250,["194"] = 260,["195"] = 262,["196"] = 263,["197"] = 265,["198"] = 266,["199"] = 267,["200"] = 268,["203"] = 272,["204"] = 274,["208"] = 279,["209"] = 280,["211"] = 283,["212"] = 226,["213"] = 286,["214"] = 297,["215"] = 297,["216"] = 297,["218"] = 297,["219"] = 298,["220"] = 299,["221"] = 300,["222"] = 301,["223"] = 302,["224"] = 304,["225"] = 305,["227"] = 308,["228"] = 310,["229"] = 311,["230"] = 312,["231"] = 313,["234"] = 317,["235"] = 318,["237"] = 321,["238"] = 286,["239"] = 324,["240"] = 330,["241"] = 330,["242"] = 330,["244"] = 330,["245"] = 331,["246"] = 332,["247"] = 333,["248"] = 333,["249"] = 333,["250"] = 333,["251"] = 334,["252"] = 336,["253"] = 337,["254"] = 337,["255"] = 337,["256"] = 337,["257"] = 337,["258"] = 337,["259"] = 337,["260"] = 339,["262"] = 340,["263"] = 340,["265"] = 340,["267"] = 341,["268"] = 342,["271"] = 346,["272"] = 336,["273"] = 349,["275"] = 350,["276"] = 350,["278"] = 350,["280"] = 352,["281"] = 353,["283"] = 349,["284"] = 357,["285"] = 358,["287"] = 361,["288"] = 361,["289"] = 361,["290"] = 361,["291"] = 373,["292"] = 324});
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
return ____exports
