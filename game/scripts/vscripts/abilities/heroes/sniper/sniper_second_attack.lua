local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 5,["17"] = 5,["18"] = 6,["19"] = 6,["20"] = 6,["21"] = 6,["22"] = 6,["23"] = 7,["24"] = 7,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 10,["29"] = 11,["30"] = 10,["31"] = 14,["32"] = 15,["33"] = 17,["34"] = 18,["35"] = 19,["36"] = 20,["37"] = 22,["38"] = 14,["39"] = 25,["40"] = 26,["41"] = 28,["42"] = 29,["43"] = 31,["44"] = 31,["45"] = 31,["46"] = 31,["47"] = 31,["48"] = 32,["49"] = 32,["50"] = 32,["51"] = 32,["52"] = 32,["53"] = 33,["54"] = 25,["55"] = 37,["56"] = 37,["57"] = 38,["58"] = 41,["59"] = 42,["60"] = 42,["65"] = 42,["66"] = 41,["67"] = 45,["68"] = 46,["69"] = 45,["70"] = 49,["71"] = 50,["72"] = 49,["73"] = 53,["74"] = 54,["75"] = 53,["76"] = 57,["77"] = 58,["79"] = 38,["80"] = 57,["81"] = 67,["82"] = 38,["83"] = 69,["84"] = 71,["85"] = 76,["86"] = 76,["87"] = 76,["88"] = 76,["89"] = 76,["90"] = 76,["91"] = 76,["92"] = 76,["93"] = 76,["94"] = 86,["96"] = 89,["97"] = 67,["98"] = 92,["99"] = 38,["100"] = 95,["101"] = 96,["103"] = 92,["104"] = 100,["105"] = 101,["106"] = 102,["108"] = 105,["109"] = 106,["110"] = 107,["111"] = 108,["112"] = 109,["113"] = 110,["114"] = 111,["115"] = 112,["116"] = 113,["117"] = 115,["118"] = 115,["119"] = 115,["120"] = 115,["121"] = 115,["122"] = 115,["123"] = 115,["124"] = 122,["125"] = 123,["126"] = 123,["127"] = 115,["128"] = 124,["129"] = 125,["130"] = 126,["131"] = 128,["132"] = 129,["133"] = 130,["134"] = 130,["135"] = 130,["136"] = 130,["137"] = 130,["138"] = 130,["141"] = 134,["142"] = 134,["143"] = 134,["144"] = 134,["145"] = 134,["146"] = 134,["147"] = 141,["148"] = 141,["149"] = 141,["150"] = 141,["151"] = 141,["152"] = 141,["153"] = 142,["154"] = 115,["155"] = 144,["156"] = 145,["157"] = 145,["158"] = 145,["159"] = 145,["160"] = 115,["161"] = 115,["162"] = 152,["163"] = 153,["165"] = 163,["166"] = 163,["167"] = 163,["168"] = 163,["169"] = 163,["170"] = 163,["171"] = 163,["172"] = 163,["173"] = 163,["174"] = 163,["176"] = 170,["177"] = 171,["178"] = 100,["179"] = 38,["180"] = 37,["181"] = 38,["183"] = 176,["184"] = 176,["185"] = 177,["186"] = 178,["187"] = 179,["188"] = 178,["189"] = 182,["190"] = 183,["191"] = 182,["192"] = 186,["193"] = 187,["194"] = 186,["195"] = 190,["196"] = 191,["197"] = 192,["198"] = 193,["199"] = 194,["200"] = 195,["201"] = 195,["202"] = 195,["203"] = 195,["204"] = 195,["205"] = 195,["206"] = 197,["207"] = 198,["208"] = 190,["209"] = 202,["210"] = 203,["211"] = 204,["212"] = 205,["213"] = 206,["214"] = 207,["215"] = 209,["216"] = 209,["217"] = 209,["218"] = 209,["219"] = 209,["220"] = 209,["221"] = 209,["222"] = 216,["223"] = 217,["224"] = 217,["225"] = 209,["226"] = 218,["227"] = 219,["228"] = 220,["229"] = 222,["230"] = 222,["231"] = 222,["232"] = 222,["233"] = 222,["234"] = 222,["235"] = 229,["236"] = 229,["237"] = 229,["238"] = 229,["239"] = 229,["240"] = 229,["241"] = 230,["242"] = 209,["243"] = 232,["244"] = 233,["245"] = 234,["246"] = 240,["247"] = 241,["248"] = 241,["249"] = 241,["250"] = 241,["251"] = 241,["252"] = 241,["254"] = 243,["255"] = 243,["256"] = 243,["257"] = 243,["258"] = 209,["259"] = 209,["260"] = 202,["261"] = 177,["262"] = 176,["263"] = 177});
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
    end
    return SniperSecondAttackCommon.prototype.GetCastPoint(self)
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
