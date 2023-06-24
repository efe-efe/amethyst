local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 68,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 6,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 8,["24"] = 12,["25"] = 13,["26"] = 12,["27"] = 16,["28"] = 17,["29"] = 18,["30"] = 19,["31"] = 20,["32"] = 21,["33"] = 22,["34"] = 23,["35"] = 25,["36"] = 25,["37"] = 25,["38"] = 25,["39"] = 25,["40"] = 25,["41"] = 31,["42"] = 32,["43"] = 32,["44"] = 25,["45"] = 33,["46"] = 34,["47"] = 34,["48"] = 34,["49"] = 34,["50"] = 34,["51"] = 34,["52"] = 35,["53"] = 35,["54"] = 35,["55"] = 35,["56"] = 35,["57"] = 35,["58"] = 37,["59"] = 37,["60"] = 37,["61"] = 37,["62"] = 37,["63"] = 37,["64"] = 43,["65"] = 43,["66"] = 43,["67"] = 43,["68"] = 43,["69"] = 43,["70"] = 43,["71"] = 25,["72"] = 45,["73"] = 46,["74"] = 25,["75"] = 25,["76"] = 50,["77"] = 16,["78"] = 53,["79"] = 54,["80"] = 56,["81"] = 61,["82"] = 62,["83"] = 63,["84"] = 53,["85"] = 7,["86"] = 6,["87"] = 7,["89"] = 67,["90"] = 67,["91"] = 68,["92"] = 69,["93"] = 70,["94"] = 69,["95"] = 73,["96"] = 74,["97"] = 73,["98"] = 77,["99"] = 78,["100"] = 77,["101"] = 81,["102"] = 82,["103"] = 81,["104"] = 68,["105"] = 67,["106"] = 68,["108"] = 86,["109"] = 86,["110"] = 87,["111"] = 88,["112"] = 89,["113"] = 90,["114"] = 90,["115"] = 90,["116"] = 90,["117"] = 90,["118"] = 90,["119"] = 90,["121"] = 88,["122"] = 94,["123"] = 95,["124"] = 94,["125"] = 98,["126"] = 99,["127"] = 100,["128"] = 100,["129"] = 100,["130"] = 100,["131"] = 100,["132"] = 100,["133"] = 104,["134"] = 104,["135"] = 104,["136"] = 104,["137"] = 104,["138"] = 104,["139"] = 104,["141"] = 107,["142"] = 98,["143"] = 110,["144"] = 111,["145"] = 110,["146"] = 114,["147"] = 115,["148"] = 114,["149"] = 118,["150"] = 119,["151"] = 118,["152"] = 87,["153"] = 86,["154"] = 87});
local ____exports = {}
local ModifierItemNullifierSlow, ModifierItemNullifier
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local direction2D = ____util.direction2D
local ItemNullifier = __TS__Class()
ItemNullifier.name = "ItemNullifier"
__TS__ClassExtends(ItemNullifier, CustomAbility)
function ItemNullifier.prototype.GetCastingCrawl(self)
    return 90
end
function ItemNullifier.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function ItemNullifier.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local projectileDirection = direction2D(nil, origin, point)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local initialDuration = self:GetSpecialValueFor("initial_duration")
    local duration = self:GetSpecialValueFor("duration")
    local abilityDamage = self:GetSpecialValueFor("ability_damage")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/nullifier/nullifier_proj.vpcf",
        spawnOrigin = origin:__add(Vector(0, 0, 80)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ModifierItemNullifier:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = duration}
            )
            ModifierItemNullifierSlow:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = initialDuration}
            )
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = abilityDamage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            unit:Purge(
                true,
                false,
                false,
                false,
                false
            )
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("DOTA_Item.Nullifier.Cast", self.caster)
end
function ItemNullifier.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "DOTA_Item.Nullifier.Target", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/items4_fx/nullifier_proj_impact.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemNullifier = __TS__Decorate(
    {registerAbility(nil, "item_nullifier_custom")},
    ItemNullifier
)
ModifierItemNullifierSlow = __TS__Class()
ModifierItemNullifierSlow.name = "ModifierItemNullifierSlow"
__TS__ClassExtends(ModifierItemNullifierSlow, CustomModifier)
function ModifierItemNullifierSlow.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierItemNullifierSlow.prototype.GetModifierAttackSpeedBonus_Constant(self)
    return -self.ability:GetSpecialValueFor("slow_pct")
end
function ModifierItemNullifierSlow.prototype.GetEffectName(self)
    return "particles/items4_fx/nullifier_slow.vpcf"
end
function ModifierItemNullifierSlow.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierItemNullifierSlow = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_nullifier_custom_slow"})},
    ModifierItemNullifierSlow
)
ModifierItemNullifier = __TS__Class()
ModifierItemNullifier.name = "ModifierItemNullifier"
__TS__ClassExtends(ModifierItemNullifier, CustomModifier)
function ModifierItemNullifier.prototype.OnCreated(self)
    if IsServer() then
        self.parent:Purge(
            true,
            false,
            false,
            false,
            false
        )
    end
end
function ModifierItemNullifier.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE}
end
function ModifierItemNullifier.prototype.GetModifierIncomingDamage_Percentage(self)
    if IsServer() then
        ModifierItemNullifierSlow:apply(
            self.parent,
            self.caster,
            self.ability,
            {duration = self.ability:GetSpecialValueFor("tick_duration")}
        )
        self.parent:Purge(
            true,
            false,
            false,
            false,
            false
        )
    end
    return 0
end
function ModifierItemNullifier.prototype.GetStatusEffectName(self)
    return "particles/status_fx/status_effect_nullifier.vpcf"
end
function ModifierItemNullifier.prototype.GetEffectName(self)
    return "particles/items4_fx/nullifier_mute_debuff.vpcf"
end
function ModifierItemNullifier.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierItemNullifier = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_nullifier_custom"})},
    ModifierItemNullifier
)
return ____exports
