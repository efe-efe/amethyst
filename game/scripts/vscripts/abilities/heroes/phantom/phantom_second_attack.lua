local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 2,["13"] = 2,["14"] = 2,["15"] = 2,["16"] = 3,["17"] = 3,["18"] = 4,["19"] = 4,["20"] = 6,["21"] = 6,["22"] = 7,["23"] = 8,["24"] = 9,["25"] = 8,["26"] = 12,["27"] = 13,["28"] = 12,["29"] = 16,["30"] = 17,["31"] = 16,["32"] = 20,["33"] = 21,["34"] = 22,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 23,["39"] = 24,["40"] = 25,["41"] = 27,["42"] = 29,["43"] = 30,["44"] = 31,["45"] = 32,["46"] = 33,["47"] = 33,["48"] = 34,["49"] = 36,["50"] = 36,["51"] = 36,["52"] = 36,["53"] = 41,["54"] = 42,["55"] = 48,["56"] = 57,["58"] = 60,["59"] = 61,["61"] = 63,["62"] = 36,["63"] = 36,["64"] = 67,["65"] = 68,["66"] = 69,["67"] = 20,["68"] = 77,["69"] = 78,["70"] = 79,["71"] = 80,["72"] = 81,["73"] = 81,["74"] = 81,["75"] = 81,["76"] = 81,["77"] = 82,["78"] = 83,["79"] = 85,["80"] = 86,["81"] = 88,["83"] = 90,["85"] = 93,["86"] = 94,["87"] = 95,["88"] = 95,["89"] = 95,["90"] = 95,["91"] = 95,["92"] = 96,["93"] = 77,["94"] = 99,["95"] = 100,["96"] = 101,["97"] = 101,["98"] = 101,["99"] = 101,["100"] = 101,["101"] = 101,["102"] = 101,["103"] = 101,["104"] = 101,["105"] = 101,["106"] = 106,["107"] = 106,["108"] = 106,["109"] = 106,["110"] = 106,["111"] = 107,["112"] = 107,["113"] = 107,["114"] = 107,["115"] = 107,["116"] = 108,["117"] = 99,["118"] = 7,["119"] = 6,["120"] = 7,["122"] = 116,["123"] = 116,["124"] = 117,["125"] = 117,["126"] = 116,["127"] = 117});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____phantom_basic_attack = require("abilities.heroes.phantom.phantom_basic_attack")
local ModifierPhantomStacks = ____phantom_basic_attack.ModifierPhantomStacks
local PhantomSecondAttack = __TS__Class()
PhantomSecondAttack.name = "PhantomSecondAttack"
__TS__ClassExtends(PhantomSecondAttack, CustomAbility)
function PhantomSecondAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK_EVENT
end
function PhantomSecondAttack.prototype.GetPlaybackRateOverride(self)
    return 0.8
end
function PhantomSecondAttack.prototype.GetCastingCrawl(self)
    return 80
end
function PhantomSecondAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange, minRange = castRange})
    local damage = self.caster:GetAverageTrueAttackDamage(self.caster)
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local meeleExtraRadius = 0
    local radius = self:GetSpecialValueFor("radius") + meeleExtraRadius
    local damagePerStack = self:GetSpecialValueFor("damage_per_stack")
    local direction = direction2D(nil, origin, point)
    local ____opt_0 = ModifierPhantomStacks:findOne(self.caster)
    local stacks = ____opt_0 and ____opt_0:GetStackCount() or 0
    local finalDamage = damage + stacks * damagePerStack
    local units = self:MeeleAttack({
        direction = direction,
        origin = origin,
        radius = radius,
        effect = function(____, target)
            ApplyDamage({victim = target, attacker = self.caster, damage = finalDamage, damage_type = DAMAGE_TYPE_PHYSICAL})
            if stacks == 3 then
                EmitSoundOn("DOTA_Item.MagicWand.Activate", self.caster)
            end
            if not isObstacle(nil, target) and not isGem(nil, target) then
                giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
            end
            self:PlayEffectsOnImpact(target, stacks)
        end
    })
    self:PlayEffectsOnFinish(direction, radius)
    self.caster:RemoveModifierByName(ModifierPhantomStacks.name)
    EmitSoundOn("Hero_PhantomAssassin.Attack", self.caster)
end
function PhantomSecondAttack.prototype.PlayEffectsOnImpact(self, target, stacks)
    EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", target)
    local offset = 100
    local origin = self.caster:GetAbsOrigin()
    local direction = direction2D(
        nil,
        origin,
        target:GetAbsOrigin()
    )
    local finalPosition = origin:__add(Vector(direction.x * offset, direction.y * offset, 0))
    local particle_cast = ""
    if stacks == 3 then
        particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf"
        EmitSoundOn("Hero_PhantomAssassin.Spatter", target)
    else
        particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
    end
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, self.caster)
    ParticleManager:SetParticleControl(particleId, 1, finalPosition)
    ParticleManager:SetParticleControlForward(
        particleId,
        1,
        direction2D(nil, finalPosition, origin)
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function PhantomSecondAttack.prototype.PlayEffectsOnFinish(self, direction, radius)
    local origin = self.caster:GetAbsOrigin()
    local efx = EFX(
        "particles/juggernaut/juggernaut_second_attack_parent.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = origin,
            cp0f = direction,
            cp3 = Vector(radius, 0, 0)
        }
    )
    ParticleManager:SetParticleControl(
        efx,
        60,
        Vector(255, 0, 255)
    )
    ParticleManager:SetParticleControl(
        efx,
        61,
        Vector(1, 0, 0)
    )
    ParticleManager:ReleaseParticleIndex(efx)
end
PhantomSecondAttack = __TS__Decorate(
    {registerAbility(nil, "phantom_second_attack")},
    PhantomSecondAttack
)
local PhantomSecondAttackRecast = __TS__Class()
PhantomSecondAttackRecast.name = "PhantomSecondAttackRecast"
__TS__ClassExtends(PhantomSecondAttackRecast, CustomAbility)
PhantomSecondAttackRecast = __TS__Decorate(
    {registerAbility(nil, "phantom_second_attack_recast")},
    PhantomSecondAttackRecast
)
return ____exports
