local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 41,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 7,["21"] = 7,["22"] = 8,["23"] = 9,["24"] = 10,["25"] = 9,["26"] = 13,["27"] = 14,["28"] = 13,["29"] = 17,["30"] = 18,["31"] = 17,["32"] = 21,["33"] = 8,["34"] = 23,["35"] = 24,["37"] = 26,["38"] = 21,["39"] = 29,["40"] = 8,["41"] = 31,["42"] = 29,["43"] = 34,["44"] = 35,["45"] = 35,["46"] = 35,["47"] = 35,["48"] = 35,["49"] = 35,["50"] = 36,["51"] = 34,["52"] = 8,["53"] = 7,["54"] = 8,["56"] = 40,["57"] = 40,["58"] = 41,["59"] = 42,["60"] = 43,["61"] = 44,["62"] = 45,["64"] = 42,["65"] = 49,["66"] = 50,["67"] = 52,["68"] = 53,["69"] = 54,["70"] = 55,["71"] = 57,["72"] = 57,["73"] = 57,["74"] = 57,["75"] = 57,["76"] = 57,["77"] = 63,["78"] = 64,["79"] = 64,["80"] = 57,["81"] = 65,["82"] = 66,["83"] = 66,["84"] = 66,["85"] = 66,["86"] = 66,["87"] = 66,["88"] = 72,["89"] = 72,["90"] = 72,["91"] = 72,["92"] = 72,["93"] = 72,["94"] = 73,["95"] = 73,["96"] = 73,["97"] = 73,["98"] = 73,["99"] = 57,["100"] = 75,["101"] = 76,["102"] = 77,["103"] = 78,["104"] = 78,["105"] = 78,["106"] = 78,["107"] = 78,["108"] = 78,["109"] = 78,["110"] = 78,["111"] = 78,["112"] = 87,["113"] = 88,["114"] = 89,["115"] = 89,["116"] = 89,["117"] = 89,["118"] = 89,["119"] = 89,["121"] = 96,["122"] = 98,["123"] = 98,["124"] = 98,["125"] = 98,["126"] = 98,["127"] = 98,["128"] = 98,["129"] = 98,["130"] = 98,["131"] = 98,["132"] = 98,["133"] = 98,["135"] = 106,["136"] = 106,["137"] = 106,["138"] = 106,["139"] = 106,["140"] = 106,["141"] = 106,["142"] = 106,["143"] = 106,["144"] = 107,["145"] = 108,["146"] = 57,["147"] = 57,["148"] = 112,["149"] = 113,["150"] = 49,["151"] = 116,["152"] = 117,["153"] = 118,["154"] = 119,["155"] = 124,["156"] = 124,["157"] = 124,["158"] = 124,["159"] = 124,["160"] = 124,["161"] = 124,["162"] = 124,["163"] = 124,["164"] = 133,["165"] = 135,["166"] = 140,["167"] = 140,["168"] = 140,["169"] = 140,["170"] = 140,["171"] = 140,["172"] = 140,["173"] = 140,["174"] = 140,["175"] = 149,["176"] = 149,["177"] = 149,["178"] = 149,["179"] = 149,["180"] = 149,["181"] = 149,["182"] = 149,["183"] = 149,["184"] = 158,["186"] = 116,["187"] = 162,["188"] = 163,["189"] = 164,["190"] = 165,["191"] = 166,["192"] = 167,["193"] = 168,["194"] = 162,["195"] = 171,["196"] = 172,["197"] = 173,["198"] = 174,["199"] = 175,["200"] = 175,["201"] = 175,["202"] = 175,["203"] = 175,["204"] = 176,["205"] = 176,["206"] = 176,["207"] = 176,["208"] = 176,["209"] = 177,["210"] = 171,["211"] = 180,["212"] = 181,["213"] = 182,["214"] = 183,["215"] = 184,["216"] = 185,["217"] = 180,["218"] = 41,["219"] = 40,["220"] = 41,["222"] = 191,["223"] = 191,["224"] = 192,["225"] = 192,["226"] = 191,["227"] = 192,["229"] = 196,["230"] = 196,["231"] = 197,["232"] = 197,["233"] = 196,["234"] = 197});
local ____exports = {}
local ModifierSniperUltimateChanneling, ModifierSniperUltimate
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local direction2D = ____util.direction2D
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local SniperUltimate = __TS__Class()
SniperUltimate.name = "SniperUltimate"
__TS__ClassExtends(SniperUltimate, CustomAbility)
function SniperUltimate.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SniperUltimate.prototype.GetPlaybackRateOverride(self)
    return 2.5
end
function SniperUltimate.prototype.GetCastingCrawl(self)
    return 0
end
function SniperUltimate.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        EmitGlobalSound("sniper_snip_ability_assass_02")
        return true
    end
    return false
end
function SniperUltimate.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    StopGlobalSound("sniper_snip_ability_assass_02")
end
function SniperUltimate.prototype.OnSpellStart(self)
    ModifierSniperUltimateChanneling:apply(
        self.caster,
        self.caster,
        self,
        {duration = self:GetSpecialValueFor("duration")}
    )
    EmitGlobalSound("sniper_snip_laugh_08")
end
SniperUltimate = __TS__Decorate(
    {registerAbility(nil, "sniper_ultimate")},
    SniperUltimate
)
ModifierSniperUltimateChanneling = __TS__Class()
ModifierSniperUltimateChanneling.name = "ModifierSniperUltimateChanneling"
__TS__ClassExtends(ModifierSniperUltimateChanneling, CustomModifier)
function ModifierSniperUltimateChanneling.prototype.OnCreated(self)
    if IsServer() then
        self:OnIntervalThink()
        self:StartIntervalThink(0.45)
    end
end
function ModifierSniperUltimateChanneling.prototype.OnIntervalThink(self)
    self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
    local origin = self.parent:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self.ability)
    local projectileSpeed = self:Value("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    self.ability:ProjectileAttack({
        source = self.parent,
        effectName = "particles/sniper/sniper_ultimate_new.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 100, projectileDirection.y * 100, 96)),
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
                damage = self:Value("ability_damage"),
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            ModifierSniperUltimate:apply(
                unit,
                projectile:getSource(),
                self.ability,
                {duration = 0.1}
            )
            self:PlayEffectsTarget(
                projectile:getSource(),
                unit,
                projectile:getPosition()
            )
        end,
        onFinish = function(____, projectile)
            local position = projectile:getPosition()
            local source = projectile:getSource()
            local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
                source,
                position,
                self:Value("radius") + 50,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER
            )
            for ____, enemy in ipairs(enemies) do
                if not ModifierSniperUltimate:findOne(enemy) then
                    ApplyDamage({
                        victim = enemy,
                        attacker = source,
                        damage = self:Value("aoe_damage"),
                        damage_type = DAMAGE_TYPE_PURE
                    })
                end
                local knockbackDirection = projectile:getVelocity():Normalized()
                ModifierDisplacement:apply(
                    enemy,
                    source,
                    self.ability,
                    {
                        x = knockbackDirection.x,
                        y = knockbackDirection.y,
                        distance = self:Value("radius"),
                        speed = self:Value("radius") / 0.15,
                        peak = 0
                    }
                )
            end
            ScreenShake(
                position,
                100,
                300,
                0.45,
                1000,
                0,
                true
            )
            self:PlayEffectsExplosion(position)
            self:PlayEffectsProjectileImpact(source, position)
        end
    })
    CustomEntitiesLegacy:FullyFaceTowards(self.parent, projectileDirection)
    EmitSoundOn("Ability.Assassinate", self.parent)
end
function ModifierSniperUltimateChanneling.prototype.OnDestroy(self)
    if IsServer() then
        self.parent:FadeGesture(ACT_DOTA_ATTACK)
        local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_base_attack_smokeburst.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControlEnt(
            particleId,
            7,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            self.parent:GetAbsOrigin():__add(Vector(0, 0, 96)),
            true
        )
        ParticleManager:ReleaseParticleIndex(particleId)
        particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_base_attack_explosion.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControlEnt(
            particleId,
            0,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            self.parent:GetAbsOrigin():__add(Vector(0, 0, 96)),
            true
        )
        ParticleManager:SetParticleControlEnt(
            particleId,
            3,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            self.parent:GetAbsOrigin():__add(Vector(0, 0, 96)),
            true
        )
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function ModifierSniperUltimateChanneling.prototype.PlayEffectsProjectileImpact(self, source, position)
    EmitSoundOn("Hero_Sniper.AssassinateDamage", source)
    local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, source)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 1, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ModifierSniperUltimateChanneling.prototype.PlayEffectsTarget(self, source, target, position)
    EmitSoundOnLocationWithCaster(position, "Hero_Sniper.AssassinateDamage", source)
    local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        target:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        1,
        target:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ModifierSniperUltimateChanneling.prototype.PlayEffectsExplosion(self, position)
    local particle_cast = "particles/econ/items/techies/techies_arcana/techies_suicide_arcana.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
ModifierSniperUltimateChanneling = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_ultimate_channeling"})},
    ModifierSniperUltimateChanneling
)
local ModifierSniperUltimateDisplacement = __TS__Class()
ModifierSniperUltimateDisplacement.name = "ModifierSniperUltimateDisplacement"
__TS__ClassExtends(ModifierSniperUltimateDisplacement, ModifierDisplacement)
ModifierSniperUltimateDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_ultimate_displacement"})},
    ModifierSniperUltimateDisplacement
)
ModifierSniperUltimate = __TS__Class()
ModifierSniperUltimate.name = "ModifierSniperUltimate"
__TS__ClassExtends(ModifierSniperUltimate, CustomModifier)
ModifierSniperUltimate = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_ultimate_hit"})},
    ModifierSniperUltimate
)
return ____exports
