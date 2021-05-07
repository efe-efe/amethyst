--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 11,["19"] = 19,["20"] = 19,["21"] = 19,["22"] = 19,["23"] = 19,["24"] = 19,["25"] = 19,["26"] = 27,["28"] = 27,["29"] = 34,["30"] = 34,["31"] = 34,["33"] = 27,["34"] = 28,["35"] = 31,["36"] = 39,["37"] = 40,["38"] = 41,["39"] = 43,["40"] = 44,["41"] = 45,["42"] = 46,["43"] = 47,["44"] = 48,["45"] = 49,["46"] = 34,["47"] = 52,["48"] = 53,["49"] = 55,["50"] = 55,["51"] = 55,["52"] = 56,["53"] = 56,["54"] = 56,["55"] = 56,["56"] = 56,["57"] = 56,["58"] = 56,["59"] = 57,["60"] = 58,["62"] = 52,["63"] = 62,["64"] = 63,["65"] = 65,["66"] = 66,["67"] = 67,["68"] = 68,["69"] = 70,["70"] = 62,["71"] = 74,["72"] = 74,["74"] = 79,["75"] = 80,["76"] = 81,["77"] = 82,["78"] = 83,["81"] = 87,["82"] = 88,["83"] = 90,["84"] = 91,["85"] = 91,["88"] = 91,["89"] = 91,["90"] = 91,["91"] = 91,["92"] = 91,["94"] = 96,["95"] = 101,["97"] = 104,["98"] = 105,["99"] = 106,["100"] = 107,["101"] = 108,["102"] = 109,["108"] = 116,["109"] = 117,["112"] = 121,["113"] = 121,["117"] = 124,["118"] = 125,["119"] = 124,["120"] = 128,["121"] = 128,["122"] = 133,["123"] = 133,["124"] = 133,["125"] = 138,["126"] = 133,["127"] = 134,["128"] = 135,["129"] = 136,["130"] = 138,["131"] = 142,["132"] = 143,["133"] = 144,["134"] = 145,["135"] = 147,["136"] = 147,["137"] = 147,["138"] = 148,["139"] = 149,["141"] = 147,["142"] = 147,["143"] = 142,["144"] = 158,["146"] = 158,["147"] = 163,["148"] = 158,["149"] = 159,["150"] = 160,["151"] = 161,["152"] = 163,["153"] = 167,["154"] = 168,["155"] = 169,["156"] = 171,["157"] = 172,["158"] = 175,["159"] = 175,["160"] = 175,["161"] = 176,["162"] = 177,["163"] = 178,["164"] = 179,["165"] = 180,["167"] = 175,["168"] = 175,["169"] = 167,["170"] = 185,["171"] = 186,["172"] = 187,["173"] = 190,["174"] = 197,["175"] = 197,["177"] = 197,["178"] = 197,["179"] = 197,["180"] = 197,["181"] = 197,["182"] = 197,["185"] = 205,["187"] = 205,["188"] = 211,["189"] = 205,["191"] = 212,["192"] = 212,["193"] = 212,["194"] = 212,["195"] = 212,["196"] = 212,["198"] = 206,["199"] = 207,["200"] = 208,["201"] = 209,["202"] = 211,["203"] = 215,["204"] = 216,["205"] = 217,["206"] = 218,["207"] = 219,["209"] = 221,["210"] = 221,["211"] = 222,["212"] = 223,["213"] = 225,["214"] = 230,["219"] = 242,["221"] = 242,["222"] = 248,["223"] = 242,["224"] = 243,["225"] = 244,["226"] = 245,["227"] = 246,["228"] = 248,["229"] = 252,["230"] = 253,["231"] = 254,["232"] = 255,["233"] = 256,["234"] = 258,["235"] = 258,["236"] = 258,["237"] = 259,["238"] = 260,["239"] = 264,["241"] = 258,["242"] = 258,["243"] = 252,["245"] = 270,["246"] = 270,["249"] = 270,["250"] = 270,["251"] = 270,["252"] = 270,["257"] = 277,["259"] = 288,["260"] = 285,["261"] = 286,["262"] = 289,["263"] = 290,["264"] = 291,["265"] = 293,["266"] = 294,["268"] = 296,["270"] = 299,["271"] = 300,["272"] = 301,["273"] = 288,["274"] = 304,["275"] = 305,["276"] = 304,["277"] = 308,["278"] = 309,["279"] = 311,["280"] = 312,["281"] = 313,["283"] = 315,["284"] = 316,["286"] = 318,["287"] = 319,["289"] = 321,["290"] = 322,["293"] = 326,["294"] = 327,["295"] = 328,["296"] = 328,["297"] = 328,["298"] = 328,["299"] = 328,["301"] = 331,["302"] = 332,["304"] = 335,["305"] = 336,["306"] = 337,["307"] = 338,["308"] = 339,["309"] = 340,["311"] = 342,["314"] = 308,["316"] = 348,["317"] = 348,["318"] = 348,["319"] = 349,["320"] = 351,["321"] = 351,["324"] = 351,["325"] = 351,["326"] = 351,["327"] = 351,["329"] = 356,["331"] = 359,["332"] = 360,["333"] = 360,["334"] = 360,["335"] = 361,["336"] = 362,["337"] = 363,["339"] = 360,["340"] = 360,["341"] = 366,["342"] = 359,["344"] = 370,["345"] = 370,["348"] = 370,["349"] = 370,["350"] = 370,["351"] = 370,["352"] = 370,["353"] = 370,["354"] = 370,["357"] = 379,["358"] = 380,["359"] = 381,["361"] = 383,["362"] = 384,["363"] = 379,["364"] = 387,["365"] = 388,["366"] = 389,["367"] = 390,["369"] = 387,["370"] = 394,["371"] = 395,["372"] = 394,["373"] = 277});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.GemTypes = {}
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
local GEM_LIGHT_PARTICLE = {[____exports.GemTypes.NO_TYPE] = "", [____exports.GemTypes.AMETHYST] = "particles/generic_gameplay/rune_arcane.vpcf", [____exports.GemTypes.SAPPHIRE] = "particles/generic_gameplay/rune_doubledamage.vpcf", [____exports.GemTypes.RUBY] = "particles/generic_gameplay/rune_haste.vpcf", [____exports.GemTypes.EMERALD] = "particles/generic_gameplay/rune_regeneration.vpcf"}
local GEM_COLOR = {
    [____exports.GemTypes.NO_TYPE] = Vector(0, 0, 0),
    [____exports.GemTypes.AMETHYST] = Vector(255, 26, 243),
    [____exports.GemTypes.SAPPHIRE] = Vector(0, 101, 255),
    [____exports.GemTypes.RUBY] = Vector(255, 26, 0),
    [____exports.GemTypes.EMERALD] = Vector(26, 255, 0)
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
    if not CustomEntities:IsBanished(
        self:GetUnit()
    ) then
        CustomEntities:FullyFaceTowards(
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
    self:Effect(killer)
    self:PlayEffectsOnDeath()
    self:GetUnit():AddNoDraw()
    CustomEntities:GetAlliance(killer):AddAmethsyt()
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
    return CustomEntities:FindUnitsInRadius(
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
                CustomEntities:RefreshCooldowns(ally)
                CustomEntities:TrueHeal(ally, final_heal)
                CustomEntities:GiveManaCustom(ally, final_mana, true, true)
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
                CustomEntities:TrueHeal(ally, final_true_heal)
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
                CustomEntities:GiveEnergy(ally, final_energy, true, true)
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
