local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 19,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 5,["23"] = 7,["24"] = 7,["25"] = 8,["26"] = 9,["27"] = 10,["29"] = 10,["31"] = 11,["32"] = 11,["33"] = 11,["34"] = 11,["35"] = 11,["36"] = 11,["37"] = 9,["38"] = 8,["39"] = 7,["40"] = 8,["42"] = 18,["43"] = 18,["44"] = 19,["46"] = 19,["47"] = 20,["48"] = 18,["49"] = 22,["50"] = 23,["51"] = 22,["52"] = 26,["53"] = 27,["54"] = 26,["55"] = 30,["56"] = 31,["57"] = 30,["58"] = 34,["59"] = 35,["60"] = 34,["61"] = 38,["62"] = 39,["63"] = 40,["64"] = 41,["65"] = 42,["66"] = 43,["67"] = 44,["68"] = 45,["69"] = 46,["70"] = 47,["71"] = 49,["72"] = 49,["73"] = 49,["74"] = 49,["75"] = 49,["76"] = 49,["77"] = 55,["78"] = 56,["79"] = 56,["80"] = 49,["81"] = 57,["82"] = 58,["83"] = 58,["84"] = 58,["85"] = 58,["86"] = 58,["87"] = 58,["88"] = 49,["89"] = 65,["90"] = 66,["91"] = 49,["92"] = 49,["93"] = 69,["94"] = 38,["95"] = 72,["96"] = 73,["97"] = 72,["98"] = 81,["99"] = 82,["100"] = 81,["101"] = 85,["102"] = 86,["103"] = 85,["104"] = 19,["105"] = 18,["106"] = 19,["108"] = 93,["109"] = 93,["110"] = 94,["111"] = 98,["112"] = 99,["113"] = 98,["114"] = 102,["115"] = 103,["116"] = 102,["117"] = 106,["118"] = 107,["119"] = 106,["120"] = 110,["121"] = 111,["122"] = 110,["123"] = 114,["124"] = 115,["125"] = 114,["126"] = 118,["127"] = 119,["128"] = 118,["129"] = 122,["130"] = 123,["131"] = 122,["132"] = 126,["133"] = 127,["134"] = 126,["135"] = 130,["136"] = 131,["137"] = 130,["138"] = 134,["139"] = 135,["140"] = 134,["141"] = 138,["142"] = 139,["143"] = 140,["145"] = 138,["146"] = 144,["147"] = 145,["148"] = 146,["149"] = 147,["150"] = 148,["151"] = 149,["154"] = 144,["155"] = 158,["156"] = 159,["157"] = 158,["158"] = 162,["159"] = 163,["160"] = 162,["161"] = 166,["162"] = 167,["163"] = 168,["164"] = 173,["165"] = 173,["166"] = 173,["167"] = 173,["168"] = 173,["169"] = 175,["170"] = 180,["171"] = 180,["172"] = 180,["173"] = 180,["174"] = 180,["175"] = 166,["176"] = 183,["177"] = 184,["178"] = 185,["179"] = 186,["181"] = 188,["182"] = 189,["183"] = 190,["185"] = 183,["186"] = 94,["187"] = 93,["188"] = 94,["190"] = 201,["191"] = 201,["192"] = 202,["193"] = 202,["194"] = 201,["195"] = 202,["197"] = 206,["198"] = 206,["199"] = 207,["201"] = 207,["202"] = 208,["203"] = 206,["204"] = 210,["205"] = 211,["206"] = 212,["207"] = 213,["209"] = 210,["210"] = 217,["211"] = 218,["212"] = 219,["214"] = 222,["215"] = 222,["216"] = 222,["217"] = 222,["218"] = 222,["219"] = 222,["220"] = 228,["221"] = 217,["222"] = 231,["223"] = 232,["224"] = 233,["225"] = 234,["226"] = 231,["227"] = 239,["228"] = 240,["229"] = 241,["230"] = 242,["232"] = 242,["235"] = 239,["236"] = 207,["237"] = 206,["238"] = 207});
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
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
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
                damage = damage,
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
