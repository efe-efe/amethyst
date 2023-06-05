local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 7,["18"] = 7,["19"] = 8,["20"] = 9,["21"] = 10,["22"] = 12,["23"] = 13,["24"] = 14,["25"] = 16,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["32"] = 9,["33"] = 8,["34"] = 7,["35"] = 8,["37"] = 23,["38"] = 23,["39"] = 24,["40"] = 27,["41"] = 28,["42"] = 27,["43"] = 31,["44"] = 32,["45"] = 31,["46"] = 35,["47"] = 36,["48"] = 35,["49"] = 39,["50"] = 40,["51"] = 39,["52"] = 43,["53"] = 44,["54"] = 45,["55"] = 46,["57"] = 43,["58"] = 50,["59"] = 51,["60"] = 51,["61"] = 51,["62"] = 51,["63"] = 51,["64"] = 51,["65"] = 51,["66"] = 51,["67"] = 51,["68"] = 61,["69"] = 62,["70"] = 63,["71"] = 63,["72"] = 63,["73"] = 66,["74"] = 67,["75"] = 67,["76"] = 67,["77"] = 67,["78"] = 67,["79"] = 67,["80"] = 73,["81"] = 63,["82"] = 63,["84"] = 77,["85"] = 77,["86"] = 77,["87"] = 77,["88"] = 77,["89"] = 77,["90"] = 83,["93"] = 50,["94"] = 88,["95"] = 89,["96"] = 90,["97"] = 91,["99"] = 88,["100"] = 95,["101"] = 96,["102"] = 96,["103"] = 96,["104"] = 96,["105"] = 96,["106"] = 96,["107"] = 96,["108"] = 95,["109"] = 105,["110"] = 106,["111"] = 107,["112"] = 108,["115"] = 105,["116"] = 113,["117"] = 114,["118"] = 113,["119"] = 117,["120"] = 118,["121"] = 117,["122"] = 121,["123"] = 122,["124"] = 121,["125"] = 125,["126"] = 126,["127"] = 125,["128"] = 129,["129"] = 130,["130"] = 129,["131"] = 136,["132"] = 137,["133"] = 138,["134"] = 139,["135"] = 136,["136"] = 144,["137"] = 145,["138"] = 147,["139"] = 149,["140"] = 150,["142"] = 153,["143"] = 154,["144"] = 154,["145"] = 154,["146"] = 154,["147"] = 154,["148"] = 154,["149"] = 154,["150"] = 154,["151"] = 154,["152"] = 155,["153"] = 155,["154"] = 155,["155"] = 155,["156"] = 155,["157"] = 144,["158"] = 158,["159"] = 159,["160"] = 158,["161"] = 162,["162"] = 163,["163"] = 165,["164"] = 166,["165"] = 168,["166"] = 168,["167"] = 168,["168"] = 168,["169"] = 168,["170"] = 173,["171"] = 162,["172"] = 176,["173"] = 177,["174"] = 176,["175"] = 180,["176"] = 181,["177"] = 180,["178"] = 184,["179"] = 185,["180"] = 186,["181"] = 187,["182"] = 188,["184"] = 191,["185"] = 192,["186"] = 192,["187"] = 192,["188"] = 192,["189"] = 193,["190"] = 195,["191"] = 197,["193"] = 200,["195"] = 202,["197"] = 205,["198"] = 184,["199"] = 24,["200"] = 23,["201"] = 24});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
local ____util = require("util")
local strongPurge = ____util.strongPurge
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
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
__TS__ClassExtends(ModifierJuggernautMobility, ModifierCombatEvents)
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
        self:StartIntervalThink(self:Value("think_interval"))
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
                        damage = self:Value("damage_per_second"),
                        damage_type = DAMAGE_TYPE_PURE
                    })
                    self:PlayEffectsOnImpact(target)
                end
            })
        else
            ApplyDamage({
                victim = enemy,
                attacker = self.caster,
                damage = self:Value("damage_per_second"),
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
function ModifierJuggernautMobility.prototype.OnHit(self, event)
    if IsServer() then
        if event.attackCategory == "projectile" then
            if not self:ShouldReflect() then
                return true
            end
            if event.projectile:getIsReflectable() == true then
                event.projectile:setVelocity(
                    event.projectile:getVelocity():__mul(-1.2),
                    event.projectile:getPosition()
                )
                event.projectile:setSource(self.parent)
                event.projectile:resetDistanceTraveled()
                EmitSoundOn("Hero_Juggernaut.Attack", self.parent)
            end
            return false
        end
        return true
    end
    return true
end
ModifierJuggernautMobility = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_mobility"})},
    ModifierJuggernautMobility
)
return ____exports
