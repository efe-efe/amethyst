local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 4,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 9,["23"] = 9,["24"] = 10,["25"] = 10,["26"] = 13,["27"] = 13,["28"] = 13,["29"] = 13,["30"] = 13,["31"] = 13,["32"] = 13,["33"] = 13,["34"] = 22,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 22,["41"] = 22,["42"] = 31,["43"] = 31,["44"] = 31,["45"] = 34,["46"] = 34,["47"] = 34,["49"] = 31,["50"] = 32,["51"] = 37,["52"] = 37,["53"] = 37,["54"] = 37,["55"] = 37,["56"] = 37,["57"] = 34,["58"] = 40,["59"] = 41,["60"] = 43,["61"] = 44,["62"] = 44,["63"] = 44,["64"] = 44,["65"] = 44,["66"] = 44,["67"] = 44,["68"] = 45,["69"] = 46,["71"] = 40,["72"] = 50,["73"] = 31,["74"] = 52,["75"] = 50,["76"] = 56,["77"] = 56,["78"] = 60,["79"] = 61,["80"] = 61,["81"] = 61,["82"] = 61,["83"] = 61,["84"] = 61,["85"] = 61,["86"] = 61,["87"] = 61,["88"] = 60,["89"] = 72,["90"] = 73,["91"] = 72,["92"] = 76,["93"] = 77,["94"] = 77,["95"] = 77,["96"] = 77,["97"] = 76,["98"] = 80,["99"] = 81,["100"] = 80,["101"] = 84,["102"] = 85,["103"] = 86,["104"] = 87,["105"] = 88,["106"] = 90,["107"] = 91,["109"] = 84,["110"] = 97,["111"] = 97,["112"] = 97,["113"] = 97,["114"] = 100,["115"] = 97,["116"] = 101,["117"] = 101,["118"] = 101,["119"] = 101,["120"] = 101,["121"] = 101,["122"] = 98,["123"] = 100,["124"] = 104,["125"] = 105,["126"] = 107,["127"] = 107,["128"] = 107,["129"] = 108,["130"] = 109,["132"] = 107,["133"] = 107,["134"] = 104,["135"] = 114,["136"] = 115,["137"] = 116,["138"] = 119,["139"] = 126,["140"] = 126,["141"] = 126,["142"] = 126,["143"] = 130,["144"] = 130,["145"] = 130,["146"] = 130,["147"] = 126,["148"] = 126,["149"] = 114,["150"] = 138,["151"] = 138,["152"] = 138,["153"] = 143,["154"] = 138,["155"] = 144,["156"] = 144,["157"] = 144,["158"] = 144,["159"] = 144,["160"] = 144,["161"] = 139,["162"] = 140,["163"] = 141,["164"] = 143,["165"] = 152,["166"] = 153,["167"] = 154,["168"] = 155,["169"] = 157,["170"] = 157,["171"] = 157,["172"] = 158,["173"] = 159,["175"] = 157,["176"] = 157,["177"] = 152,["178"] = 168,["179"] = 168,["180"] = 168,["181"] = 173,["182"] = 168,["183"] = 174,["184"] = 174,["185"] = 174,["186"] = 174,["187"] = 174,["188"] = 174,["189"] = 169,["190"] = 170,["191"] = 171,["192"] = 173,["193"] = 177,["194"] = 178,["195"] = 179,["196"] = 181,["197"] = 182,["198"] = 184,["199"] = 184,["200"] = 184,["201"] = 185,["202"] = 186,["203"] = 187,["204"] = 188,["205"] = 189,["207"] = 184,["208"] = 184,["209"] = 177,["210"] = 194,["211"] = 195,["212"] = 196,["213"] = 199,["214"] = 206,["215"] = 206,["216"] = 206,["217"] = 206,["218"] = 210,["219"] = 210,["220"] = 210,["221"] = 210,["222"] = 206,["223"] = 206,["224"] = 194,["225"] = 219,["226"] = 219,["227"] = 219,["228"] = 225,["229"] = 219,["230"] = 226,["231"] = 226,["232"] = 226,["233"] = 226,["234"] = 226,["235"] = 226,["236"] = 220,["237"] = 221,["238"] = 222,["239"] = 223,["240"] = 225,["241"] = 234,["242"] = 235,["243"] = 236,["244"] = 237,["245"] = 238,["246"] = 240,["247"] = 240,["248"] = 240,["249"] = 241,["250"] = 242,["251"] = 244,["252"] = 249,["254"] = 240,["255"] = 240,["256"] = 234,["257"] = 261,["258"] = 261,["259"] = 261,["260"] = 267,["261"] = 261,["262"] = 268,["263"] = 268,["264"] = 268,["265"] = 268,["266"] = 268,["267"] = 268,["268"] = 262,["269"] = 263,["270"] = 264,["271"] = 265,["272"] = 267,["273"] = 271,["274"] = 272,["275"] = 273,["276"] = 274,["277"] = 275,["278"] = 277,["279"] = 277,["280"] = 277,["281"] = 278,["282"] = 279,["283"] = 283,["285"] = 277,["286"] = 277,["287"] = 271,["288"] = 288,["289"] = 289,["290"] = 289,["291"] = 289,["292"] = 289,["293"] = 289,["294"] = 289,["295"] = 289,["296"] = 289,["297"] = 289,["298"] = 288,["299"] = 296,["300"] = 296,["301"] = 296,["302"] = 307,["303"] = 304,["304"] = 305,["305"] = 308,["306"] = 309,["307"] = 310,["308"] = 312,["309"] = 313,["311"] = 315,["313"] = 318,["314"] = 319,["315"] = 320,["316"] = 307,["317"] = 323,["318"] = 324,["319"] = 323,["320"] = 327,["321"] = 328,["322"] = 330,["323"] = 331,["324"] = 332,["326"] = 334,["327"] = 335,["329"] = 337,["330"] = 338,["332"] = 340,["333"] = 341,["336"] = 345,["337"] = 346,["338"] = 347,["339"] = 347,["340"] = 347,["341"] = 347,["342"] = 347,["344"] = 350,["345"] = 351,["347"] = 354,["348"] = 355,["349"] = 356,["350"] = 357,["351"] = 358,["352"] = 359,["354"] = 361,["357"] = 327,["358"] = 366,["359"] = 367,["360"] = 368,["361"] = 370,["362"] = 370,["363"] = 370,["364"] = 370,["365"] = 370,["366"] = 370,["367"] = 370,["368"] = 370,["369"] = 370,["370"] = 375,["371"] = 375,["372"] = 366,["373"] = 378,["374"] = 379,["375"] = 379,["376"] = 379,["377"] = 380,["378"] = 381,["379"] = 379,["380"] = 379,["381"] = 383,["382"] = 378,["383"] = 386,["384"] = 387,["385"] = 387,["386"] = 387,["387"] = 387,["388"] = 387,["389"] = 387,["390"] = 387,["391"] = 387,["392"] = 387,["393"] = 387,["394"] = 387,["395"] = 387,["396"] = 386,["397"] = 396,["398"] = 397,["399"] = 398,["401"] = 400,["402"] = 401,["403"] = 396,["404"] = 404,["405"] = 405,["406"] = 406,["407"] = 404,["408"] = 409,["409"] = 410,["410"] = 409});
local ____exports = {}
local ____modifier_gem = require("modifiers.modifier_gem")
local ModifierGem = ____modifier_gem.ModifierGem
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
    ModifierGem:apply(
        self:GetUnit(),
        self:GetUnit(),
        nil,
        {}
    )
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
                ally:AddNewModifier(ally, nil, "modifier_emerald", {duration = self.duration, healPerSecond = final_heal_per_second})
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
            ParticleManager:DestroyParticle(light, false)
            ParticleManager:ReleaseParticleIndex(light)
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
    ParticleManager:DestroyParticle(self.progress_circle, false)
    ParticleManager:ReleaseParticleIndex(self.progress_circle)
end
function GemWrapper.prototype.GetColor(self)
    return GEM_COLOR[self.type]
end
return ____exports
