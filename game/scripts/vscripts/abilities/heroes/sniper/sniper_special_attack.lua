local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 193,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 8,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 9,["28"] = 13,["29"] = 14,["30"] = 13,["31"] = 17,["32"] = 18,["33"] = 19,["34"] = 20,["35"] = 20,["36"] = 20,["37"] = 20,["38"] = 20,["39"] = 20,["40"] = 20,["41"] = 20,["42"] = 20,["43"] = 29,["44"] = 29,["45"] = 29,["46"] = 29,["47"] = 29,["48"] = 30,["49"] = 17,["50"] = 34,["51"] = 34,["52"] = 35,["53"] = 36,["54"] = 37,["55"] = 36,["56"] = 40,["57"] = 41,["58"] = 40,["59"] = 44,["60"] = 45,["61"] = 46,["62"] = 47,["63"] = 47,["64"] = 47,["65"] = 47,["66"] = 47,["67"] = 47,["68"] = 47,["69"] = 47,["70"] = 47,["71"] = 49,["72"] = 49,["73"] = 49,["74"] = 49,["75"] = 49,["76"] = 49,["77"] = 49,["78"] = 49,["79"] = 49,["80"] = 49,["81"] = 55,["82"] = 44,["83"] = 35,["84"] = 34,["85"] = 35,["87"] = 64,["88"] = 64,["89"] = 65,["90"] = 66,["91"] = 67,["92"] = 66,["93"] = 70,["94"] = 71,["95"] = 72,["96"] = 73,["97"] = 73,["98"] = 73,["99"] = 73,["100"] = 73,["101"] = 73,["102"] = 73,["103"] = 73,["104"] = 73,["105"] = 75,["106"] = 75,["107"] = 75,["108"] = 75,["109"] = 75,["110"] = 75,["111"] = 75,["112"] = 75,["113"] = 75,["114"] = 75,["115"] = 81,["116"] = 70,["117"] = 65,["118"] = 64,["119"] = 65,["121"] = 86,["122"] = 86,["123"] = 87,["124"] = 88,["125"] = 89,["126"] = 88,["127"] = 92,["128"] = 93,["129"] = 92,["130"] = 96,["131"] = 97,["132"] = 96,["133"] = 100,["134"] = 101,["135"] = 102,["137"] = 100,["138"] = 106,["139"] = 107,["140"] = 107,["141"] = 107,["142"] = 107,["143"] = 107,["144"] = 107,["145"] = 106,["146"] = 115,["147"] = 116,["148"] = 115,["149"] = 119,["150"] = 120,["151"] = 119,["152"] = 87,["153"] = 86,["154"] = 87,["156"] = 124,["157"] = 125,["158"] = 124,["159"] = 125,["160"] = 128,["161"] = 129,["162"] = 128,["163"] = 132,["164"] = 133,["165"] = 132,["166"] = 136,["167"] = 137,["168"] = 136,["169"] = 140,["170"] = 141,["171"] = 140,["172"] = 144,["173"] = 145,["174"] = 144,["175"] = 148,["176"] = 149,["177"] = 148,["178"] = 152,["179"] = 153,["180"] = 152,["181"] = 156,["182"] = 157,["183"] = 158,["184"] = 159,["185"] = 159,["186"] = 159,["187"] = 159,["188"] = 159,["189"] = 159,["190"] = 159,["191"] = 160,["193"] = 156,["194"] = 164,["195"] = 125,["196"] = 167,["197"] = 168,["198"] = 169,["200"] = 164,["201"] = 173,["202"] = 174,["203"] = 175,["204"] = 180,["205"] = 180,["206"] = 180,["207"] = 180,["208"] = 180,["209"] = 181,["210"] = 181,["211"] = 181,["212"] = 181,["213"] = 181,["214"] = 181,["215"] = 181,["216"] = 181,["217"] = 181,["218"] = 182,["219"] = 182,["220"] = 182,["221"] = 182,["222"] = 182,["223"] = 173,["224"] = 185,["225"] = 186,["226"] = 187,["227"] = 188,["228"] = 185,["229"] = 125,["230"] = 124,["231"] = 125,["233"] = 125,["234"] = 192,["235"] = 192,["236"] = 193,["237"] = 196,["238"] = 197,["239"] = 196,["240"] = 200,["241"] = 201,["242"] = 200,["243"] = 204,["244"] = 205,["245"] = 204,["246"] = 208,["247"] = 209,["248"] = 208,["249"] = 212,["250"] = 213,["251"] = 212,["252"] = 216,["253"] = 217,["254"] = 216,["255"] = 220,["256"] = 221,["257"] = 220,["258"] = 224,["259"] = 225,["260"] = 226,["261"] = 226,["262"] = 226,["263"] = 226,["264"] = 226,["265"] = 226,["266"] = 226,["267"] = 227,["268"] = 228,["270"] = 224,["271"] = 232,["272"] = 193,["273"] = 235,["274"] = 236,["275"] = 237,["277"] = 232,["278"] = 241,["279"] = 242,["280"] = 243,["281"] = 248,["282"] = 249,["283"] = 250,["284"] = 252,["285"] = 257,["286"] = 258,["287"] = 258,["288"] = 258,["289"] = 258,["290"] = 258,["291"] = 259,["292"] = 241,["293"] = 262,["294"] = 263,["295"] = 264,["296"] = 265,["297"] = 270,["298"] = 271,["299"] = 271,["300"] = 271,["301"] = 271,["302"] = 271,["303"] = 271,["304"] = 271,["305"] = 271,["306"] = 271,["307"] = 262,["308"] = 274,["309"] = 275,["310"] = 276,["311"] = 277,["312"] = 274,["313"] = 193,["314"] = 192,["315"] = 193,["317"] = 281,["318"] = 281,["319"] = 282,["320"] = 285,["321"] = 286,["322"] = 287,["323"] = 288,["325"] = 285,["326"] = 296,["327"] = 297,["328"] = 298,["329"] = 299,["331"] = 296,["332"] = 303,["333"] = 304,["334"] = 305,["336"] = 305,["339"] = 303,["340"] = 309,["341"] = 310,["342"] = 309,["343"] = 313,["344"] = 314,["345"] = 313,["346"] = 317,["347"] = 318,["348"] = 317,["349"] = 282,["350"] = 281,["351"] = 282,["353"] = 322,["354"] = 322,["355"] = 323,["356"] = 323,["357"] = 322,["358"] = 323});
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
