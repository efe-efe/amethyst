local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 19,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 7,["24"] = 7,["25"] = 8,["26"] = 9,["27"] = 10,["29"] = 10,["31"] = 11,["32"] = 11,["33"] = 11,["34"] = 11,["35"] = 11,["36"] = 11,["37"] = 9,["38"] = 8,["39"] = 7,["40"] = 8,["42"] = 18,["43"] = 18,["44"] = 19,["46"] = 19,["47"] = 20,["48"] = 18,["49"] = 22,["50"] = 23,["51"] = 22,["52"] = 26,["53"] = 27,["54"] = 26,["55"] = 30,["56"] = 31,["57"] = 30,["58"] = 34,["59"] = 35,["60"] = 34,["61"] = 38,["62"] = 39,["63"] = 40,["64"] = 41,["65"] = 42,["66"] = 43,["67"] = 44,["68"] = 45,["69"] = 46,["70"] = 48,["71"] = 48,["72"] = 48,["73"] = 48,["74"] = 48,["75"] = 48,["76"] = 54,["77"] = 55,["78"] = 55,["79"] = 48,["80"] = 56,["81"] = 57,["82"] = 57,["83"] = 57,["84"] = 57,["85"] = 57,["86"] = 57,["87"] = 48,["88"] = 64,["89"] = 65,["90"] = 48,["91"] = 48,["92"] = 68,["93"] = 38,["94"] = 71,["95"] = 72,["96"] = 71,["97"] = 80,["98"] = 81,["99"] = 80,["100"] = 84,["101"] = 85,["102"] = 84,["103"] = 19,["104"] = 18,["105"] = 19,["107"] = 92,["108"] = 92,["109"] = 93,["110"] = 97,["111"] = 98,["112"] = 97,["113"] = 101,["114"] = 102,["115"] = 101,["116"] = 105,["117"] = 106,["118"] = 105,["119"] = 109,["120"] = 110,["121"] = 109,["122"] = 113,["123"] = 114,["124"] = 113,["125"] = 117,["126"] = 118,["127"] = 117,["128"] = 121,["129"] = 122,["130"] = 121,["131"] = 125,["132"] = 126,["133"] = 125,["134"] = 129,["135"] = 130,["136"] = 129,["137"] = 133,["138"] = 134,["139"] = 133,["140"] = 137,["141"] = 138,["142"] = 139,["144"] = 137,["145"] = 143,["146"] = 144,["147"] = 145,["148"] = 146,["149"] = 147,["150"] = 148,["153"] = 143,["154"] = 157,["155"] = 158,["156"] = 157,["157"] = 161,["158"] = 162,["159"] = 161,["160"] = 165,["161"] = 166,["162"] = 167,["163"] = 172,["164"] = 172,["165"] = 172,["166"] = 172,["167"] = 172,["168"] = 174,["169"] = 179,["170"] = 179,["171"] = 179,["172"] = 179,["173"] = 179,["174"] = 165,["175"] = 182,["176"] = 183,["177"] = 184,["178"] = 185,["180"] = 187,["181"] = 188,["182"] = 189,["184"] = 182,["185"] = 93,["186"] = 92,["187"] = 93,["189"] = 200,["190"] = 200,["191"] = 201,["192"] = 201,["193"] = 200,["194"] = 201,["196"] = 205,["197"] = 205,["198"] = 206,["200"] = 206,["201"] = 207,["202"] = 205,["203"] = 209,["204"] = 210,["205"] = 211,["206"] = 212,["208"] = 209,["209"] = 216,["210"] = 217,["211"] = 218,["213"] = 221,["214"] = 221,["215"] = 221,["216"] = 221,["217"] = 221,["218"] = 221,["219"] = 227,["220"] = 216,["221"] = 230,["222"] = 231,["223"] = 232,["224"] = 233,["225"] = 230,["226"] = 238,["227"] = 239,["228"] = 240,["229"] = 241,["231"] = 241,["234"] = 238,["235"] = 206,["236"] = 205,["237"] = 206});
local ____exports = {}
local SpectreExtraRecast, ModifierSpectreExtra, ModifierSpectreRecast, ModifierSpectreDebuff
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____util = require("util")
local clamp = ____util.clamp
local direction2D = ____util.direction2D
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local SpectreExtra = __TS__Class()
SpectreExtra.name = "SpectreExtra"
__TS__ClassExtends(SpectreExtra, CustomAbility)
function SpectreExtra.prototype.OnSpellStart(self)
    local ____opt_0 = SpectreExtraRecast:findOne(self.caster)
    if ____opt_0 ~= nil then
        ____opt_0:ResetDamage()
    end
    ModifierSpectreExtra:apply(
        self.caster,
        self.caster,
        self,
        {duration = self:GetSpecialValueFor("duration")}
    )
end
SpectreExtra = __TS__Decorate(
    {registerAbility(nil, "spectre_extra")},
    SpectreExtra
)
SpectreExtraRecast = __TS__Class()
SpectreExtraRecast.name = "SpectreExtraRecast"
__TS__ClassExtends(SpectreExtraRecast, CustomAbility)
function SpectreExtraRecast.prototype.____constructor(self, ...)
    CustomAbility.prototype.____constructor(self, ...)
    self.extraDamage = 0
end
function SpectreExtraRecast.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SpectreExtraRecast.prototype.GetPlaybackRateOverride(self)
    return 1
end
function SpectreExtraRecast.prototype.GetCastingCrawl(self)
    return 80
end
function SpectreExtraRecast.prototype.GetIgnoreActivationCycle(self)
    return true
end
function SpectreExtraRecast.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local spectreExtra = SpectreExtra:findOne(self.caster)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = spectreExtra and spectreExtra:GetSpecialValueFor("recast_damage") or 0
    local maxDamage = spectreExtra and spectreExtra:GetSpecialValueFor("max_damage") or 0
    local finalDamage = clamp(nil, damage + self.extraDamage, maxDamage, 0)
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/spectre/spectre_extra_recast.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
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
                damage = finalDamage,
                damage_type = DAMAGE_TYPE_MAGICAL
            })
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("Hero_Nevermore.Raze_Flames", self.caster)
end
function SpectreExtraRecast.prototype.PlayEffectsOnFinish(self, position)
    EFX("particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf", PATTACH_WORLDORIGIN, self.caster, {cp0 = position, cp1 = position, cp2 = position, release = true})
end
function SpectreExtraRecast.prototype.AddDamage(self, damage)
    self.extraDamage = self.extraDamage + damage
end
function SpectreExtraRecast.prototype.ResetDamage(self)
    self.extraDamage = 0
end
SpectreExtraRecast = __TS__Decorate(
    {registerAbility(nil, "spectre_extra_recast")},
    SpectreExtraRecast
)
ModifierSpectreExtra = __TS__Class()
ModifierSpectreExtra.name = "ModifierSpectreExtra"
__TS__ClassExtends(ModifierSpectreExtra, CustomModifier)
function ModifierSpectreExtra.prototype.IsHidden(self)
    return false
end
function ModifierSpectreExtra.prototype.IsDebuff(self)
    return false
end
function ModifierSpectreExtra.prototype.IsPurgable(self)
    return false
end
function ModifierSpectreExtra.prototype.IsAura(self)
    return true
end
function ModifierSpectreExtra.prototype.GetModifierAura(self)
    return ModifierSpectreDebuff.name
end
function ModifierSpectreExtra.prototype.GetAuraRadius(self)
    return self:Value("radius")
end
function ModifierSpectreExtra.prototype.GetAuraDuration(self)
    return 0
end
function ModifierSpectreExtra.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierSpectreExtra.prototype.GetAuraEntityReject(self, unit)
    return CustomEntitiesLegacy:Allies(self.caster, unit)
end
function ModifierSpectreExtra.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierSpectreExtra.prototype.OnCreated(self)
    if IsServer() then
        self:PlayEffectsOnCreated()
    end
end
function ModifierSpectreExtra.prototype.OnDestroy(self)
    if IsServer() then
        self.ability:StartCooldown(self.ability:GetCooldown(self.ability:GetLevel()))
        self:StopEffects()
        if self.ability:GetLevel() >= 2 then
            ModifierSpectreRecast:apply(self.parent, self.parent, self.ability, {abilityLeft = SpectreExtra.name, abilityRight = SpectreExtraRecast.name, duration = 5})
        end
    end
end
function ModifierSpectreExtra.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierSpectreExtra.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("speed_buff_pct")
end
function ModifierSpectreExtra.prototype.PlayEffectsOnCreated(self)
    EmitSoundOn("Hero_Spectre.Haunt", self.parent)
    self.particleIdMain = ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(
        self.particleIdMain,
        2,
        self.parent:GetAbsOrigin()
    )
    self.particleIdSecond = ParticleManager:CreateParticle("particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_mist.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(
        self.particleIdSecond,
        3,
        self.parent:GetAbsOrigin()
    )
end
function ModifierSpectreExtra.prototype.StopEffects(self)
    if self.particleIdMain then
        ParticleManager:DestroyParticle(self.particleIdMain, false)
        ParticleManager:ReleaseParticleIndex(self.particleIdMain)
    end
    if self.particleIdSecond then
        ParticleManager:DestroyParticle(self.particleIdSecond, false)
        ParticleManager:ReleaseParticleIndex(self.particleIdSecond)
    end
end
ModifierSpectreExtra = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_extra"})},
    ModifierSpectreExtra
)
ModifierSpectreRecast = __TS__Class()
ModifierSpectreRecast.name = "ModifierSpectreRecast"
__TS__ClassExtends(ModifierSpectreRecast, ModifierRecast)
ModifierSpectreRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_extra_recast"})},
    ModifierSpectreRecast
)
ModifierSpectreDebuff = __TS__Class()
ModifierSpectreDebuff.name = "ModifierSpectreDebuff"
__TS__ClassExtends(ModifierSpectreDebuff, CustomModifier)
function ModifierSpectreDebuff.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.damageDone = 0
end
function ModifierSpectreDebuff.prototype.OnCreated(self)
    if IsServer() then
        self.damageDone = 0
        self:StartIntervalThink(self:Value("think_interval"))
    end
end
function ModifierSpectreDebuff.prototype.OnIntervalThink(self)
    if not isObstacle(nil, self.parent) and not isGem(nil, self.parent) then
        self.damageDone = self.damageDone + self:Value("damage_per_second")
    end
    ApplyDamage({
        victim = self.parent,
        attacker = self.caster,
        damage = self:Value("damage_per_second"),
        damage_type = DAMAGE_TYPE_PURE
    })
    self:PlayEffects()
end
function ModifierSpectreDebuff.prototype.PlayEffects(self)
    EmitSoundOn("Hero_Spectre.Desolate", self.caster)
    EmitSoundOn("Hero_Spectre.Attack", self.parent)
    EFX("particles/spectre/spectre_extra_impact.vpcf", PATTACH_ABSORIGIN, self.parent, {release = true})
end
function ModifierSpectreDebuff.prototype.OnDestroy(self)
    if IsServer() then
        self.caster:Heal(self.damageDone, self.ability)
        local ____opt_6 = SpectreExtraRecast:findOne(self.caster)
        if ____opt_6 ~= nil then
            ____opt_6:AddDamage(self.damageDone)
        end
    end
end
ModifierSpectreDebuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_debuff"})},
    ModifierSpectreDebuff
)
return ____exports
