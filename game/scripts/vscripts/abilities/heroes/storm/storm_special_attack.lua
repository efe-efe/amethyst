local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 60,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 3,["20"] = 3,["21"] = 4,["22"] = 4,["23"] = 5,["24"] = 5,["25"] = 6,["26"] = 6,["27"] = 8,["28"] = 8,["29"] = 9,["30"] = 10,["31"] = 11,["32"] = 10,["33"] = 14,["34"] = 15,["35"] = 14,["36"] = 18,["37"] = 19,["38"] = 18,["39"] = 22,["40"] = 23,["41"] = 24,["42"] = 25,["43"] = 25,["44"] = 25,["45"] = 25,["46"] = 25,["47"] = 25,["48"] = 25,["49"] = 25,["50"] = 25,["51"] = 27,["52"] = 27,["53"] = 27,["54"] = 27,["55"] = 27,["56"] = 27,["57"] = 27,["58"] = 27,["59"] = 27,["60"] = 32,["61"] = 33,["62"] = 22,["63"] = 36,["64"] = 37,["65"] = 39,["66"] = 44,["67"] = 45,["68"] = 46,["69"] = 36,["70"] = 49,["71"] = 50,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 50,["76"] = 50,["77"] = 53,["78"] = 53,["79"] = 53,["80"] = 53,["81"] = 53,["82"] = 53,["83"] = 53,["84"] = 53,["85"] = 53,["86"] = 54,["87"] = 55,["88"] = 49,["89"] = 9,["90"] = 8,["91"] = 9,["93"] = 59,["94"] = 59,["95"] = 60,["96"] = 62,["97"] = 60,["98"] = 65,["99"] = 62,["100"] = 68,["101"] = 69,["102"] = 69,["103"] = 69,["104"] = 69,["105"] = 69,["106"] = 69,["107"] = 69,["108"] = 69,["109"] = 69,["110"] = 69,["111"] = 69,["112"] = 76,["113"] = 78,["114"] = 78,["115"] = 78,["116"] = 78,["117"] = 78,["118"] = 78,["119"] = 78,["120"] = 78,["121"] = 78,["122"] = 88,["123"] = 89,["124"] = 89,["125"] = 89,["126"] = 89,["127"] = 89,["128"] = 89,["129"] = 96,["130"] = 96,["131"] = 96,["132"] = 96,["133"] = 96,["134"] = 96,["135"] = 96,["136"] = 96,["137"] = 96,["138"] = 96,["139"] = 102,["140"] = 104,["141"] = 105,["142"] = 106,["143"] = 106,["144"] = 106,["145"] = 106,["146"] = 107,["148"] = 109,["149"] = 110,["150"] = 111,["155"] = 116,["156"] = 68,["157"] = 119,["158"] = 120,["159"] = 120,["160"] = 120,["161"] = 120,["162"] = 120,["163"] = 120,["164"] = 120,["165"] = 121,["166"] = 121,["167"] = 121,["168"] = 121,["169"] = 121,["170"] = 121,["171"] = 121,["172"] = 123,["173"] = 124,["174"] = 125,["175"] = 126,["176"] = 126,["177"] = 126,["178"] = 126,["179"] = 126,["180"] = 126,["181"] = 126,["183"] = 119,["184"] = 60,["185"] = 59,["186"] = 60,["188"] = 131,["189"] = 131,["190"] = 132,["191"] = 136,["192"] = 137,["193"] = 138,["194"] = 138,["195"] = 138,["196"] = 138,["197"] = 138,["198"] = 139,["199"] = 147,["200"] = 147,["201"] = 147,["202"] = 147,["203"] = 147,["204"] = 147,["205"] = 147,["206"] = 147,["207"] = 147,["208"] = 156,["209"] = 156,["210"] = 156,["211"] = 156,["212"] = 156,["213"] = 156,["214"] = 156,["215"] = 156,["216"] = 157,["217"] = 158,["219"] = 136,["220"] = 162,["221"] = 163,["222"] = 164,["223"] = 165,["225"] = 162,["226"] = 169,["227"] = 170,["228"] = 170,["229"] = 170,["230"] = 170,["231"] = 170,["232"] = 171,["233"] = 172,["234"] = 169,["235"] = 175,["236"] = 176,["237"] = 175,["238"] = 179,["239"] = 180,["240"] = 179,["241"] = 183,["242"] = 184,["243"] = 183,["244"] = 132,["245"] = 131,["246"] = 132});
local ____exports = {}
local ModifierStormSpecialAttackThinker, ModifierStormSpecialAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveEnergyPercent = ____util.giveEnergyPercent
local giveManaPercent = ____util.giveManaPercent
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____storm_ultimate = require("abilities.heroes.storm.storm_ultimate")
local ModifierStormUltimate = ____storm_ultimate.ModifierStormUltimate
local StormSpecialAttack = __TS__Class()
StormSpecialAttack.name = "StormSpecialAttack"
__TS__ClassExtends(StormSpecialAttack, CustomAbility)
function StormSpecialAttack.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function StormSpecialAttack.prototype.GetPlaybackRateOverride(self)
    return 2
end
function StormSpecialAttack.prototype.GetCastingCrawl(self)
    return 10
end
function StormSpecialAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {maxRange = self:GetCastRange(
            Vector(0, 0, 0),
            nil
        )}
    )
    ModifierStormSpecialAttackThinker:createThinker(
        self.caster,
        self,
        point,
        {
            delayTime = self:GetSpecialValueFor("delay_time"),
            radius = self:GetSpecialValueFor("radius")
        }
    )
    self:PlayEffectsOnCast(origin, point)
    EmitSoundOn("Hero_StormSpirit.ElectricVortexCast", self.caster)
end
function StormSpecialAttack.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function StormSpecialAttack.prototype.PlayEffectsOnCast(self, origin, point)
    local efx = EFX(
        "particles/storm/storm_special_attack_launch.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.caster,
        {cp1 = point + Vector(0, 0, 2000)}
    )
    ParticleManager:SetParticleControlEnt(
        efx,
        0,
        self.caster,
        PATTACH_POINT_FOLLOW,
        "attach_attack1",
        origin,
        false
    )
    ParticleManager:ReleaseParticleIndex(efx)
    EmitSoundOn("Hero_StormSpirit.Attack", self.caster)
end
StormSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "storm_special_attack")},
    StormSpecialAttack
)
ModifierStormSpecialAttackThinker = __TS__Class()
ModifierStormSpecialAttackThinker.name = "ModifierStormSpecialAttackThinker"
__TS__ClassExtends(ModifierStormSpecialAttackThinker, ModifierThinker)
function ModifierStormSpecialAttackThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    self.origin = self.parent:GetAbsOrigin()
end
function ModifierStormSpecialAttackThinker.prototype.OnReady(self)
    EFX(
        "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = self.origin,
            cp1 = self.origin + Vector(0, 0, 1000),
            cp2 = self.origin,
            release = true
        }
    )
    local giveMana = true
    local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.parent,
        self.parent:GetAbsOrigin(),
        self:Value("radius"),
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    for ____, enemy in ipairs(enemies) do
        ApplyDamage({
            victim = enemy,
            attacker = self.caster,
            damage = self:Value("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE
        })
        ModifierStormSpecialAttack:apply(
            enemy,
            self.caster,
            self.ability,
            {
                duration = self:Value("duration"),
                originX = self.origin.x,
                originY = self.origin.y
            }
        )
        enemy:AddNewModifier(self.caster, self.ability, "modifier_generic_stunned", {duration = 0.1})
        if not isObstacle(nil, enemy) and not isGem(nil, enemy) then
            if self.ability:GetLevel() >= 2 then
                enemy:Script_ReduceMana(
                    self:Value("mana_gain_pct"),
                    self.ability
                )
                self:GiveMana()
            else
                if giveMana then
                    self:GiveMana()
                    giveMana = false
                end
            end
        end
    end
    self:Destroy()
end
function ModifierStormSpecialAttackThinker.prototype.GiveMana(self)
    giveManaPercent(
        nil,
        self.caster,
        self:Value("mana_gain_pct"),
        true,
        false
    )
    giveEnergyPercent(
        nil,
        self.caster,
        self:Value("energy_gain_pct"),
        true,
        false
    )
    local modifier = ModifierStormUltimate:findOne(self.caster)
    if modifier then
        local extraManaPct = self:Value("mana_gain_pct") * (modifier:GetManaMultiplier() - 1)
        giveManaPercent(
            nil,
            self.caster,
            extraManaPct,
            true,
            true
        )
    end
end
ModifierStormSpecialAttackThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_special_attack_thinker"})},
    ModifierStormSpecialAttackThinker
)
ModifierStormSpecialAttack = __TS__Class()
ModifierStormSpecialAttack.name = "ModifierStormSpecialAttack"
__TS__ClassExtends(ModifierStormSpecialAttack, CustomModifier)
function ModifierStormSpecialAttack.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = Vector(
            params.originX,
            params.originY,
            self.parent:GetAbsOrigin().z
        )
        self.particleId = EFX("particles/units/heroes/hero_stormspirit/stormspirit_electric_vortex.vpcf", PATTACH_CUSTOMORIGIN, nil, {cp0 = self.origin})
        ParticleManager:SetParticleControlEnt(
            self.particleId,
            1,
            self.parent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            Vector(0, 0, 0),
            true
        )
        self:AddParticle(
            self.particleId,
            false,
            false,
            -1,
            false,
            false
        )
        EmitSoundOn("Hero_StormSpirit.ElectricVortex", self.parent)
        self:StartIntervalThink(0.03)
    end
end
function ModifierStormSpecialAttack.prototype.OnDestroy(self)
    if IsServer() then
        DEFX(self.particleId, false)
        StopSoundOn("Hero_StormSpirit.ElectricVortex", self.parent)
    end
end
function ModifierStormSpecialAttack.prototype.OnIntervalThink(self)
    local direction = direction2D(
        nil,
        self.parent:GetAbsOrigin(),
        self.origin
    )
    local point = self.parent:GetAbsOrigin():__add(direction:__mul(10))
    self.parent:SetAbsOrigin(point)
end
function ModifierStormSpecialAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierStormSpecialAttack.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierStormSpecialAttack.prototype.GetOverrideAnimationRate(self)
    return 1
end
ModifierStormSpecialAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_special_attack_efx"})},
    ModifierStormSpecialAttack
)
return ____exports
