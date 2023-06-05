local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 43,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 7,["21"] = 7,["22"] = 8,["23"] = 9,["24"] = 10,["25"] = 9,["26"] = 13,["27"] = 14,["28"] = 13,["29"] = 17,["30"] = 18,["31"] = 17,["32"] = 21,["33"] = 8,["34"] = 23,["35"] = 24,["37"] = 26,["38"] = 21,["39"] = 29,["40"] = 8,["41"] = 31,["42"] = 29,["43"] = 34,["44"] = 35,["45"] = 35,["46"] = 35,["47"] = 35,["48"] = 35,["49"] = 35,["50"] = 36,["51"] = 34,["52"] = 8,["53"] = 7,["54"] = 8,["56"] = 42,["57"] = 42,["58"] = 43,["59"] = 44,["60"] = 45,["61"] = 46,["62"] = 47,["64"] = 44,["65"] = 51,["66"] = 52,["67"] = 54,["68"] = 55,["69"] = 56,["70"] = 57,["71"] = 59,["72"] = 59,["73"] = 59,["74"] = 59,["75"] = 59,["76"] = 59,["77"] = 65,["78"] = 66,["79"] = 66,["80"] = 59,["81"] = 67,["82"] = 68,["83"] = 68,["84"] = 68,["85"] = 68,["86"] = 68,["87"] = 68,["88"] = 74,["89"] = 74,["90"] = 74,["91"] = 74,["92"] = 74,["93"] = 74,["94"] = 75,["95"] = 75,["96"] = 75,["97"] = 75,["98"] = 75,["99"] = 59,["100"] = 77,["101"] = 78,["102"] = 79,["103"] = 80,["104"] = 80,["105"] = 80,["106"] = 80,["107"] = 80,["108"] = 80,["109"] = 80,["110"] = 80,["111"] = 80,["112"] = 89,["113"] = 90,["114"] = 91,["115"] = 91,["116"] = 91,["117"] = 91,["118"] = 91,["119"] = 91,["121"] = 98,["122"] = 100,["123"] = 100,["124"] = 100,["125"] = 100,["126"] = 100,["127"] = 100,["128"] = 100,["129"] = 100,["130"] = 100,["131"] = 100,["132"] = 100,["133"] = 100,["135"] = 108,["136"] = 108,["137"] = 108,["138"] = 108,["139"] = 108,["140"] = 108,["141"] = 108,["142"] = 108,["143"] = 108,["144"] = 109,["145"] = 110,["146"] = 59,["147"] = 59,["148"] = 114,["149"] = 115,["150"] = 51,["151"] = 118,["152"] = 119,["153"] = 120,["154"] = 121,["155"] = 126,["156"] = 126,["157"] = 126,["158"] = 126,["159"] = 126,["160"] = 126,["161"] = 126,["162"] = 126,["163"] = 126,["164"] = 135,["165"] = 137,["166"] = 142,["167"] = 142,["168"] = 142,["169"] = 142,["170"] = 142,["171"] = 142,["172"] = 142,["173"] = 142,["174"] = 142,["175"] = 151,["176"] = 151,["177"] = 151,["178"] = 151,["179"] = 151,["180"] = 151,["181"] = 151,["182"] = 151,["183"] = 151,["184"] = 160,["186"] = 118,["187"] = 164,["188"] = 165,["189"] = 166,["190"] = 167,["191"] = 168,["192"] = 169,["193"] = 170,["194"] = 164,["195"] = 173,["196"] = 174,["197"] = 175,["198"] = 176,["199"] = 177,["200"] = 177,["201"] = 177,["202"] = 177,["203"] = 177,["204"] = 178,["205"] = 178,["206"] = 178,["207"] = 178,["208"] = 178,["209"] = 179,["210"] = 173,["211"] = 182,["212"] = 183,["213"] = 184,["214"] = 185,["215"] = 186,["216"] = 187,["217"] = 182,["218"] = 43,["219"] = 42,["220"] = 43,["222"] = 197,["223"] = 197,["224"] = 198,["225"] = 198,["226"] = 197,["227"] = 198,["229"] = 202,["230"] = 202,["231"] = 203,["232"] = 203,["233"] = 202,["234"] = 203});
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
    local projectileSpeed = self.ability:GetSpecialValueFor("projectile_speed")
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
                damage = self.ability:GetSpecialValueFor("ability_damage"),
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
                        damage = self.ability:GetSpecialValueFor("aoe_damage"),
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
