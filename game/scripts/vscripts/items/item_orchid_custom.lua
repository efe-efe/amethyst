local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 61,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 6,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 8,["24"] = 12,["25"] = 13,["26"] = 12,["27"] = 16,["28"] = 17,["29"] = 18,["30"] = 19,["31"] = 20,["32"] = 21,["33"] = 22,["34"] = 24,["35"] = 24,["36"] = 24,["37"] = 24,["38"] = 24,["39"] = 24,["40"] = 30,["41"] = 31,["42"] = 31,["43"] = 24,["44"] = 32,["45"] = 33,["46"] = 33,["47"] = 33,["48"] = 33,["49"] = 33,["50"] = 33,["51"] = 40,["52"] = 40,["53"] = 40,["54"] = 40,["55"] = 40,["56"] = 40,["57"] = 24,["58"] = 42,["59"] = 43,["60"] = 24,["61"] = 24,["62"] = 47,["63"] = 16,["64"] = 50,["65"] = 51,["66"] = 53,["67"] = 54,["68"] = 55,["69"] = 56,["70"] = 50,["71"] = 7,["72"] = 6,["73"] = 7,["75"] = 60,["76"] = 60,["77"] = 61,["78"] = 64,["79"] = 65,["80"] = 66,["81"] = 64,["82"] = 73,["83"] = 74,["84"] = 75,["85"] = 75,["86"] = 75,["87"] = 75,["88"] = 75,["89"] = 75,["90"] = 81,["91"] = 83,["92"] = 84,["93"] = 85,["96"] = 73,["97"] = 90,["98"] = 91,["99"] = 90,["100"] = 94,["101"] = 95,["102"] = 96,["103"] = 94,["104"] = 99,["105"] = 100,["106"] = 99,["107"] = 105,["108"] = 106,["109"] = 107,["110"] = 107,["111"] = 107,["112"] = 107,["113"] = 107,["114"] = 108,["115"] = 105,["116"] = 111,["117"] = 112,["118"] = 111,["119"] = 114,["120"] = 115,["121"] = 114,["122"] = 61,["123"] = 60,["124"] = 61});
local ____exports = {}
local ModifierItemOrchid
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local direction2D = ____util.direction2D
local ItemOrchid = __TS__Class()
ItemOrchid.name = "ItemOrchid"
__TS__ClassExtends(ItemOrchid, CustomAbility)
function ItemOrchid.prototype.GetCastingCrawl(self)
    return 90
end
function ItemOrchid.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function ItemOrchid.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local duration = self:GetSpecialValueFor("duration")
    local projectileDirection = direction2D(nil, origin, point)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local damage = self:GetSpecialValueFor("ability_damage")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/orchid_proj.vpcf",
        spawnOrigin = origin:__add(Vector(0, 0, 80)),
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
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            ModifierItemOrchid:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = duration}
            )
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("DOTA_Item.Orchid.Activate", self.caster)
end
function ItemOrchid.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "DOTA_Item.Orchid.Activate", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/orchid_proj_impact.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemOrchid = __TS__Decorate(
    {registerAbility(nil, "item_orchid_custom")},
    ItemOrchid
)
ModifierItemOrchid = __TS__Class()
ModifierItemOrchid.name = "ModifierItemOrchid"
__TS__ClassExtends(ModifierItemOrchid, CustomModifier)
function ModifierItemOrchid.prototype.OnCreated(self)
    self:SetStackCount(0)
    self.particleId = ParticleManager:CreateParticle("particles/items2_fx/orchid.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
end
function ModifierItemOrchid.prototype.OnDestroy(self)
    if IsServer() then
        ApplyDamage({
            victim = self.parent,
            attacker = self.caster,
            damage = self:GetStackCount(),
            damage_type = DAMAGE_TYPE_PURE
        })
        self:PlayEffectsOnDestroy()
        if self.particleId then
            ParticleManager:DestroyParticle(self.particleId, false)
            ParticleManager:ReleaseParticleIndex(self.particleId)
        end
    end
end
function ModifierItemOrchid.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE}
end
function ModifierItemOrchid.prototype.GetModifierIncomingDamage_Percentage(self, event)
    self:SetStackCount(self:GetStackCount() + event.damage)
    return 0
end
function ModifierItemOrchid.prototype.CheckState(self)
    return {[MODIFIER_STATE_SILENCED] = true}
end
function ModifierItemOrchid.prototype.PlayEffectsOnDestroy(self)
    local particleId = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(self:GetStackCount() * 100)
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ModifierItemOrchid.prototype.GetEffectName(self)
    return "particles/generic_gameplay/generic_silenced.vpcf"
end
function ModifierItemOrchid.prototype.GetEffectAttachType(self)
    return PATTACH_OVERHEAD_FOLLOW
end
ModifierItemOrchid = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_item_orchid_custom"})},
    ModifierItemOrchid
)
return ____exports
