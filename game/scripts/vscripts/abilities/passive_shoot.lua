local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 14,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 2,["16"] = 2,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 6,["22"] = 6,["23"] = 7,["24"] = 8,["25"] = 9,["26"] = 8,["27"] = 7,["28"] = 6,["29"] = 7,["31"] = 13,["32"] = 13,["33"] = 14,["35"] = 14,["36"] = 15,["37"] = 13,["38"] = 17,["39"] = 18,["40"] = 19,["42"] = 17,["43"] = 23,["44"] = 24,["45"] = 26,["48"] = 30,["49"] = 30,["50"] = 30,["51"] = 30,["52"] = 30,["53"] = 30,["54"] = 30,["55"] = 30,["56"] = 32,["57"] = 32,["58"] = 32,["59"] = 32,["60"] = 32,["61"] = 32,["62"] = 32,["63"] = 32,["64"] = 32,["65"] = 32,["66"] = 32,["67"] = 32,["68"] = 32,["69"] = 32,["70"] = 32,["71"] = 44,["72"] = 45,["73"] = 46,["74"] = 47,["75"] = 48,["76"] = 50,["77"] = 50,["78"] = 50,["79"] = 50,["80"] = 50,["81"] = 50,["82"] = 50,["83"] = 50,["84"] = 50,["85"] = 52,["86"] = 52,["87"] = 52,["88"] = 52,["89"] = 52,["90"] = 52,["91"] = 52,["92"] = 52,["93"] = 60,["94"] = 61,["95"] = 61,["96"] = 52,["97"] = 62,["98"] = 63,["99"] = 63,["100"] = 63,["101"] = 63,["102"] = 63,["103"] = 63,["104"] = 52,["105"] = 52,["107"] = 23,["108"] = 14,["109"] = 13,["110"] = 14});
local ____exports = {}
local ModifierPassiveShot
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local createRadiusMarker = ____util.createRadiusMarker
local direction2D = ____util.direction2D
local fullyFaceTowards = ____util.fullyFaceTowards
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local PassiveShot = __TS__Class()
PassiveShot.name = "PassiveShot"
__TS__ClassExtends(PassiveShot, CustomAbility)
function PassiveShot.prototype.GetIntrinsicModifierName(self)
    return ModifierPassiveShot.name
end
PassiveShot = __TS__Decorate(
    {registerAbility(nil, "passive_shoot")},
    PassiveShot
)
ModifierPassiveShot = __TS__Class()
ModifierPassiveShot.name = "ModifierPassiveShot"
__TS__ClassExtends(ModifierPassiveShot, CustomModifier)
function ModifierPassiveShot.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.radius = 700
end
function ModifierPassiveShot.prototype.OnCreated(self)
    if IsServer() then
        self:StartIntervalThink(1)
    end
end
function ModifierPassiveShot.prototype.OnIntervalThink(self)
    local origin = self.parent:GetAbsOrigin()
    if not self.parent:IsAlive() then
        return
    end
    createRadiusMarker(
        nil,
        self.parent,
        origin,
        self.radius,
        "public",
        0.1
    )
    local enemy = table.remove(
        __TS__ArrayFilter(
            CustomEntitiesLegacy:FindUnitsInRadius(
                self.caster,
                origin,
                self.radius,
                3,
                1 + 18,
                0,
                0
            ),
            function(____, enemy) return enemy ~= self.parent end
        ),
        1
    )
    if enemy then
        local point = enemy:GetAbsOrigin()
        local projectileDirection = direction2D(nil, origin, point)
        local projectileSpeed = 1200
        local projectileHitbox = 100
        fullyFaceTowards(
            nil,
            self.parent,
            Vector(
                projectileDirection.x,
                projectileDirection.y,
                self.parent:GetForwardVector().z
            )
        )
        self.ability:ProjectileAttack({
            source = self.caster,
            effectName = "particles/phantom/phantom_special_attack.vpcf",
            distance = self.radius,
            startRadius = projectileHitbox,
            spawnOrigin = origin:__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
            velocity = projectileDirection:__mul(projectileSpeed),
            groundOffset = 0,
            unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
                projectile:getSource(),
                unit
            ) end,
            onUnitHit = function(____, unit, projectile)
                ApplyDamage({
                    victim = unit,
                    attacker = projectile:getSource(),
                    damage = self.ability:GetAbilityDamage(),
                    damage_type = DAMAGE_TYPE_PHYSICAL
                })
            end
        })
    end
end
ModifierPassiveShot = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_passive_shoot"})},
    ModifierPassiveShot
)
return ____exports
