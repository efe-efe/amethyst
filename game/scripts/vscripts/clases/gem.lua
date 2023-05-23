local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 3,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 9,["23"] = 9,["24"] = 12,["25"] = 12,["26"] = 12,["27"] = 12,["28"] = 12,["29"] = 12,["30"] = 12,["31"] = 12,["32"] = 21,["33"] = 21,["34"] = 21,["35"] = 21,["36"] = 21,["37"] = 21,["38"] = 21,["39"] = 21,["40"] = 30,["41"] = 30,["42"] = 30,["43"] = 33,["44"] = 33,["45"] = 33,["47"] = 30,["48"] = 31,["49"] = 33,["50"] = 37,["51"] = 38,["52"] = 40,["53"] = 41,["54"] = 41,["55"] = 43,["56"] = 43,["57"] = 43,["58"] = 41,["59"] = 41,["60"] = 45,["61"] = 46,["63"] = 37,["64"] = 50,["65"] = 30,["66"] = 52,["67"] = 50,["68"] = 56,["69"] = 56,["70"] = 60,["71"] = 61,["72"] = 61,["73"] = 61,["74"] = 61,["75"] = 61,["76"] = 61,["77"] = 61,["78"] = 61,["79"] = 61,["80"] = 60,["81"] = 74,["82"] = 75,["83"] = 74,["84"] = 78,["85"] = 79,["86"] = 79,["87"] = 79,["88"] = 79,["89"] = 78,["90"] = 82,["91"] = 87,["92"] = 82,["93"] = 90,["94"] = 91,["95"] = 92,["96"] = 93,["97"] = 99,["98"] = 106,["99"] = 107,["101"] = 90,["102"] = 113,["103"] = 113,["104"] = 113,["105"] = 113,["106"] = 116,["107"] = 113,["108"] = 117,["109"] = 117,["110"] = 117,["111"] = 117,["112"] = 117,["113"] = 117,["114"] = 114,["115"] = 116,["116"] = 125,["117"] = 126,["118"] = 128,["119"] = 128,["120"] = 128,["121"] = 129,["122"] = 130,["124"] = 128,["125"] = 128,["126"] = 125,["127"] = 135,["128"] = 136,["129"] = 137,["130"] = 145,["131"] = 157,["132"] = 157,["133"] = 157,["134"] = 157,["135"] = 161,["136"] = 161,["137"] = 161,["138"] = 161,["139"] = 157,["140"] = 157,["141"] = 135,["142"] = 169,["143"] = 169,["144"] = 169,["145"] = 174,["146"] = 169,["147"] = 175,["148"] = 175,["149"] = 175,["150"] = 175,["151"] = 175,["152"] = 175,["153"] = 170,["154"] = 171,["155"] = 172,["156"] = 174,["157"] = 183,["158"] = 184,["159"] = 185,["160"] = 186,["161"] = 188,["162"] = 188,["163"] = 188,["164"] = 189,["165"] = 190,["167"] = 188,["168"] = 188,["169"] = 183,["170"] = 199,["171"] = 199,["172"] = 199,["173"] = 204,["174"] = 199,["175"] = 205,["176"] = 205,["177"] = 205,["178"] = 205,["179"] = 205,["180"] = 205,["181"] = 200,["182"] = 201,["183"] = 202,["184"] = 204,["185"] = 213,["186"] = 214,["187"] = 215,["188"] = 217,["189"] = 218,["190"] = 220,["191"] = 220,["192"] = 220,["193"] = 221,["194"] = 222,["195"] = 223,["196"] = 224,["197"] = 225,["199"] = 220,["200"] = 220,["201"] = 213,["202"] = 230,["203"] = 231,["204"] = 232,["205"] = 240,["206"] = 252,["207"] = 252,["208"] = 252,["209"] = 252,["210"] = 256,["211"] = 256,["212"] = 256,["213"] = 256,["214"] = 252,["215"] = 252,["216"] = 230,["217"] = 265,["218"] = 265,["219"] = 265,["220"] = 271,["221"] = 265,["222"] = 272,["223"] = 272,["224"] = 272,["225"] = 272,["226"] = 272,["227"] = 272,["228"] = 266,["229"] = 267,["230"] = 268,["231"] = 269,["232"] = 271,["233"] = 280,["234"] = 281,["235"] = 282,["236"] = 283,["237"] = 284,["238"] = 290,["239"] = 290,["240"] = 290,["241"] = 291,["242"] = 292,["243"] = 294,["244"] = 299,["246"] = 290,["247"] = 290,["248"] = 280,["249"] = 316,["250"] = 316,["251"] = 316,["252"] = 322,["253"] = 316,["254"] = 323,["255"] = 323,["256"] = 323,["257"] = 323,["258"] = 323,["259"] = 323,["260"] = 317,["261"] = 318,["262"] = 319,["263"] = 320,["264"] = 322,["265"] = 331,["266"] = 332,["267"] = 333,["268"] = 334,["269"] = 335,["270"] = 337,["271"] = 337,["272"] = 337,["273"] = 338,["274"] = 339,["275"] = 343,["277"] = 337,["278"] = 337,["279"] = 331,["280"] = 348,["281"] = 349,["282"] = 349,["283"] = 349,["284"] = 349,["285"] = 353,["286"] = 353,["287"] = 353,["288"] = 349,["289"] = 349,["290"] = 348,["291"] = 361,["292"] = 361,["293"] = 361,["294"] = 372,["295"] = 369,["296"] = 370,["297"] = 373,["298"] = 374,["299"] = 375,["300"] = 377,["301"] = 378,["303"] = 380,["305"] = 383,["306"] = 384,["307"] = 385,["308"] = 372,["309"] = 388,["310"] = 389,["311"] = 388,["312"] = 392,["313"] = 393,["314"] = 395,["315"] = 396,["316"] = 397,["318"] = 399,["319"] = 400,["321"] = 402,["322"] = 403,["324"] = 405,["325"] = 406,["328"] = 410,["329"] = 411,["330"] = 412,["331"] = 412,["332"] = 412,["333"] = 412,["334"] = 412,["336"] = 420,["337"] = 423,["339"] = 426,["340"] = 427,["341"] = 428,["342"] = 429,["343"] = 430,["344"] = 431,["346"] = 433,["349"] = 392,["350"] = 438,["351"] = 439,["352"] = 440,["353"] = 442,["354"] = 442,["355"] = 442,["356"] = 442,["357"] = 446,["358"] = 446,["359"] = 446,["360"] = 442,["361"] = 442,["362"] = 452,["363"] = 452,["364"] = 438,["365"] = 455,["366"] = 456,["367"] = 456,["368"] = 456,["369"] = 457,["370"] = 458,["371"] = 459,["373"] = 456,["374"] = 456,["375"] = 462,["376"] = 455,["377"] = 465,["378"] = 466,["379"] = 466,["380"] = 466,["381"] = 466,["382"] = 470,["383"] = 470,["384"] = 470,["385"] = 470,["386"] = 470,["387"] = 470,["388"] = 466,["389"] = 466,["390"] = 465,["391"] = 480,["392"] = 481,["393"] = 482,["395"] = 484,["396"] = 485,["397"] = 480,["398"] = 488,["399"] = 489,["400"] = 490,["401"] = 491,["403"] = 488,["404"] = 495,["405"] = 496,["406"] = 495});
local ____exports = {}
local ____breakable_bounty = require("clases.breakable_bounty")
local BreakableBounty = ____breakable_bounty.default
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
local GEM_LIGHT_PARTICLE = {
    [____exports.GemTypes.NO_TYPE] = "",
    [____exports.GemTypes.AMETHYST] = "particles/generic_gameplay/rune_arcane.vpcf",
    [____exports.GemTypes.SAPPHIRE] = "particles/generic_gameplay/rune_doubledamage.vpcf",
    [____exports.GemTypes.RUBY] = "particles/generic_gameplay/rune_haste.vpcf",
    [____exports.GemTypes.EMERALD] = "particles/generic_gameplay/rune_regeneration.vpcf",
    [____exports.GemTypes.DIAMOND] = "particles/generic_gameplay/rune_regeneration.vpcf"
}
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
__TS__ClassExtends(Gem, BreakableBounty)
function Gem.prototype.____constructor(self, origin, particle, model, scale)
    if scale == nil then
        scale = 1
    end
    BreakableBounty.prototype.____constructor(self, origin, {particle = particle, model = model, scale = scale, health = 100})
    self.type = ____exports.GemTypes.NO_TYPE
end
function Gem.prototype.Update(self)
    local currentAngle = GameRules:GetGameTime() % (math.pi * 2) * 2
    if not CustomEntitiesLegacy:IsBanished(self:GetUnit()) then
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
function Gem.prototype.BeforeRemoving(self, killer)
    BreakableBounty.prototype.BeforeRemoving(self, killer)
    CustomEntitiesLegacy:GetAlliance(killer):AddAmethsyt()
end
function Gem.prototype.Effect(self, killer)
end
function Gem.prototype.GetUnits(self, searcher, iTeamFlags)
    return CustomEntitiesLegacy:FindUnitsInRadius(
        searcher,
        self:GetUnit():GetAbsOrigin(),
        FIND_UNITS_EVERYWHERE,
        iTeamFlags,
        DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
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
    return math.ceil(#heroes * value / #allies)
end
function Gem.prototype.PlayEffectsOnSpawn(self)
    local unit = self:GetUnit()
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", unit)
    EFX("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    EFX("particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    if self.particle then
        EFX(self.particle, PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
    end
end
____exports.Diamond = __TS__Class()
local Diamond = ____exports.Diamond
Diamond.name = "Diamond"
__TS__ClassExtends(Diamond, Gem)
function Diamond.prototype.____constructor(self, origin)
    Gem.prototype.____constructor(
        self,
        origin,
        "particles/generic_gameplay/rune_doubledamage.vpcf",
        "models/heroes/oracle/weapon.vmdl",
        3
    )
    self.type = ____exports.GemTypes.DIAMOND
end
function Diamond.prototype.Effect(self, killer)
    local allies = self:GetAllies(killer)
    __TS__ArrayForEach(
        allies,
        function(____, ally)
            if ally:IsRealHero() then
                ally:SetAbilityPoints(ally:GetAbilityPoints() + 1)
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
    Gem.prototype.____constructor(
        self,
        origin,
        "particles/generic_gameplay/rune_doubledamage.vpcf",
        "models/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_sphere.vmdl",
        4
    )
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
    Gem.prototype.____constructor(
        self,
        origin,
        "particles/generic_gameplay/rune_arcane.vpcf",
        "models/heroes/oracle/crystal_ball.vmdl",
        3
    )
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
        origin:__add(Vector(0, 0, 64)),
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
    Gem.prototype.____constructor(
        self,
        origin,
        "particles/generic_gameplay/rune_haste.vpcf",
        "models/items/furion/dark_staff/bulb.vmdl",
        0.5
    )
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
    if math.fmod(self.current_time, self.light_delay_time) == 0 and #self.lights < 5 then
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
    local origin = self.origin:__add(Vector(0, -1, 0):__mul(250))
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
    local ____self_lights_0 = self.lights
    ____self_lights_0[#____self_lights_0 + 1] = efx
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
return ____exports
