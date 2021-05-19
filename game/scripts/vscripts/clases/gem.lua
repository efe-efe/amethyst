--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 11,["19"] = 19,["20"] = 19,["21"] = 19,["22"] = 19,["23"] = 19,["24"] = 19,["25"] = 19,["26"] = 27,["27"] = 27,["28"] = 27,["29"] = 34,["30"] = 34,["31"] = 34,["33"] = 27,["34"] = 28,["35"] = 31,["36"] = 39,["37"] = 40,["38"] = 41,["39"] = 43,["40"] = 44,["41"] = 45,["42"] = 46,["43"] = 47,["44"] = 48,["45"] = 49,["46"] = 34,["47"] = 52,["48"] = 53,["49"] = 55,["50"] = 55,["51"] = 55,["52"] = 56,["53"] = 56,["54"] = 56,["55"] = 56,["56"] = 56,["57"] = 56,["58"] = 56,["59"] = 57,["60"] = 58,["62"] = 52,["63"] = 62,["64"] = 63,["65"] = 65,["68"] = 69,["69"] = 70,["70"] = 71,["71"] = 72,["72"] = 74,["73"] = 62,["74"] = 78,["75"] = 78,["76"] = 82,["77"] = 83,["78"] = 84,["79"] = 85,["80"] = 86,["81"] = 87,["82"] = 82,["83"] = 90,["84"] = 91,["85"] = 92,["86"] = 94,["87"] = 95,["88"] = 95,["89"] = 95,["90"] = 95,["91"] = 95,["92"] = 95,["93"] = 95,["94"] = 95,["95"] = 95,["96"] = 95,["97"] = 100,["98"] = 105,["99"] = 90,["100"] = 108,["101"] = 109,["102"] = 109,["103"] = 109,["104"] = 109,["105"] = 109,["106"] = 109,["107"] = 109,["108"] = 109,["109"] = 109,["110"] = 108,["111"] = 120,["112"] = 121,["113"] = 120,["114"] = 124,["115"] = 125,["116"] = 125,["117"] = 125,["118"] = 125,["119"] = 124,["120"] = 128,["121"] = 129,["122"] = 128,["123"] = 132,["124"] = 132,["125"] = 137,["126"] = 137,["127"] = 137,["128"] = 142,["129"] = 137,["130"] = 138,["131"] = 139,["132"] = 140,["133"] = 142,["134"] = 146,["135"] = 147,["136"] = 148,["137"] = 149,["138"] = 151,["139"] = 151,["140"] = 151,["141"] = 152,["142"] = 153,["144"] = 151,["145"] = 151,["146"] = 146,["147"] = 162,["148"] = 162,["149"] = 162,["150"] = 167,["151"] = 162,["152"] = 163,["153"] = 164,["154"] = 165,["155"] = 167,["156"] = 171,["157"] = 172,["158"] = 173,["159"] = 175,["160"] = 176,["161"] = 179,["162"] = 179,["163"] = 179,["164"] = 180,["165"] = 181,["166"] = 182,["167"] = 183,["168"] = 184,["170"] = 179,["171"] = 179,["172"] = 171,["173"] = 189,["174"] = 190,["175"] = 191,["176"] = 194,["177"] = 201,["178"] = 201,["179"] = 201,["180"] = 201,["181"] = 201,["182"] = 201,["183"] = 201,["184"] = 201,["185"] = 201,["186"] = 201,["187"] = 189,["188"] = 209,["189"] = 209,["190"] = 209,["191"] = 215,["192"] = 209,["194"] = 216,["195"] = 216,["196"] = 216,["197"] = 216,["198"] = 216,["199"] = 216,["201"] = 210,["202"] = 211,["203"] = 212,["204"] = 213,["205"] = 215,["206"] = 219,["207"] = 220,["208"] = 221,["209"] = 222,["210"] = 223,["211"] = 225,["212"] = 225,["213"] = 225,["214"] = 226,["215"] = 227,["216"] = 229,["217"] = 234,["219"] = 225,["220"] = 225,["221"] = 219,["222"] = 246,["223"] = 246,["224"] = 246,["225"] = 252,["226"] = 246,["227"] = 247,["228"] = 248,["229"] = 249,["230"] = 250,["231"] = 252,["232"] = 256,["233"] = 257,["234"] = 258,["235"] = 259,["236"] = 260,["237"] = 262,["238"] = 262,["239"] = 262,["240"] = 263,["241"] = 264,["242"] = 268,["244"] = 262,["245"] = 262,["246"] = 256,["247"] = 273,["248"] = 274,["249"] = 274,["250"] = 274,["251"] = 274,["252"] = 274,["253"] = 274,["254"] = 274,["255"] = 274,["256"] = 274,["257"] = 273,["258"] = 281,["259"] = 281,["260"] = 281,["261"] = 281,["262"] = 292,["263"] = 289,["264"] = 290,["265"] = 293,["266"] = 294,["267"] = 295,["268"] = 297,["269"] = 298,["271"] = 300,["273"] = 303,["274"] = 304,["275"] = 305,["276"] = 292,["277"] = 308,["278"] = 309,["279"] = 308,["280"] = 312,["281"] = 313,["282"] = 315,["283"] = 316,["284"] = 317,["286"] = 319,["287"] = 320,["289"] = 322,["290"] = 323,["292"] = 325,["293"] = 326,["296"] = 330,["297"] = 331,["298"] = 332,["299"] = 332,["300"] = 332,["301"] = 332,["302"] = 332,["304"] = 335,["305"] = 336,["307"] = 339,["308"] = 340,["309"] = 341,["310"] = 342,["311"] = 343,["312"] = 344,["314"] = 346,["317"] = 312,["318"] = 351,["319"] = 352,["320"] = 352,["321"] = 352,["322"] = 353,["323"] = 355,["324"] = 355,["325"] = 355,["326"] = 355,["327"] = 355,["328"] = 355,["329"] = 355,["330"] = 355,["331"] = 355,["332"] = 360,["333"] = 351,["334"] = 363,["335"] = 364,["336"] = 364,["337"] = 364,["338"] = 365,["339"] = 366,["340"] = 367,["342"] = 364,["343"] = 364,["344"] = 370,["345"] = 363,["346"] = 373,["347"] = 374,["348"] = 374,["349"] = 374,["350"] = 374,["351"] = 374,["352"] = 374,["353"] = 374,["354"] = 374,["355"] = 374,["356"] = 374,["357"] = 374,["358"] = 374,["359"] = 373,["360"] = 383,["361"] = 384,["362"] = 385,["363"] = 386,["365"] = 388,["366"] = 389,["367"] = 383,["368"] = 392,["369"] = 393,["370"] = 394,["371"] = 395,["373"] = 392,["374"] = 399,["375"] = 400,["376"] = 399,["377"] = 281,["378"] = 281});
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
