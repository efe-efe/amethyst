--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 9,["19"] = 9,["20"] = 12,["21"] = 21,["22"] = 21,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 30,["30"] = 30,["31"] = 30,["32"] = 33,["33"] = 33,["34"] = 33,["36"] = 30,["37"] = 31,["38"] = 33,["39"] = 37,["40"] = 38,["41"] = 40,["42"] = 40,["43"] = 40,["44"] = 41,["45"] = 41,["46"] = 41,["47"] = 41,["48"] = 41,["49"] = 41,["50"] = 41,["51"] = 42,["52"] = 43,["54"] = 37,["55"] = 47,["56"] = 30,["57"] = 49,["58"] = 47,["59"] = 53,["60"] = 53,["61"] = 57,["62"] = 58,["63"] = 58,["64"] = 58,["65"] = 58,["66"] = 58,["67"] = 58,["68"] = 58,["69"] = 58,["70"] = 58,["71"] = 57,["72"] = 69,["73"] = 70,["74"] = 69,["75"] = 73,["76"] = 74,["77"] = 74,["78"] = 74,["79"] = 74,["80"] = 73,["81"] = 77,["82"] = 78,["83"] = 77,["84"] = 81,["85"] = 82,["86"] = 83,["87"] = 84,["88"] = 85,["89"] = 87,["90"] = 88,["92"] = 81,["93"] = 92,["94"] = 92,["95"] = 92,["96"] = 92,["97"] = 95,["98"] = 92,["99"] = 93,["100"] = 95,["101"] = 99,["102"] = 100,["103"] = 102,["104"] = 102,["105"] = 102,["106"] = 103,["107"] = 104,["108"] = 104,["109"] = 104,["111"] = 102,["112"] = 102,["113"] = 99,["114"] = 109,["115"] = 110,["116"] = 111,["117"] = 114,["118"] = 121,["119"] = 121,["120"] = 121,["121"] = 121,["122"] = 121,["123"] = 121,["124"] = 121,["125"] = 121,["126"] = 121,["127"] = 121,["128"] = 109,["129"] = 128,["130"] = 128,["131"] = 128,["132"] = 133,["133"] = 128,["134"] = 129,["135"] = 130,["136"] = 131,["137"] = 133,["138"] = 137,["139"] = 138,["140"] = 139,["141"] = 140,["142"] = 142,["143"] = 142,["144"] = 142,["145"] = 143,["146"] = 144,["148"] = 142,["149"] = 142,["150"] = 137,["151"] = 153,["152"] = 153,["153"] = 153,["154"] = 158,["155"] = 153,["156"] = 154,["157"] = 155,["158"] = 156,["159"] = 158,["160"] = 162,["161"] = 163,["162"] = 164,["163"] = 166,["164"] = 167,["165"] = 170,["166"] = 170,["167"] = 170,["168"] = 171,["169"] = 172,["170"] = 173,["171"] = 174,["172"] = 175,["174"] = 170,["175"] = 170,["176"] = 162,["177"] = 180,["178"] = 181,["179"] = 182,["180"] = 185,["181"] = 192,["182"] = 192,["183"] = 192,["184"] = 192,["185"] = 192,["186"] = 192,["187"] = 192,["188"] = 192,["189"] = 192,["190"] = 192,["191"] = 180,["192"] = 200,["193"] = 200,["194"] = 200,["195"] = 206,["196"] = 200,["198"] = 207,["199"] = 207,["200"] = 207,["201"] = 207,["202"] = 207,["203"] = 207,["205"] = 201,["206"] = 202,["207"] = 203,["208"] = 204,["209"] = 206,["210"] = 210,["211"] = 211,["212"] = 212,["213"] = 213,["214"] = 214,["215"] = 216,["216"] = 216,["217"] = 216,["218"] = 217,["219"] = 218,["220"] = 220,["221"] = 225,["223"] = 216,["224"] = 216,["225"] = 210,["226"] = 237,["227"] = 237,["228"] = 237,["229"] = 243,["230"] = 237,["231"] = 238,["232"] = 239,["233"] = 240,["234"] = 241,["235"] = 243,["236"] = 247,["237"] = 248,["238"] = 249,["239"] = 250,["240"] = 251,["241"] = 253,["242"] = 253,["243"] = 253,["244"] = 254,["245"] = 255,["246"] = 259,["248"] = 253,["249"] = 253,["250"] = 247,["251"] = 264,["252"] = 265,["253"] = 265,["254"] = 265,["255"] = 265,["256"] = 265,["257"] = 265,["258"] = 265,["259"] = 265,["260"] = 265,["261"] = 264,["262"] = 272,["263"] = 272,["264"] = 272,["265"] = 272,["266"] = 283,["267"] = 280,["268"] = 281,["269"] = 284,["270"] = 285,["271"] = 286,["272"] = 288,["273"] = 289,["275"] = 291,["277"] = 294,["278"] = 295,["279"] = 296,["280"] = 283,["281"] = 299,["282"] = 300,["283"] = 299,["284"] = 303,["285"] = 304,["286"] = 306,["287"] = 307,["288"] = 308,["290"] = 310,["291"] = 311,["293"] = 313,["294"] = 314,["296"] = 316,["297"] = 317,["300"] = 321,["301"] = 322,["302"] = 323,["303"] = 323,["304"] = 323,["305"] = 323,["306"] = 323,["308"] = 326,["309"] = 327,["311"] = 330,["312"] = 331,["313"] = 332,["314"] = 333,["315"] = 334,["316"] = 335,["318"] = 337,["321"] = 303,["322"] = 342,["323"] = 343,["324"] = 343,["325"] = 343,["326"] = 344,["327"] = 346,["328"] = 346,["329"] = 346,["330"] = 346,["331"] = 346,["332"] = 346,["333"] = 346,["334"] = 346,["335"] = 346,["336"] = 351,["337"] = 342,["338"] = 354,["339"] = 355,["340"] = 355,["341"] = 355,["342"] = 356,["343"] = 357,["344"] = 358,["346"] = 355,["347"] = 355,["348"] = 361,["349"] = 354,["350"] = 364,["351"] = 365,["352"] = 365,["353"] = 365,["354"] = 365,["355"] = 365,["356"] = 365,["357"] = 365,["358"] = 365,["359"] = 365,["360"] = 365,["361"] = 365,["362"] = 365,["363"] = 364,["364"] = 374,["365"] = 375,["366"] = 376,["368"] = 378,["369"] = 379,["370"] = 374,["371"] = 382,["372"] = 383,["373"] = 384,["374"] = 385,["376"] = 382,["377"] = 389,["378"] = 390,["379"] = 389,["380"] = 272,["381"] = 272});
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
__TS__ClassExtends(Gem, BreakableBounty)
function Gem.prototype.____constructor(self, origin, particle, model, scale)
    if scale == nil then
        scale = 1
    end
    BreakableBounty.prototype.____constructor(self, origin, {particle = particle, model = model, scale = scale, health = 100})
    self.type = ____exports.GemTypes.NO_TYPE
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
