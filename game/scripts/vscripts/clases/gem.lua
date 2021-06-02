--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 9,["19"] = 9,["20"] = 12,["21"] = 21,["22"] = 21,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 30,["30"] = 30,["31"] = 30,["32"] = 37,["33"] = 37,["34"] = 37,["36"] = 30,["37"] = 31,["38"] = 34,["39"] = 42,["40"] = 43,["41"] = 44,["42"] = 46,["43"] = 47,["44"] = 48,["45"] = 49,["46"] = 50,["47"] = 51,["48"] = 52,["49"] = 37,["50"] = 55,["51"] = 56,["52"] = 58,["53"] = 58,["54"] = 58,["55"] = 59,["56"] = 59,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 59,["61"] = 59,["62"] = 60,["63"] = 61,["65"] = 55,["66"] = 65,["67"] = 66,["68"] = 68,["71"] = 72,["72"] = 73,["73"] = 74,["74"] = 75,["75"] = 77,["76"] = 65,["77"] = 81,["78"] = 81,["79"] = 85,["80"] = 86,["81"] = 87,["82"] = 88,["83"] = 89,["84"] = 90,["85"] = 85,["86"] = 93,["87"] = 94,["88"] = 95,["89"] = 97,["90"] = 98,["91"] = 98,["92"] = 98,["93"] = 98,["94"] = 98,["95"] = 98,["96"] = 98,["97"] = 98,["98"] = 98,["99"] = 98,["100"] = 103,["101"] = 108,["102"] = 93,["103"] = 111,["104"] = 112,["105"] = 112,["106"] = 112,["107"] = 112,["108"] = 112,["109"] = 112,["110"] = 112,["111"] = 112,["112"] = 112,["113"] = 111,["114"] = 123,["115"] = 124,["116"] = 123,["117"] = 127,["118"] = 128,["119"] = 128,["120"] = 128,["121"] = 128,["122"] = 127,["123"] = 131,["124"] = 132,["125"] = 131,["126"] = 135,["127"] = 135,["128"] = 139,["129"] = 139,["130"] = 139,["131"] = 139,["132"] = 142,["133"] = 139,["134"] = 140,["135"] = 142,["136"] = 146,["137"] = 147,["138"] = 149,["139"] = 149,["140"] = 149,["141"] = 150,["142"] = 151,["143"] = 151,["144"] = 151,["146"] = 149,["147"] = 149,["148"] = 146,["149"] = 156,["150"] = 157,["151"] = 158,["152"] = 161,["153"] = 168,["154"] = 168,["155"] = 168,["156"] = 168,["157"] = 168,["158"] = 168,["159"] = 168,["160"] = 168,["161"] = 168,["162"] = 168,["163"] = 156,["164"] = 175,["165"] = 175,["166"] = 175,["167"] = 180,["168"] = 175,["169"] = 176,["170"] = 177,["171"] = 178,["172"] = 180,["173"] = 184,["174"] = 185,["175"] = 186,["176"] = 187,["177"] = 189,["178"] = 189,["179"] = 189,["180"] = 190,["181"] = 191,["183"] = 189,["184"] = 189,["185"] = 184,["186"] = 200,["187"] = 200,["188"] = 200,["189"] = 205,["190"] = 200,["191"] = 201,["192"] = 202,["193"] = 203,["194"] = 205,["195"] = 209,["196"] = 210,["197"] = 211,["198"] = 213,["199"] = 214,["200"] = 217,["201"] = 217,["202"] = 217,["203"] = 218,["204"] = 219,["205"] = 220,["206"] = 221,["207"] = 222,["209"] = 217,["210"] = 217,["211"] = 209,["212"] = 227,["213"] = 228,["214"] = 229,["215"] = 232,["216"] = 239,["217"] = 239,["218"] = 239,["219"] = 239,["220"] = 239,["221"] = 239,["222"] = 239,["223"] = 239,["224"] = 239,["225"] = 239,["226"] = 227,["227"] = 247,["228"] = 247,["229"] = 247,["230"] = 253,["231"] = 247,["233"] = 254,["234"] = 254,["235"] = 254,["236"] = 254,["237"] = 254,["238"] = 254,["240"] = 248,["241"] = 249,["242"] = 250,["243"] = 251,["244"] = 253,["245"] = 257,["246"] = 258,["247"] = 259,["248"] = 260,["249"] = 261,["250"] = 263,["251"] = 263,["252"] = 263,["253"] = 264,["254"] = 265,["255"] = 267,["256"] = 272,["258"] = 263,["259"] = 263,["260"] = 257,["261"] = 284,["262"] = 284,["263"] = 284,["264"] = 290,["265"] = 284,["266"] = 285,["267"] = 286,["268"] = 287,["269"] = 288,["270"] = 290,["271"] = 294,["272"] = 295,["273"] = 296,["274"] = 297,["275"] = 298,["276"] = 300,["277"] = 300,["278"] = 300,["279"] = 301,["280"] = 302,["281"] = 306,["283"] = 300,["284"] = 300,["285"] = 294,["286"] = 311,["287"] = 312,["288"] = 312,["289"] = 312,["290"] = 312,["291"] = 312,["292"] = 312,["293"] = 312,["294"] = 312,["295"] = 312,["296"] = 311,["297"] = 319,["298"] = 319,["299"] = 319,["300"] = 319,["301"] = 330,["302"] = 327,["303"] = 328,["304"] = 331,["305"] = 332,["306"] = 333,["307"] = 335,["308"] = 336,["310"] = 338,["312"] = 341,["313"] = 342,["314"] = 343,["315"] = 330,["316"] = 346,["317"] = 347,["318"] = 346,["319"] = 350,["320"] = 351,["321"] = 353,["322"] = 354,["323"] = 355,["325"] = 357,["326"] = 358,["328"] = 360,["329"] = 361,["331"] = 363,["332"] = 364,["335"] = 368,["336"] = 369,["337"] = 370,["338"] = 370,["339"] = 370,["340"] = 370,["341"] = 370,["343"] = 373,["344"] = 374,["346"] = 377,["347"] = 378,["348"] = 379,["349"] = 380,["350"] = 381,["351"] = 382,["353"] = 384,["356"] = 350,["357"] = 389,["358"] = 390,["359"] = 390,["360"] = 390,["361"] = 391,["362"] = 393,["363"] = 393,["364"] = 393,["365"] = 393,["366"] = 393,["367"] = 393,["368"] = 393,["369"] = 393,["370"] = 393,["371"] = 398,["372"] = 389,["373"] = 401,["374"] = 402,["375"] = 402,["376"] = 402,["377"] = 403,["378"] = 404,["379"] = 405,["381"] = 402,["382"] = 402,["383"] = 408,["384"] = 401,["385"] = 411,["386"] = 412,["387"] = 412,["388"] = 412,["389"] = 412,["390"] = 412,["391"] = 412,["392"] = 412,["393"] = 412,["394"] = 412,["395"] = 412,["396"] = 412,["397"] = 412,["398"] = 411,["399"] = 421,["400"] = 422,["401"] = 423,["402"] = 424,["404"] = 426,["405"] = 427,["406"] = 421,["407"] = 430,["408"] = 431,["409"] = 432,["410"] = 433,["412"] = 430,["413"] = 437,["414"] = 438,["415"] = 437,["416"] = 319,["417"] = 319});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.GemTypes = GemTypes or ({})
____exports.GemTypes.NO_TYPE = 0
____exports.GemTypes[____exports.GemTypes.NO_TYPE] = "NO_TYPE"
____exports.GemTypes.AMETHYST = 1
____exports.GemTypes[____exports.GemTypes.AMETHYST] = "AMETHYST"
____exports.GemTypes.SAPPHIRE = 2
____exports.GemTypes[____exports.GemTypes.SAPPHIRE] = "SAPPHIRE"
____exports.GemTypes.RUBY = 3
____exports.GemTypes[____exports.GemTypes.RUBY] = "RUBY"
____exports.GemTypes.EMERALD = 4
____exports.GemTypes[____exports.GemTypes.EMERALD] = "EMERALD"
____exports.GemTypes.DIAMOND = 5
____exports.GemTypes[____exports.GemTypes.DIAMOND] = "DIAMOND"
local GEM_LIGHT_PARTICLE = {[____exports.GemTypes.NO_TYPE] = "", [____exports.GemTypes.AMETHYST] = "particles/generic_gameplay/rune_arcane.vpcf", [____exports.GemTypes.SAPPHIRE] = "particles/generic_gameplay/rune_doubledamage.vpcf", [____exports.GemTypes.RUBY] = "particles/generic_gameplay/rune_haste.vpcf", [____exports.GemTypes.EMERALD] = "particles/generic_gameplay/rune_regeneration.vpcf", [____exports.GemTypes.DIAMOND] = "particles/generic_gameplay/rune_regeneration.vpcf"}
local GEM_COLOR = {
    [____exports.GemTypes.NO_TYPE] = Vector(0, 0, 0),
    [____exports.GemTypes.AMETHYST] = Vector(255, 26, 243),
    [____exports.GemTypes.SAPPHIRE] = Vector(0, 101, 255),
    [____exports.GemTypes.RUBY] = Vector(255, 26, 0),
    [____exports.GemTypes.EMERALD] = Vector(26, 255, 0),
    [____exports.GemTypes.DIAMOND] = Vector(26, 255, 0)
}
local Gem = __TS__Class()
Gem.name = "Gem"
__TS__ClassExtends(Gem, UnitEntity)
function Gem.prototype.____constructor(self, origin, particle, model, scale)
    if scale == nil then
        scale = 1
    end
    UnitEntity.prototype.____constructor(self, {properties = {origin = origin, name = "npc_dota_creature_amethyst"}})
    self.max_health = 100
    self.type = ____exports.GemTypes.NO_TYPE
    self.particle = particle
    self.model = model
    self.scale = scale
    local unit = self:GetUnit()
    unit:SetModel(self.model)
    unit:SetModelScale(self.scale)
    unit:SetMaxHealth(self.max_health)
    unit:SetBaseMaxHealth(self.max_health)
    unit:SetHealth(self.max_health)
    self:PlayEffectsOnSpawn()
end
function Gem.prototype.Update(self)
    local currentAngle = (GameRules:GetGameTime() % (math.pi * 2)) * 2
    if not CustomEntitiesLegacy:IsBanished(
        self:GetUnit()
    ) then
        CustomEntitiesLegacy:FullyFaceTowards(
            self:GetUnit(),
            Vector(
                math.cos(currentAngle),
                math.sin(currentAngle)
            )
        )
        self:GetUnit():SetModel(self.model)
        self:GetUnit():SetModelScale(self.scale)
    end
end
function Gem.prototype.OnDeath(self, params)
    local killer = params.killer
    if killer == self.unit then
        return
    end
    self:Effect(killer)
    self:PlayEffectsOnDeath()
    self:GetUnit():AddNoDraw()
    CustomEntitiesLegacy:GetAlliance(killer):AddAmethsyt()
    self:Destroy(false)
end
function Gem.prototype.Effect(self, killer)
end
function Gem.prototype.PlayEffectsOnSpawn(self)
    local unit = self:GetUnit()
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", unit)
    EFX("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX("particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX(self.particle, PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
end
function Gem.prototype.PlayEffectsOnDeath(self)
    local parent = self:GetUnit()
    local origin = parent:GetAbsOrigin()
    EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", parent)
    EFX(
        "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = origin,
            cp2 = Vector(255, 80, 230),
            release = true
        }
    )
    EFX("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = origin, cp5 = origin, release = true})
    self:PlaySpecificEffectsOnDeath()
end
function Gem.prototype.GetUnits(self, searcher, iTeamFlags)
    return CustomEntitiesLegacy:FindUnitsInRadius(
        searcher,
        self:GetUnit():GetAbsOrigin(),
        FIND_UNITS_EVERYWHERE,
        iTeamFlags,
        DOTA_UNIT_TARGET_HERO,
        (DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE) + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
        FIND_ANY_ORDER
    )
end
function Gem.prototype.GetAllies(self, searcher)
    return self:GetUnits(searcher, DOTA_UNIT_TARGET_TEAM_FRIENDLY)
end
function Gem.prototype.GetHeroes(self)
    return self:GetUnits(
        self:GetUnit(),
        DOTA_UNIT_TARGET_TEAM_BOTH
    )
end
function Gem.prototype.ProcessValue(self, allies, heroes, value)
    return math.ceil((#heroes * value) / #allies)
end
function Gem.prototype.PlaySpecificEffectsOnDeath(self)
end
____exports.Diamond = __TS__Class()
local Diamond = ____exports.Diamond
Diamond.name = "Diamond"
__TS__ClassExtends(Diamond, Gem)
function Diamond.prototype.____constructor(self, origin)
    Gem.prototype.____constructor(self, origin, "particles/generic_gameplay/rune_doubledamage.vpcf", "models/heroes/oracle/weapon.vmdl", 3)
    self.type = ____exports.GemTypes.DIAMOND
end
function Diamond.prototype.Effect(self, killer)
    local allies = self:GetAllies(killer)
    __TS__ArrayForEach(
        allies,
        function(____, ally)
            if ally:IsRealHero() then
                ally:SetAbilityPoints(
                    ally:GetAbilityPoints() + 1
                )
            end
        end
    )
end
function Diamond.prototype.PlayEffectsOnTarget(self, target)
    EmitSoundOn("DOTA_Item.Refresher.Activate", target)
    EFX("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, target, {release = true})
    EFX("particles/gems/amethyst.vpcf", PATTACH_CUSTOMORIGIN, target, {cp0 = {ent = target, point = "attach_hitloc"}, release = true})
    EFX(
        "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        target,
        {
            cp1 = target:GetAbsOrigin(),
            cp3 = target:GetAbsOrigin(),
            release = true
        }
    )
end
local Sapphire = __TS__Class()
Sapphire.name = "Sapphire"
__TS__ClassExtends(Sapphire, Gem)
function Sapphire.prototype.____constructor(self, origin)
    Gem.prototype.____constructor(self, origin, "particles/generic_gameplay/rune_doubledamage.vpcf", "models/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_sphere.vmdl", 4)
    self.shield = 20
    self.duration = 10
    self.type = ____exports.GemTypes.SAPPHIRE
end
function Sapphire.prototype.Effect(self, killer)
    local allies = self:GetAllies(killer)
    local heroes = self:GetHeroes()
    local final_shield = self:ProcessValue(allies, heroes, self.shield)
    __TS__ArrayForEach(
        allies,
        function(____, ally)
            if ally:IsRealHero() then
                ally:AddNewModifier(ally, nil, "modifier_sapphire", {duration = self.duration, damage_block = final_shield})
            end
        end
    )
end
local Amethyst = __TS__Class()
Amethyst.name = "Amethyst"
__TS__ClassExtends(Amethyst, Gem)
function Amethyst.prototype.____constructor(self, origin)
    Gem.prototype.____constructor(self, origin, "particles/generic_gameplay/rune_arcane.vpcf", "models/heroes/oracle/crystal_ball.vmdl", 3)
    self.mana_bounty = 25
    self.heal_bounty = 5
    self.type = ____exports.GemTypes.AMETHYST
end
function Amethyst.prototype.Effect(self, killer)
    local allies = self:GetAllies(killer)
    local heroes = self:GetHeroes()
    local final_mana = self:ProcessValue(allies, heroes, self.mana_bounty)
    local final_heal = self:ProcessValue(allies, heroes, self.heal_bounty)
    __TS__ArrayForEach(
        allies,
        function(____, ally)
            if ally:IsRealHero() then
                CustomEntitiesLegacy:RefreshCooldowns(ally)
                CustomEntitiesLegacy:TrueHeal(ally, final_heal)
                CustomEntitiesLegacy:GiveManaCustom(ally, final_mana, true, true)
                self:PlayEffectsOnTarget(ally)
            end
        end
    )
end
function Amethyst.prototype.PlayEffectsOnTarget(self, target)
    EmitSoundOn("DOTA_Item.Refresher.Activate", target)
    EFX("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, target, {release = true})
    EFX("particles/gems/amethyst.vpcf", PATTACH_CUSTOMORIGIN, target, {cp0 = {ent = target, point = "attach_hitloc"}, release = true})
    EFX(
        "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        target,
        {
            cp1 = target:GetAbsOrigin(),
            cp3 = target:GetAbsOrigin(),
            release = true
        }
    )
end
local Emerald = __TS__Class()
Emerald.name = "Emerald"
__TS__ClassExtends(Emerald, Gem)
function Emerald.prototype.____constructor(self, origin)
    Gem.prototype.____constructor(
        self,
        origin:__add(
            Vector(0, 0, 64)
        ),
        "particles/generic_gameplay/rune_regeneration.vpcf",
        "models/items/rubick/rubick_arcana/rubick_arcana_cube.vmdl",
        0.45
    )
    self.heal_per_second = 2
    self.true_heal = 10
    self.duration = 8
    self.type = ____exports.GemTypes.EMERALD
end
function Emerald.prototype.Effect(self, killer)
    local allies = self:GetAllies(killer)
    local heroes = self:GetHeroes()
    local final_true_heal = self:ProcessValue(allies, heroes, self.true_heal)
    local final_heal_per_second = self:ProcessValue(allies, heroes, self.heal_per_second)
    __TS__ArrayForEach(
        allies,
        function(____, ally)
            if ally:IsRealHero() then
                CustomEntitiesLegacy:TrueHeal(ally, final_true_heal)
                ally:AddNewModifier(ally, nil, "modifier_emerald", {duration = self.duration, heal_per_second = final_heal_per_second})
                EFX("particles/gems/emerald.vpcf", PATTACH_ABSORIGIN_FOLLOW, ally, {cp3 = {ent = ally, point = "attach_hitloc"}, release = true})
            end
        end
    )
end
local Ruby = __TS__Class()
Ruby.name = "Ruby"
__TS__ClassExtends(Ruby, Gem)
function Ruby.prototype.____constructor(self, origin)
    Gem.prototype.____constructor(self, origin, "particles/generic_gameplay/rune_haste.vpcf", "models/items/furion/dark_staff/bulb.vmdl", 0.5)
    self.duration = 10
    self.energy_bounty = 25
    self.damage = 3
    self.type = ____exports.GemTypes.RUBY
end
function Ruby.prototype.Effect(self, killer)
    local allies = self:GetAllies(killer)
    local heroes = self:GetHeroes()
    local final_damage = self:ProcessValue(allies, heroes, self.damage)
    local final_energy = self:ProcessValue(allies, heroes, self.energy_bounty)
    __TS__ArrayForEach(
        allies,
        function(____, ally)
            if ally:IsRealHero() then
                ally:AddNewModifier(ally, nil, "modifier_ruby", {duration = self.duration, damage = final_damage})
                CustomEntitiesLegacy:GiveEnergy(ally, final_energy, true, true)
            end
        end
    )
end
function Ruby.prototype.PlaySpecificEffectsOnDeath(self)
    EFX(
        "particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = GetGroundPosition(self.origin, nil),
            release = true
        }
    )
end
____exports.default = (function()
    ____exports.default = __TS__Class()
    local GemWrapper = ____exports.default
    GemWrapper.name = "GemWrapper"
    function GemWrapper.prototype.____constructor(self, delay, origin, ____type)
        self.destroyed = false
        self.lights = {}
        self.delay_time = delay * 30
        self.current_time = delay * 30
        self.light_delay_time = self.delay_time / 5
        if not ____type then
            self.type = RandomInt(____exports.GemTypes.AMETHYST, ____exports.GemTypes.EMERALD)
        else
            self.type = ____type
        end
        self.origin = origin
        self:CreateLight()
        self.progress_circle = self:CreateProgressCircle()
    end
    function GemWrapper.prototype.Alive(self)
        return not self.destroyed
    end
    function GemWrapper.prototype.Update(self)
        self.current_time = self.current_time - 1
        if self.current_time == 0 then
            if self.type == ____exports.GemTypes.AMETHYST then
                self.entity = __TS__New(Amethyst, self.origin)
            end
            if self.type == ____exports.GemTypes.SAPPHIRE then
                self.entity = __TS__New(Sapphire, self.origin)
            end
            if self.type == ____exports.GemTypes.RUBY then
                self.entity = __TS__New(Ruby, self.origin)
            end
            if self.type == ____exports.GemTypes.EMERALD then
                self.entity = __TS__New(Emerald, self.origin)
            end
        end
        local percentage = (self.delay_time - self.current_time) / self.delay_time
        if percentage <= 1 then
            ParticleManager:SetParticleControl(
                self.progress_circle,
                1,
                Vector(250, percentage, 0)
            )
        end
        if (math.fmod(self.current_time, self.light_delay_time) == 0) and (#self.lights < 5) then
            self:CreateLight()
        end
        if self.entity then
            if not self.entity:Alive() then
                self.entity = nil
                self.destroyed = true
                self:DestroyProgressCircle()
                self:CleanLights()
            else
                self.entity:Update()
            end
        end
    end
    function GemWrapper.prototype.CreateLight(self)
        local origin = self.origin:__add(
            Vector(0, -1, 0):__mul(250)
        )
        origin = RotatePoint(self.origin, origin, 72 * #self.lights)
        local efx = EFX(
            GEM_LIGHT_PARTICLE[self.type],
            PATTACH_WORLDORIGIN,
            nil,
            {
                cp0 = GetGroundPosition(origin, nil),
                release = false
            }
        )
        __TS__ArrayPush(self.lights, efx)
    end
    function GemWrapper.prototype.CleanLights(self)
        __TS__ArrayForEach(
            self.lights,
            function(____, light)
                if light then
                    ParticleManager:DestroyParticle(light, false)
                    ParticleManager:ReleaseParticleIndex(light)
                end
            end
        )
        self.lights = {}
    end
    function GemWrapper.prototype.CreateProgressCircle(self)
        return EFX(
            "particles/progress_circle/generic_progress_circle.vpcf",
            PATTACH_WORLDORIGIN,
            nil,
            {
                cp0f = Vector(0, -1, 0),
                cp0 = self.origin - Vector(0, 0, 120),
                cp1 = Vector(250, 0, 1),
                cp15 = GEM_COLOR[self.type],
                cp16 = Vector(1, 0, 0)
            }
        )
    end
    function GemWrapper.prototype.Destroy(self, remove)
        if self.entity then
            self.entity:GetUnit():ForceKill(false)
            self.entity:Destroy(remove)
        end
        self:DestroyProgressCircle()
        self:CleanLights()
    end
    function GemWrapper.prototype.DestroyProgressCircle(self)
        if self.progress_circle then
            ParticleManager:DestroyParticle(self.progress_circle, false)
            ParticleManager:ReleaseParticleIndex(self.progress_circle)
        end
    end
    function GemWrapper.prototype.GetColor(self)
        return GEM_COLOR[self.type]
    end
    return GemWrapper
end)()
return ____exports
