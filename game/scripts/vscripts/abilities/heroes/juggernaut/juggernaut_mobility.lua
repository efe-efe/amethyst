local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 6,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 9,["22"] = 11,["23"] = 12,["24"] = 13,["25"] = 15,["26"] = 16,["27"] = 17,["28"] = 17,["29"] = 17,["30"] = 17,["32"] = 8,["33"] = 7,["34"] = 6,["35"] = 7,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 26,["41"] = 27,["42"] = 26,["43"] = 30,["44"] = 31,["45"] = 30,["46"] = 34,["47"] = 35,["48"] = 34,["49"] = 38,["50"] = 39,["51"] = 38,["52"] = 42,["53"] = 43,["54"] = 44,["55"] = 45,["56"] = 46,["58"] = 42,["59"] = 50,["60"] = 51,["61"] = 51,["62"] = 51,["63"] = 51,["64"] = 51,["65"] = 51,["66"] = 51,["67"] = 51,["68"] = 51,["69"] = 61,["70"] = 62,["71"] = 63,["72"] = 63,["73"] = 63,["74"] = 66,["75"] = 67,["76"] = 67,["77"] = 67,["78"] = 67,["79"] = 67,["80"] = 67,["81"] = 73,["82"] = 63,["83"] = 63,["85"] = 77,["86"] = 77,["87"] = 77,["88"] = 77,["89"] = 77,["90"] = 77,["91"] = 83,["94"] = 50,["95"] = 88,["96"] = 89,["97"] = 90,["98"] = 91,["100"] = 88,["101"] = 95,["102"] = 96,["103"] = 96,["104"] = 96,["105"] = 96,["106"] = 96,["107"] = 96,["108"] = 96,["109"] = 95,["110"] = 105,["111"] = 106,["112"] = 107,["113"] = 108,["116"] = 105,["117"] = 113,["118"] = 114,["119"] = 113,["120"] = 117,["121"] = 118,["122"] = 117,["123"] = 121,["124"] = 122,["125"] = 121,["126"] = 125,["127"] = 126,["128"] = 125,["129"] = 129,["130"] = 130,["131"] = 129,["132"] = 136,["133"] = 137,["134"] = 138,["135"] = 139,["136"] = 136,["137"] = 144,["138"] = 145,["139"] = 147,["140"] = 149,["141"] = 150,["143"] = 153,["144"] = 154,["145"] = 154,["146"] = 154,["147"] = 154,["148"] = 154,["149"] = 154,["150"] = 154,["151"] = 154,["152"] = 154,["153"] = 155,["154"] = 155,["155"] = 155,["156"] = 155,["157"] = 155,["158"] = 144,["159"] = 158,["160"] = 159,["161"] = 158,["162"] = 162,["163"] = 163,["164"] = 165,["165"] = 166,["166"] = 168,["167"] = 168,["168"] = 168,["169"] = 168,["170"] = 168,["171"] = 173,["172"] = 162,["173"] = 176,["174"] = 177,["175"] = 176,["176"] = 180,["177"] = 181,["178"] = 180,["179"] = 23,["180"] = 22,["181"] = 23});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local strongPurge = ____util.strongPurge
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local JuggernautMobility = __TS__Class()
JuggernautMobility.name = "JuggernautMobility"
__TS__ClassExtends(JuggernautMobility, CustomAbility)
function JuggernautMobility.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    strongPurge(nil, self.caster)
    self.caster:RemoveModifierByName("modifier_hero_movement")
    self.caster:AddNewModifier(self.caster, self, "modifier_juggernaut_mobility", {duration = duration})
    local random = RandomInt(1, 9)
    if random > 1 then
        EmitSoundOn(
            "juggernaut_jug_ability_bladefury_0" .. tostring(random),
            self.caster
        )
    end
end
JuggernautMobility = __TS__Decorate(
    {registerAbility(nil, "juggernaut_mobility")},
    JuggernautMobility
)
local ModifierJuggernautMobility = __TS__Class()
ModifierJuggernautMobility.name = "ModifierJuggernautMobility"
__TS__ClassExtends(ModifierJuggernautMobility, CustomModifier)
function ModifierJuggernautMobility.prototype.IsHidden(self)
    return false
end
function ModifierJuggernautMobility.prototype.IsDebuff(self)
    return false
end
function ModifierJuggernautMobility.prototype.IsPurgable(self)
    return true
end
function ModifierJuggernautMobility.prototype.StatusEffectPriority(self)
    return 2
end
function ModifierJuggernautMobility.prototype.OnCreated(self)
    if IsServer() then
        local think_interval = self.ability:GetSpecialValueFor("think_interval")
        self:StartIntervalThink(think_interval)
        self:PlayEffects()
    end
end
function ModifierJuggernautMobility.prototype.OnIntervalThink(self)
    local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.parent,
        self.parent:GetAbsOrigin(),
        self:Value("radius"),
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_ANY_ORDER
    )
    for ____, enemy in ipairs(enemies) do
        if self.parent:HasModifier("modifier_upgrade_juggernaut_fury_attack") then
            self.ability:SingleAttack({
                attackType = "basic",
                target = enemy,
                effect = function(____, target)
                    ApplyDamage({
                        victim = target,
                        attacker = self.caster,
                        damage = self.ability:GetSpecialValueFor("damage_per_second"),
                        damage_type = DAMAGE_TYPE_PURE
                    })
                    self:PlayEffectsOnImpact(target)
                end
            })
        else
            ApplyDamage({
                victim = enemy,
                attacker = self.caster,
                damage = self.ability:GetSpecialValueFor("damage_per_second"),
                damage_type = DAMAGE_TYPE_PURE
            })
            self:PlayEffectsOnImpact(enemy)
        end
    end
end
function ModifierJuggernautMobility.prototype.OnDestroy(self)
    if IsServer() then
        self:StopEffects()
        EmitSoundOn("Hero_Juggernaut.BladeFuryStop", self.parent)
    end
end
function ModifierJuggernautMobility.prototype.DeclareFunctions(self)
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT
    }
end
function ModifierJuggernautMobility.prototype.OnOrder(self, event)
    if event.unit == self.parent then
        if event.order_type == DOTA_UNIT_ORDER_STOP or event.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
            self:Destroy()
        end
    end
end
function ModifierJuggernautMobility.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("speed_buff_pct")
end
function ModifierJuggernautMobility.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_OVERRIDE_ABILITY_1
end
function ModifierJuggernautMobility.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierJuggernautMobility.prototype.GetOverrideAnimationWeight(self)
    return 2
end
function ModifierJuggernautMobility.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_SILENCED] = true}
end
function ModifierJuggernautMobility.prototype.PlayEffectsOnImpact(self, target)
    EmitSoundOn("Hero_Juggernaut.Attack", target)
    EmitSoundOn("Hero_Juggernaut.BladeFury.Impact", target)
    EFX("particles/juggernaut/juggernaut_mobility_impact.vpcf", PATTACH_ABSORIGIN, target, {release = true})
end
function ModifierJuggernautMobility.prototype.PlayEffects(self)
    EmitSoundOn("Hero_Juggernaut.BladeFuryStart", self.parent)
    local path = "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"
    if self:ShouldReflect() then
        path = "particles/econ/items/juggernaut/jugg_sword_jade/juggernaut_blade_fury_jade.vpcf"
    end
    self.particleId = ParticleManager:CreateParticle(path, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(
        self.particleId,
        5,
        Vector(
            self:Value("radius"),
            1,
            1
        )
    )
    ParticleManager:SetParticleControl(
        self.particleId,
        2,
        self.parent:GetAbsOrigin()
    )
end
function ModifierJuggernautMobility.prototype.ShouldReflect(self)
    return self.ability:GetLevel() >= 2 or self.caster:HasModifier("modifier_upgrade_juggernaut_fury_reflects")
end
function ModifierJuggernautMobility.prototype.StopEffects(self)
    StopSoundOn("Hero_Juggernaut.BladeFuryStart", self.parent)
    ParticleManager:DestroyParticle(self.particleId, false)
    ParticleManager:ReleaseParticleIndex(self.particleId)
    local effect_cast = ParticleManager:CreateParticle(
        "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_beserkers_call_owner_aoe_dome.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self:GetCaster()
    )
    ParticleManager:ReleaseParticleIndex(effect_cast)
end
function ModifierJuggernautMobility.prototype.GetEffectName(self)
    return "particles/econ/events/ti9/phase_boots_ti9.vpcf"
end
function ModifierJuggernautMobility.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierJuggernautMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_mobility"})},
    ModifierJuggernautMobility
)
return ____exports
