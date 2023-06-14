local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 127,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 2,["17"] = 2,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 6,["23"] = 6,["24"] = 7,["25"] = 7,["26"] = 7,["27"] = 7,["28"] = 8,["29"] = 8,["30"] = 9,["31"] = 9,["32"] = 10,["33"] = 10,["34"] = 10,["35"] = 12,["36"] = 12,["37"] = 13,["38"] = 14,["39"] = 15,["40"] = 16,["41"] = 17,["43"] = 20,["44"] = 21,["45"] = 22,["47"] = 14,["48"] = 13,["49"] = 12,["50"] = 13,["52"] = 40,["53"] = 40,["54"] = 41,["55"] = 42,["56"] = 43,["57"] = 44,["58"] = 45,["59"] = 46,["60"] = 47,["61"] = 49,["62"] = 50,["63"] = 54,["64"] = 63,["65"] = 72,["66"] = 73,["67"] = 42,["68"] = 41,["69"] = 40,["70"] = 41,["72"] = 80,["73"] = 80,["74"] = 81,["75"] = 82,["76"] = 83,["77"] = 85,["78"] = 90,["79"] = 82,["80"] = 98,["81"] = 99,["82"] = 100,["83"] = 101,["84"] = 110,["85"] = 98,["86"] = 81,["87"] = 80,["88"] = 81,["90"] = 126,["91"] = 126,["92"] = 127,["93"] = 128,["94"] = 129,["95"] = 128,["96"] = 132,["97"] = 133,["98"] = 132,["99"] = 136,["100"] = 137,["101"] = 136,["102"] = 140,["103"] = 141,["104"] = 140,["105"] = 144,["106"] = 145,["107"] = 146,["108"] = 147,["109"] = 148,["110"] = 149,["111"] = 150,["112"] = 151,["113"] = 153,["114"] = 154,["115"] = 155,["116"] = 156,["117"] = 158,["118"] = 158,["120"] = 160,["121"] = 160,["122"] = 160,["123"] = 160,["124"] = 160,["125"] = 160,["126"] = 166,["127"] = 167,["128"] = 167,["129"] = 160,["130"] = 168,["131"] = 169,["132"] = 176,["133"] = 177,["134"] = 178,["137"] = 182,["138"] = 160,["139"] = 184,["140"] = 185,["141"] = 160,["142"] = 160,["143"] = 188,["144"] = 144,["145"] = 191,["146"] = 192,["147"] = 193,["148"] = 194,["149"] = 195,["150"] = 196,["151"] = 191,["152"] = 127,["153"] = 126,["154"] = 127,["156"] = 203,["157"] = 203,["158"] = 204,["159"] = 207,["160"] = 208,["161"] = 207,["162"] = 211,["163"] = 212,["164"] = 211,["165"] = 215,["166"] = 216,["167"] = 215,["168"] = 219,["169"] = 204,["170"] = 221,["171"] = 222,["173"] = 219,["174"] = 231,["175"] = 204,["176"] = 233,["177"] = 234,["178"] = 235,["179"] = 235,["180"] = 235,["181"] = 235,["182"] = 239,["183"] = 239,["184"] = 239,["185"] = 235,["186"] = 235,["188"] = 231,["189"] = 247,["190"] = 204,["192"] = 248,["193"] = 247,["194"] = 251,["195"] = 252,["196"] = 251,["197"] = 255,["198"] = 256,["199"] = 255,["200"] = 259,["201"] = 260,["202"] = 259,["203"] = 204,["204"] = 203,["205"] = 204,["207"] = 267,["208"] = 267,["209"] = 268,["210"] = 269,["211"] = 270,["212"] = 271,["213"] = 272,["214"] = 273,["215"] = 274,["216"] = 274,["218"] = 276,["221"] = 269,["222"] = 281,["223"] = 282,["224"] = 281,["225"] = 285,["226"] = 286,["227"] = 285,["228"] = 289,["229"] = 290,["230"] = 289,["231"] = 293,["232"] = 294,["233"] = 293,["234"] = 297,["235"] = 298,["236"] = 297,["237"] = 268,["238"] = 267,["239"] = 268,["241"] = 302,["242"] = 302,["243"] = 303,["244"] = 303,["245"] = 302,["246"] = 303,["248"] = 308,["249"] = 308,["250"] = 309,["251"] = 310,["252"] = 311,["253"] = 310,["254"] = 314,["255"] = 315,["256"] = 314,["257"] = 318,["258"] = 319,["259"] = 318,["260"] = 309,["261"] = 308,["262"] = 309,["264"] = 323,["265"] = 323,["266"] = 324,["267"] = 325,["268"] = 326,["269"] = 325,["270"] = 331,["271"] = 324,["272"] = 334,["273"] = 335,["274"] = 340,["276"] = 331,["277"] = 344,["278"] = 345,["279"] = 346,["280"] = 347,["282"] = 350,["283"] = 350,["284"] = 350,["285"] = 350,["286"] = 350,["287"] = 350,["288"] = 351,["289"] = 354,["290"] = 355,["291"] = 356,["292"] = 357,["295"] = 360,["297"] = 363,["298"] = 344,["299"] = 366,["300"] = 367,["301"] = 368,["303"] = 366,["304"] = 381,["305"] = 381,["306"] = 405,["307"] = 324,["309"] = 406,["310"] = 405,["311"] = 414,["312"] = 415,["313"] = 414,["314"] = 418,["315"] = 419,["316"] = 418,["317"] = 324,["318"] = 323,["319"] = 324,["321"] = 423,["322"] = 423,["323"] = 424,["324"] = 425,["325"] = 424,["326"] = 427,["327"] = 428,["329"] = 425,["330"] = 432,["331"] = 424,["332"] = 434,["333"] = 435,["334"] = 436,["335"] = 436,["336"] = 436,["337"] = 436,["338"] = 436,["339"] = 437,["340"] = 437,["341"] = 436,["342"] = 436,["343"] = 439,["344"] = 441,["345"] = 442,["346"] = 443,["347"] = 443,["348"] = 443,["349"] = 443,["351"] = 446,["352"] = 447,["354"] = 450,["355"] = 451,["356"] = 451,["357"] = 451,["358"] = 451,["359"] = 451,["360"] = 451,["361"] = 451,["362"] = 451,["363"] = 451,["364"] = 451,["366"] = 457,["367"] = 457,["368"] = 457,["369"] = 457,["370"] = 457,["371"] = 457,["372"] = 458,["374"] = 432,["375"] = 462,["376"] = 463,["377"] = 464,["378"] = 464,["379"] = 464,["380"] = 464,["381"] = 468,["382"] = 468,["383"] = 468,["384"] = 468,["385"] = 464,["386"] = 464,["387"] = 462,["388"] = 476,["389"] = 477,["390"] = 478,["391"] = 478,["392"] = 478,["393"] = 478,["394"] = 482,["395"] = 482,["396"] = 482,["397"] = 478,["398"] = 478,["399"] = 476,["400"] = 489,["401"] = 490,["402"] = 490,["403"] = 424,["404"] = 490,["405"] = 490,["406"] = 489,["407"] = 424,["408"] = 423,["409"] = 424});
local ____exports = {}
local PhantomExCounterRecast, ModifierPhantomExCounterRecast, ModifierPhantomCounterBuff, ModifierPhantomCounterShield, ModifierPhantomCounter, ModifierPhantomCounterBanish
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ____modifier_counter = require("modifiers.modifier_counter")
local ModifierCounter = ____modifier_counter.ModifierCounter
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____modifier_shield = require("modifiers.modifier_shield")
local ModifierShield = ____modifier_shield.ModifierShield
local ____util = require("util")
local clampPosition = ____util.clampPosition
local direction2D = ____util.direction2D
local isObstacle = ____util.isObstacle
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____phantom_basic_attack = require("abilities.heroes.phantom.phantom_basic_attack")
local ModifierPhantomStacks = ____phantom_basic_attack.ModifierPhantomStacks
local PhantomBasicAttack = ____phantom_basic_attack.PhantomBasicAttack
local PhantomCounter = __TS__Class()
PhantomCounter.name = "PhantomCounter"
__TS__ClassExtends(PhantomCounter, CustomAbility)
function PhantomCounter.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("counter_duration")
    if self.caster:HasModifier("modifier_upgrade_phantom_strike_instant") then
        duration = duration / 2
    end
    local modifier = ModifierPhantomCounter:apply(self.caster, self.caster, self, {duration = duration})
    if modifier and self.caster:HasModifier("modifier_upgrade_phantom_strike_instant") then
        modifier:OnHit({triggerCounters = true, attackCategory = "single", source = self.caster})
    end
end
PhantomCounter = __TS__Decorate(
    {registerAbility(nil, "phantom_counter")},
    PhantomCounter
)
local PhantomCounterRecast = __TS__Class()
PhantomCounterRecast.name = "PhantomCounterRecast"
__TS__ClassExtends(PhantomCounterRecast, CustomAbility)
function PhantomCounterRecast.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local phantomCounter = PhantomCounter:findOne(self.caster)
    local duration = phantomCounter and phantomCounter:GetSpecialValueFor("buff_duration") or 0
    local shield = phantomCounter and phantomCounter:GetSpecialValueFor("shield") or 0
    local shieldDuration = phantomCounter and phantomCounter:GetSpecialValueFor("shield_duration") or 0
    ModifierPhantomCounterBuff:apply(self.caster, self.caster, self, {duration = duration})
    ModifierPhantomCounterShield:apply(self.caster, self.caster, nil, {duration = shieldDuration, damageBlock = shield})
    EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {cp3 = origin, release = true})
    EFX("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {cp3 = origin, release = true})
    EmitSoundOn("Hero_Sven.GodsStrength.Attack", self.caster)
    EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", self.caster)
end
PhantomCounterRecast = __TS__Decorate(
    {registerAbility(nil, "phantom_counter_recast")},
    PhantomCounterRecast
)
local PhantomExCounter = __TS__Class()
PhantomExCounter.name = "PhantomExCounter"
__TS__ClassExtends(PhantomExCounter, CustomAbility)
function PhantomExCounter.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    ModifierPhantomExCounterRecast:apply(self.caster, self.caster, self, {abilityLeft = PhantomExCounter.name, abilityRight = PhantomExCounterRecast.name, duration = duration})
    self:PlayEffectsOnCast()
end
function PhantomExCounter.prototype.PlayEffectsOnCast(self)
    local origin = self.caster:GetAbsOrigin()
    EmitSoundOn("Hero_PhantomAssassin.Blur.Break", self.caster)
    EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster, {cp3 = origin, release = true})
    EFX("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = origin, cp3 = origin, release = true})
end
PhantomExCounter = __TS__Decorate(
    {registerAbility(nil, "phantom_ex_counter")},
    PhantomExCounter
)
PhantomExCounterRecast = __TS__Class()
PhantomExCounterRecast.name = "PhantomExCounterRecast"
__TS__ClassExtends(PhantomExCounterRecast, CustomAbility)
function PhantomExCounterRecast.prototype.GetAnimation(self)
    return ACT_DOTA_TELEPORT_END
end
function PhantomExCounterRecast.prototype.GetPlaybackRateOverride(self)
    return 2
end
function PhantomExCounterRecast.prototype.GetCastingCrawl(self)
    return 80
end
function PhantomExCounterRecast.prototype.GetFadeGestureOnCast(self)
    return false
end
function PhantomExCounterRecast.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local projectileSpeed = self:GetSpecialValueFor("projectile_speed")
    local projectileDirection = direction2D(nil, origin, point)
    local damage = self:GetSpecialValueFor("ability_damage")
    local modifier = ModifierPhantomStacks:findOne(self.caster)
    local stacks = modifier and modifier:GetStackCount() or 0
    local phantomBasicAttack = PhantomBasicAttack:findOne(self.caster)
    local phantomExCounter = PhantomExCounter:findOne(self.caster)
    local durationPerStack = phantomExCounter and phantomExCounter:GetSpecialValueFor("duration_per_stack") or 0
    local sleepDuration = (phantomExCounter and phantomExCounter:GetSpecialValueFor("sleep_duration") or 0) + durationPerStack * stacks
    if modifier ~= nil then
        modifier:Destroy()
    end
    self:ProjectileAttack({
        source = self.caster,
        effectName = "particles/phantom/phantom_counter_recast.vpcf",
        spawnOrigin = origin:__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
        velocity = projectileDirection:__mul(projectileSpeed),
        groundOffset = 0,
        unitTest = function(____, unit, projectile) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(
            projectile:getSource(),
            unit
        ) end,
        onUnitHit = function(____, unit, projectile)
            ApplyDamage({victim = unit, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
            if projectile:getSource() == self.caster then
                if not isObstacle(nil, unit) and phantomBasicAttack then
                    ModifierPhantomStacks:apply(self.caster, self.caster, phantomBasicAttack, {})
                end
            end
            unit:AddNewModifier(self.caster, self, "modifier_generic_sleep", {duration = sleepDuration})
        end,
        onFinish = function(____, projectile)
            self:PlayEffectsOnFinish(projectile:getPosition())
        end
    })
    EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self.caster)
end
function PhantomExCounterRecast.prototype.PlayEffectsOnFinish(self, position)
    EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", self.caster)
    local particle_cast = "particles/phantom/phantom_special_attack_explosion.vpcf"
    local particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 3, position)
    ParticleManager:ReleaseParticleIndex(particleId)
end
PhantomExCounterRecast = __TS__Decorate(
    {registerAbility(nil, "phantom_ex_counter_recast")},
    PhantomExCounterRecast
)
ModifierPhantomExCounterRecast = __TS__Class()
ModifierPhantomExCounterRecast.name = "ModifierPhantomExCounterRecast"
__TS__ClassExtends(ModifierPhantomExCounterRecast, ModifierRecast)
function ModifierPhantomExCounterRecast.prototype.IsHidden(self)
    return false
end
function ModifierPhantomExCounterRecast.prototype.IsDebuff(self)
    return false
end
function ModifierPhantomExCounterRecast.prototype.IsPurgable(self)
    return true
end
function ModifierPhantomExCounterRecast.prototype.OnCreated(self, params)
    ModifierRecast.prototype.OnCreated(self, params)
    if IsServer() then
        self.particleId = EFX("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {})
    end
end
function ModifierPhantomExCounterRecast.prototype.OnDestroy(self)
    ModifierRecast.prototype.OnDestroy(self)
    if IsServer() then
        DEFX(self.particleId, false)
        EFX(
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self.parent,
            {
                cp3 = self.parent:GetAbsOrigin(),
                release = true
            }
        )
    end
end
function ModifierPhantomExCounterRecast.prototype.DeclareFunctions(self)
    local ____array_14 = __TS__SparseArrayNew(unpack(ModifierRecast.prototype.DeclareFunctions(self)))
    __TS__SparseArrayPush(____array_14, MODIFIER_PROPERTY_INVISIBILITY_LEVEL, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE)
    return {__TS__SparseArraySpread(____array_14)}
end
function ModifierPhantomExCounterRecast.prototype.GetModifierInvisibilityLevel(self)
    return 2
end
function ModifierPhantomExCounterRecast.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:Value("speed_buff_pct")
end
function ModifierPhantomExCounterRecast.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVISIBLE] = true, [MODIFIER_STATE_TRUESIGHT_IMMUNE] = false}
end
ModifierPhantomExCounterRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_ex_counter_recast"})},
    ModifierPhantomExCounterRecast
)
ModifierPhantomCounterBuff = __TS__Class()
ModifierPhantomCounterBuff.name = "ModifierPhantomCounterBuff"
__TS__ClassExtends(ModifierPhantomCounterBuff, CustomModifier)
function ModifierPhantomCounterBuff.prototype.OnCreated(self)
    if IsServer() then
        if self.parent:HasModifier("modifier_upgrade_phantom_countering_stacks") then
            local modifier = ModifierPhantomStacks:findOne(self.parent)
            local stacks = modifier and modifier:GetStackCount() or 0
            if modifier ~= nil then
                modifier:Destroy()
            end
            self:SetStackCount(stacks / 2 * self.parent:GetAverageTrueAttackDamage(self.parent))
        end
    end
end
function ModifierPhantomCounterBuff.prototype.GetModifierAttackSpeedBonus_Constant(self)
    return self:Value("as_speed")
end
function ModifierPhantomCounterBuff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
end
function ModifierPhantomCounterBuff.prototype.GetModifierPreAttack_BonusDamage(self)
    return self:GetStackCount()
end
function ModifierPhantomCounterBuff.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function ModifierPhantomCounterBuff.prototype.GetStatusEffectName(self)
    return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end
ModifierPhantomCounterBuff = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_counter"})},
    ModifierPhantomCounterBuff
)
ModifierPhantomCounterShield = __TS__Class()
ModifierPhantomCounterShield.name = "ModifierPhantomCounterShield"
__TS__ClassExtends(ModifierPhantomCounterShield, ModifierShield)
ModifierPhantomCounterShield = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_counter_shield"})},
    ModifierPhantomCounterShield
)
local ModifierPhantomCounterRecast = __TS__Class()
ModifierPhantomCounterRecast.name = "ModifierPhantomCounterRecast"
__TS__ClassExtends(ModifierPhantomCounterRecast, ModifierRecast)
function ModifierPhantomCounterRecast.prototype.IsHidden(self)
    return false
end
function ModifierPhantomCounterRecast.prototype.IsDebuff(self)
    return false
end
function ModifierPhantomCounterRecast.prototype.IsPurgable(self)
    return true
end
ModifierPhantomCounterRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_counter_recast"})},
    ModifierPhantomCounterRecast
)
ModifierPhantomCounter = __TS__Class()
ModifierPhantomCounter.name = "ModifierPhantomCounter"
__TS__ClassExtends(ModifierPhantomCounter, ModifierCounter)
function ModifierPhantomCounter.prototype.GetBanishDuration(self)
    return self.parent:HasModifier("modifier_upgrade_phantom_strike_instant") and self:Value("banish_duration") / 2 or self:Value("banish_duration")
end
function ModifierPhantomCounter.prototype.OnDestroy(self)
    ModifierCounter.prototype.OnDestroy(self)
    if IsServer() then
        local particleId = ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function ModifierPhantomCounter.prototype.OnHit(self, event)
    if IsServer() then
        if not event.triggerCounters then
            return true
        end
        ModifierPhantomCounterBanish:apply(
            self.parent,
            self.parent,
            self.ability,
            {duration = self:GetBanishDuration()}
        )
        self:Destroy()
        if event.attackCategory == "projectile" then
            local projectile = event.projectile
            if projectile:getIsDestructible() then
                projectile:scheduleDestroy()
            end
        end
        return false
    end
    return true
end
function ModifierPhantomCounter.prototype.AfterHit(self)
    if IsServer() then
        self:Destroy()
    end
end
function ModifierPhantomCounter.prototype.OnOrder(self, params)
end
function ModifierPhantomCounter.prototype.DeclareFunctions(self)
    local ____array_19 = __TS__SparseArrayNew(unpack(ModifierCounter.prototype.DeclareFunctions(self)))
    __TS__SparseArrayPush(____array_19, MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE, MODIFIER_EVENT_ON_ORDER)
    return {__TS__SparseArraySpread(____array_19)}
end
function ModifierPhantomCounter.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_CAST_ABILITY_3
end
function ModifierPhantomCounter.prototype.GetOverrideAnimationRate(self)
    return 0.4
end
ModifierPhantomCounter = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_counter_countering"})},
    ModifierPhantomCounter
)
ModifierPhantomCounterBanish = __TS__Class()
ModifierPhantomCounterBanish.name = "ModifierPhantomCounterBanish"
__TS__ClassExtends(ModifierPhantomCounterBanish, ModifierBanish)
function ModifierPhantomCounterBanish.prototype.OnCreated(self)
    ModifierBanish.prototype.OnCreated(self)
    if IsServer() then
        self:PlayEffectsOnCreated()
    end
end
function ModifierPhantomCounterBanish.prototype.OnDestroy(self)
    ModifierBanish.prototype.OnDestroy(self)
    if IsServer() then
        local cursor = CustomAbilitiesLegacy:GetCursorPosition(self.ability)
        local point = clampPosition(
            nil,
            self.parent:GetAbsOrigin(),
            cursor,
            {maxRange = self.ability:GetCastRange(
                Vector(0, 0, 0),
                nil
            )}
        )
        local phantomBasicAttack = PhantomBasicAttack:findOne(self.parent)
        FindClearSpaceForUnit(self.parent, point, true)
        if not self.parent:HasModifier("modifier_upgrade_phantom_strike_instant") then
            self.parent:Heal(
                self:Value("heal"),
                self.ability
            )
        end
        if phantomBasicAttack then
            phantomBasicAttack:TryThrowKnives("modifier_upgrade_phantom_strike_knives")
        end
        if self.ability:GetLevel() >= 2 then
            ModifierPhantomCounterRecast:apply(
                self.parent,
                self.parent,
                self.ability,
                {
                    abilityLeft = PhantomCounter.name,
                    abilityRight = PhantomCounterRecast.name,
                    duration = self:Value("buff_duration")
                }
            )
        end
        ModifierPhantomCounterBuff:apply(
            self.parent,
            self.parent,
            self.ability,
            {duration = self:Value("buff_duration")}
        )
        self:PlayEffectsOnCast()
    end
end
function ModifierPhantomCounterBanish.prototype.PlayEffectsOnCreated(self)
    EmitSoundOn("Hero_PhantomAssassin.Blur", self.parent)
    EFX(
        "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = self.parent:GetAbsOrigin(),
            cp3 = self.parent:GetAbsOrigin(),
            release = true
        }
    )
end
function ModifierPhantomCounterBanish.prototype.PlayEffectsOnCast(self)
    EmitSoundOn("Hero_PhantomAssassin.Blur.Break", self.parent)
    EFX(
        "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.parent,
        {
            cp3 = self.parent:GetAbsOrigin(),
            release = true
        }
    )
end
function ModifierPhantomCounterBanish.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierBanish.prototype.CheckState(self),
        {[MODIFIER_STATE_COMMAND_RESTRICTED] = true}
    )
end
ModifierPhantomCounterBanish = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_phantom_counter_banish"})},
    ModifierPhantomCounterBanish
)
return ____exports
