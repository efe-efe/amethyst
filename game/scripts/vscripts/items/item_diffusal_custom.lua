local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 89,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 4,["19"] = 4,["20"] = 6,["21"] = 6,["22"] = 7,["23"] = 8,["24"] = 9,["25"] = 8,["26"] = 12,["27"] = 13,["28"] = 12,["29"] = 16,["30"] = 17,["31"] = 18,["32"] = 19,["33"] = 19,["34"] = 19,["35"] = 19,["36"] = 20,["37"] = 23,["38"] = 24,["39"] = 25,["40"] = 26,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 30,["49"] = 30,["50"] = 30,["51"] = 30,["52"] = 34,["53"] = 35,["54"] = 36,["55"] = 43,["56"] = 30,["57"] = 30,["58"] = 30,["59"] = 48,["60"] = 49,["61"] = 16,["62"] = 52,["63"] = 53,["64"] = 54,["65"] = 55,["66"] = 56,["67"] = 58,["68"] = 63,["69"] = 64,["70"] = 65,["71"] = 67,["72"] = 72,["73"] = 73,["74"] = 74,["75"] = 52,["76"] = 77,["77"] = 78,["78"] = 83,["79"] = 83,["80"] = 83,["81"] = 83,["82"] = 83,["83"] = 84,["84"] = 77,["85"] = 7,["86"] = 6,["87"] = 7,["89"] = 88,["90"] = 88,["91"] = 89,["92"] = 90,["93"] = 91,["94"] = 90,["95"] = 94,["96"] = 95,["97"] = 94,["98"] = 98,["99"] = 99,["100"] = 98,["101"] = 102,["102"] = 103,["103"] = 104,["104"] = 104,["105"] = 104,["106"] = 104,["107"] = 105,["109"] = 108,["110"] = 102,["111"] = 111,["112"] = 112,["113"] = 111,["114"] = 115,["115"] = 116,["116"] = 115,["117"] = 121,["118"] = 122,["119"] = 123,["120"] = 121,["121"] = 128,["122"] = 129,["123"] = 128,["124"] = 132,["125"] = 133,["126"] = 132,["127"] = 89,["128"] = 88,["129"] = 89});
local ____exports = {}
local ModifierItemDiffusal
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local meeleEFX = ____util.meeleEFX
local ItemDiffusal = __TS__Class()
ItemDiffusal.name = "ItemDiffusal"
__TS__ClassExtends(ItemDiffusal, CustomAbility)
function ItemDiffusal.prototype.GetCastingCrawl(self)
    return 30
end
function ItemDiffusal.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function ItemDiffusal.prototype.OnSpellStart(self)
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
            ModifierItemDiffusal:apply(target, self.caster, self, {duration = duration})
            ApplyDamage({victim = target, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
            self:PlayEffectsOnImpact(target)
        end,
        baseSound = "DOTA_Item.DiffusalBlade.Activate"
    })
    EmitSoundOnLocationWithCaster(point, "Hero_Juggernaut.PreAttack", self.caster)
    self:PlayEffectsOnFinish(point)
end
function ItemDiffusal.prototype.PlayEffectsOnFinish(self, position)
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
function ItemDiffusal.prototype.PlayEffectsOnImpact(self, target)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemDiffusal = __TS__Decorate(
    {registerAbility(nil, "item_diffusal_custom")},
    ItemDiffusal
)
ModifierItemDiffusal = __TS__Class()
ModifierItemDiffusal.name = "ModifierItemDiffusal"
__TS__ClassExtends(ModifierItemDiffusal, CustomModifier)
function ModifierItemDiffusal.prototype.OnCreated(self)
    EmitSoundOn("DOTA_Item.DiffusalBlade.Target", self.parent)
end
function ModifierItemDiffusal.prototype.OnDestroy(self)
    StopSoundOn("DOTA_Item.DiffusalBlade.Target", self.parent)
end
function ModifierItemDiffusal.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE}
end
function ModifierItemDiffusal.prototype.GetModifierIncomingDamage_Percentage(self)
    if IsServer() then
        self.parent:Script_ReduceMana(
            self:Value("mana_per_tick"),
            self.ability
        )
        self:PlayEffectsOnImpact(self.parent)
    end
    return 0
end
function ModifierItemDiffusal.prototype.GetModifierAttackSpeedBonus_Constant(self)
    return -self:Value("ms_pct")
end
function ModifierItemDiffusal.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
function ModifierItemDiffusal.prototype.PlayEffectsOnImpact(self, target)
    EmitSoundOn("DOTA_Item.DiffusalBlade.Target", target)
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, target))
end
function ModifierItemDiffusal.prototype.GetEffectName(self)
    return "particles/items_fx/diffusal_slow.vpcf"
end
function ModifierItemDiffusal.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierItemDiffusal = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_diffusal_custom"})},
    ModifierItemDiffusal
)
return ____exports
