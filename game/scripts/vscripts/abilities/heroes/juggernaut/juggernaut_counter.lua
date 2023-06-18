local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 24,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 2,["17"] = 2,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 6,["23"] = 6,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 6,["28"] = 7,["29"] = 7,["30"] = 8,["31"] = 8,["32"] = 10,["33"] = 10,["34"] = 11,["35"] = 12,["36"] = 13,["37"] = 14,["38"] = 12,["39"] = 11,["40"] = 10,["41"] = 11,["43"] = 23,["44"] = 23,["45"] = 24,["46"] = 25,["47"] = 24,["48"] = 28,["49"] = 29,["50"] = 30,["52"] = 25,["53"] = 40,["54"] = 41,["55"] = 42,["56"] = 43,["58"] = 46,["59"] = 48,["60"] = 48,["61"] = 48,["62"] = 48,["63"] = 48,["64"] = 48,["65"] = 48,["66"] = 48,["67"] = 48,["68"] = 48,["69"] = 48,["70"] = 55,["71"] = 56,["72"] = 58,["73"] = 59,["74"] = 60,["75"] = 60,["76"] = 60,["77"] = 60,["78"] = 61,["79"] = 63,["81"] = 66,["82"] = 67,["86"] = 71,["88"] = 74,["89"] = 40,["90"] = 77,["91"] = 78,["92"] = 79,["94"] = 77,["95"] = 83,["96"] = 84,["97"] = 86,["98"] = 83,["99"] = 95,["100"] = 24,["102"] = 96,["103"] = 95,["104"] = 99,["105"] = 100,["106"] = 99,["107"] = 103,["108"] = 104,["109"] = 103,["110"] = 24,["111"] = 23,["112"] = 24,["114"] = 108,["115"] = 108,["116"] = 109,["117"] = 110,["118"] = 111,["119"] = 110,["120"] = 114,["121"] = 115,["122"] = 114,["123"] = 109,["124"] = 108,["125"] = 109,["127"] = 119,["128"] = 119,["129"] = 119,["130"] = 120,["131"] = 121,["132"] = 122,["133"] = 123,["134"] = 125,["135"] = 125,["136"] = 125,["137"] = 125,["138"] = 125,["139"] = 125,["140"] = 125,["141"] = 125,["142"] = 125,["143"] = 135,["144"] = 136,["145"] = 136,["146"] = 138,["147"] = 139,["148"] = 145,["149"] = 136,["150"] = 136,["152"] = 150,["153"] = 151,["154"] = 120,["155"] = 156,["156"] = 157,["157"] = 158,["158"] = 160,["159"] = 156,["160"] = 167,["161"] = 168,["162"] = 169,["163"] = 170,["164"] = 167,["165"] = 174,["166"] = 174,["167"] = 175,["168"] = 180,["169"] = 181,["170"] = 182,["171"] = 183,["172"] = 184,["173"] = 184,["174"] = 184,["175"] = 184,["176"] = 184,["177"] = 184,["178"] = 184,["179"] = 184,["180"] = 184,["181"] = 184,["182"] = 184,["183"] = 184,["184"] = 185,["185"] = 186,["186"] = 188,["187"] = 180,["188"] = 195,["189"] = 196,["190"] = 196,["191"] = 196,["192"] = 196,["193"] = 197,["194"] = 199,["195"] = 200,["196"] = 201,["198"] = 203,["199"] = 203,["200"] = 203,["201"] = 203,["204"] = 195,["205"] = 175,["206"] = 174,["207"] = 175,["209"] = 213,["210"] = 213,["211"] = 214,["212"] = 215,["213"] = 216,["214"] = 215,["215"] = 219,["216"] = 220,["217"] = 219,["218"] = 223,["219"] = 224,["220"] = 223,["221"] = 227,["222"] = 228,["223"] = 227,["224"] = 231,["225"] = 232,["226"] = 233,["227"] = 234,["228"] = 235,["229"] = 235,["230"] = 235,["231"] = 235,["232"] = 235,["233"] = 235,["234"] = 235,["235"] = 235,["236"] = 235,["237"] = 235,["238"] = 235,["239"] = 235,["240"] = 236,["241"] = 238,["242"] = 239,["243"] = 239,["244"] = 239,["245"] = 239,["246"] = 239,["247"] = 239,["248"] = 239,["249"] = 239,["250"] = 239,["251"] = 239,["253"] = 245,["254"] = 231,["255"] = 249,["256"] = 250,["257"] = 251,["259"] = 214,["260"] = 249,["261"] = 256,["262"] = 257,["263"] = 257,["264"] = 257,["265"] = 257,["266"] = 258,["267"] = 260,["268"] = 261,["269"] = 262,["271"] = 264,["272"] = 264,["273"] = 264,["274"] = 264,["277"] = 268,["278"] = 269,["279"] = 270,["280"] = 256,["281"] = 214,["282"] = 213,["283"] = 214,["285"] = 277,["286"] = 277,["287"] = 278,["288"] = 279,["289"] = 280,["290"] = 279,["291"] = 283,["292"] = 284,["293"] = 283,["294"] = 278,["295"] = 277,["296"] = 278,["298"] = 288,["299"] = 288,["300"] = 289,["302"] = 289,["303"] = 290,["304"] = 288,["305"] = 292,["306"] = 293,["307"] = 292,["308"] = 296,["309"] = 297,["310"] = 296,["311"] = 300,["312"] = 301,["313"] = 302,["315"] = 300,["316"] = 306,["317"] = 307,["318"] = 308,["319"] = 308,["320"] = 308,["321"] = 308,["322"] = 308,["323"] = 308,["325"] = 306,["326"] = 312,["327"] = 313,["328"] = 312,["329"] = 316,["330"] = 317,["331"] = 316,["332"] = 320,["333"] = 321,["334"] = 320,["335"] = 326,["336"] = 327,["337"] = 326,["338"] = 330,["339"] = 331,["340"] = 330,["341"] = 289,["342"] = 288,["343"] = 289});
local ____exports = {}
local ModifierJuggernautCounter, ModifierJuggernautCounterRecast, JuggernautCounterRecast, ModifierJuggernautExCounterRecast, ModifierJuggernautSwiftness
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____modifier_counter = require("modifiers.modifier_counter")
local ModifierCounter = ____modifier_counter.ModifierCounter
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____util = require("util")
local clamp = ____util.clamp
local clampPosition = ____util.clampPosition
local isCountering = ____util.isCountering
local isObstacle = ____util.isObstacle
local strongPurge = ____util.strongPurge
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local JuggernautCounter = __TS__Class()
JuggernautCounter.name = "JuggernautCounter"
__TS__ClassExtends(JuggernautCounter, CustomAbility)
function JuggernautCounter.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("counter_duration")
    ModifierJuggernautCounter:apply(self.caster, self.caster, nil, {duration = duration})
end
JuggernautCounter = __TS__Decorate(
    {registerAbility(nil, "juggernaut_counter")},
    JuggernautCounter
)
ModifierJuggernautCounter = __TS__Class()
ModifierJuggernautCounter.name = "ModifierJuggernautCounter"
__TS__ClassExtends(ModifierJuggernautCounter, ModifierCounter)
function ModifierJuggernautCounter.prototype.OnDestroy(self)
    ModifierCounter.prototype.OnDestroy(self)
    if IsServer() then
        EmitSoundOn("Hero_Juggernaut.Attack", self.caster)
        ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent))
    end
end
function ModifierJuggernautCounter.prototype.OnHit(self, event)
    if IsServer() then
        if not event.triggerCounters then
            return true
        end
        local juggernautCounter = JuggernautCounter:findOne(self.parent)
        ModifierJuggernautCounterRecast:apply(
            self.parent,
            self.parent,
            nil,
            {
                abilityLeft = JuggernautCounter.name,
                abilityRight = JuggernautCounterRecast.name,
                charges = juggernautCounter and juggernautCounter:GetSpecialValueFor("recasts") or 0,
                duration = juggernautCounter and juggernautCounter:GetSpecialValueFor("recast_time") or 0
            }
        )
        strongPurge(nil, self.parent)
        self:PlayEffectsOnTrigger()
        if event.attackCategory == "projectile" then
            if event.projectile:getIsReflectable() then
                event.projectile:setVelocity(
                    event.projectile:getVelocity():__mul(-1.2),
                    event.projectile:getPosition()
                )
                event.projectile:setSource(self.parent)
                event.projectile:resetDistanceTraveled()
            else
                if event.projectile:getIsDestructible() then
                    event.projectile:scheduleDestroy()
                end
            end
        end
        return false
    end
    return false
end
function ModifierJuggernautCounter.prototype.AfterHit(self)
    if IsServer() then
        self:Destroy()
    end
end
function ModifierJuggernautCounter.prototype.PlayEffectsOnTrigger(self)
    EmitSoundOn("juggernaut_jug_ability_bladefury_05", self.parent)
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent))
end
function ModifierJuggernautCounter.prototype.DeclareFunctions(self)
    local ____array_4 = __TS__SparseArrayNew(unpack(ModifierCounter.prototype.DeclareFunctions(self)))
    __TS__SparseArrayPush(____array_4, MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE)
    return {__TS__SparseArraySpread(____array_4)}
end
function ModifierJuggernautCounter.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_SPAWN
end
function ModifierJuggernautCounter.prototype.GetOverrideAnimationRate(self)
    return 0.1
end
ModifierJuggernautCounter = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_counter_countering"})},
    ModifierJuggernautCounter
)
ModifierJuggernautCounterRecast = __TS__Class()
ModifierJuggernautCounterRecast.name = "ModifierJuggernautCounterRecast"
__TS__ClassExtends(ModifierJuggernautCounterRecast, ModifierRecast)
function ModifierJuggernautCounterRecast.prototype.GetEffectName(self)
    return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end
function ModifierJuggernautCounterRecast.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierJuggernautCounterRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_counter_recast"})},
    ModifierJuggernautCounterRecast
)
local JuggernautSlash = __TS__Class()
JuggernautSlash.name = "JuggernautSlash"
__TS__ClassExtends(JuggernautSlash, CustomAbility)
function JuggernautSlash.prototype.Slash(self, point, damage, particle)
    local from = self.caster:GetAbsOrigin()
    FindClearSpaceForUnit(self.caster, point, true)
    local to = self.caster:GetAbsOrigin()
    local enemies = CustomEntitiesLegacy:FindUnitsInLine(
        self.caster,
        to,
        from,
        100,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE
    )
    for ____, enemy in ipairs(enemies) do
        self:SingleAttack({
            target = enemy,
            effect = function(____, target)
                ApplyDamage({victim = target, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
                self:PlayEffectsOnTarget(target)
            end
        })
    end
    self:OnSlashEnded(enemies)
    self:PlayEffectsOnSlash(from, to, particle)
end
function JuggernautSlash.prototype.PlayEffectsOnSlash(self, from, to, particle)
    EmitSoundOn("Hero_Juggernaut.BladeDance", self.caster)
    EmitSoundOn("Hero_Juggernaut.Attack", self.caster)
    EFX(particle, PATTACH_WORLDORIGIN, nil, {cp0 = from, cp1 = to, release = true})
end
function JuggernautSlash.prototype.PlayEffectsOnTarget(self, target)
    EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", target)
    EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", target)
    EmitSoundOn("Hero_Juggernaut.Attack", target)
end
JuggernautCounterRecast = __TS__Class()
JuggernautCounterRecast.name = "JuggernautCounterRecast"
__TS__ClassExtends(JuggernautCounterRecast, JuggernautSlash)
function JuggernautCounterRecast.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local minRange = self:GetSpecialValueFor("min_range")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {
            maxRange = self:GetCastRange(
                Vector(0, 0, 0),
                nil
            ),
            minRange = minRange
        }
    )
    local juggernautCounter = JuggernautCounter:findOne(self.caster)
    local damage = juggernautCounter and juggernautCounter:GetSpecialValueFor("ability_damage") or 0
    self:Slash(point, damage, "particles/juggernaut/juggernaut_counter_recast.vpcf")
end
function JuggernautCounterRecast.prototype.OnSlashEnded(self, targets)
    local validTargets = #__TS__ArrayFilter(
        targets,
        function(____, target) return not isObstacle(nil, target) and not isCountering(nil, target) end
    )
    local modifier = ModifierJuggernautCounterRecast:findOne(self.caster)
    if modifier then
        if validTargets <= 0 then
            modifier:Destroy()
        else
            modifier:SetDuration(
                modifier:GetDuration(),
                true
            )
        end
    end
end
JuggernautCounterRecast = __TS__Decorate(
    {registerAbility(nil, "juggernaut_counter_recast")},
    JuggernautCounterRecast
)
local JuggernautExCounter = __TS__Class()
JuggernautExCounter.name = "JuggernautExCounter"
__TS__ClassExtends(JuggernautExCounter, JuggernautSlash)
function JuggernautExCounter.prototype.GetAnimation(self)
    return ACT_DOTA_TAUNT
end
function JuggernautExCounter.prototype.GetPlaybackRateOverride(self)
    return 2
end
function JuggernautExCounter.prototype.GetCastingCrawl(self)
    return 10
end
function JuggernautExCounter.prototype.GetAnimationTranslate(self)
    return Translate.odachi
end
function JuggernautExCounter.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local minRange = self:GetSpecialValueFor("min_range")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {
            maxRange = self:GetCastRange(
                Vector(0, 0, 0),
                nil
            ),
            minRange = minRange
        }
    )
    local damage = self:GetSpecialValueFor("ability_damage") or 0
    if not ModifierJuggernautExCounterRecast:findOne(self.caster) then
        ModifierJuggernautExCounterRecast:apply(
            self.caster,
            self.caster,
            nil,
            {
                abilityLeft = JuggernautExCounter.name,
                charges = self:GetSpecialValueFor("recasts"),
                duration = self:GetSpecialValueFor("recast_time")
            }
        )
    end
    self:Slash(point, damage, "particles/juggernaut/juggernaut_ex_counter.vpcf")
end
function JuggernautExCounter.prototype.GetManaCost(self, level)
    if IsServer() and ModifierJuggernautExCounterRecast:findOne(self.caster) then
        return 0
    end
    return JuggernautSlash.prototype.GetManaCost(self, level)
end
function JuggernautExCounter.prototype.OnSlashEnded(self, targets)
    local validTargets = #__TS__ArrayFilter(
        targets,
        function(____, target) return not isObstacle(nil, target) and not isCountering(nil, target) end
    )
    local modifier = ModifierJuggernautExCounterRecast:findOne(self.caster)
    if modifier then
        if validTargets <= 0 then
            modifier:Destroy()
        else
            modifier:SetDuration(
                modifier:GetDuration(),
                true
            )
        end
    end
    local swiftnessDuration = self:GetSpecialValueFor("swiftness_duration")
    local swiftnessPct = self:GetSpecialValueFor("swiftness_pct")
    ModifierJuggernautSwiftness:apply(self.caster, self.caster, nil, {swiftnessPct = swiftnessPct * validTargets, duration = swiftnessDuration})
end
JuggernautExCounter = __TS__Decorate(
    {registerAbility(nil, "juggernaut_ex_counter")},
    JuggernautExCounter
)
ModifierJuggernautExCounterRecast = __TS__Class()
ModifierJuggernautExCounterRecast.name = "ModifierJuggernautExCounterRecast"
__TS__ClassExtends(ModifierJuggernautExCounterRecast, ModifierRecast)
function ModifierJuggernautExCounterRecast.prototype.GetEffectName(self)
    return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end
function ModifierJuggernautExCounterRecast.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
ModifierJuggernautExCounterRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_ex_counter_recast"})},
    ModifierJuggernautExCounterRecast
)
ModifierJuggernautSwiftness = __TS__Class()
ModifierJuggernautSwiftness.name = "ModifierJuggernautSwiftness"
__TS__ClassExtends(ModifierJuggernautSwiftness, CustomModifier)
function ModifierJuggernautSwiftness.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.maxSpeedPct = 100
end
function ModifierJuggernautSwiftness.prototype.IsDebuff(self)
    return false
end
function ModifierJuggernautSwiftness.prototype.IsPurgable(self)
    return true
end
function ModifierJuggernautSwiftness.prototype.OnCreated(self, params)
    if IsServer() then
        self:SetStackCount(clamp(nil, params.swiftnessPct, self.maxSpeedPct, 0))
    end
end
function ModifierJuggernautSwiftness.prototype.OnRefresh(self, params)
    if IsServer() then
        self:SetStackCount(clamp(
            nil,
            self:GetStackCount() + params.swiftnessPct,
            self.maxSpeedPct,
            0
        ))
    end
end
function ModifierJuggernautSwiftness.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierJuggernautSwiftness.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    return self:GetStackCount()
end
function ModifierJuggernautSwiftness.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
function ModifierJuggernautSwiftness.prototype.GetEffectName(self)
    return "particles/items2_fx/butterfly_buff.vpcf"
end
function ModifierJuggernautSwiftness.prototype.GetTexture(self)
    return "modifier_swiftness"
end
ModifierJuggernautSwiftness = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_swiftness"})},
    ModifierJuggernautSwiftness
)
return ____exports
