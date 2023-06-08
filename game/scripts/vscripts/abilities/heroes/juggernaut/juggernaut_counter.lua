local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 24,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 2,["17"] = 2,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 6,["23"] = 6,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 7,["28"] = 7,["29"] = 8,["30"] = 8,["31"] = 10,["32"] = 10,["33"] = 11,["34"] = 12,["35"] = 13,["36"] = 14,["37"] = 12,["38"] = 11,["39"] = 10,["40"] = 11,["42"] = 23,["43"] = 23,["44"] = 24,["45"] = 25,["46"] = 24,["47"] = 28,["48"] = 29,["49"] = 30,["51"] = 25,["52"] = 40,["53"] = 41,["54"] = 42,["55"] = 43,["57"] = 46,["58"] = 48,["59"] = 48,["60"] = 48,["61"] = 48,["62"] = 48,["63"] = 48,["64"] = 48,["65"] = 48,["66"] = 48,["67"] = 48,["68"] = 48,["69"] = 55,["70"] = 56,["71"] = 58,["72"] = 59,["73"] = 60,["74"] = 60,["75"] = 60,["76"] = 60,["77"] = 61,["78"] = 63,["80"] = 66,["81"] = 67,["85"] = 71,["87"] = 74,["88"] = 40,["89"] = 77,["90"] = 78,["91"] = 79,["93"] = 77,["94"] = 83,["95"] = 84,["96"] = 86,["97"] = 83,["98"] = 95,["99"] = 24,["101"] = 96,["102"] = 95,["103"] = 99,["104"] = 100,["105"] = 99,["106"] = 103,["107"] = 104,["108"] = 103,["109"] = 24,["110"] = 23,["111"] = 24,["113"] = 108,["114"] = 108,["115"] = 109,["116"] = 110,["117"] = 111,["118"] = 110,["119"] = 114,["120"] = 115,["121"] = 114,["122"] = 109,["123"] = 108,["124"] = 109,["126"] = 119,["127"] = 119,["128"] = 119,["129"] = 120,["130"] = 121,["131"] = 122,["132"] = 123,["133"] = 125,["134"] = 125,["135"] = 125,["136"] = 125,["137"] = 125,["138"] = 125,["139"] = 125,["140"] = 125,["141"] = 125,["142"] = 135,["143"] = 136,["144"] = 136,["145"] = 138,["146"] = 139,["147"] = 145,["148"] = 136,["149"] = 136,["151"] = 150,["152"] = 151,["153"] = 120,["154"] = 156,["155"] = 157,["156"] = 158,["157"] = 160,["158"] = 156,["159"] = 167,["160"] = 168,["161"] = 169,["162"] = 170,["163"] = 167,["164"] = 174,["165"] = 174,["166"] = 175,["167"] = 180,["168"] = 181,["169"] = 182,["170"] = 183,["171"] = 184,["172"] = 184,["173"] = 184,["174"] = 184,["175"] = 184,["176"] = 184,["177"] = 184,["178"] = 184,["179"] = 184,["180"] = 184,["181"] = 184,["182"] = 184,["183"] = 185,["184"] = 186,["185"] = 188,["186"] = 180,["187"] = 195,["188"] = 196,["189"] = 196,["190"] = 196,["191"] = 196,["192"] = 197,["193"] = 199,["194"] = 200,["195"] = 201,["197"] = 203,["198"] = 203,["199"] = 203,["200"] = 203,["203"] = 195,["204"] = 175,["205"] = 174,["206"] = 175,["208"] = 213,["209"] = 213,["210"] = 214,["211"] = 215,["212"] = 216,["213"] = 215,["214"] = 219,["215"] = 220,["216"] = 219,["217"] = 223,["218"] = 224,["219"] = 223,["220"] = 227,["221"] = 228,["222"] = 227,["223"] = 231,["224"] = 232,["225"] = 233,["226"] = 234,["227"] = 235,["228"] = 235,["229"] = 235,["230"] = 235,["231"] = 235,["232"] = 235,["233"] = 235,["234"] = 235,["235"] = 235,["236"] = 235,["237"] = 235,["238"] = 235,["239"] = 236,["240"] = 238,["241"] = 239,["242"] = 239,["243"] = 239,["244"] = 239,["245"] = 239,["246"] = 239,["247"] = 239,["248"] = 239,["249"] = 239,["250"] = 239,["252"] = 245,["253"] = 231,["254"] = 249,["255"] = 250,["256"] = 251,["258"] = 214,["259"] = 249,["260"] = 256,["261"] = 257,["262"] = 257,["263"] = 257,["264"] = 257,["265"] = 258,["266"] = 260,["267"] = 261,["268"] = 262,["270"] = 264,["271"] = 264,["272"] = 264,["273"] = 264,["276"] = 268,["277"] = 269,["278"] = 270,["279"] = 256,["280"] = 214,["281"] = 213,["282"] = 214,["284"] = 277,["285"] = 277,["286"] = 278,["287"] = 279,["288"] = 280,["289"] = 279,["290"] = 283,["291"] = 284,["292"] = 283,["293"] = 278,["294"] = 277,["295"] = 278,["297"] = 288,["298"] = 288,["299"] = 289,["301"] = 289,["302"] = 290,["303"] = 288,["304"] = 292,["305"] = 293,["306"] = 292,["307"] = 296,["308"] = 297,["309"] = 296,["310"] = 300,["311"] = 301,["312"] = 302,["314"] = 300,["315"] = 306,["316"] = 307,["317"] = 308,["318"] = 308,["319"] = 308,["320"] = 308,["321"] = 308,["322"] = 308,["324"] = 306,["325"] = 312,["326"] = 313,["327"] = 312,["328"] = 316,["329"] = 317,["330"] = 316,["331"] = 320,["332"] = 321,["333"] = 320,["334"] = 326,["335"] = 327,["336"] = 326,["337"] = 330,["338"] = 331,["339"] = 330,["340"] = 289,["341"] = 288,["342"] = 289});
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
        local juggernautCounter = self.parent:FindAbilityByName(JuggernautCounter.name)
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
    local juggernautCounter = self.caster:FindAbilityByName(JuggernautCounter.name)
    local damage = juggernautCounter and juggernautCounter:GetSpecialValueFor("ability_damage") or 0
    self:Slash(point, damage, "particles/juggernaut/juggernaut_counter_recast.vpcf")
end
function JuggernautCounterRecast.prototype.OnSlashEnded(self, targets)
    local validTargets = #__TS__ArrayFilter(
        targets,
        function(____, target) return not isObstacle(nil, target) end
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
        function(____, target) return not isObstacle(nil, target) end
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
