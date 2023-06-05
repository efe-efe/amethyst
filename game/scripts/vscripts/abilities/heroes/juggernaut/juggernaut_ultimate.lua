local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 97,["12"] = 1,["13"] = 1,["14"] = 1,["15"] = 2,["16"] = 2,["17"] = 3,["18"] = 3,["19"] = 4,["20"] = 4,["21"] = 5,["22"] = 6,["23"] = 7,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 11,["28"] = 12,["29"] = 14,["30"] = 14,["31"] = 15,["32"] = 15,["33"] = 16,["34"] = 16,["35"] = 17,["36"] = 17,["37"] = 19,["38"] = 19,["39"] = 20,["40"] = 21,["41"] = 22,["42"] = 21,["43"] = 25,["44"] = 26,["45"] = 25,["46"] = 29,["47"] = 30,["48"] = 29,["49"] = 33,["50"] = 34,["51"] = 33,["52"] = 37,["53"] = 20,["54"] = 39,["55"] = 40,["57"] = 42,["58"] = 37,["59"] = 45,["60"] = 20,["61"] = 47,["62"] = 48,["63"] = 49,["64"] = 45,["65"] = 52,["66"] = 53,["67"] = 54,["68"] = 55,["69"] = 55,["70"] = 55,["71"] = 55,["72"] = 56,["73"] = 58,["74"] = 58,["75"] = 58,["76"] = 58,["77"] = 58,["78"] = 58,["79"] = 58,["80"] = 58,["81"] = 58,["82"] = 68,["83"] = 52,["84"] = 71,["85"] = 72,["86"] = 73,["87"] = 74,["88"] = 76,["89"] = 83,["90"] = 88,["91"] = 88,["92"] = 88,["93"] = 88,["94"] = 88,["95"] = 89,["96"] = 89,["97"] = 89,["98"] = 89,["99"] = 89,["100"] = 90,["101"] = 71,["102"] = 20,["103"] = 19,["104"] = 20,["106"] = 96,["107"] = 96,["108"] = 97,["109"] = 100,["110"] = 97,["111"] = 103,["112"] = 104,["113"] = 105,["114"] = 106,["115"] = 106,["118"] = 100,["119"] = 110,["120"] = 111,["121"] = 112,["122"] = 113,["123"] = 113,["124"] = 113,["125"] = 113,["126"] = 115,["127"] = 116,["128"] = 118,["129"] = 118,["130"] = 118,["131"] = 118,["132"] = 118,["133"] = 118,["134"] = 118,["135"] = 118,["136"] = 118,["137"] = 122,["141"] = 110,["142"] = 128,["143"] = 129,["144"] = 128,["145"] = 132,["146"] = 133,["147"] = 132,["148"] = 136,["149"] = 137,["150"] = 136,["151"] = 140,["152"] = 141,["153"] = 141,["154"] = 97,["155"] = 141,["156"] = 141,["157"] = 140,["158"] = 150,["159"] = 151,["160"] = 150,["161"] = 97,["162"] = 96,["163"] = 97,["165"] = 158,["166"] = 158,["167"] = 159,["168"] = 165,["169"] = 166,["170"] = 165,["171"] = 169,["172"] = 170,["173"] = 169,["174"] = 173,["175"] = 174,["176"] = 173,["177"] = 177,["178"] = 178,["179"] = 179,["180"] = 180,["181"] = 181,["182"] = 182,["183"] = 183,["184"] = 184,["185"] = 185,["186"] = 186,["187"] = 186,["188"] = 186,["189"] = 186,["190"] = 186,["192"] = 177,["193"] = 190,["194"] = 191,["195"] = 192,["196"] = 193,["198"] = 190,["199"] = 197,["200"] = 198,["201"] = 198,["202"] = 199,["203"] = 199,["204"] = 199,["205"] = 199,["206"] = 199,["207"] = 199,["208"] = 199,["209"] = 199,["210"] = 201,["211"] = 201,["212"] = 201,["213"] = 201,["214"] = 201,["215"] = 201,["216"] = 201,["217"] = 201,["218"] = 201,["219"] = 201,["220"] = 201,["221"] = 201,["222"] = 197,["223"] = 212,["224"] = 213,["225"] = 214,["226"] = 215,["227"] = 216,["228"] = 216,["229"] = 216,["230"] = 216,["231"] = 220,["232"] = 221,["233"] = 226,["234"] = 227,["235"] = 227,["236"] = 227,["237"] = 227,["238"] = 227,["239"] = 228,["240"] = 229,["241"] = 230,["242"] = 231,["243"] = 232,["244"] = 233,["245"] = 234,["246"] = 234,["247"] = 234,["248"] = 234,["249"] = 234,["250"] = 234,["251"] = 234,["252"] = 234,["253"] = 234,["254"] = 235,["255"] = 216,["256"] = 216,["258"] = 239,["259"] = 241,["260"] = 243,["261"] = 243,["262"] = 241,["263"] = 244,["264"] = 245,["265"] = 250,["267"] = 212,["268"] = 254,["269"] = 255,["270"] = 254,["271"] = 258,["272"] = 259,["273"] = 258,["274"] = 262,["275"] = 263,["276"] = 262,["277"] = 266,["278"] = 267,["279"] = 266,["280"] = 270,["281"] = 271,["282"] = 271,["283"] = 271,["284"] = 271,["285"] = 271,["286"] = 271,["287"] = 271,["288"] = 270,["289"] = 280,["290"] = 281,["291"] = 284,["292"] = 289,["293"] = 290,["294"] = 280,["295"] = 293,["296"] = 294,["297"] = 299,["298"] = 300,["299"] = 301,["300"] = 293,["301"] = 304,["302"] = 305,["303"] = 304,["304"] = 159,["305"] = 158,["306"] = 159,["308"] = 312,["309"] = 312,["310"] = 313,["311"] = 314,["312"] = 315,["313"] = 315,["314"] = 313,["315"] = 315,["316"] = 315,["317"] = 314,["318"] = 313,["319"] = 312,["320"] = 313});
local ____exports = {}
local ModifierJuggernautUltimateDisplacement, ModifierJuggernautUltimateSlashing, ModifierJuggernautBanish
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_banish = require("modifiers.modifier_banish")
local ModifierBanish = ____modifier_banish.ModifierBanish
local ____modifier_casting = require("modifiers.modifier_casting")
local Translate = ____modifier_casting.Translate
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local attackWithBaseDamage = ____util.attackWithBaseDamage
local createRadiusMarker = ____util.createRadiusMarker
local direction2D = ____util.direction2D
local hideHealthBar = ____util.hideHealthBar
local isObstacle = ____util.isObstacle
local randomInArray = ____util.randomInArray
local unhideHealthBar = ____util.unhideHealthBar
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____juggernaut_basic_attack = require("abilities.heroes.juggernaut.juggernaut_basic_attack")
local ModifierJuggernautStacks = ____juggernaut_basic_attack.ModifierJuggernautStacks
local ____juggernaut_second_attack = require("abilities.heroes.juggernaut.juggernaut_second_attack")
local ModifierJuggernautSpin = ____juggernaut_second_attack.ModifierJuggernautSpin
local JuggernautUltimate = __TS__Class()
JuggernautUltimate.name = "JuggernautUltimate"
__TS__ClassExtends(JuggernautUltimate, CustomAbility)
function JuggernautUltimate.prototype.GetCastAnimationCustom(self)
    return ACT_DOTA_GENERIC_CHANNEL_1
end
function JuggernautUltimate.prototype.GetPlaybackRateOverride(self)
    return 2
end
function JuggernautUltimate.prototype.GetCastingCrawl(self)
    return 0
end
function JuggernautUltimate.prototype.GetAnimationTranslate(self)
    return Translate.sharp_blade
end
function JuggernautUltimate.prototype.OnAbilityPhaseStart(self)
    if CustomAbility.prototype.OnAbilityPhaseStart(self) then
        self:PlayEffectsOnPhase()
        return true
    end
    return false
end
function JuggernautUltimate.prototype.OnAbilityPhaseInterrupted(self)
    CustomAbility.prototype.OnAbilityPhaseInterrupted(self)
    StopGlobalSound("juggernaut_jug_rare_17")
    StopGlobalSound("Hero_Juggernaut.PreAttack")
    StopGlobalSound("Hero_Lycan.SummonWolves")
end
function JuggernautUltimate.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local distance = self:GetCastRange(
        Vector(0, 0, 0),
        nil
    )
    local direction = direction2D(nil, origin, point)
    ModifierJuggernautUltimateDisplacement:apply(self.caster, self.caster, self, {
        x = direction.x,
        y = direction.y,
        distance = distance,
        speed = distance / 0.5,
        peak = 50,
        teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
        flagFilter = DOTA_UNIT_TARGET_FLAG_NO_INVIS
    })
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self.caster)
end
function JuggernautUltimate.prototype.PlayEffectsOnPhase(self)
    EmitGlobalSound("juggernaut_jug_rare_17")
    EmitGlobalSound("Hero_Lycan.SummonWolves")
    EmitGlobalSound("Hero_Juggernaut.PreAttack")
    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/juggernaut/juggernaut_ultimate_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster))
    local particleId = ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControl(
        particleId,
        2,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:SetParticleControl(
        particleId,
        3,
        self.caster:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
JuggernautUltimate = __TS__Decorate(
    {registerAbility(nil, "juggernaut_ultimate")},
    JuggernautUltimate
)
ModifierJuggernautUltimateDisplacement = __TS__Class()
ModifierJuggernautUltimateDisplacement.name = "ModifierJuggernautUltimateDisplacement"
__TS__ClassExtends(ModifierJuggernautUltimateDisplacement, ModifierDisplacement)
function ModifierJuggernautUltimateDisplacement.prototype.OnCreated(self, params)
    ModifierDisplacement.prototype.OnCreated(self, params)
    if IsServer() then
        local modifier = ModifierJuggernautStacks:findOne(self.parent)
        self.stacks = modifier and modifier:GetStackCount() or 0
        if modifier ~= nil then
            modifier:Destroy()
        end
    end
end
function ModifierJuggernautUltimateDisplacement.prototype.OnCollide(self, params)
    if IsServer() then
        if params.collision == "unit" then
            local enemy = __TS__ArrayFind(
                params.units,
                function(____, unit) return not isObstacle(nil, unit) end
            )
            if enemy then
                EmitSoundOn("Hero_PhantomAssassin.Attack", enemy)
                ModifierJuggernautUltimateSlashing:apply(
                    self.parent,
                    self.parent,
                    self.ability,
                    {
                        duration = self:Value("duration"),
                        aspdBuff = self:Value("aspd_per_stack") * self.stacks
                    }
                )
                self:Destroy()
            end
        end
    end
end
function ModifierJuggernautUltimateDisplacement.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierJuggernautUltimateDisplacement.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_ATTACK_EVENT
end
function ModifierJuggernautUltimateDisplacement.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierJuggernautUltimateDisplacement.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_OUT_OF_GAME] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
function ModifierJuggernautUltimateDisplacement.prototype.GetEffectName(self)
    return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end
ModifierJuggernautUltimateDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_ultimate_displacement"})},
    ModifierJuggernautUltimateDisplacement
)
ModifierJuggernautUltimateSlashing = __TS__Class()
ModifierJuggernautUltimateSlashing.name = "ModifierJuggernautUltimateSlashing"
__TS__ClassExtends(ModifierJuggernautUltimateSlashing, CustomModifier)
function ModifierJuggernautUltimateSlashing.prototype.IsHidden(self)
    return false
end
function ModifierJuggernautUltimateSlashing.prototype.IsDebuff(self)
    return false
end
function ModifierJuggernautUltimateSlashing.prototype.IsPurgable(self)
    return false
end
function ModifierJuggernautUltimateSlashing.prototype.OnCreated(self, params)
    if IsServer() then
        self.currentPosition = self.parent:GetAbsOrigin()
        self.previousPosition = self.currentPosition
        self:SetStackCount(params.aspdBuff)
        local attacksPerSecond = self.parent:GetAttacksPerSecond()
        self.attackSpeed = math.abs(1 / attacksPerSecond)
        self:OnIntervalThink()
        self:StartIntervalThink(self.attackSpeed)
        hideHealthBar(
            nil,
            self.parent,
            self:GetDuration()
        )
    end
end
function ModifierJuggernautUltimateSlashing.prototype.OnDestroy(self)
    if IsServer() then
        unhideHealthBar(nil, self.parent)
        ModifierJuggernautSpin:apply(self.parent, self.parent, nil, {duration = 0.3})
    end
end
function ModifierJuggernautUltimateSlashing.prototype.FindTargets(self)
    local ____opt_4 = self.currentTarget
    local findOrigin = ____opt_4 and ____opt_4:GetAbsOrigin() or self.parent:GetAbsOrigin()
    createRadiusMarker(
        nil,
        self.parent,
        findOrigin,
        self:Value("find_radius"),
        "public",
        0.1
    )
    return __TS__ArrayFilter(
        CustomEntitiesLegacy:FindUnitsInRadius(
            self.parent,
            findOrigin,
            self:Value("find_radius"),
            2,
            1 + 18,
            16 + 256,
            0
        ),
        function(____, enemy) return not isObstacle(nil, enemy) end
    )
end
function ModifierJuggernautUltimateSlashing.prototype.OnIntervalThink(self)
    local enemies = self:FindTargets()
    if #enemies > 0 then
        self.currentTarget = randomInArray(nil, enemies)
        self.ability:SingleAttack({
            target = self.currentTarget,
            attackType = "basic",
            triggerCounters = false,
            effect = function(____, target)
                attackWithBaseDamage(nil, {source = self.parent, target = target, ability = self.ability})
                local targetOrigin = target:GetAbsOrigin()
                FindClearSpaceForUnit(
                    self.parent,
                    targetOrigin:__add(RandomVector(128)),
                    false
                )
                local direction = targetOrigin:__sub(self.parent:GetAbsOrigin())
                direction.z = self.parent:GetForwardVector().z
                self.parent:SetForwardVector(direction:Normalized())
                self.currentPosition = self.parent:GetAbsOrigin()
                self:PlayEffectsTarget(target)
                self:PlayEffectsTrail(self.previousPosition, self.currentPosition)
                ScreenShake(
                    targetOrigin,
                    100,
                    300,
                    0.45,
                    1000,
                    0,
                    true
                )
                self.previousPosition = self.currentPosition
            end
        })
    else
        self.currentTarget = nil
        local effectOrigin = self.parent:GetAbsOrigin():__add(RandomVector(RandomInt(
            self:Value("find_radius") / 2,
            self:Value("find_radius")
        )))
        EmitSoundOn("Hero_Juggernaut.ArcanaHaste.Anim", self.parent)
        EFX("particles/juggernaut/juggernaut_ultimate_glitch.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = effectOrigin, cp1 = effectOrigin, release = true})
        ModifierJuggernautBanish:apply(self.parent, self.parent, nil, {duration = self.attackSpeed})
    end
end
function ModifierJuggernautUltimateSlashing.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierJuggernautUltimateSlashing.prototype.GetModifierAttackSpeedBonus_Constant(self)
    return -50 + self:GetStackCount()
end
function ModifierJuggernautUltimateSlashing.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_OVERRIDE_ABILITY_4
end
function ModifierJuggernautUltimateSlashing.prototype.GetOverrideAnimationRate(self)
    return 1.5
end
function ModifierJuggernautUltimateSlashing.prototype.CheckState(self)
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true
    }
end
function ModifierJuggernautUltimateSlashing.prototype.PlayEffectsTarget(self, target)
    EFX("particles/juggernaut/juggernaut_basic_attack_impact.vpcf", PATTACH_ABSORIGIN, target, {release = true})
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:ReleaseParticleIndex(particleId)
    EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", target)
end
function ModifierJuggernautUltimateSlashing.prototype.PlayEffectsTrail(self, previousPosition, currentPosition)
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControl(particleId, 0, previousPosition)
    ParticleManager:SetParticleControl(particleId, 1, currentPosition)
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ModifierJuggernautUltimateSlashing.prototype.GetEffectName(self)
    return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end
ModifierJuggernautUltimateSlashing = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_ultimate_slashing"})},
    ModifierJuggernautUltimateSlashing
)
ModifierJuggernautBanish = __TS__Class()
ModifierJuggernautBanish.name = "ModifierJuggernautBanish"
__TS__ClassExtends(ModifierJuggernautBanish, ModifierBanish)
function ModifierJuggernautBanish.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierBanish.prototype.CheckState(self),
        {[MODIFIER_STATE_COMMAND_RESTRICTED] = true}
    )
end
ModifierJuggernautBanish = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_ultimate_banish"})},
    ModifierJuggernautBanish
)
return ____exports
