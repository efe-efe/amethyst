local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 24,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 2,["17"] = 2,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 6,["23"] = 6,["24"] = 6,["25"] = 6,["26"] = 6,["27"] = 7,["28"] = 7,["29"] = 8,["30"] = 8,["31"] = 10,["32"] = 10,["33"] = 11,["34"] = 12,["35"] = 13,["36"] = 14,["37"] = 12,["38"] = 11,["39"] = 10,["40"] = 11,["42"] = 23,["43"] = 23,["44"] = 24,["45"] = 25,["46"] = 24,["47"] = 28,["48"] = 29,["49"] = 30,["51"] = 25,["52"] = 40,["53"] = 41,["54"] = 42,["55"] = 43,["57"] = 46,["58"] = 48,["59"] = 48,["60"] = 48,["61"] = 48,["62"] = 48,["63"] = 48,["64"] = 48,["65"] = 48,["66"] = 48,["67"] = 48,["68"] = 48,["69"] = 55,["70"] = 56,["71"] = 58,["72"] = 59,["73"] = 60,["74"] = 60,["75"] = 60,["76"] = 60,["77"] = 61,["78"] = 63,["80"] = 66,["81"] = 67,["85"] = 71,["87"] = 74,["88"] = 40,["89"] = 77,["90"] = 78,["91"] = 79,["93"] = 77,["94"] = 83,["95"] = 84,["96"] = 86,["97"] = 83,["98"] = 95,["99"] = 24,["101"] = 96,["102"] = 95,["103"] = 99,["104"] = 100,["105"] = 99,["106"] = 103,["107"] = 104,["108"] = 103,["109"] = 24,["110"] = 23,["111"] = 24,["113"] = 111,["114"] = 111,["115"] = 112,["116"] = 113,["117"] = 114,["118"] = 113,["119"] = 117,["120"] = 118,["121"] = 117,["122"] = 112,["123"] = 111,["124"] = 112,["126"] = 131,["127"] = 131,["128"] = 131,["129"] = 132,["130"] = 133,["131"] = 134,["132"] = 135,["133"] = 137,["134"] = 137,["135"] = 137,["136"] = 137,["137"] = 137,["138"] = 137,["139"] = 137,["140"] = 137,["141"] = 137,["142"] = 147,["143"] = 148,["144"] = 148,["145"] = 150,["146"] = 151,["147"] = 157,["148"] = 148,["149"] = 148,["151"] = 162,["152"] = 163,["153"] = 132,["154"] = 168,["155"] = 169,["156"] = 170,["157"] = 172,["158"] = 168,["159"] = 179,["160"] = 180,["161"] = 181,["162"] = 182,["163"] = 179,["164"] = 186,["165"] = 186,["166"] = 187,["167"] = 192,["168"] = 193,["169"] = 194,["170"] = 195,["171"] = 196,["172"] = 196,["173"] = 196,["174"] = 196,["175"] = 196,["176"] = 196,["177"] = 196,["178"] = 196,["179"] = 196,["180"] = 196,["181"] = 196,["182"] = 196,["183"] = 197,["184"] = 198,["185"] = 200,["186"] = 192,["187"] = 207,["188"] = 208,["189"] = 208,["190"] = 208,["191"] = 208,["192"] = 209,["193"] = 211,["194"] = 212,["195"] = 213,["197"] = 215,["198"] = 215,["199"] = 215,["200"] = 215,["203"] = 207,["204"] = 187,["205"] = 186,["206"] = 187,["208"] = 225,["209"] = 225,["210"] = 226,["211"] = 227,["212"] = 228,["213"] = 227,["214"] = 231,["215"] = 232,["216"] = 231,["217"] = 235,["218"] = 236,["219"] = 235,["220"] = 239,["221"] = 240,["222"] = 239,["223"] = 243,["224"] = 244,["225"] = 245,["226"] = 246,["227"] = 247,["228"] = 247,["229"] = 247,["230"] = 247,["231"] = 247,["232"] = 247,["233"] = 247,["234"] = 247,["235"] = 247,["236"] = 247,["237"] = 247,["238"] = 247,["239"] = 248,["240"] = 250,["241"] = 251,["242"] = 251,["243"] = 251,["244"] = 251,["245"] = 251,["246"] = 251,["247"] = 251,["248"] = 251,["249"] = 251,["250"] = 251,["252"] = 257,["253"] = 243,["254"] = 261,["255"] = 262,["256"] = 263,["258"] = 226,["259"] = 261,["260"] = 268,["261"] = 269,["262"] = 269,["263"] = 269,["264"] = 269,["265"] = 270,["266"] = 272,["267"] = 273,["268"] = 274,["270"] = 276,["271"] = 276,["272"] = 276,["273"] = 276,["276"] = 280,["277"] = 281,["278"] = 282,["279"] = 268,["280"] = 226,["281"] = 225,["282"] = 226,["284"] = 291,["285"] = 291,["286"] = 292,["287"] = 293,["288"] = 294,["289"] = 293,["290"] = 297,["291"] = 298,["292"] = 297,["293"] = 292,["294"] = 291,["295"] = 292,["297"] = 309,["298"] = 309,["299"] = 310,["301"] = 310,["302"] = 311,["303"] = 309,["304"] = 313,["305"] = 314,["306"] = 313,["307"] = 317,["308"] = 318,["309"] = 317,["310"] = 321,["311"] = 322,["312"] = 323,["314"] = 321,["315"] = 327,["316"] = 328,["317"] = 329,["318"] = 329,["319"] = 329,["320"] = 329,["321"] = 329,["322"] = 329,["324"] = 327,["325"] = 333,["326"] = 334,["327"] = 333,["328"] = 337,["329"] = 338,["330"] = 337,["331"] = 341,["332"] = 342,["333"] = 341,["334"] = 347,["335"] = 348,["336"] = 347,["337"] = 351,["338"] = 352,["339"] = 351,["340"] = 310,["341"] = 309,["342"] = 310});
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
    {registerModifier(nil)},
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
