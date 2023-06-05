local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 109,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 6,["20"] = 6,["21"] = 7,["22"] = 8,["23"] = 7,["24"] = 10,["25"] = 11,["27"] = 13,["28"] = 8,["29"] = 16,["30"] = 17,["31"] = 16,["32"] = 20,["33"] = 21,["34"] = 20,["35"] = 24,["36"] = 25,["37"] = 24,["38"] = 28,["39"] = 29,["40"] = 30,["41"] = 31,["42"] = 32,["43"] = 33,["44"] = 34,["45"] = 35,["46"] = 37,["47"] = 38,["48"] = 38,["49"] = 38,["50"] = 38,["51"] = 38,["52"] = 39,["53"] = 39,["54"] = 39,["55"] = 39,["56"] = 39,["57"] = 41,["58"] = 42,["59"] = 42,["60"] = 42,["61"] = 42,["62"] = 42,["63"] = 42,["64"] = 48,["65"] = 49,["66"] = 49,["67"] = 42,["68"] = 50,["69"] = 51,["70"] = 52,["71"] = 54,["72"] = 56,["73"] = 56,["74"] = 56,["75"] = 56,["76"] = 56,["77"] = 56,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 63,["85"] = 63,["86"] = 63,["87"] = 63,["88"] = 63,["89"] = 63,["90"] = 42,["91"] = 70,["92"] = 71,["93"] = 42,["94"] = 42,["96"] = 76,["97"] = 78,["98"] = 78,["99"] = 78,["100"] = 78,["101"] = 78,["102"] = 78,["103"] = 78,["104"] = 86,["105"] = 28,["106"] = 89,["107"] = 90,["108"] = 89,["109"] = 93,["110"] = 94,["111"] = 95,["112"] = 100,["113"] = 101,["114"] = 102,["115"] = 93,["116"] = 7,["117"] = 6,["118"] = 7,["120"] = 108,["121"] = 108,["122"] = 109,["123"] = 110,["124"] = 111,["125"] = 110,["126"] = 114,["127"] = 115,["128"] = 114,["129"] = 118,["130"] = 119,["131"] = 118,["132"] = 122,["133"] = 123,["134"] = 123,["135"] = 109,["136"] = 123,["137"] = 123,["138"] = 122,["139"] = 109,["140"] = 108,["141"] = 109,["143"] = 136,["144"] = 136,["145"] = 137,["146"] = 138,["147"] = 139,["148"] = 140,["149"] = 141,["150"] = 141,["151"] = 141,["152"] = 141,["153"] = 141,["154"] = 141,["155"] = 147,["158"] = 138,["159"] = 152,["160"] = 153,["161"] = 152,["162"] = 156,["163"] = 157,["164"] = 156,["165"] = 160,["166"] = 161,["167"] = 160,["168"] = 164,["169"] = 165,["170"] = 165,["171"] = 137,["172"] = 165,["173"] = 165,["174"] = 164,["175"] = 137,["176"] = 136,["177"] = 137});
local ____exports = {}
local ModifierSniperExtra, ModifierSniperExtraEnemy
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local direction2D = ____util.direction2D
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local SniperExtra = __TS__Class()
SniperExtra.name = "SniperExtra"
__TS__ClassExtends(SniperExtra, CustomAbility)
function SniperExtra.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        EmitSoundOn("Ability.AssassinateLoad", self.caster)
        return true
    end
    return false
end
function SniperExtra.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function SniperExtra.prototype.GetPlaybackRateOverride(self)
    return 0.4
end
function SniperExtra.prototype.GetCastingCrawl(self)
    return 0
end
function SniperExtra.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local knockbackDistance = self:GetSpecialValueFor("knockback_distance")
    local damage = self:GetSpecialValueFor("damage_per_bullet")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local straightDirection = direction2D(nil, origin, point)
    local directions = {}
    directions[#directions + 1] = straightDirection
    directions[#directions + 1] = RotatePoint(
        Vector(0, 0, 0),
        Vector(0, 0, 0):__add(straightDirection),
        -30
    ):Normalized()
    directions[#directions + 1] = RotatePoint(
        Vector(0, 0, 0),
        Vector(0, 0, 0):__add(straightDirection),
        30
    ):Normalized()
    for ____, direction in ipairs(directions) do
        self:ProjectileAttack({
            source = self.caster,
            effectName = "particles/sniper/sniper_extra.vpcf",
            spawnOrigin = origin:__add(Vector(0, 0, 60)),
            velocity = direction:__mul(projectileSpeed),
            groundOffset = 0,
            unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
                projectile:getSource(),
                unit
            ) end,
            onUnitHit = function(____, unit, projectile)
                local x = unit:GetAbsOrigin().x - origin.x
                local y = unit:GetAbsOrigin().y - origin.y
                local distance = knockbackDistance - unit:GetAbsOrigin():__sub(origin):Length2D()
                ModifierSniperExtraEnemy:apply(
                    unit,
                    projectile:getSource(),
                    self,
                    {
                        x = x,
                        y = y,
                        distance = distance,
                        speed = distance / 0.35,
                        peak = 32
                    }
                )
                ApplyDamage({
                    victim = unit,
                    attacker = projectile:getSource(),
                    damage = damage,
                    damage_type = DAMAGE_TYPE_MAGICAL
                })
            end,
            onFinish = function(____, projectile)
                self:PlayEffectsOnFinish(projectile:getPosition())
            end
        })
    end
    local knockbackDirection = point:__sub(origin):__mul(Vector(-1, -1, -1)):Normalized()
    ModifierSniperExtra:apply(self.caster, self.caster, self, {
        x = knockbackDirection.x,
        y = knockbackDirection.y,
        distance = knockbackDistance,
        speed = knockbackDistance / 0.35,
        peak = 64
    })
    self:PlayEffectsOnCast()
end
function SniperExtra.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_Techies.LandMine.Detonate", self.caster)
end
function SniperExtra.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_Sniper.ProjectileImpact", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_base_attack_explosion.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
SniperExtra = __TS__Decorate(
    {registerAbility(nil, "sniper_extra")},
    SniperExtra
)
ModifierSniperExtra = __TS__Class()
ModifierSniperExtra.name = "ModifierSniperExtra"
__TS__ClassExtends(ModifierSniperExtra, ModifierDisplacement)
function ModifierSniperExtra.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierSniperExtra.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierSniperExtra.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierSniperExtra.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_OUT_OF_GAME] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
ModifierSniperExtra = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_extra_displacement"})},
    ModifierSniperExtra
)
ModifierSniperExtraEnemy = __TS__Class()
ModifierSniperExtraEnemy.name = "ModifierSniperExtraEnemy"
__TS__ClassExtends(ModifierSniperExtraEnemy, ModifierDisplacement)
function ModifierSniperExtraEnemy.prototype.OnCollide(self, event)
    if IsServer() then
        if event.collision == "wall" then
            ApplyDamage({
                victim = self.parent,
                attacker = self.caster,
                damage = self:Value("damage_on_collision"),
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            self:Destroy()
        end
    end
end
function ModifierSniperExtraEnemy.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierSniperExtraEnemy.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierSniperExtraEnemy.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierSniperExtraEnemy.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
ModifierSniperExtraEnemy = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_extra_displacement_enemy"})},
    ModifierSniperExtraEnemy
)
return ____exports
