local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 115,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 6,["22"] = 6,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 11,["28"] = 10,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 24,["38"] = 25,["39"] = 27,["40"] = 28,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 28,["49"] = 30,["50"] = 30,["51"] = 30,["52"] = 30,["53"] = 30,["54"] = 30,["55"] = 30,["56"] = 30,["57"] = 39,["58"] = 39,["59"] = 39,["60"] = 39,["61"] = 41,["62"] = 42,["63"] = 42,["64"] = 42,["65"] = 42,["66"] = 42,["67"] = 42,["68"] = 42,["69"] = 42,["70"] = 42,["71"] = 42,["72"] = 42,["73"] = 42,["74"] = 52,["75"] = 53,["78"] = 61,["79"] = 61,["80"] = 61,["81"] = 61,["82"] = 62,["83"] = 64,["84"] = 65,["85"] = 67,["86"] = 73,["87"] = 22,["88"] = 80,["89"] = 81,["90"] = 82,["91"] = 88,["92"] = 88,["93"] = 88,["94"] = 88,["95"] = 88,["96"] = 88,["97"] = 88,["98"] = 88,["99"] = 88,["100"] = 97,["101"] = 97,["102"] = 97,["103"] = 97,["104"] = 97,["105"] = 97,["106"] = 97,["107"] = 97,["108"] = 97,["109"] = 106,["110"] = 80,["111"] = 9,["112"] = 8,["113"] = 9,["115"] = 114,["116"] = 114,["117"] = 115,["118"] = 118,["119"] = 119,["120"] = 120,["121"] = 121,["122"] = 122,["123"] = 123,["125"] = 118,["126"] = 127,["127"] = 128,["128"] = 127,["129"] = 131,["130"] = 132,["131"] = 137,["132"] = 138,["133"] = 138,["134"] = 138,["135"] = 138,["136"] = 138,["137"] = 139,["138"] = 131,["139"] = 115,["140"] = 114,["141"] = 115,["143"] = 147,["144"] = 147,["145"] = 148,["146"] = 149,["147"] = 150,["148"] = 149,["149"] = 153,["150"] = 154,["151"] = 153,["152"] = 148,["153"] = 147,["154"] = 148,["156"] = 160,["157"] = 160,["158"] = 161,["160"] = 161,["161"] = 162,["162"] = 163,["163"] = 160,["164"] = 165,["165"] = 166,["166"] = 165,["167"] = 169,["168"] = 170,["169"] = 169,["170"] = 173,["171"] = 174,["172"] = 173,["173"] = 177,["174"] = 178,["175"] = 177,["176"] = 181,["177"] = 182,["178"] = 181,["179"] = 185,["180"] = 186,["181"] = 185,["182"] = 189,["183"] = 190,["184"] = 189,["185"] = 193,["186"] = 194,["187"] = 195,["188"] = 196,["190"] = 199,["191"] = 200,["192"] = 201,["194"] = 193,["195"] = 205,["196"] = 206,["197"] = 207,["198"] = 208,["199"] = 209,["201"] = 211,["202"] = 219,["203"] = 221,["204"] = 223,["205"] = 224,["207"] = 227,["208"] = 228,["210"] = 205,["211"] = 232,["212"] = 233,["213"] = 234,["214"] = 234,["215"] = 234,["216"] = 234,["217"] = 234,["218"] = 235,["219"] = 235,["220"] = 235,["221"] = 235,["222"] = 235,["223"] = 235,["224"] = 235,["225"] = 235,["226"] = 235,["227"] = 232,["228"] = 238,["229"] = 239,["230"] = 244,["231"] = 244,["232"] = 244,["233"] = 244,["234"] = 244,["235"] = 245,["236"] = 247,["237"] = 252,["238"] = 252,["239"] = 252,["240"] = 252,["241"] = 252,["242"] = 253,["243"] = 253,["244"] = 253,["245"] = 253,["246"] = 253,["247"] = 253,["248"] = 253,["249"] = 253,["250"] = 253,["251"] = 254,["252"] = 254,["253"] = 254,["254"] = 254,["255"] = 254,["256"] = 254,["257"] = 254,["258"] = 254,["259"] = 254,["260"] = 263,["261"] = 263,["262"] = 265,["263"] = 270,["264"] = 270,["265"] = 270,["266"] = 270,["267"] = 270,["268"] = 271,["269"] = 271,["270"] = 271,["271"] = 271,["272"] = 271,["273"] = 272,["274"] = 272,["275"] = 272,["276"] = 272,["277"] = 272,["278"] = 272,["279"] = 272,["280"] = 272,["281"] = 272,["282"] = 273,["283"] = 273,["284"] = 273,["285"] = 273,["286"] = 273,["287"] = 274,["288"] = 274,["289"] = 274,["290"] = 274,["291"] = 274,["292"] = 275,["293"] = 275,["294"] = 238,["295"] = 278,["296"] = 279,["297"] = 278,["298"] = 282,["299"] = 283,["300"] = 284,["303"] = 287,["305"] = 282,["306"] = 291,["307"] = 292,["308"] = 293,["309"] = 294,["310"] = 295,["313"] = 298,["314"] = 291,["315"] = 161,["316"] = 160,["317"] = 161,["319"] = 302,["320"] = 302,["321"] = 303,["322"] = 303,["323"] = 302,["324"] = 303,["326"] = 305,["327"] = 305,["328"] = 306,["329"] = 307,["330"] = 308,["331"] = 309,["332"] = 310,["334"] = 307,["335"] = 314,["336"] = 315,["337"] = 315,["338"] = 315,["339"] = 315,["340"] = 314,["341"] = 318,["342"] = 319,["343"] = 318,["344"] = 322,["345"] = 323,["346"] = 322,["347"] = 306,["348"] = 305,["349"] = 306});
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
