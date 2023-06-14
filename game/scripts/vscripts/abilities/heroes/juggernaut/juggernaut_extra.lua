local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 115,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 5,["20"] = 5,["21"] = 6,["22"] = 6,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 10,["27"] = 11,["28"] = 10,["29"] = 14,["30"] = 15,["31"] = 14,["32"] = 18,["33"] = 19,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 24,["38"] = 25,["39"] = 27,["40"] = 28,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 28,["49"] = 30,["50"] = 30,["51"] = 30,["52"] = 30,["53"] = 30,["54"] = 30,["55"] = 30,["56"] = 30,["57"] = 39,["58"] = 39,["59"] = 39,["60"] = 39,["61"] = 41,["62"] = 42,["63"] = 42,["64"] = 42,["65"] = 42,["66"] = 42,["67"] = 42,["68"] = 42,["69"] = 42,["70"] = 42,["71"] = 42,["72"] = 42,["73"] = 42,["74"] = 52,["75"] = 53,["78"] = 61,["79"] = 61,["80"] = 61,["81"] = 61,["82"] = 62,["83"] = 64,["84"] = 65,["85"] = 65,["87"] = 67,["88"] = 73,["89"] = 22,["90"] = 80,["91"] = 81,["92"] = 82,["93"] = 88,["94"] = 88,["95"] = 88,["96"] = 88,["97"] = 88,["98"] = 88,["99"] = 88,["100"] = 88,["101"] = 88,["102"] = 97,["103"] = 97,["104"] = 97,["105"] = 97,["106"] = 97,["107"] = 97,["108"] = 97,["109"] = 97,["110"] = 97,["111"] = 106,["112"] = 80,["113"] = 9,["114"] = 8,["115"] = 9,["117"] = 114,["118"] = 114,["119"] = 115,["120"] = 118,["121"] = 119,["122"] = 120,["123"] = 121,["124"] = 122,["125"] = 123,["127"] = 118,["128"] = 127,["129"] = 128,["130"] = 127,["131"] = 131,["132"] = 132,["133"] = 137,["134"] = 138,["135"] = 138,["136"] = 138,["137"] = 138,["138"] = 138,["139"] = 139,["140"] = 131,["141"] = 115,["142"] = 114,["143"] = 115,["145"] = 147,["146"] = 147,["147"] = 148,["148"] = 149,["149"] = 150,["150"] = 149,["151"] = 153,["152"] = 154,["153"] = 153,["154"] = 148,["155"] = 147,["156"] = 148,["158"] = 160,["159"] = 160,["160"] = 161,["162"] = 161,["163"] = 162,["164"] = 163,["165"] = 160,["166"] = 165,["167"] = 166,["168"] = 165,["169"] = 169,["170"] = 170,["171"] = 169,["172"] = 173,["173"] = 174,["174"] = 173,["175"] = 177,["176"] = 178,["177"] = 177,["178"] = 181,["179"] = 182,["180"] = 181,["181"] = 185,["182"] = 186,["183"] = 185,["184"] = 189,["185"] = 190,["186"] = 189,["187"] = 193,["188"] = 194,["189"] = 195,["190"] = 196,["192"] = 199,["193"] = 200,["194"] = 201,["196"] = 193,["197"] = 205,["198"] = 206,["199"] = 207,["200"] = 208,["201"] = 209,["203"] = 211,["204"] = 219,["205"] = 221,["206"] = 223,["207"] = 224,["209"] = 227,["210"] = 228,["212"] = 205,["213"] = 232,["214"] = 233,["215"] = 234,["216"] = 234,["217"] = 234,["218"] = 234,["219"] = 234,["220"] = 235,["221"] = 235,["222"] = 235,["223"] = 235,["224"] = 235,["225"] = 235,["226"] = 235,["227"] = 235,["228"] = 235,["229"] = 232,["230"] = 238,["231"] = 239,["232"] = 244,["233"] = 244,["234"] = 244,["235"] = 244,["236"] = 244,["237"] = 245,["238"] = 247,["239"] = 252,["240"] = 252,["241"] = 252,["242"] = 252,["243"] = 252,["244"] = 253,["245"] = 253,["246"] = 253,["247"] = 253,["248"] = 253,["249"] = 253,["250"] = 253,["251"] = 253,["252"] = 253,["253"] = 254,["254"] = 254,["255"] = 254,["256"] = 254,["257"] = 254,["258"] = 254,["259"] = 254,["260"] = 254,["261"] = 254,["262"] = 263,["263"] = 263,["264"] = 265,["265"] = 270,["266"] = 270,["267"] = 270,["268"] = 270,["269"] = 270,["270"] = 271,["271"] = 271,["272"] = 271,["273"] = 271,["274"] = 271,["275"] = 272,["276"] = 272,["277"] = 272,["278"] = 272,["279"] = 272,["280"] = 272,["281"] = 272,["282"] = 272,["283"] = 272,["284"] = 273,["285"] = 273,["286"] = 273,["287"] = 273,["288"] = 273,["289"] = 274,["290"] = 274,["291"] = 274,["292"] = 274,["293"] = 274,["294"] = 275,["295"] = 275,["296"] = 238,["297"] = 278,["298"] = 279,["299"] = 278,["300"] = 282,["301"] = 283,["302"] = 284,["305"] = 287,["307"] = 282,["308"] = 291,["309"] = 292,["310"] = 293,["311"] = 294,["312"] = 295,["315"] = 298,["316"] = 291,["317"] = 161,["318"] = 160,["319"] = 161,["321"] = 302,["322"] = 302,["323"] = 303,["324"] = 303,["325"] = 302,["326"] = 303,["328"] = 305,["329"] = 305,["330"] = 306,["331"] = 307,["332"] = 308,["333"] = 309,["334"] = 310,["336"] = 307,["337"] = 314,["338"] = 315,["339"] = 315,["340"] = 315,["341"] = 315,["342"] = 314,["343"] = 318,["344"] = 319,["345"] = 318,["346"] = 322,["347"] = 323,["348"] = 322,["349"] = 306,["350"] = 305,["351"] = 306});
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
    local juggernautExtraRecast = JuggernautExtraRecast:findOne(self.caster)
    if juggernautExtraRecast ~= nil then
        juggernautExtraRecast:SetHealingWardIndex(healingWard:GetEntityIndex())
    end
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
    local ____self_particleIds_2 = self.particleIds
    ____self_particleIds_2[#____self_particleIds_2 + 1] = particleId
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
    local ____self_particleIds_3 = self.particleIds
    ____self_particleIds_3[#____self_particleIds_3 + 1] = particleId
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
