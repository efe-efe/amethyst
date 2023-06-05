local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 117,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 6,["22"] = 6,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 11,["28"] = 10,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 24,["38"] = 25,["39"] = 27,["40"] = 28,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 28,["49"] = 30,["50"] = 30,["51"] = 30,["52"] = 30,["53"] = 30,["54"] = 30,["55"] = 30,["56"] = 30,["57"] = 39,["58"] = 39,["59"] = 39,["60"] = 39,["61"] = 41,["62"] = 42,["63"] = 42,["64"] = 42,["65"] = 42,["66"] = 42,["67"] = 42,["68"] = 42,["69"] = 42,["70"] = 42,["71"] = 42,["72"] = 42,["73"] = 42,["74"] = 52,["75"] = 53,["78"] = 61,["79"] = 61,["80"] = 61,["81"] = 61,["82"] = 62,["83"] = 64,["84"] = 65,["85"] = 67,["86"] = 73,["87"] = 22,["88"] = 80,["89"] = 81,["90"] = 82,["91"] = 88,["92"] = 88,["93"] = 88,["94"] = 88,["95"] = 88,["96"] = 88,["97"] = 88,["98"] = 88,["99"] = 88,["100"] = 97,["101"] = 97,["102"] = 97,["103"] = 97,["104"] = 97,["105"] = 97,["106"] = 97,["107"] = 97,["108"] = 97,["109"] = 106,["110"] = 80,["111"] = 9,["112"] = 8,["113"] = 9,["115"] = 116,["116"] = 116,["117"] = 117,["118"] = 120,["119"] = 121,["120"] = 122,["121"] = 123,["122"] = 124,["123"] = 125,["125"] = 120,["126"] = 129,["127"] = 130,["128"] = 129,["129"] = 133,["130"] = 134,["131"] = 139,["132"] = 140,["133"] = 140,["134"] = 140,["135"] = 140,["136"] = 140,["137"] = 141,["138"] = 133,["139"] = 117,["140"] = 116,["141"] = 117,["143"] = 149,["144"] = 149,["145"] = 150,["146"] = 151,["147"] = 152,["148"] = 151,["149"] = 155,["150"] = 156,["151"] = 155,["152"] = 150,["153"] = 149,["154"] = 150,["156"] = 167,["157"] = 167,["158"] = 168,["160"] = 168,["161"] = 169,["162"] = 170,["163"] = 167,["164"] = 172,["165"] = 173,["166"] = 172,["167"] = 176,["168"] = 177,["169"] = 176,["170"] = 180,["171"] = 181,["172"] = 180,["173"] = 184,["174"] = 185,["175"] = 184,["176"] = 188,["177"] = 189,["178"] = 188,["179"] = 192,["180"] = 193,["181"] = 192,["182"] = 196,["183"] = 197,["184"] = 196,["185"] = 200,["186"] = 201,["187"] = 202,["188"] = 203,["190"] = 206,["191"] = 207,["192"] = 208,["194"] = 200,["195"] = 212,["196"] = 213,["197"] = 214,["198"] = 215,["199"] = 216,["201"] = 218,["202"] = 226,["203"] = 228,["204"] = 230,["205"] = 231,["207"] = 234,["208"] = 235,["210"] = 212,["211"] = 239,["212"] = 240,["213"] = 241,["214"] = 241,["215"] = 241,["216"] = 241,["217"] = 241,["218"] = 242,["219"] = 242,["220"] = 242,["221"] = 242,["222"] = 242,["223"] = 242,["224"] = 242,["225"] = 242,["226"] = 242,["227"] = 239,["228"] = 245,["229"] = 246,["230"] = 251,["231"] = 251,["232"] = 251,["233"] = 251,["234"] = 251,["235"] = 252,["236"] = 254,["237"] = 259,["238"] = 259,["239"] = 259,["240"] = 259,["241"] = 259,["242"] = 260,["243"] = 260,["244"] = 260,["245"] = 260,["246"] = 260,["247"] = 260,["248"] = 260,["249"] = 260,["250"] = 260,["251"] = 261,["252"] = 261,["253"] = 261,["254"] = 261,["255"] = 261,["256"] = 261,["257"] = 261,["258"] = 261,["259"] = 261,["260"] = 270,["261"] = 270,["262"] = 272,["263"] = 277,["264"] = 277,["265"] = 277,["266"] = 277,["267"] = 277,["268"] = 278,["269"] = 278,["270"] = 278,["271"] = 278,["272"] = 278,["273"] = 279,["274"] = 279,["275"] = 279,["276"] = 279,["277"] = 279,["278"] = 279,["279"] = 279,["280"] = 279,["281"] = 279,["282"] = 280,["283"] = 280,["284"] = 280,["285"] = 280,["286"] = 280,["287"] = 281,["288"] = 281,["289"] = 281,["290"] = 281,["291"] = 281,["292"] = 282,["293"] = 282,["294"] = 245,["295"] = 285,["296"] = 286,["297"] = 285,["298"] = 289,["299"] = 290,["300"] = 291,["303"] = 294,["305"] = 289,["306"] = 298,["307"] = 299,["308"] = 300,["309"] = 301,["310"] = 302,["313"] = 305,["314"] = 298,["315"] = 168,["316"] = 167,["317"] = 168,["319"] = 309,["320"] = 309,["321"] = 310,["322"] = 310,["323"] = 309,["324"] = 310,["326"] = 321,["327"] = 321,["328"] = 322,["329"] = 323,["330"] = 324,["331"] = 325,["332"] = 326,["334"] = 323,["335"] = 330,["336"] = 331,["337"] = 331,["338"] = 331,["339"] = 331,["340"] = 330,["341"] = 334,["342"] = 335,["343"] = 334,["344"] = 338,["345"] = 339,["346"] = 338,["347"] = 322,["348"] = 321,["349"] = 322});
local ____exports = {}
local JuggernautExtraRecast, ModifierJuggernautExtraShield, ModifierJuggernautExtraWard, ModifierJuggernautExtraRecast, ModifierJuggernautExtra
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_recast = require("modifiers.modifier_recast")
local ModifierRecast = ____modifier_recast.ModifierRecast
local ____modifier_shield = require("modifiers.modifier_shield")
local ModifierShield = ____modifier_shield.ModifierShield
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local JuggernautExtra = __TS__Class()
JuggernautExtra.name = "JuggernautExtra"
__TS__ClassExtends(JuggernautExtra, CustomAbility)
function JuggernautExtra.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function JuggernautExtra.prototype.GetPlaybackRateOverride(self)
    return 2
end
function JuggernautExtra.prototype.GetCastingCrawl(self)
    return 10
end
function JuggernautExtra.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    local shield = self:GetSpecialValueFor("shield")
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        self.caster:GetAbsOrigin(),
        cursor,
        {maxRange = self:GetCastRange(
            Vector(0, 0, 0),
            nil
        )}
    )
    local healingWard = CreateUnitByName(
        "npc_dota_creature_juggernaut_healing_totem",
        point,
        true,
        self.caster,
        self.caster,
        self.caster:GetTeam()
    )
    healingWard:SetControllableByPlayer(
        self.caster:GetPlayerOwnerID(),
        true
    )
    if self:GetLevel() >= 2 then
        local units = __TS__ArrayFilter(
            CustomEntitiesLegacy:FindUnitsInRadius(
                self.caster,
                point,
                radius,
                1,
                1 + 18,
                0,
                0
            ),
            function(____, unit) return unit ~= healingWard end
        )
        for ____, unit in ipairs(units) do
            ModifierJuggernautExtraShield:apply(unit, self.caster, nil, {duration = 6, damageBlock = shield})
        end
    end
    ResolveNPCPositions(
        healingWard:GetAbsOrigin(),
        healingWard:GetHullRadius() + healingWard:GetCollisionPadding()
    )
    ModifierJuggernautExtraWard:apply(healingWard, self.caster, self, {duration = duration})
    local juggernautExtraRecast = self.caster:FindAbilityByName(JuggernautExtraRecast.name)
    juggernautExtraRecast:SetHealingWardIndex(healingWard:GetEntityIndex())
    ModifierJuggernautExtraRecast:apply(self.caster, self.caster, nil, {duration = duration, abilityLeft = JuggernautExtra.name, abilityRight = JuggernautExtraRecast.name, charges = 999})
    self:PlayEffects(healingWard)
end
function JuggernautExtra.prototype.PlayEffects(self, target)
    EmitSoundOn("Hero_Juggernaut.HealingWard.Cast", self.caster)
    local particleId = EFX("particles/econ/items/undying/fall20_undying_head/fall20_undying_soul_rip_heal.vpcf", PATTACH_CUSTOMORIGIN, target, {})
    ParticleManager:SetParticleControlEnt(
        particleId,
        0,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        target:GetAbsOrigin(),
        true
    )
    ParticleManager:SetParticleControlEnt(
        particleId,
        1,
        self.caster,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.caster:GetAbsOrigin(),
        true
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
JuggernautExtra = __TS__Decorate(
    {registerAbility(nil, "juggernaut_extra")},
    JuggernautExtra
)
JuggernautExtraRecast = __TS__Class()
JuggernautExtraRecast.name = "JuggernautExtraRecast"
__TS__ClassExtends(JuggernautExtraRecast, CustomAbility)
function JuggernautExtraRecast.prototype.OnSpellStart(self)
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    if self.healingWardIndex then
        local healingWard = EntIndexToHScript(self.healingWardIndex)
        healingWard:MoveToPosition(point)
        self:PlayEffects(point)
    end
end
function JuggernautExtraRecast.prototype.SetHealingWardIndex(self, index)
    self.healingWardIndex = index
end
function JuggernautExtraRecast.prototype.PlayEffects(self, point)
    local particleId = ParticleManager:CreateParticle("particles/ui_mouseactions/clicked_basemove.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleId, 0, point)
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(0, 255, 0)
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
JuggernautExtraRecast = __TS__Decorate(
    {registerAbility(nil, "juggernaut_extra_recast")},
    JuggernautExtraRecast
)
ModifierJuggernautExtraShield = __TS__Class()
ModifierJuggernautExtraShield.name = "ModifierJuggernautExtraShield"
__TS__ClassExtends(ModifierJuggernautExtraShield, ModifierShield)
function ModifierJuggernautExtraShield.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TOOLTIP}
end
function ModifierJuggernautExtraShield.prototype.OnTooltip(self)
    return self:GetStackCount()
end
ModifierJuggernautExtraShield = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_extra_shield"})},
    ModifierJuggernautExtraShield
)
ModifierJuggernautExtraWard = __TS__Class()
ModifierJuggernautExtraWard.name = "ModifierJuggernautExtraWard"
__TS__ClassExtends(ModifierJuggernautExtraWard, CustomModifier)
function ModifierJuggernautExtraWard.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.health = 1
    self.particleIds = {}
end
function ModifierJuggernautExtraWard.prototype.IsAura(self)
    return true
end
function ModifierJuggernautExtraWard.prototype.GetModifierAura(self)
    return ModifierJuggernautExtra.name
end
function ModifierJuggernautExtraWard.prototype.GetAuraRadius(self)
    return self:Value("radius")
end
function ModifierJuggernautExtraWard.prototype.GetAuraDuration(self)
    return 0.5
end
function ModifierJuggernautExtraWard.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierJuggernautExtraWard.prototype.GetAuraEntityReject(self, unit)
    return not CustomEntitiesLegacy:Allies(self.caster, unit)
end
function ModifierJuggernautExtraWard.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierJuggernautExtraWard.prototype.OnCreated(self)
    if IsServer() then
        if self.caster:HasModifier("modifier_upgrade_juggernaut_spinning_ward") then
            self.health = 5
        end
        self:PlayEffectsOnCreated()
        self:StartIntervalThink(0.03)
        EmitSoundOn("Hero_Juggernaut.HealingWard.Loop", self.parent)
    end
end
function ModifierJuggernautExtraWard.prototype.OnDestroy(self)
    if IsServer() then
        for ____, particleId in ipairs(self.particleIds) do
            ParticleManager:DestroyParticle(particleId, false)
            ParticleManager:ReleaseParticleIndex(particleId)
        end
        EFX("particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {release = true})
        self.parent:Kill(nil, self.parent)
        self.ability:StartCooldown(self.ability:GetCooldown(0))
        if self.caster:HasModifier("modifier_juggernaut_extra_recast") then
            self.caster:RemoveModifierByName("modifier_juggernaut_extra_recast")
        end
        StopSoundOn("Hero_Juggernaut.HealingWard.Stop", self.parent)
        EmitSoundOn("Hero_Juggernaut.HealingWard.Stop", self.parent)
    end
end
function ModifierJuggernautExtraWard.prototype.OnIntervalThink(self)
    local percentage = (self:GetDuration() - self:GetRemainingTime()) / self:GetDuration() + 0.03
    ParticleManager:SetParticleControl(
        self.particleIds[2],
        0,
        self.parent:GetAbsOrigin():__add(Vector(0, 0, 16))
    )
    ParticleManager:SetParticleControl(
        self.particleIds[2],
        1,
        Vector(
            self:Value("radius"),
            percentage,
            0
        )
    )
end
function ModifierJuggernautExtraWard.prototype.PlayEffectsOnCreated(self)
    local particleId = ParticleManager:CreateParticle("particles/econ/items/juggernaut/bladekeeper_healing_ward/juggernaut_healing_ward_eruption_dc.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.parent:GetAbsOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
    particleId = ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.parent:GetAbsOrigin():__add(Vector(0, 0, 100))
    )
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(
            self:Value("radius"),
            1,
            1
        )
    )
    ParticleManager:SetParticleControlEnt(
        particleId,
        2,
        self.parent,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.parent:GetAbsOrigin(),
        true
    )
    local ____self_particleIds_0 = self.particleIds
    ____self_particleIds_0[#____self_particleIds_0 + 1] = particleId
    particleId = ParticleManager:CreateParticle("particles/progress_circle/generic_progress_circle_small.vpcf", PATTACH_WORLDORIGIN, self.parent)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.parent:GetAbsOrigin():__add(Vector(0, 0, 16))
    )
    ParticleManager:SetParticleControlForward(
        particleId,
        0,
        Vector(0, -1, 0)
    )
    ParticleManager:SetParticleControl(
        particleId,
        1,
        Vector(
            self:Value("radius"),
            0,
            1
        )
    )
    ParticleManager:SetParticleControl(
        particleId,
        15,
        Vector(1, 255, 1)
    )
    ParticleManager:SetParticleControl(
        particleId,
        16,
        Vector(1, 0, 0)
    )
    local ____self_particleIds_1 = self.particleIds
    ____self_particleIds_1[#____self_particleIds_1 + 1] = particleId
end
function ModifierJuggernautExtraWard.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_DEATH, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE}
end
function ModifierJuggernautExtraWard.prototype.OnDeath(self, event)
    if IsServer() then
        if event.unit ~= self.parent then
            return
        end
        self:Destroy()
    end
end
function ModifierJuggernautExtraWard.prototype.GetModifierIncomingDamage_Percentage(self)
    if IsServer() then
        self.health = self.health - 1
        if self.health == 0 then
            self.parent:ForceKill(false)
        end
    end
    return -100
end
ModifierJuggernautExtraWard = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_extra_ward"})},
    ModifierJuggernautExtraWard
)
ModifierJuggernautExtraRecast = __TS__Class()
ModifierJuggernautExtraRecast.name = "ModifierJuggernautExtraRecast"
__TS__ClassExtends(ModifierJuggernautExtraRecast, ModifierRecast)
ModifierJuggernautExtraRecast = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_extra_recast"})},
    ModifierJuggernautExtraRecast
)
ModifierJuggernautExtra = __TS__Class()
ModifierJuggernautExtra.name = "ModifierJuggernautExtra"
__TS__ClassExtends(ModifierJuggernautExtra, CustomModifier)
function ModifierJuggernautExtra.prototype.OnCreated(self)
    if IsServer() then
        self:OnIntervalThink()
        self:StartIntervalThink(1)
    end
end
function ModifierJuggernautExtra.prototype.OnIntervalThink(self)
    self.parent:Heal(
        self:Value("heal_per_second"),
        self.ability
    )
end
function ModifierJuggernautExtra.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TOOLTIP}
end
function ModifierJuggernautExtra.prototype.OnTooltip(self)
    return self:Value("heal_per_second")
end
ModifierJuggernautExtra = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_juggernaut_extra"})},
    ModifierJuggernautExtra
)
return ____exports
