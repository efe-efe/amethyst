--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 11,["19"] = 19,["20"] = 19,["21"] = 19,["22"] = 19,["23"] = 19,["24"] = 19,["25"] = 19,["26"] = 27,["28"] = 27,["29"] = 34,["30"] = 34,["31"] = 34,["33"] = 27,["34"] = 28,["35"] = 31,["36"] = 36,["37"] = 37,["38"] = 38,["39"] = 40,["40"] = 41,["41"] = 42,["42"] = 43,["43"] = 44,["44"] = 45,["45"] = 46,["46"] = 34,["47"] = 49,["48"] = 50,["49"] = 52,["50"] = 52,["51"] = 52,["52"] = 53,["53"] = 53,["54"] = 53,["55"] = 53,["56"] = 53,["57"] = 53,["58"] = 53,["59"] = 54,["60"] = 55,["62"] = 49,["63"] = 59,["64"] = 60,["65"] = 62,["66"] = 63,["67"] = 64,["68"] = 65,["69"] = 67,["70"] = 59,["71"] = 71,["72"] = 71,["74"] = 76,["75"] = 77,["76"] = 78,["77"] = 79,["78"] = 80,["81"] = 84,["82"] = 85,["83"] = 87,["84"] = 88,["85"] = 88,["88"] = 88,["89"] = 88,["90"] = 88,["91"] = 88,["92"] = 88,["94"] = 93,["95"] = 98,["97"] = 101,["98"] = 102,["99"] = 103,["100"] = 104,["101"] = 105,["102"] = 106,["108"] = 113,["109"] = 114,["112"] = 118,["113"] = 118,["117"] = 121,["118"] = 122,["119"] = 121,["120"] = 125,["121"] = 125,["122"] = 130,["123"] = 130,["124"] = 130,["125"] = 135,["126"] = 130,["127"] = 131,["128"] = 132,["129"] = 133,["130"] = 135,["131"] = 139,["132"] = 140,["133"] = 141,["134"] = 142,["135"] = 144,["136"] = 144,["137"] = 144,["138"] = 145,["139"] = 146,["141"] = 144,["142"] = 144,["143"] = 139,["144"] = 155,["146"] = 155,["147"] = 160,["148"] = 155,["149"] = 156,["150"] = 157,["151"] = 158,["152"] = 160,["153"] = 164,["154"] = 165,["155"] = 166,["156"] = 168,["157"] = 169,["158"] = 172,["159"] = 172,["160"] = 172,["161"] = 173,["162"] = 174,["163"] = 175,["164"] = 176,["165"] = 177,["167"] = 172,["168"] = 172,["169"] = 164,["170"] = 182,["171"] = 183,["172"] = 184,["173"] = 187,["174"] = 194,["175"] = 194,["177"] = 194,["178"] = 194,["179"] = 194,["180"] = 194,["181"] = 194,["182"] = 194,["185"] = 202,["187"] = 202,["188"] = 208,["189"] = 202,["191"] = 209,["192"] = 209,["193"] = 209,["194"] = 209,["195"] = 209,["196"] = 209,["198"] = 203,["199"] = 204,["200"] = 205,["201"] = 206,["202"] = 208,["203"] = 212,["204"] = 213,["205"] = 214,["206"] = 215,["207"] = 216,["209"] = 218,["210"] = 218,["211"] = 219,["212"] = 220,["213"] = 222,["214"] = 227,["219"] = 239,["221"] = 239,["222"] = 245,["223"] = 239,["224"] = 240,["225"] = 241,["226"] = 242,["227"] = 243,["228"] = 245,["229"] = 249,["230"] = 250,["231"] = 251,["232"] = 252,["233"] = 253,["234"] = 255,["235"] = 255,["236"] = 255,["237"] = 256,["238"] = 257,["239"] = 261,["241"] = 255,["242"] = 255,["243"] = 249,["245"] = 267,["246"] = 267,["249"] = 267,["250"] = 267,["251"] = 267,["252"] = 267,["257"] = 274,["259"] = 285,["260"] = 282,["261"] = 283,["262"] = 286,["263"] = 287,["264"] = 288,["265"] = 290,["266"] = 291,["268"] = 293,["270"] = 296,["271"] = 297,["272"] = 298,["273"] = 285,["274"] = 301,["275"] = 302,["276"] = 301,["277"] = 305,["278"] = 306,["279"] = 308,["280"] = 309,["281"] = 310,["283"] = 312,["284"] = 313,["286"] = 315,["287"] = 316,["289"] = 318,["290"] = 319,["293"] = 323,["294"] = 324,["295"] = 325,["296"] = 325,["297"] = 325,["298"] = 325,["299"] = 325,["301"] = 328,["302"] = 329,["304"] = 332,["305"] = 333,["306"] = 334,["307"] = 335,["308"] = 336,["309"] = 337,["311"] = 339,["314"] = 305,["316"] = 345,["317"] = 345,["318"] = 345,["319"] = 346,["320"] = 348,["321"] = 348,["324"] = 348,["325"] = 348,["326"] = 348,["327"] = 348,["329"] = 353,["331"] = 356,["332"] = 357,["333"] = 357,["334"] = 357,["335"] = 358,["336"] = 359,["337"] = 360,["339"] = 357,["340"] = 357,["341"] = 363,["342"] = 356,["344"] = 367,["345"] = 367,["348"] = 367,["349"] = 367,["350"] = 367,["351"] = 367,["352"] = 367,["353"] = 367,["354"] = 367,["357"] = 376,["358"] = 377,["359"] = 378,["361"] = 380,["362"] = 381,["363"] = 376,["364"] = 384,["365"] = 385,["366"] = 386,["367"] = 387,["369"] = 384,["370"] = 391,["371"] = 392,["372"] = 391,["373"] = 274});
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
    UnitEntity.prototype.____constructor(self, origin, "npc_dota_creature_amethyst")
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
