local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 5,["17"] = 5,["18"] = 6,["19"] = 6,["20"] = 6,["21"] = 6,["22"] = 6,["23"] = 7,["24"] = 7,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 10,["29"] = 11,["30"] = 10,["31"] = 14,["32"] = 15,["33"] = 17,["34"] = 18,["35"] = 19,["36"] = 20,["37"] = 22,["38"] = 14,["39"] = 25,["40"] = 26,["41"] = 28,["42"] = 29,["43"] = 31,["44"] = 31,["45"] = 31,["46"] = 31,["47"] = 31,["48"] = 32,["49"] = 32,["50"] = 32,["51"] = 32,["52"] = 32,["53"] = 33,["54"] = 25,["55"] = 37,["56"] = 37,["57"] = 38,["58"] = 41,["59"] = 42,["60"] = 42,["65"] = 42,["66"] = 41,["67"] = 45,["68"] = 46,["69"] = 45,["70"] = 49,["71"] = 50,["72"] = 49,["73"] = 53,["74"] = 54,["75"] = 53,["76"] = 57,["77"] = 58,["78"] = 38,["80"] = 66,["81"] = 57,["82"] = 69,["83"] = 38,["84"] = 71,["85"] = 73,["86"] = 78,["87"] = 78,["88"] = 78,["89"] = 78,["90"] = 78,["91"] = 78,["92"] = 78,["93"] = 78,["94"] = 78,["95"] = 88,["97"] = 91,["98"] = 69,["99"] = 94,["100"] = 38,["101"] = 97,["102"] = 98,["104"] = 94,["105"] = 102,["106"] = 103,["107"] = 104,["109"] = 107,["110"] = 108,["111"] = 109,["112"] = 110,["113"] = 111,["114"] = 112,["115"] = 113,["116"] = 114,["117"] = 115,["118"] = 117,["119"] = 117,["120"] = 117,["121"] = 117,["122"] = 117,["123"] = 117,["124"] = 117,["125"] = 124,["126"] = 125,["127"] = 125,["128"] = 117,["129"] = 126,["130"] = 127,["131"] = 128,["132"] = 130,["133"] = 131,["134"] = 132,["135"] = 132,["136"] = 132,["137"] = 132,["138"] = 132,["139"] = 132,["142"] = 136,["143"] = 136,["144"] = 136,["145"] = 136,["146"] = 136,["147"] = 136,["148"] = 143,["149"] = 143,["150"] = 143,["151"] = 143,["152"] = 143,["153"] = 143,["154"] = 144,["155"] = 117,["156"] = 146,["157"] = 147,["158"] = 147,["159"] = 147,["160"] = 147,["161"] = 117,["162"] = 117,["163"] = 154,["164"] = 155,["166"] = 165,["167"] = 165,["168"] = 165,["169"] = 165,["170"] = 165,["171"] = 165,["172"] = 165,["173"] = 165,["174"] = 165,["175"] = 165,["177"] = 172,["178"] = 173,["179"] = 102,["180"] = 38,["181"] = 37,["182"] = 38,["184"] = 178,["185"] = 178,["186"] = 179,["187"] = 180,["188"] = 181,["189"] = 180,["190"] = 184,["191"] = 185,["192"] = 184,["193"] = 188,["194"] = 189,["195"] = 188,["196"] = 192,["197"] = 193,["198"] = 194,["199"] = 195,["200"] = 196,["201"] = 197,["202"] = 197,["203"] = 197,["204"] = 197,["205"] = 197,["206"] = 197,["207"] = 199,["208"] = 200,["209"] = 192,["210"] = 204,["211"] = 205,["212"] = 206,["213"] = 207,["214"] = 208,["215"] = 209,["216"] = 211,["217"] = 211,["218"] = 211,["219"] = 211,["220"] = 211,["221"] = 211,["222"] = 211,["223"] = 218,["224"] = 219,["225"] = 219,["226"] = 211,["227"] = 220,["228"] = 221,["229"] = 222,["230"] = 224,["231"] = 224,["232"] = 224,["233"] = 224,["234"] = 224,["235"] = 224,["236"] = 231,["237"] = 231,["238"] = 231,["239"] = 231,["240"] = 231,["241"] = 231,["242"] = 232,["243"] = 211,["244"] = 234,["245"] = 235,["246"] = 236,["247"] = 242,["248"] = 243,["249"] = 243,["250"] = 243,["251"] = 243,["252"] = 243,["253"] = 243,["255"] = 245,["256"] = 245,["257"] = 245,["258"] = 245,["259"] = 211,["260"] = 211,["261"] = 204,["262"] = 179,["263"] = 178,["264"] = 179});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____modifier_root = require("modifiers.modifier_root")
local ModifierRoot = ____modifier_root.ModifierRoot
local ____modifier_stunned = require("modifiers.modifier_stunned")
local ModifierStun = ____modifier_stunned.ModifierStun
local ____projectiles = require("projectiles")
local ProjectileBehavior = ____projectiles.ProjectileBehavior
local ____util = require("util")
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local SniperSecondAttackCommon = __TS__Class()
SniperSecondAttackCommon.name = "SniperSecondAttackCommon"
__TS__ClassExtends(SniperSecondAttackCommon, CustomAbility)
function SniperSecondAttackCommon.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Ability.Assassinate", self.caster)
end
function SniperSecondAttackCommon.prototype.PlayEffectsOnFinish(self, position, path)
    EmitSoundOnLocationWithCaster(position, "Hero_Sniper.AssassinateDamage", self.caster)
    local particleId = ParticleManager:CreateParticle(path, PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 1, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function SniperSecondAttackCommon.prototype.PlayEffectsOnHit(self, unit)
    EmitSoundOn("Hero_Sniper.AssassinateDamage", self.caster)
    local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        unit:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        1,
        unit:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
local SniperSecondAttack = __TS__Class()
SniperSecondAttack.name = "SniperSecondAttack"
__TS__ClassExtends(SniperSecondAttack, SniperSecondAttackCommon)
function SniperSecondAttack.prototype.GetAnimation(self)
    local ____temp_0
    if self:GetLevel() >= 2 then
        ____temp_0 = ACT_DOTA_DIE
    else
        ____temp_0 = ACT_DOTA_CAST_ABILITY_1
    end
    return ____temp_0
end
function SniperSecondAttack.prototype.GetAnimationTranslate(self)
    return self:GetLevel() >= 2 and Translate.overkilled or nil
end
function SniperSecondAttack.prototype.GetPlaybackRateOverride(self)
    return self:GetLevel() >= 2 and 0.8 or 0.5
end
function SniperSecondAttack.prototype.GetCastingCrawl(self)
    return self:GetLevel() >= 2 and 60 or 0
end
function SniperSecondAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return SniperSecondAttackCommon.prototype.GetCastPoint(self)
    end
    return 0
end
function SniperSecondAttack.prototype.OnAbilityPhaseStart(self)
    if SniperSecondAttackCommon.prototype.OnAbilityPhaseStart(self) then
        EmitGlobalSound("Ability.AssassinateLoad")
        self.particleId = ParticleManager:CreateParticle("particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
        ParticleManager:SetParticleControlEnt(
            self.particleId,
            1,
            self.caster,
            PATTACH_ABSORIGIN_FOLLOW,
            "attach_hitloc",
            self.caster:GetAbsOrigin(),
            false
        )
        return true
    end
    return false
end
function SniperSecondAttack.prototype.OnAbilityPhaseInterrupted(self)
    SniperSecondAttackCommon.prototype.OnAbilityPhaseInterrupted(self)
    if self.particleId then
        DEFX(self.particleId, true)
    end
end
function SniperSecondAttack.prototype.OnSpellStart(self)
    if self.particleId then
        DEFX(self.particleId, false)
    end
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local stunDuration = self:GetSpecialValueFor("stun_duration")
    local reductionPerHit = self:GetSpecialValueFor("reduction_per_hit") / 100
    local minDamage = self:GetSpecialValueFor("min_damage")
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/sniper/sniper_second_attack.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitBehavior = ProjectileBehavior.NOTHING,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            local hits = projectile.hitLog.size
            local finalDamage = math.max(minDamage, damage * (1 - hits * reductionPerHit))
            if hits < 1 and projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and not isGem(nil, unit) then
                    giveManaAndEnergyPercent(
                        nil,
                        projectile:getSource(),
                        manaGainPct,
                        true
                    )
                end
            end
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = finalDamage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            ModifierStun:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = stunDuration}
            )
            self:PlayEffectsOnHit(unit)
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(
                projectile:getPosition(),
                "particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
            )
        end
    })
    if self:GetLevel() >= 2 then
        EFX("particles/econ/items/phantom_lancer/phantom_lancer_fall20_immortal/phantom_lancer_fall20_immortal_doppelganger_aoe_gold_bits.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {cp1 = origin, release = true})
    else
        EFX(
            "particles/sniper/sniper_second_attack_endcap_model.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self.caster,
            {
                cp1 = projectileDirection:__mul(100):__add(origin),
                cp1f = self.caster:GetForwardVector(),
                release = true
            }
        )
    end
    self:PlayEffectsOnCast()
    self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 3)
end
SniperSecondAttack = __TS__Decorate(
    {registerAbility(nil, "sniper_second_attack")},
    SniperSecondAttack
)
local SniperExSecondAttack = __TS__Class()
SniperExSecondAttack.name = "SniperExSecondAttack"
__TS__ClassExtends(SniperExSecondAttack, SniperSecondAttackCommon)
function SniperExSecondAttack.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SniperExSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 0.5
end
function SniperExSecondAttack.prototype.GetCastingCrawl(self)
    return 0
end
function SniperExSecondAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local projectileDirection = direction2D(nil, origin, point)
    local projectileOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96))
    self:ThrowProjectile(
        origin:__add(Vector(0, 0, 96)),
        projectileDirection,
        true,
        self.caster
    )
    self:PlayEffectsOnCast()
    self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
end
function SniperExSecondAttack.prototype.ThrowProjectile(self, origin, direction, firstTime, source)
    local damage = self:GetSpecialValueFor("ability_damage")
    local speed = self:GetSpecialValueFor("projectile_speed")
    local rootDuration = self:GetSpecialValueFor("root_duration")
    local reductionPerHit = self:GetSpecialValueFor("reduction_per_hit") / 100
    local minDamage = self:GetSpecialValueFor("min_damage")
    self:ProjectileAttack({
        source = source,
        effectName = "particles/sniper/sniper_ex_second_attack_new.vpcf",
        spawnOrigin = origin,
        velocity = direction:__mul(speed),
        groundOffset = 0,
        unitBehavior = ProjectileBehavior.NOTHING,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            local hits = projectile.hitLog.size
            local finalDamage = math.max(minDamage, damage * (1 - hits * reductionPerHit))
            ApplyDamage({
                victim = unit,
                attacker = projectile:getSource(),
                damage = finalDamage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
            ModifierRoot:apply(
                unit,
                projectile:getSource(),
                self,
                {duration = rootDuration}
            )
            self:PlayEffectsOnHit(unit)
        end,
        onFinish = function(____, projectile)
            if self:GetLevel() >= 2 and firstTime then
                local newDirection = projectile:getSource():GetAbsOrigin():__add(Vector(0, 0, 96)):__sub(projectile:getPosition()):Normalized()
                local newOrigin = projectile:getPosition():__add(Vector(newDirection.x * 45, newDirection.y * 45, 0))
                self:ThrowProjectile(
                    newOrigin,
                    newDirection,
                    false,
                    projectile:getSource()
                )
            end
            self:PlayEffectsOnFinish(
                projectile:getPosition(),
                "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_base_attack_impact.vpcf"
            )
        end
    })
end
SniperExSecondAttack = __TS__Decorate(
    {registerAbility(nil, "sniper_ex_second_attack")},
    SniperExSecondAttack
)
return ____exports
