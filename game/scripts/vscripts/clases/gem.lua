--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 9,["19"] = 9,["20"] = 12,["21"] = 21,["22"] = 21,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 30,["30"] = 30,["31"] = 30,["32"] = 33,["33"] = 33,["34"] = 33,["36"] = 30,["37"] = 31,["38"] = 33,["39"] = 37,["40"] = 38,["41"] = 40,["42"] = 40,["43"] = 40,["44"] = 41,["45"] = 41,["46"] = 43,["47"] = 43,["48"] = 43,["49"] = 41,["50"] = 41,["51"] = 45,["52"] = 46,["54"] = 37,["55"] = 50,["56"] = 30,["57"] = 52,["58"] = 50,["59"] = 56,["60"] = 56,["61"] = 60,["62"] = 61,["63"] = 61,["64"] = 61,["65"] = 61,["66"] = 61,["67"] = 61,["68"] = 61,["69"] = 61,["70"] = 61,["71"] = 60,["72"] = 74,["73"] = 75,["74"] = 74,["75"] = 78,["76"] = 79,["77"] = 79,["78"] = 79,["79"] = 79,["80"] = 78,["81"] = 82,["82"] = 87,["83"] = 82,["84"] = 90,["85"] = 91,["86"] = 92,["87"] = 93,["88"] = 99,["89"] = 106,["90"] = 107,["92"] = 90,["93"] = 113,["94"] = 113,["95"] = 113,["96"] = 113,["97"] = 116,["98"] = 113,["99"] = 114,["100"] = 116,["101"] = 125,["102"] = 126,["103"] = 128,["104"] = 128,["105"] = 128,["106"] = 129,["107"] = 130,["108"] = 130,["109"] = 130,["111"] = 128,["112"] = 128,["113"] = 125,["114"] = 135,["115"] = 136,["116"] = 137,["117"] = 145,["118"] = 157,["119"] = 157,["120"] = 157,["121"] = 157,["122"] = 161,["123"] = 161,["124"] = 161,["125"] = 161,["126"] = 157,["127"] = 157,["128"] = 135,["129"] = 169,["130"] = 169,["131"] = 169,["132"] = 174,["133"] = 169,["134"] = 170,["135"] = 171,["136"] = 172,["137"] = 174,["138"] = 183,["139"] = 184,["140"] = 185,["141"] = 186,["142"] = 188,["143"] = 188,["144"] = 188,["145"] = 189,["146"] = 190,["148"] = 188,["149"] = 188,["150"] = 183,["151"] = 199,["152"] = 199,["153"] = 199,["154"] = 204,["155"] = 199,["156"] = 200,["157"] = 201,["158"] = 202,["159"] = 204,["160"] = 213,["161"] = 214,["162"] = 215,["163"] = 217,["164"] = 218,["165"] = 220,["166"] = 220,["167"] = 220,["168"] = 221,["169"] = 222,["170"] = 223,["171"] = 224,["172"] = 225,["174"] = 220,["175"] = 220,["176"] = 213,["177"] = 230,["178"] = 231,["179"] = 232,["180"] = 240,["181"] = 252,["182"] = 252,["183"] = 252,["184"] = 252,["185"] = 256,["186"] = 256,["187"] = 256,["188"] = 256,["189"] = 252,["190"] = 252,["191"] = 230,["192"] = 265,["193"] = 265,["194"] = 265,["195"] = 271,["196"] = 265,["198"] = 273,["199"] = 273,["200"] = 273,["201"] = 274,["202"] = 275,["203"] = 276,["205"] = 266,["206"] = 267,["207"] = 268,["208"] = 269,["209"] = 271,["210"] = 280,["211"] = 281,["212"] = 282,["213"] = 283,["214"] = 284,["215"] = 290,["216"] = 290,["217"] = 290,["218"] = 291,["219"] = 292,["220"] = 294,["221"] = 299,["223"] = 290,["224"] = 290,["225"] = 280,["226"] = 316,["227"] = 316,["228"] = 316,["229"] = 322,["230"] = 316,["231"] = 317,["232"] = 318,["233"] = 319,["234"] = 320,["235"] = 322,["236"] = 331,["237"] = 332,["238"] = 333,["239"] = 334,["240"] = 335,["241"] = 337,["242"] = 337,["243"] = 337,["244"] = 338,["245"] = 339,["246"] = 343,["248"] = 337,["249"] = 337,["250"] = 331,["251"] = 348,["252"] = 349,["253"] = 349,["254"] = 349,["255"] = 349,["256"] = 353,["257"] = 353,["258"] = 353,["259"] = 349,["260"] = 349,["261"] = 348,["262"] = 361,["263"] = 361,["264"] = 361,["265"] = 361,["266"] = 372,["267"] = 369,["268"] = 370,["269"] = 373,["270"] = 374,["271"] = 375,["272"] = 377,["273"] = 378,["275"] = 380,["277"] = 383,["278"] = 384,["279"] = 385,["280"] = 372,["281"] = 388,["282"] = 389,["283"] = 388,["284"] = 392,["285"] = 393,["286"] = 395,["287"] = 396,["288"] = 397,["290"] = 399,["291"] = 400,["293"] = 402,["294"] = 403,["296"] = 405,["297"] = 406,["300"] = 410,["301"] = 411,["302"] = 412,["303"] = 412,["304"] = 412,["305"] = 412,["306"] = 412,["308"] = 420,["309"] = 423,["311"] = 426,["312"] = 427,["313"] = 428,["314"] = 429,["315"] = 430,["316"] = 431,["318"] = 433,["321"] = 392,["322"] = 438,["323"] = 439,["324"] = 439,["325"] = 439,["326"] = 440,["327"] = 442,["328"] = 442,["329"] = 442,["330"] = 442,["331"] = 446,["332"] = 446,["333"] = 446,["334"] = 442,["335"] = 442,["336"] = 452,["337"] = 438,["338"] = 455,["339"] = 456,["340"] = 456,["341"] = 456,["342"] = 457,["343"] = 458,["344"] = 459,["346"] = 456,["347"] = 456,["348"] = 462,["349"] = 455,["350"] = 465,["351"] = 466,["352"] = 466,["353"] = 466,["354"] = 466,["355"] = 470,["356"] = 470,["357"] = 470,["358"] = 470,["359"] = 470,["360"] = 470,["361"] = 466,["362"] = 466,["363"] = 465,["364"] = 480,["365"] = 481,["366"] = 482,["368"] = 484,["369"] = 485,["370"] = 480,["371"] = 488,["372"] = 489,["373"] = 490,["374"] = 491,["376"] = 488,["377"] = 495,["378"] = 496,["379"] = 495,["380"] = 361,["381"] = 361});
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
