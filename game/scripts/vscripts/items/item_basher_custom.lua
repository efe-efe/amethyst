local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 4,["18"] = 6,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 8,["24"] = 12,["25"] = 13,["26"] = 12,["27"] = 16,["28"] = 17,["29"] = 18,["30"] = 19,["31"] = 19,["32"] = 19,["33"] = 19,["34"] = 20,["35"] = 23,["36"] = 24,["37"] = 25,["38"] = 26,["39"] = 28,["40"] = 28,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 30,["47"] = 30,["48"] = 30,["49"] = 30,["50"] = 34,["51"] = 35,["52"] = 36,["53"] = 43,["54"] = 30,["55"] = 30,["56"] = 30,["57"] = 48,["58"] = 16,["59"] = 51,["60"] = 52,["61"] = 53,["62"] = 54,["63"] = 55,["64"] = 57,["65"] = 62,["66"] = 63,["67"] = 64,["68"] = 66,["69"] = 71,["70"] = 72,["71"] = 73,["72"] = 51,["73"] = 76,["74"] = 77,["75"] = 82,["76"] = 82,["77"] = 82,["78"] = 82,["79"] = 82,["80"] = 83,["81"] = 76,["82"] = 7,["83"] = 6,["84"] = 7});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_stunned = require("modifiers.modifier_stunned")
local ModifierStun = ____modifier_stunned.ModifierStun
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local meeleEFX = ____util.meeleEFX
local ItemBasher = __TS__Class()
ItemBasher.name = "ItemBasher"
__TS__ClassExtends(ItemBasher, CustomAbility)
function ItemBasher.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function ItemBasher.prototype.GetCastingCrawl(self)
    return 30
end
function ItemBasher.prototype.OnSpellStart(self)
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = self.caster:GetOrigin()
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange})
    local radius = self:GetSpecialValueFor("radius")
    local direction = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local duration = self:GetSpecialValueFor("duration")
    meeleEFX(
        nil,
        self.caster,
        direction,
        radius,
        Vector(255, 255, 0)
    )
    self:MeeleAttack({
        direction = direction,
        origin = origin,
        radius = radius,
        effect = function(____, target)
            ModifierStun:apply(target, self.caster, self, {duration = duration})
            ApplyDamage({victim = target, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
            self:PlayEffectsOnImpact(target)
        end,
        baseSound = "DOTA_Item.SkullBasher.PreAttack"
    })
    self:PlayEffectsOnFinish(point)
end
function ItemBasher.prototype.PlayEffectsOnFinish(self, position)
    local offset = 40
    local origin = self.caster:GetAbsOrigin()
    local direction = direction2D(nil, origin, position)
    local finalPosition = origin:__add(Vector(direction.x * offset, direction.y * offset, 0))
    local particleId = ParticleManager:CreateParticle("particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf", PATTACH_POINT, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, finalPosition)
    ParticleManager:SetParticleControlForward(particleId, 0, direction)
    ParticleManager:ReleaseParticleIndex(particleId)
    particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", PATTACH_POINT, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, finalPosition)
    ParticleManager:SetParticleControlForward(particleId, 0, direction)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ItemBasher.prototype.PlayEffectsOnImpact(self, target)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemBasher = __TS__Decorate(
    {registerAbility(nil, "item_basher_custom")},
    ItemBasher
)
return ____exports
