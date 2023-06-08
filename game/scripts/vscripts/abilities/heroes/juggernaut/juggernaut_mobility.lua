local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 6,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 9,["22"] = 11,["23"] = 12,["24"] = 13,["25"] = 15,["26"] = 16,["27"] = 17,["28"] = 17,["29"] = 17,["30"] = 17,["32"] = 8,["33"] = 7,["34"] = 6,["35"] = 7,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 26,["41"] = 27,["42"] = 26,["43"] = 30,["44"] = 31,["45"] = 30,["46"] = 34,["47"] = 35,["48"] = 34,["49"] = 38,["50"] = 39,["51"] = 38,["52"] = 42,["53"] = 43,["54"] = 44,["55"] = 45,["57"] = 42,["58"] = 49,["59"] = 50,["60"] = 50,["61"] = 50,["62"] = 50,["63"] = 50,["64"] = 50,["65"] = 50,["66"] = 50,["67"] = 50,["68"] = 60,["69"] = 61,["70"] = 62,["71"] = 62,["72"] = 62,["73"] = 65,["74"] = 66,["75"] = 66,["76"] = 66,["77"] = 66,["78"] = 66,["79"] = 66,["80"] = 72,["81"] = 62,["82"] = 62,["84"] = 76,["85"] = 76,["86"] = 76,["87"] = 76,["88"] = 76,["89"] = 76,["90"] = 82,["93"] = 49,["94"] = 87,["95"] = 88,["96"] = 89,["97"] = 90,["99"] = 87,["100"] = 94,["101"] = 95,["102"] = 95,["103"] = 95,["104"] = 95,["105"] = 95,["106"] = 95,["107"] = 95,["108"] = 94,["109"] = 104,["110"] = 105,["111"] = 106,["112"] = 107,["115"] = 104,["116"] = 112,["117"] = 113,["118"] = 112,["119"] = 116,["120"] = 117,["121"] = 116,["122"] = 120,["123"] = 121,["124"] = 120,["125"] = 124,["126"] = 125,["127"] = 124,["128"] = 128,["129"] = 129,["130"] = 128,["131"] = 135,["132"] = 136,["133"] = 137,["134"] = 138,["135"] = 135,["136"] = 143,["137"] = 144,["138"] = 146,["139"] = 148,["140"] = 149,["142"] = 152,["143"] = 153,["144"] = 153,["145"] = 153,["146"] = 153,["147"] = 153,["148"] = 153,["149"] = 153,["150"] = 153,["151"] = 153,["152"] = 154,["153"] = 154,["154"] = 154,["155"] = 154,["156"] = 154,["157"] = 143,["158"] = 157,["159"] = 158,["160"] = 157,["161"] = 161,["162"] = 162,["163"] = 164,["164"] = 165,["165"] = 167,["166"] = 167,["167"] = 167,["168"] = 167,["169"] = 167,["170"] = 172,["171"] = 161,["172"] = 175,["173"] = 176,["174"] = 175,["175"] = 179,["176"] = 180,["177"] = 179,["178"] = 183,["179"] = 184,["180"] = 185,["181"] = 186,["182"] = 187,["184"] = 190,["185"] = 191,["186"] = 191,["187"] = 191,["188"] = 191,["189"] = 192,["190"] = 194,["191"] = 196,["193"] = 199,["195"] = 201,["197"] = 204,["198"] = 183,["199"] = 23,["200"] = 22,["201"] = 23});
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
