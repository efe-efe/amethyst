local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 8,["20"] = 9,["21"] = 8,["22"] = 12,["23"] = 13,["24"] = 12,["25"] = 16,["26"] = 17,["27"] = 18,["28"] = 19,["29"] = 20,["30"] = 21,["31"] = 23,["32"] = 23,["33"] = 23,["34"] = 23,["35"] = 23,["36"] = 23,["37"] = 29,["38"] = 30,["39"] = 30,["40"] = 23,["41"] = 31,["42"] = 32,["43"] = 32,["44"] = 32,["45"] = 32,["46"] = 32,["47"] = 32,["48"] = 33,["49"] = 23,["50"] = 35,["51"] = 36,["52"] = 23,["53"] = 23,["54"] = 40,["55"] = 16,["56"] = 43,["57"] = 44,["58"] = 46,["59"] = 51,["60"] = 52,["61"] = 53,["62"] = 43,["63"] = 56,["64"] = 57,["65"] = 62,["66"] = 62,["67"] = 62,["68"] = 62,["69"] = 62,["70"] = 63,["71"] = 56,["72"] = 7,["73"] = 6,["74"] = 7});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_root = require("modifiers.modifier_root")
local ModifierRoot = ____modifier_root.ModifierRoot
local ____util = require("util")
local direction2D = ____util.direction2D
local ItemAtos = __TS__Class()
ItemAtos.name = "ItemAtos"
__TS__ClassExtends(ItemAtos, CustomAbility)
function ItemAtos.prototype.GetCastingCrawl(self)
    return 90
end
function ItemAtos.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function ItemAtos.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local duration = self:GetSpecialValueFor("duration")
    local projectileDirection = direction2D(nil, origin, point)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/rod_of_atos/rod_of_atos_attack.vpcf",
        spawnOrigin = origin:__add(Vector(0, 0, 80)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ModifierRoot:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = duration}
            )
            self:PlayEffectsOnImpact(unit)
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("DOTA_Item.RodOfAtos.Target", self.caster)
end
function ItemAtos.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "DOTA_Item.RodOfAtos.Cast", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/items2_fx/rod_of_atos_attack_impact.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ItemAtos.prototype.PlayEffectsOnImpact(self, target)
    local particleId = ParticleManager:CreateParticle("particles/items2_fx/rod_of_atos_impact.vpcf", PATTACH_ABSORIGIN, target)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemAtos = __TS__Decorate(
    {registerAbility(nil, "item_atos_custom")},
    ItemAtos
)
return ____exports
