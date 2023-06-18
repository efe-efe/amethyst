local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 338,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 4,["16"] = 5,["17"] = 6,["18"] = 7,["19"] = 8,["20"] = 9,["21"] = 10,["22"] = 11,["23"] = 12,["24"] = 13,["25"] = 15,["26"] = 15,["27"] = 16,["28"] = 16,["29"] = 18,["30"] = 18,["31"] = 19,["32"] = 20,["33"] = 21,["34"] = 20,["35"] = 24,["36"] = 25,["37"] = 26,["39"] = 29,["40"] = 24,["41"] = 32,["42"] = 33,["43"] = 34,["44"] = 35,["45"] = 19,["47"] = 19,["48"] = 32,["49"] = 42,["50"] = 43,["51"] = 42,["52"] = 46,["53"] = 47,["54"] = 48,["55"] = 48,["56"] = 49,["58"] = 52,["59"] = 46,["60"] = 55,["61"] = 56,["62"] = 55,["63"] = 59,["64"] = 60,["65"] = 61,["66"] = 62,["67"] = 62,["68"] = 62,["69"] = 62,["70"] = 63,["71"] = 68,["72"] = 70,["73"] = 71,["74"] = 72,["75"] = 73,["76"] = 74,["77"] = 74,["78"] = 74,["79"] = 74,["81"] = 74,["82"] = 75,["83"] = 78,["84"] = 79,["85"] = 79,["86"] = 79,["87"] = 79,["88"] = 79,["89"] = 79,["90"] = 79,["91"] = 79,["92"] = 79,["94"] = 82,["95"] = 83,["96"] = 84,["97"] = 85,["98"] = 86,["99"] = 86,["100"] = 86,["102"] = 86,["104"] = 82,["105"] = 82,["106"] = 82,["107"] = 82,["108"] = 82,["109"] = 82,["110"] = 82,["111"] = 82,["112"] = 88,["113"] = 89,["114"] = 91,["115"] = 92,["117"] = 95,["118"] = 95,["119"] = 95,["120"] = 95,["121"] = 95,["122"] = 82,["123"] = 82,["124"] = 82,["125"] = 82,["126"] = 100,["127"] = 101,["128"] = 59,["129"] = 104,["130"] = 105,["131"] = 107,["132"] = 109,["133"] = 110,["134"] = 111,["136"] = 104,["137"] = 115,["138"] = 116,["139"] = 116,["140"] = 116,["141"] = 116,["142"] = 116,["143"] = 116,["144"] = 116,["145"] = 116,["146"] = 116,["147"] = 116,["148"] = 121,["149"] = 121,["150"] = 121,["151"] = 121,["152"] = 121,["153"] = 122,["154"] = 122,["155"] = 122,["156"] = 122,["157"] = 122,["158"] = 124,["159"] = 125,["160"] = 125,["161"] = 125,["162"] = 125,["163"] = 125,["165"] = 128,["166"] = 115,["167"] = 131,["168"] = 132,["169"] = 137,["170"] = 138,["171"] = 138,["172"] = 138,["173"] = 138,["174"] = 138,["175"] = 139,["176"] = 140,["177"] = 131,["178"] = 143,["179"] = 144,["180"] = 149,["181"] = 150,["182"] = 151,["183"] = 143,["184"] = 154,["185"] = 155,["186"] = 156,["187"] = 157,["189"] = 154,["190"] = 161,["191"] = 162,["192"] = 163,["193"] = 164,["194"] = 169,["197"] = 173,["198"] = 174,["199"] = 177,["200"] = 182,["201"] = 183,["202"] = 183,["203"] = 183,["204"] = 183,["205"] = 183,["206"] = 183,["207"] = 183,["208"] = 183,["209"] = 183,["210"] = 184,["211"] = 161,["212"] = 19,["213"] = 18,["214"] = 19,["216"] = 188,["217"] = 189,["218"] = 188,["219"] = 189,["221"] = 189,["222"] = 190,["223"] = 188,["224"] = 194,["225"] = 189,["226"] = 194,["227"] = 200,["228"] = 201,["229"] = 200,["230"] = 204,["231"] = 205,["234"] = 208,["236"] = 204,["237"] = 212,["238"] = 213,["239"] = 214,["240"] = 214,["241"] = 214,["242"] = 214,["243"] = 214,["244"] = 214,["245"] = 218,["246"] = 219,["247"] = 219,["248"] = 219,["249"] = 219,["250"] = 219,["251"] = 219,["252"] = 220,["253"] = 220,["254"] = 220,["255"] = 220,["256"] = 220,["257"] = 220,["259"] = 223,["260"] = 224,["261"] = 224,["262"] = 224,["263"] = 224,["266"] = 212,["267"] = 229,["268"] = 230,["269"] = 231,["271"] = 233,["272"] = 229,["273"] = 236,["274"] = 237,["277"] = 241,["278"] = 242,["279"] = 242,["280"] = 242,["281"] = 242,["282"] = 243,["284"] = 236,["285"] = 247,["286"] = 248,["287"] = 249,["289"] = 252,["290"] = 252,["291"] = 252,["292"] = 252,["293"] = 252,["294"] = 252,["295"] = 247,["296"] = 255,["297"] = 256,["298"] = 257,["299"] = 255,["300"] = 260,["301"] = 261,["302"] = 260,["303"] = 264,["304"] = 265,["305"] = 264,["306"] = 274,["307"] = 275,["308"] = 276,["309"] = 277,["310"] = 282,["311"] = 282,["312"] = 282,["313"] = 282,["314"] = 282,["315"] = 282,["316"] = 282,["317"] = 282,["318"] = 282,["319"] = 291,["320"] = 291,["321"] = 291,["322"] = 291,["323"] = 291,["324"] = 291,["325"] = 291,["326"] = 291,["327"] = 291,["329"] = 274,["330"] = 302,["331"] = 303,["332"] = 304,["333"] = 305,["335"] = 302,["336"] = 309,["337"] = 310,["338"] = 309,["339"] = 313,["340"] = 314,["341"] = 313,["342"] = 317,["343"] = 318,["344"] = 317,["345"] = 189,["346"] = 188,["347"] = 189,["349"] = 189,["350"] = 334,["351"] = 334,["352"] = 335,["353"] = 335,["354"] = 334,["355"] = 335,["357"] = 337,["358"] = 337,["359"] = 338,["360"] = 339,["361"] = 340,["362"] = 339,["363"] = 343,["364"] = 344,["365"] = 343,["366"] = 347,["367"] = 348,["368"] = 347,["369"] = 351,["370"] = 352,["371"] = 351,["372"] = 355,["373"] = 356,["374"] = 355,["375"] = 359,["376"] = 360,["377"] = 359,["378"] = 338,["379"] = 337,["380"] = 338});
local ____exports = {}
local ModifierSpectreDesolate
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_cooldown = require("modifiers.modifier_cooldown")
local ModifierCooldown = ____modifier_cooldown.ModifierCooldown
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local giveManaAndEnergyPercent = ____util.giveManaAndEnergyPercent
local isCountering = ____util.isCountering
local isGem = ____util.isGem
local isObstacle = ____util.isObstacle
local lock = ____util.lock
local replenishEFX = ____util.replenishEFX
local tryLock = ____util.tryLock
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local SpectreBasicAttack = __TS__Class()
SpectreBasicAttack.name = "SpectreBasicAttack"
__TS__ClassExtends(SpectreBasicAttack, CustomAbility)
function SpectreBasicAttack.prototype.GetIntrinsicModifierName(self)
    return ____exports.ModifierSpectreBasicAttack.name
end
function SpectreBasicAttack.prototype.GetCastPoint(self)
    if IsServer() then
        return self.caster:GetAttackAnimationPoint()
    end
    return 0
end
function SpectreBasicAttack.prototype.GetCooldown(self, level)
    if IsServer() then
        local attacksPerSecond = self.caster:GetAttacksPerSecond()
        local attackSpeed = 1 / attacksPerSecond
        return CustomAbility.prototype.GetCooldown(self, level) + attackSpeed
    end
    return CustomAbility.prototype.GetCooldown(self, level)
end
function SpectreBasicAttack.prototype.GetAnimation(self)
    return ACT_DOTA_ATTACK
end
function SpectreBasicAttack.prototype.GetPlaybackRateOverride(self)
    if IsServer() then
        local ____opt_0 = ____exports.ModifierSpectreBasicAttack:findOne(self.caster)
        local slow = ____opt_0 and ____opt_0:IsCooldownReady() and 0.3 or 0
        return 1.1 - slow
    end
    return 0
end
function SpectreBasicAttack.prototype.GetCastingCrawl(self)
    return self:GetSpecialValueFor("cast_point_speed_pct")
end
function SpectreBasicAttack.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local castRange = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local point = clampPosition(nil, origin, cursor, {maxRange = castRange, minRange = castRange})
    local meeleExtraRadius = 0
    local cooldownReduction = self:GetSpecialValueFor("cooldown_reduction")
    local cooldownReductionCounter = self:GetSpecialValueFor("cooldown_reduction_counter")
    local manaGainPct = self:GetSpecialValueFor("mana_gain_pct")
    local direction = direction2D(nil, origin, point)
    local ____opt_2 = ____exports.ModifierSpectreBasicAttack:findOne(self.caster)
    local ____temp_4 = ____opt_2 and ____opt_2:IsCooldownReady()
    if ____temp_4 == nil then
        ____temp_4 = false
    end
    local charged = ____temp_4
    local radius = self:GetSpecialValueFor("radius") + meeleExtraRadius + (charged and self:GetSpecialValueFor("charged_extra_radius") or 0)
    if charged then
        ScreenShake(
            point,
            100,
            100,
            0.45,
            1000,
            0,
            true
        )
    end
    local ____self_MeeleAttack_9 = self.MeeleAttack
    local ____direction_6 = direction
    local ____origin_7 = origin
    local ____radius_8 = radius
    local ____charged_5
    if charged then
        ____charged_5 = nil
    else
        ____charged_5 = 1
    end
    ____self_MeeleAttack_9(
        self,
        {
            direction = ____direction_6,
            origin = ____origin_7,
            radius = ____radius_8,
            maxTargets = ____charged_5,
            attackType = "basic",
            effect = function(____, target)
                attackWithBaseDamage(nil, {source = self.caster, target = target})
                if not isObstacle(nil, target) and not isGem(nil, target) then
                    giveManaAndEnergyPercent(nil, self.caster, manaGainPct, true)
                end
                self:PlayEffectsOnImpact(
                    target,
                    target:GetAbsOrigin(),
                    charged
                )
            end,
            baseSound = "Hero_Juggernaut.PreAttack"
        }
    )
    self:PlayEffectsOnFinish(direction, charged, radius)
    self:PlayEffectsOnCast(charged)
end
function SpectreBasicAttack.prototype.PlayEffectsOnFinish(self, direction, charged, radius)
    local origin = self.caster:GetAbsOrigin()
    self:PlayEffectsMeele(origin, direction, radius, charged)
    if charged then
        self:PlayEffectsMeeleExplosion(origin)
        self:PlayEffectsMeeleDecorators(origin, direction, radius)
    end
end
function SpectreBasicAttack.prototype.PlayEffectsMeele(self, origin, direction, radius, charged)
    local particleId = EFX(
        "particles/spectre/spectre_basic_attack_parent.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = origin,
            cp0f = direction,
            cp3 = Vector(radius, 0, 0)
        }
    )
    ParticleManager:SetParticleControl(
        particleId,
        60,
        Vector(107, 14, 103)
    )
    ParticleManager:SetParticleControl(
        particleId,
        61,
        Vector(1, 0, 0)
    )
    if charged then
        ParticleManager:SetParticleControl(
            particleId,
            4,
            Vector(1, 0, 0)
        )
    end
    ParticleManager:ReleaseParticleIndex(particleId)
end
function SpectreBasicAttack.prototype.PlayEffectsMeeleDecorators(self, origin, direction, radius)
    local particleId = ParticleManager:CreateParticle("particles/spectre/spectre_basic_attack_charged.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, origin)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(radius, radius, radius)
    )
    ParticleManager:SetParticleControlForward(particleId, 0, direction)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function SpectreBasicAttack.prototype.PlayEffectsMeeleExplosion(self, origin)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragonform_iron_dragon.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControl(particleId, 2, origin)
    ParticleManager:SetParticleControl(particleId, 4, origin)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function SpectreBasicAttack.prototype.PlayEffectsOnCast(self, charged)
    EmitSoundOn("Hero_Spectre.PreAttack", self.caster)
    if charged then
        EmitSoundOn("Hero_Sven.Layer.GodsStrength", self.caster)
    end
end
function SpectreBasicAttack.prototype.PlayEffectsOnImpact(self, target, position, charged)
    if charged then
        EmitSoundOn("Hero_BountyHunter.Jinada", target)
        local particleId = ParticleManager:CreateParticle("particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf", PATTACH_POINT, target)
        ParticleManager:ReleaseParticleIndex(particleId)
        return
    end
    EmitSoundOn("Hero_Spectre.Attack", target)
    EFX("particles/phantom/phantom_basic_attack.vpcf", PATTACH_ABSORIGIN, target, {release = true})
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_desolate.vpcf", PATTACH_POINT, self.caster)
    ParticleManager:SetParticleControl(particleId, 0, position)
    ParticleManager:SetParticleControlForward(
        particleId,
        0,
        direction2D(
            nil,
            self.caster:GetAbsOrigin(),
            position
        )
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
SpectreBasicAttack = __TS__Decorate(
    {registerAbility(nil, "spectre_basic_attack")},
    SpectreBasicAttack
)
____exports.ModifierSpectreBasicAttack = __TS__Class()
local ModifierSpectreBasicAttack = ____exports.ModifierSpectreBasicAttack
ModifierSpectreBasicAttack.name = "ModifierSpectreBasicAttack"
__TS__ClassExtends(ModifierSpectreBasicAttack, ModifierCooldown)
function ModifierSpectreBasicAttack.prototype.____constructor(self, ...)
    ModifierCooldown.prototype.____constructor(self, ...)
    self.attackSpeedLock = lock(nil)
end
function ModifierSpectreBasicAttack.prototype.OnCreated(self)
    ModifierCooldown.prototype.OnCreated(self)
end
function ModifierSpectreBasicAttack.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT}
end
function ModifierSpectreBasicAttack.prototype.OnBasicAttackEnded(self)
    if self:GetRemainingTime() > 0 then
        return
    else
        self:StartCooldown()
    end
end
function ModifierSpectreBasicAttack.prototype.OnBasicAttackLanded(self, event)
    if self:IsCooldownReady() then
        event.target:AddNewModifier(
            self.parent,
            self.ability,
            "modifier_generic_silence",
            {duration = self:Value("silence_duration")}
        )
        if not isObstacle(nil, event.target) and not isGem(nil, event.target) then
            giveManaAndEnergyPercent(
                nil,
                self.caster,
                self:Value("mana_gain_pct"),
                true
            )
            ModifierSpectreDesolate:apply(
                event.target,
                self.parent,
                self.ability,
                {duration = self:Value("desolate_duration")}
            )
        end
        if not isObstacle(nil, event.target) and not isCountering(nil, event.target) then
            self.parent:Heal(
                self:Value("heal_charged"),
                self.ability
            )
        end
    end
end
function ModifierSpectreBasicAttack.prototype.GetModifierPreAttack_BonusDamage(self)
    if not self:IsCooldownReady() then
        return 0
    end
    return self.ability:GetSpecialValueFor("charged_damage")
end
function ModifierSpectreBasicAttack.prototype.OnAttackLanded(self, event)
    if event.attacker ~= self.parent then
        return
    end
    if ModifierSpectreDesolate:findOne(event.target) and not isObstacle(nil, event.target) then
        self.parent:Heal(
            self:Value("heal_desolate"),
            self.ability
        )
        self:PlayEffectsLifeSteal()
    end
end
function ModifierSpectreBasicAttack.prototype.GetModifierAttackPointConstant(self)
    if not self:IsCooldownReady() or not IsServer() then
        return 0
    end
    return tryLock(
        nil,
        self.attackSpeedLock,
        function() return 0.2 + self.caster:GetAttackAnimationPoint() end,
        0
    )
end
function ModifierSpectreBasicAttack.prototype.OnReplenish(self)
    replenishEFX(nil, self.parent)
    self:PlayEffectsWeapon()
end
function ModifierSpectreBasicAttack.prototype.OnCooldownStart(self)
    self:StopEffectsWeapon()
end
function ModifierSpectreBasicAttack.prototype.PlayEffectsLifeSteal(self)
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster))
end
function ModifierSpectreBasicAttack.prototype.PlayEffectsWeapon(self)
    if IsServer() then
        local origin = self.caster:GetAbsOrigin()
        self.particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_base_attack_c.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
        ParticleManager:SetParticleControlEnt(
            self.particleId,
            0,
            self.caster,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            origin,
            true
        )
        ParticleManager:SetParticleControlEnt(
            self.particleId,
            3,
            self.caster,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            origin,
            true
        )
    end
end
function ModifierSpectreBasicAttack.prototype.StopEffectsWeapon(self)
    if IsServer() and self.particleId then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierSpectreBasicAttack.prototype.GetEffectName(self)
    return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf"
end
function ModifierSpectreBasicAttack.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifierSpectreBasicAttack.prototype.GetReplenishTime(self)
    return self:Value("replenish_time")
end
ModifierSpectreBasicAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_basic_attack_cooldown"})},
    ModifierSpectreBasicAttack
)
____exports.ModifierSpectreBasicAttack = ModifierSpectreBasicAttack
local ModifierSpectreBasicAttackBuff = __TS__Class()
ModifierSpectreBasicAttackBuff.name = "ModifierSpectreBasicAttackBuff"
__TS__ClassExtends(ModifierSpectreBasicAttackBuff, CustomModifier)
ModifierSpectreBasicAttackBuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_basic_attack_attack"})},
    ModifierSpectreBasicAttackBuff
)
ModifierSpectreDesolate = __TS__Class()
ModifierSpectreDesolate.name = "ModifierSpectreDesolate"
__TS__ClassExtends(ModifierSpectreDesolate, CustomModifier)
function ModifierSpectreDesolate.prototype.IsDebuff(self)
    return true
end
function ModifierSpectreDesolate.prototype.IsHidden(self)
    return false
end
function ModifierSpectreDesolate.prototype.IsPurgable(self)
    return true
end
function ModifierSpectreDesolate.prototype.GetEffectName(self)
    return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
end
function ModifierSpectreDesolate.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifierSpectreDesolate.prototype.GetTexture(self)
    return "spectre_desolate_modifier"
end
ModifierSpectreDesolate = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_spectre_desolate_custom"})},
    ModifierSpectreDesolate
)
return ____exports
