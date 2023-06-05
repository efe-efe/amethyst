local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 198,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 8,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 9,["28"] = 13,["29"] = 14,["30"] = 13,["31"] = 17,["32"] = 18,["33"] = 19,["34"] = 20,["35"] = 20,["36"] = 20,["37"] = 20,["38"] = 20,["39"] = 20,["40"] = 20,["41"] = 20,["42"] = 20,["43"] = 29,["44"] = 29,["45"] = 29,["46"] = 29,["47"] = 29,["48"] = 30,["49"] = 17,["50"] = 34,["51"] = 34,["52"] = 35,["53"] = 36,["54"] = 37,["55"] = 36,["56"] = 40,["57"] = 41,["58"] = 40,["59"] = 44,["60"] = 45,["61"] = 46,["62"] = 47,["63"] = 47,["64"] = 47,["65"] = 47,["66"] = 47,["67"] = 47,["68"] = 47,["69"] = 47,["70"] = 47,["71"] = 49,["72"] = 49,["73"] = 49,["74"] = 49,["75"] = 49,["76"] = 49,["77"] = 49,["78"] = 49,["79"] = 49,["80"] = 49,["81"] = 55,["82"] = 44,["83"] = 35,["84"] = 34,["85"] = 35,["87"] = 64,["88"] = 64,["89"] = 65,["90"] = 66,["91"] = 67,["92"] = 66,["93"] = 70,["94"] = 71,["95"] = 72,["96"] = 73,["97"] = 73,["98"] = 73,["99"] = 73,["100"] = 73,["101"] = 73,["102"] = 73,["103"] = 73,["104"] = 73,["105"] = 75,["106"] = 75,["107"] = 75,["108"] = 75,["109"] = 75,["110"] = 75,["111"] = 75,["112"] = 75,["113"] = 75,["114"] = 75,["115"] = 81,["116"] = 70,["117"] = 65,["118"] = 64,["119"] = 65,["121"] = 89,["122"] = 89,["123"] = 90,["124"] = 91,["125"] = 92,["126"] = 91,["127"] = 95,["128"] = 96,["129"] = 95,["130"] = 99,["131"] = 100,["132"] = 99,["133"] = 103,["134"] = 104,["135"] = 105,["137"] = 103,["138"] = 109,["139"] = 110,["140"] = 110,["141"] = 110,["142"] = 110,["143"] = 110,["144"] = 110,["145"] = 109,["146"] = 118,["147"] = 119,["148"] = 118,["149"] = 122,["150"] = 123,["151"] = 122,["152"] = 90,["153"] = 89,["154"] = 90,["156"] = 127,["157"] = 128,["158"] = 127,["159"] = 128,["160"] = 131,["161"] = 132,["162"] = 131,["163"] = 135,["164"] = 136,["165"] = 135,["166"] = 139,["167"] = 140,["168"] = 139,["169"] = 143,["170"] = 144,["171"] = 143,["172"] = 147,["173"] = 148,["174"] = 147,["175"] = 151,["176"] = 152,["177"] = 151,["178"] = 155,["179"] = 156,["180"] = 155,["181"] = 159,["182"] = 160,["183"] = 161,["184"] = 162,["185"] = 162,["186"] = 162,["187"] = 162,["188"] = 162,["189"] = 162,["190"] = 162,["191"] = 163,["193"] = 159,["194"] = 167,["195"] = 128,["196"] = 170,["197"] = 171,["198"] = 172,["200"] = 167,["201"] = 176,["202"] = 177,["203"] = 178,["204"] = 183,["205"] = 183,["206"] = 183,["207"] = 183,["208"] = 183,["209"] = 184,["210"] = 184,["211"] = 184,["212"] = 184,["213"] = 184,["214"] = 184,["215"] = 184,["216"] = 184,["217"] = 184,["218"] = 185,["219"] = 185,["220"] = 185,["221"] = 185,["222"] = 185,["223"] = 176,["224"] = 188,["225"] = 189,["226"] = 190,["227"] = 191,["228"] = 188,["229"] = 128,["230"] = 127,["231"] = 128,["233"] = 128,["234"] = 197,["235"] = 197,["236"] = 198,["237"] = 201,["238"] = 202,["239"] = 201,["240"] = 205,["241"] = 206,["242"] = 205,["243"] = 209,["244"] = 210,["245"] = 209,["246"] = 213,["247"] = 214,["248"] = 213,["249"] = 217,["250"] = 218,["251"] = 217,["252"] = 221,["253"] = 222,["254"] = 221,["255"] = 225,["256"] = 226,["257"] = 225,["258"] = 229,["259"] = 230,["260"] = 231,["261"] = 231,["262"] = 231,["263"] = 231,["264"] = 231,["265"] = 231,["266"] = 231,["267"] = 232,["268"] = 233,["270"] = 229,["271"] = 237,["272"] = 198,["273"] = 240,["274"] = 241,["275"] = 242,["277"] = 237,["278"] = 246,["279"] = 247,["280"] = 248,["281"] = 253,["282"] = 254,["283"] = 255,["284"] = 257,["285"] = 262,["286"] = 263,["287"] = 263,["288"] = 263,["289"] = 263,["290"] = 263,["291"] = 264,["292"] = 246,["293"] = 267,["294"] = 268,["295"] = 269,["296"] = 270,["297"] = 275,["298"] = 276,["299"] = 276,["300"] = 276,["301"] = 276,["302"] = 276,["303"] = 276,["304"] = 276,["305"] = 276,["306"] = 276,["307"] = 267,["308"] = 279,["309"] = 280,["310"] = 281,["311"] = 282,["312"] = 279,["313"] = 198,["314"] = 197,["315"] = 198,["317"] = 288,["318"] = 288,["319"] = 289,["320"] = 292,["321"] = 293,["322"] = 294,["323"] = 295,["325"] = 292,["326"] = 303,["327"] = 304,["328"] = 305,["329"] = 306,["331"] = 303,["332"] = 310,["333"] = 311,["334"] = 312,["336"] = 312,["339"] = 310,["340"] = 316,["341"] = 317,["342"] = 316,["343"] = 320,["344"] = 321,["345"] = 320,["346"] = 324,["347"] = 325,["348"] = 324,["349"] = 289,["350"] = 288,["351"] = 289,["353"] = 329,["354"] = 329,["355"] = 330,["356"] = 330,["357"] = 329,["358"] = 330});
local ____exports = {}
local ModifierSniperExSpecialAttackThinker, ModifierSniperExSpecialAttack
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____sniper_basic_attack = require("abilities.heroes.sniper.sniper_basic_attack")
local ModifierSniperCharges = ____sniper_basic_attack.ModifierSniperCharges
local SniperSpecialAttackCommon = __TS__Class()
SniperSpecialAttackCommon.name = "SniperSpecialAttackCommon"
__TS__ClassExtends(SniperSpecialAttackCommon, CustomAbility)
function SniperSpecialAttackCommon.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function SniperSpecialAttackCommon.prototype.GetPlaybackRateOverride(self)
    return 1.5
end
function SniperSpecialAttackCommon.prototype.PlayEffects(self, point, path)
    EmitSoundOn("Hero_Sniper.ShrapnelShoot", self.caster)
    local particleId = ParticleManager:CreateParticle(path, PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControlEnt(
        particleId,
        0,
        self.caster,
        PATTACH_POINT_FOLLOW,
        "attach_attack1",
        self.caster:GetAbsOrigin(),
        false
    )
    ParticleManager:SetParticleControl(
        particleId,
        1,
        point:__add(Vector(0, 0, 2000))
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
local SniperSpecialAttack = __TS__Class()
SniperSpecialAttack.name = "SniperSpecialAttack"
__TS__ClassExtends(SniperSpecialAttack, SniperSpecialAttackCommon)
function SniperSpecialAttack.prototype.GetIntrinsicModifierName(self)
    return "modifier_sniper_special_attack_charges"
end
function SniperSpecialAttack.prototype.GetCastingCrawl(self)
    return 10
end
function SniperSpecialAttack.prototype.OnSpellStart(self)
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
    ____exports.ModifierSniperSpecialAttackThinker:createThinker(
        self.caster,
        self,
        Vector(point.x, point.y, origin.z),
        {
            duration = self:GetSpecialValueFor("duration"),
            delayTime = self:GetSpecialValueFor("delay_time"),
            radius = self:GetSpecialValueFor("radius")
        }
    )
    self:PlayEffects(point, "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf")
end
SniperSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "sniper_special_attack")},
    SniperSpecialAttack
)
local SniperExSpecialAttack = __TS__Class()
SniperExSpecialAttack.name = "SniperExSpecialAttack"
__TS__ClassExtends(SniperExSpecialAttack, SniperSpecialAttackCommon)
function SniperExSpecialAttack.prototype.GetCastingCrawl(self)
    return 100
end
function SniperExSpecialAttack.prototype.OnSpellStart(self)
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
    ModifierSniperExSpecialAttackThinker:createThinker(
        self.caster,
        self,
        Vector(point.x, point.y, origin.z),
        {
            duration = self:GetSpecialValueFor("duration"),
            delayTime = self:GetSpecialValueFor("delay_time"),
            radius = self:GetSpecialValueFor("radius")
        }
    )
    self:PlayEffects(point, "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_shrapnel_launch.vpcf")
end
SniperExSpecialAttack = __TS__Decorate(
    {registerAbility(nil, "sniper_ex_special_attack")},
    SniperExSpecialAttack
)
local ModifierSniperSpecialAttackDebuff = __TS__Class()
ModifierSniperSpecialAttackDebuff.name = "ModifierSniperSpecialAttackDebuff"
__TS__ClassExtends(ModifierSniperSpecialAttackDebuff, CustomModifier)
function ModifierSniperSpecialAttackDebuff.prototype.IsHidden(self)
    return false
end
function ModifierSniperSpecialAttackDebuff.prototype.IsDebuff(self)
    return true
end
function ModifierSniperSpecialAttackDebuff.prototype.IsPurgable(self)
    return false
end
function ModifierSniperSpecialAttackDebuff.prototype.OnCreated(self)
    if IsServer() then
        self:StartIntervalThink(self:Value("think_interval"))
    end
end
function ModifierSniperSpecialAttackDebuff.prototype.OnIntervalThink(self)
    ApplyDamage({
        victim = self.parent,
        attacker = self.caster,
        damage = self:Value("damage_per_think"),
        damage_type = DAMAGE_TYPE_PURE
    })
end
function ModifierSniperSpecialAttackDebuff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierSniperSpecialAttackDebuff.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return -self:Value("slow_pct")
end
ModifierSniperSpecialAttackDebuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_shrapnel_debuff"})},
    ModifierSniperSpecialAttackDebuff
)
____exports.ModifierSniperSpecialAttackThinker = __TS__Class()
local ModifierSniperSpecialAttackThinker = ____exports.ModifierSniperSpecialAttackThinker
ModifierSniperSpecialAttackThinker.name = "ModifierSniperSpecialAttackThinker"
__TS__ClassExtends(ModifierSniperSpecialAttackThinker, ModifierThinker)
function ModifierSniperSpecialAttackThinker.prototype.IsAura(self)
    return self.initialized
end
function ModifierSniperSpecialAttackThinker.prototype.GetModifierAura(self)
    return ModifierSniperSpecialAttackDebuff.name
end
function ModifierSniperSpecialAttackThinker.prototype.GetAuraRadius(self)
    return self:Value("radius")
end
function ModifierSniperSpecialAttackThinker.prototype.GetAuraDuration(self)
    return self:Value("debuff_linger")
end
function ModifierSniperSpecialAttackThinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierSniperSpecialAttackThinker.prototype.GetAuraEntityReject(self, unit)
    return CustomEntitiesLegacy:Allies(self.caster, unit)
end
function ModifierSniperSpecialAttackThinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierSniperSpecialAttackThinker.prototype.OnReady(self)
    if IsServer() then
        local direction = self.parent:GetAbsOrigin():__sub(self.caster:GetAbsOrigin()):Normalized()
        AddFOWViewer(
            self.caster:GetTeamNumber(),
            self.parent:GetAbsOrigin(),
            self:Value("radius"),
            self:Value("duration"),
            false
        )
        self:PlayEffects(direction)
    end
end
function ModifierSniperSpecialAttackThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        self:StopEffects()
        UTIL_Remove(self.parent)
    end
end
function ModifierSniperSpecialAttackThinker.prototype.PlayEffects(self, direction)
    EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self.parent)
    self.particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        self.particleId,
        0,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        self.particleId,
        1,
        Vector(
            self:Value("radius"),
            0,
            0
        )
    )
    ParticleManager:SetParticleControlForward(
        self.particleId,
        2,
        direction:__add(Vector(0, 0, 0.1))
    )
end
function ModifierSniperSpecialAttackThinker.prototype.StopEffects(self)
    ParticleManager:DestroyParticle(self.particleId, false)
    ParticleManager:ReleaseParticleIndex(self.particleId)
    StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self.parent)
end
ModifierSniperSpecialAttackThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_shrapnel_thinker_custom"})},
    ModifierSniperSpecialAttackThinker
)
____exports.ModifierSniperSpecialAttackThinker = ModifierSniperSpecialAttackThinker
ModifierSniperExSpecialAttackThinker = __TS__Class()
ModifierSniperExSpecialAttackThinker.name = "ModifierSniperExSpecialAttackThinker"
__TS__ClassExtends(ModifierSniperExSpecialAttackThinker, ModifierThinker)
function ModifierSniperExSpecialAttackThinker.prototype.IsAura(self)
    return self.initialized
end
function ModifierSniperExSpecialAttackThinker.prototype.GetModifierAura(self)
    return ModifierSniperExSpecialAttack.name
end
function ModifierSniperExSpecialAttackThinker.prototype.GetAuraRadius(self)
    return self:Value("radius")
end
function ModifierSniperExSpecialAttackThinker.prototype.GetAuraDuration(self)
    return self:Value("buff_linger")
end
function ModifierSniperExSpecialAttackThinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierSniperExSpecialAttackThinker.prototype.GetAuraEntityReject(self, unit)
    return not CustomEntitiesLegacy:Allies(self.caster, unit)
end
function ModifierSniperExSpecialAttackThinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierSniperExSpecialAttackThinker.prototype.OnReady(self)
    if IsServer() then
        AddFOWViewer(
            self.caster:GetTeamNumber(),
            self.parent:GetAbsOrigin(),
            self:Value("radius"),
            self:Value("duration"),
            false
        )
        self:PlayEffectsOnCreated()
        self:PlayEffectsAoe()
    end
end
function ModifierSniperExSpecialAttackThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        self:StopEffects()
        UTIL_Remove(self.parent)
    end
end
function ModifierSniperExSpecialAttackThinker.prototype.PlayEffectsOnCreated(self)
    local origin = self.parent:GetAbsOrigin()
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, origin)
    ParticleManager:SetParticleControl(particleId, 1, origin)
    ParticleManager:SetParticleControl(particleId, 2, origin)
    particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, origin)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        origin:__add(Vector(0, 0, 1000))
    )
    ParticleManager:SetParticleControl(particleId, 2, origin)
end
function ModifierSniperExSpecialAttackThinker.prototype.PlayEffectsAoe(self)
    local origin = self.parent:GetAbsOrigin()
    EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self.parent)
    self.particleId = ParticleManager:CreateParticle("particles/sniper/sniper_ex_special_attack.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.particleId, 0, origin)
    ParticleManager:SetParticleControl(
        self.particleId,
        1,
        Vector(
            self:Value("radius"),
            0,
            0
        )
    )
end
function ModifierSniperExSpecialAttackThinker.prototype.StopEffects(self)
    ParticleManager:DestroyParticle(self.particleId, false)
    ParticleManager:ReleaseParticleIndex(self.particleId)
    StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self.parent)
end
ModifierSniperExSpecialAttackThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_ex_special_attack_thinker"})},
    ModifierSniperExSpecialAttackThinker
)
ModifierSniperExSpecialAttack = __TS__Class()
ModifierSniperExSpecialAttack.name = "ModifierSniperExSpecialAttack"
__TS__ClassExtends(ModifierSniperExSpecialAttack, CustomModifier)
function ModifierSniperExSpecialAttack.prototype.OnCreated(self)
    if IsServer() then
        self:StartIntervalThink(0.1)
        self.particleId = ParticleManager:CreateParticle("particles/sniper/sniper_ex_special_attack_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierSniperExSpecialAttack.prototype.OnDestroy(self)
    if IsServer() then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierSniperExSpecialAttack.prototype.OnIntervalThink(self)
    if self.parent == self.caster then
        local ____opt_0 = ModifierSniperCharges:findOne(self.parent)
        if ____opt_0 ~= nil then
            ____opt_0:RefreshCharges()
        end
    end
end
function ModifierSniperExSpecialAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
end
function ModifierSniperExSpecialAttack.prototype.GetModifierPreAttack_BonusDamage(self)
    return self:Value("extra_damage")
end
function ModifierSniperExSpecialAttack.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("ms_pct")
end
ModifierSniperExSpecialAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sniper_ex_special_attack_buff"})},
    ModifierSniperExSpecialAttack
)
local SniperSpecialAttackRecast = __TS__Class()
SniperSpecialAttackRecast.name = "SniperSpecialAttackRecast"
__TS__ClassExtends(SniperSpecialAttackRecast, CustomAbility)
SniperSpecialAttackRecast = __TS__Decorate(
    {registerAbility(nil, "sniper_special_attack_recast")},
    SniperSpecialAttackRecast
)
return ____exports
