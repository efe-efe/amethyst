--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 7,["16"] = 9,["17"] = 9,["18"] = 9,["19"] = 9,["20"] = 9,["21"] = 9,["22"] = 9,["23"] = 9,["24"] = 9,["25"] = 16,["26"] = 16,["27"] = 16,["28"] = 16,["29"] = 16,["30"] = 16,["31"] = 16,["32"] = 16,["33"] = 16,["34"] = 16,["35"] = 16,["36"] = 28,["37"] = 28,["38"] = 28,["39"] = 28,["40"] = 28,["41"] = 29,["42"] = 30,["43"] = 30,["44"] = 30,["45"] = 30,["46"] = 28,["47"] = 32,["48"] = 33,["49"] = 29,["50"] = 35,["52"] = 36,["53"] = 36,["54"] = 37,["55"] = 38,["56"] = 39,["57"] = 40,["60"] = 36,["63"] = 35,["64"] = 45,["65"] = 46,["66"] = 47,["67"] = 48,["68"] = 48,["69"] = 48,["70"] = 49,["71"] = 49,["72"] = 49,["73"] = 50,["74"] = 51,["75"] = 53,["76"] = 54,["77"] = 54,["78"] = 54,["79"] = 54,["80"] = 54,["81"] = 54,["82"] = 54,["83"] = 55,["84"] = 55,["85"] = 55,["86"] = 55,["87"] = 55,["88"] = 55,["89"] = 55,["90"] = 55,["91"] = 55,["92"] = 56,["93"] = 56,["94"] = 56,["95"] = 56,["96"] = 56,["97"] = 56,["98"] = 56,["99"] = 56,["101"] = 59,["102"] = 60,["103"] = 61,["105"] = 64,["106"] = 66,["107"] = 67,["109"] = 69,["110"] = 70,["112"] = 73,["113"] = 74,["114"] = 74,["115"] = 74,["116"] = 74,["117"] = 74,["118"] = 74,["119"] = 74,["120"] = 74,["121"] = 74,["122"] = 74,["123"] = 74,["125"] = 86,["126"] = 86,["127"] = 87,["128"] = 88,["129"] = 89,["130"] = 90,["133"] = 86,["137"] = 96,["138"] = 97,["139"] = 98,["142"] = 102,["143"] = 103,["144"] = 45,["145"] = 105,["146"] = 106,["147"] = 107,["148"] = 108,["149"] = 110,["150"] = 111,["151"] = 112,["153"] = 114,["154"] = 115,["156"] = 117,["157"] = 118,["158"] = 119,["160"] = 121,["161"] = 122,["162"] = 123,["163"] = 124,["165"] = 126,["166"] = 127,["167"] = 128,["168"] = 129,["170"] = 131,["171"] = 132,["173"] = 134,["174"] = 135,["175"] = 136,["177"] = 138,["178"] = 139,["179"] = 140,["181"] = 142,["182"] = 143,["183"] = 144,["185"] = 146,["186"] = 147,["187"] = 148,["190"] = 151,["191"] = 152,["192"] = 153,["193"] = 154,["195"] = 156,["196"] = 157,["197"] = 158,["198"] = 159,["200"] = 161,["201"] = 162,["202"] = 163,["205"] = 166,["206"] = 167,["207"] = 168,["208"] = 169,["210"] = 171,["211"] = 172,["212"] = 173,["215"] = 176,["216"] = 177,["217"] = 178,["218"] = 179,["220"] = 181,["221"] = 182,["222"] = 183,["224"] = 185,["225"] = 186,["226"] = 187,["229"] = 190,["230"] = 191,["231"] = 192,["232"] = 193,["234"] = 195,["235"] = 196,["237"] = 198,["238"] = 199,["240"] = 201,["241"] = 202,["242"] = 203,["245"] = 206,["246"] = 207,["247"] = 208,["249"] = 210,["250"] = 211,["251"] = 212,["253"] = 214,["254"] = 215,["255"] = 216,["257"] = 218,["258"] = 219,["261"] = 223,["262"] = 105,["263"] = 225,["264"] = 226,["265"] = 227,["266"] = 229,["267"] = 230,["268"] = 231,["270"] = 233,["271"] = 234,["272"] = 235,["274"] = 237,["275"] = 238,["276"] = 239,["278"] = 241,["279"] = 242,["280"] = 243,["282"] = 245,["283"] = 246,["284"] = 247,["285"] = 248,["287"] = 251,["288"] = 252,["289"] = 253,["292"] = 256,["293"] = 257,["294"] = 258,["296"] = 260,["297"] = 261,["300"] = 264,["301"] = 225,["302"] = 266,["303"] = 267,["304"] = 268,["305"] = 270,["306"] = 271,["307"] = 272,["309"] = 275,["310"] = 276,["311"] = 277,["312"] = 278,["313"] = 280,["314"] = 281,["316"] = 283,["319"] = 286,["320"] = 286,["321"] = 287,["322"] = 288,["323"] = 289,["326"] = 286,["330"] = 295,["331"] = 299,["334"] = 302,["335"] = 303,["336"] = 304,["339"] = 307,["341"] = 310,["342"] = 311,["343"] = 312,["344"] = 312,["345"] = 312,["346"] = 314,["347"] = 315,["348"] = 316,["349"] = 316,["350"] = 316,["351"] = 316,["352"] = 316,["353"] = 316,["354"] = 316,["355"] = 316,["356"] = 316,["357"] = 317,["358"] = 317,["359"] = 317,["360"] = 317,["361"] = 317,["362"] = 317,["363"] = 317,["367"] = 266,["368"] = 322,["369"] = 28,["370"] = 324,["371"] = 322,["372"] = 28,["373"] = 28,["374"] = 327,["375"] = 327,["376"] = 327,["377"] = 327,["378"] = 328,["379"] = 327,["380"] = 330,["381"] = 331,["382"] = 328,["383"] = 334,["384"] = 334,["385"] = 334,["386"] = 334,["387"] = 335,["388"] = 334,["389"] = 337,["390"] = 335,["391"] = 340,["392"] = 340,["393"] = 340,["394"] = 340,["395"] = 345,["396"] = 340,["397"] = 341,["398"] = 343,["399"] = 347,["400"] = 348,["401"] = 349,["402"] = 350,["403"] = 351,["405"] = 353,["406"] = 354,["408"] = 345,["409"] = 358,["410"] = 340,["411"] = 360,["412"] = 361,["413"] = 362,["414"] = 363,["415"] = 364,["417"] = 367,["418"] = 368,["420"] = 358,["421"] = 372,["422"] = 373,["423"] = 373,["424"] = 373,["425"] = 373,["426"] = 373,["427"] = 374,["428"] = 374,["429"] = 374,["430"] = 375,["431"] = 376,["432"] = 379,["433"] = 380,["434"] = 381,["435"] = 383,["436"] = 384,["438"] = 374,["439"] = 374,["440"] = 372,["441"] = 390,["442"] = 391,["443"] = 390,["444"] = 394,["445"] = 395,["446"] = 394,["447"] = 398,["448"] = 399,["449"] = 400,["450"] = 400,["451"] = 400,["452"] = 400,["453"] = 400,["454"] = 400,["455"] = 401,["456"] = 398,["457"] = 404,["458"] = 405,["459"] = 406,["460"] = 406,["461"] = 406,["462"] = 406,["463"] = 406,["464"] = 406,["465"] = 407,["466"] = 404,["467"] = 410,["468"] = 411,["469"] = 413,["470"] = 414,["472"] = 416,["473"] = 417,["476"] = 421,["477"] = 422,["478"] = 422,["479"] = 422,["480"] = 423,["481"] = 424,["482"] = 425,["484"] = 430,["485"] = 422,["486"] = 422,["487"] = 433,["488"] = 434,["490"] = 410,["491"] = 441,["492"] = 442,["493"] = 443,["494"] = 441,["495"] = 446,["496"] = 447,["497"] = 447,["498"] = 447,["499"] = 450,["500"] = 450,["501"] = 450,["502"] = 450,["503"] = 450,["504"] = 450,["505"] = 450,["506"] = 446,["507"] = 453,["508"] = 454,["509"] = 454,["510"] = 454,["511"] = 454,["512"] = 459,["513"] = 460,["514"] = 460,["515"] = 460,["516"] = 460,["517"] = 460,["518"] = 460,["519"] = 460,["520"] = 453,["521"] = 463,["522"] = 464,["523"] = 464,["524"] = 464,["525"] = 464,["526"] = 469,["527"] = 470,["528"] = 470,["529"] = 470,["530"] = 470,["531"] = 470,["532"] = 470,["533"] = 470,["534"] = 463,["535"] = 473,["536"] = 474,["537"] = 474,["538"] = 474,["539"] = 474,["540"] = 478,["541"] = 478,["542"] = 478,["543"] = 478,["544"] = 473,["545"] = 481,["546"] = 482,["547"] = 482,["548"] = 482,["549"] = 482,["550"] = 490,["551"] = 490,["552"] = 490,["553"] = 490,["554"] = 481,["555"] = 493,["556"] = 494,["557"] = 495,["558"] = 496,["561"] = 499,["562"] = 500,["563"] = 501,["566"] = 504,["567"] = 493,["568"] = 507,["569"] = 508,["570"] = 509,["572"] = 511,["573"] = 507,["574"] = 514,["575"] = 515,["576"] = 516,["578"] = 519,["579"] = 520,["580"] = 521,["582"] = 524,["583"] = 514,["584"] = 527,["585"] = 528,["586"] = 529,["588"] = 531,["589"] = 532,["591"] = 535,["592"] = 527,["593"] = 538,["594"] = 539,["595"] = 540,["597"] = 542,["598"] = 543,["600"] = 545,["601"] = 538,["602"] = 548,["603"] = 549,["604"] = 549,["605"] = 549,["606"] = 549,["607"] = 551,["608"] = 552,["610"] = 555,["611"] = 556,["613"] = 559,["614"] = 548});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
local ____upgrades = require("upgrades.upgrades")
local Upgrades = ____upgrades.default
local ____bounties = require("bounties.bounties")
local Bounties = ____bounties.default
local DEBUG = false
local CollisionTypes = CollisionTypes or ({})
CollisionTypes.SUCCESS = 0
CollisionTypes[CollisionTypes.SUCCESS] = "SUCCESS"
CollisionTypes.UNIT = 1
CollisionTypes[CollisionTypes.UNIT] = "UNIT"
CollisionTypes.WALL = 2
CollisionTypes[CollisionTypes.WALL] = "WALL"
CollisionTypes.TREE = 3
CollisionTypes[CollisionTypes.TREE] = "TREE"
local Orientations = Orientations or ({})
Orientations.NONE = 0
Orientations[Orientations.NONE] = "NONE"
Orientations.DIAGONAL_LEFT = 1
Orientations[Orientations.DIAGONAL_LEFT] = "DIAGONAL_LEFT"
Orientations.DIAGONAL_RIGHT = 2
Orientations[Orientations.DIAGONAL_RIGHT] = "DIAGONAL_RIGHT"
Orientations.HORIZONTAL = 3
Orientations[Orientations.HORIZONTAL] = "HORIZONTAL"
Orientations.VERTICAL = 4
Orientations[Orientations.VERTICAL] = "VERTICAL"
____exports.default = (function()
    ____exports.default = __TS__Class()
    local CustomNPC = ____exports.default
    CustomNPC.name = "CustomNPC"
    __TS__ClassExtends(CustomNPC, UnitEntity)
    function CustomNPC.prototype.____constructor(self, unit)
        CustomEntitiesLegacy:Initialize(
            unit,
            not unit:IsRealHero()
        )
        UnitEntity.prototype.____constructor(self, {unit = unit})
        customEntities:Disarm(self.unit)
        customEntities:IgnoreMSLimit(self.unit)
    end
    function CustomNPC.prototype.LevelAllAbilities(self, level)
        do
            local i = 0
            while i <= 23 do
                local ability = self.unit:GetAbilityByIndex(i)
                if ability then
                    if CustomAbilitiesLegacy:IsNotTalentNorAttribute(ability) then
                        ability:SetLevel(level)
                    end
                end
                i = i + 1
            end
        end
    end
    function CustomNPC.prototype.Move(self, direction, speed)
        local offset = 70
        local origin = self.unit:GetAbsOrigin()
        local futureOrigin = origin:__add(
            direction:__mul(speed)
        )
        local testOrigin = futureOrigin:__add(
            direction:__mul(offset)
        )
        futureOrigin.z = GetGroundPosition(futureOrigin, self.unit).z
        local normal = CustomEntitiesLegacy:GetNormal(self.unit, futureOrigin)
        if IsInToolsMode() and DEBUG then
            DebugDrawLine_vCol(
                futureOrigin,
                testOrigin,
                Vector(255, 0, 0),
                true,
                1
            )
            DebugDrawLine_vCol(
                futureOrigin,
                futureOrigin:__add(
                    normal:__mul(200)
                ),
                Vector(255, 255, 255),
                true,
                1
            )
            DebugDrawCircle(
                futureOrigin,
                Vector(255, 0, 0),
                5,
                offset,
                false,
                0.03
            )
        end
        if self.unit:HasModifier("modifier_spectre_special_attack_buff") then
            self.unit:SetAbsOrigin(futureOrigin)
            return CollisionTypes.SUCCESS
        end
        local trees = GridNav:GetAllTreesAroundPoint(testOrigin, 5, true)
        if normal.z <= 0.9 then
            return CollisionTypes.WALL
        end
        if #trees > 0 then
            return CollisionTypes.TREE
        end
        if not self.unit:IsPhased() then
            local units = FindUnitsInRadius(
                self.unit:GetTeamNumber(),
                testOrigin,
                nil,
                5,
                DOTA_UNIT_TARGET_TEAM_BOTH,
                DOTA_UNIT_TARGET_ALL,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false
            )
            do
                local i = 0
                while i < #units do
                    local unit = units[i + 1]
                    if unit ~= self.unit then
                        if not unit:IsPhased() then
                            return CollisionTypes.UNIT
                        end
                    end
                    i = i + 1
                end
            end
        end
        if not CustomEntitiesLegacy:IsAnimating(self.unit) then
            if not self.unit:HasModifier("modifier_hero_movement") then
                self.unit:AddNewModifier(self.unit, nil, "modifier_hero_movement", {})
            end
        end
        self.unit:SetAbsOrigin(futureOrigin)
        return CollisionTypes.SUCCESS
    end
    function CustomNPC.prototype.AlternativeDirectionsWalls(self, direction)
        local directions = {}
        local collisionDirection = CustomEntitiesLegacy:GetCollisionDirection(self.unit)
        local angle = VectorToAngles(direction).y
        if Math:IsNorthEast(angle) then
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                return directions
            end
            __TS__ArrayPush(directions, Math.NORTH)
            __TS__ArrayPush(directions, Math.EAST)
        end
        if Math:IsNorthWest(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, Math.NORTH)
                __TS__ArrayPush(directions, Math.WEST)
                return directions
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, Math.NORTH)
                __TS__ArrayPush(directions, Math.WEST)
                return directions
            end
            __TS__ArrayPush(directions, Math.NORTH)
            __TS__ArrayPush(directions, Math.WEST)
        end
        if Math:IsSouthEast(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, Math.SOUTH)
                __TS__ArrayPush(directions, Math.EAST)
            end
            if collisionDirection == Orientations.HORIZONTAL then
                __TS__ArrayPush(directions, Math.EAST)
                __TS__ArrayPush(directions, Math.SOUTH)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, Math.SOUTH)
                __TS__ArrayPush(directions, Math.EAST)
            end
        end
        if Math:IsSouthWest(angle) then
            if collisionDirection == Orientations.HORIZONTAL then
                __TS__ArrayPush(directions, Math.WEST)
                __TS__ArrayPush(directions, Math.SOUTH)
            end
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, Math.SOUTH_WEST)
                __TS__ArrayPush(directions, Math.WEST)
                __TS__ArrayPush(directions, Math.SOUTH)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, Math.SOUTH)
                __TS__ArrayPush(directions, Math.WEST)
            end
        end
        if Math:IsEast(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, Math.NORTH_EAST)
                __TS__ArrayPush(directions, Math.NORTH)
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, Math.SOUTH_EAST)
                __TS__ArrayPush(directions, Math.SOUTH)
            end
        end
        if Math:IsWest(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, Math.SOUTH_EAST)
                __TS__ArrayPush(directions, Math.SOUTH)
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, Math.NORTH_WEST)
                __TS__ArrayPush(directions, Math.NORTH)
            end
            if collisionDirection == Orientations.HORIZONTAL then
                __TS__ArrayPush(directions, Math.SOUTH)
                __TS__ArrayPush(directions, Math.NORTH)
            end
        end
        if Math:IsNorth(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, Math.NORTH_EAST)
                __TS__ArrayPush(directions, Math.EAST)
            end
            if collisionDirection == Orientations.HORIZONTAL then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, Math.WEST)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, Math.NORTH_WEST)
                __TS__ArrayPush(directions, Math.WEST)
            end
        end
        if Math:IsSouth(angle) then
            if collisionDirection == Orientations.HORIZONTAL then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, Math.SOUTH_WEST)
                __TS__ArrayPush(directions, Math.WEST)
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, Math.SOUTH_EAST)
                __TS__ArrayPush(directions, Math.EAST)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, Math.EAST)
            end
        end
        return directions
    end
    function CustomNPC.prototype.AlternativeDirections(self, direction)
        local directions = {}
        local angle = VectorToAngles(direction).y
        if Math:IsNorthEast(angle) then
            __TS__ArrayPush(directions, Math.NORTH)
            __TS__ArrayPush(directions, Math.EAST)
        end
        if Math:IsNorthWest(angle) then
            __TS__ArrayPush(directions, Math.NORTH)
            __TS__ArrayPush(directions, Math.WEST)
        end
        if Math:IsSouthEast(angle) then
            __TS__ArrayPush(directions, Math.SOUTH)
            __TS__ArrayPush(directions, Math.EAST)
        end
        if Math:IsSouthWest(angle) then
            __TS__ArrayPush(directions, Math.SOUTH)
            __TS__ArrayPush(directions, Math.WEST)
        end
        if Math:IsEast(angle) or Math:IsWest(angle) then
            if self.unit:GetAbsOrigin().y < 0 then
                __TS__ArrayPush(directions, Math.SOUTH)
                __TS__ArrayPush(directions, Math.NORTH)
            end
            if self.unit:GetAbsOrigin().y > 0 then
                __TS__ArrayPush(directions, Math.NORTH)
                __TS__ArrayPush(directions, Math.SOUTH)
            end
        end
        if Math:IsNorth(angle) or Math:IsSouth(angle) then
            if self.unit:GetAbsOrigin().x < 0 then
                __TS__ArrayPush(directions, Math.WEST)
            end
            if self.unit:GetAbsOrigin().x > 0 then
                __TS__ArrayPush(directions, Math.EAST)
            end
        end
        return directions
    end
    function CustomNPC.prototype.Update(self)
        local direction = CustomEntitiesLegacy:GetDirection(self.unit):Normalized()
        local speed = self.unit:GetIdealSpeed() / 25
        if CustomEntitiesLegacy:IsAnimating(self.unit) then
            self.unit:RemoveModifierByName("modifier_hero_movement")
            self.unit:RemoveModifierByName("modifier_tower_idle")
        end
        if ((direction.x ~= 0) or (direction.y ~= 0)) and CustomEntitiesLegacy:CanWalk(self.unit) then
            local output = self:Move(direction, speed)
            if output ~= CollisionTypes.SUCCESS then
                local alternativeDirections = {}
                if output == CollisionTypes.WALL then
                    alternativeDirections = self:AlternativeDirectionsWalls(direction)
                else
                    alternativeDirections = self:AlternativeDirections(direction)
                end
                do
                    local i = 0
                    while i < #alternativeDirections do
                        local alternativeDireaction = alternativeDirections[i + 1]
                        local newOutput = self:Move(alternativeDireaction, speed * 0.8)
                        if newOutput == CollisionTypes.SUCCESS then
                            break
                        end
                        i = i + 1
                    end
                end
            end
            if ((not self.unit:HasModifier("modifier_casting")) and (not self.unit:HasModifier("modifier_mars_counter_countering"))) and (not self.unit:HasModifier("modifier_spectre_counter_countering")) then
                CustomEntitiesLegacy:FullyFaceTowards(self.unit, direction)
            end
        else
            if self.unit:GetUnitName() == "dire_tower" then
                if not self.unit:HasModifier("modifier_tower_idle") then
                    self.unit:AddNewModifier(self.unit, nil, "modifier_tower_idle", {})
                end
            end
            self.unit:RemoveModifierByName("modifier_hero_movement")
        end
        if IsInToolsMode() and DEBUG then
            if self.unit.GetPlayerID then
                local player = GameRules.Addon:FindPlayerById(
                    self.unit:GetPlayerID()
                )
                if player then
                    local mouse = player:GetCursorPosition()
                    DebugDrawLine_vCol(
                        self.unit:GetAbsOrigin(),
                        self.unit:GetAbsOrigin():__add(
                            self.unit:GetForwardVector():__mul(500)
                        ),
                        Vector(0, 0, 255),
                        true,
                        0.03
                    )
                    DebugDrawLine_vCol(
                        self.unit:GetAbsOrigin(),
                        mouse,
                        Vector(0, 255, 0),
                        true,
                        0.03
                    )
                end
            end
        end
    end
    function CustomNPC.prototype.OnDeath(self, params)
        UnitEntity.prototype.OnDeath(self, params)
        self:Destroy(false)
    end
    return CustomNPC
end)()
____exports.CustomHeroNPC = __TS__Class()
local CustomHeroNPC = ____exports.CustomHeroNPC
CustomHeroNPC.name = "CustomHeroNPC"
__TS__ClassExtends(CustomHeroNPC, ____exports.default)
function CustomHeroNPC.prototype.____constructor(self, unit)
    CustomHeroNPC.____super.prototype.____constructor(self, unit)
    customEntities:HideHealthBar(self.unit)
    customEntities:SetUseEnergy(self.unit)
end
____exports.CustomNonPlayerHeroNPC = __TS__Class()
local CustomNonPlayerHeroNPC = ____exports.CustomNonPlayerHeroNPC
CustomNonPlayerHeroNPC.name = "CustomNonPlayerHeroNPC"
__TS__ClassExtends(CustomNonPlayerHeroNPC, ____exports.CustomHeroNPC)
function CustomNonPlayerHeroNPC.prototype.____constructor(self, unit)
    CustomNonPlayerHeroNPC.____super.prototype.____constructor(self, unit)
    self:LevelAllAbilities(1)
end
____exports.CustomPlayerHeroNPC = __TS__Class()
local CustomPlayerHeroNPC = ____exports.CustomPlayerHeroNPC
CustomPlayerHeroNPC.name = "CustomPlayerHeroNPC"
__TS__ClassExtends(CustomPlayerHeroNPC, ____exports.CustomHeroNPC)
function CustomPlayerHeroNPC.prototype.____constructor(self, unit)
    CustomPlayerHeroNPC.____super.prototype.____constructor(self, unit)
    self.heroUpgrades = {}
    self.remainingTimeToRemoveMana = 1 * 30
    if GameRules.Addon:IsPVE() then
        self.unit:GetAbilityByIndex(0):SetLevel(1)
        self.unit:GetAbilityByIndex(5):SetLevel(1)
        self.unit:GetAbilityByIndex(6):SetLevel(1)
        self.unit:SetAbilityPoints(2)
    else
        self:LevelAllAbilities(1)
        self.unit:SetAbilityPoints(2)
    end
end
function CustomPlayerHeroNPC.prototype.Update(self)
    CustomPlayerHeroNPC.____super.prototype.Update(self)
    if self.remainingTimeToRemoveMana > 0 then
        self.remainingTimeToRemoveMana = self.remainingTimeToRemoveMana - 1
    elseif self.remainingTimeToRemoveMana == 0 then
        CustomEntitiesLegacy:SetManaCustom(self.unit, 0, true)
        self.remainingTimeToRemoveMana = -1
    end
    if self.unit:IsAlive() then
        self:PickupItems()
    end
end
function CustomPlayerHeroNPC.prototype.PickupItems(self)
    local dropItems = Entities:FindAllByClassnameWithin(
        "dota_item_drop",
        self.unit:GetAbsOrigin(),
        self.unit:GetHullRadius() * 2.5
    )
    __TS__ArrayForEach(
        dropItems,
        function(____, drop)
            local item = drop:GetContainedItem()
            local owner = item:GetPurchaser()
            if (not owner) or ((owner and CustomEntitiesLegacy:Allies(self.unit, owner)) and (self.unit ~= owner)) then
                self.unit:AddItem(item)
                item:OnSpellStart()
                GameRules.Addon:OnPickedUp(item)
                UTIL_Remove(drop)
            end
        end
    )
end
function CustomPlayerHeroNPC.prototype.IsRanged(self)
    return self.unit:GetPrimaryAttribute() == DOTA_ATTRIBUTE_AGILITY
end
function CustomPlayerHeroNPC.prototype.IsMeele(self)
    return self.unit:GetPrimaryAttribute() == DOTA_ATTRIBUTE_STRENGTH
end
function CustomPlayerHeroNPC.prototype.IsUpgrading(self)
    local tableName = "custom_npc_upgrades"
    local value = CustomNetTables:GetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        )
    )
    return value and (value.upgrades ~= nil)
end
function CustomPlayerHeroNPC.prototype.IsSelectingBounty(self)
    local tableName = "custom_npc_bounties"
    local value = CustomNetTables:GetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        )
    )
    return value and (value.bounties ~= nil)
end
function CustomPlayerHeroNPC.prototype.ApplyUpgrade(self, upgrade)
    self:ClearTable("custom_npc_upgrades")
    if upgrade.modifier then
        self.unit:AddNewModifier(self.unit, nil, upgrade.modifier.name, {duration = upgrade.modifier.duration})
    end
    if upgrade.effect then
        upgrade:effect(self.unit)
        return
    end
    local found = false
    self.heroUpgrades = __TS__ArrayMap(
        self.heroUpgrades,
        function(____, heroUpgrade)
            if heroUpgrade.id == upgrade.id then
                found = true
                return __TS__ObjectAssign({}, heroUpgrade, {level = heroUpgrade.level + 1})
            end
            return heroUpgrade
        end
    )
    if not found then
        __TS__ArrayPush(self.heroUpgrades, {id = upgrade.id, level = 1})
    end
end
function CustomPlayerHeroNPC.prototype.SelectBounty(self, bounty)
    self:ClearTable("custom_npc_bounties")
    self.bounty = bounty
end
function CustomPlayerHeroNPC.prototype.ClearTable(self, name)
    local data = {
        playerId = self.unit:GetPlayerOwnerID()
    }
    CustomNetTables:SetTableValue(
        name,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.RequestBounties(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        bounties = self:GenerateBounties(3)
    }
    local tableName = "custom_npc_bounties"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.RequestUpgrades(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3)
    }
    local tableName = "custom_npc_upgrades"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.GenerateBounties(self, amount)
    local bounties = __TS__ArrayFilter(
        Bounties,
        function(____, bounty) return self:ValidateBounty(bounty) end
    )
    return Math:GetRandomElementsFromArray(
        bounties,
        Clamp(amount, #bounties, 0)
    )
end
function CustomPlayerHeroNPC.prototype.GenerateUpgrades(self, amount)
    local upgrades = __TS__ArrayFilter(
        Upgrades,
        function(____, upgrade) return (((self:ValidateUpgradeHero(upgrade) and self:ValidateUpgradeAbility(upgrade)) and self:ValidateUpgradeAttackCapabilities(upgrade)) and self:ValidateUpgradeStacks(upgrade)) and self:ValidateUpgradeLevel(upgrade) end
    )
    return Math:GetRandomElementsFromArray(
        upgrades,
        Clamp(amount, #upgrades, 0)
    )
end
function CustomPlayerHeroNPC.prototype.ValidateBounty(self, bounty)
    if bounty.id == "bounty_upgrades" then
        if #self.heroUpgrades < 2 then
            return false
        end
    end
    if bounty.id == "bounty_regenerate" then
        if ((not GameRules.Addon.run) or (not GameRules.Addon.run.stage)) or (GameRules.Addon.run.stage.currentRoom == 0) then
            return false
        end
    end
    return true
end
function CustomPlayerHeroNPC.prototype.ValidateUpgradeHero(self, upgrade)
    if not upgrade.hero then
        return true
    end
    return upgrade.hero == self.unit:GetName()
end
function CustomPlayerHeroNPC.prototype.ValidateUpgradeAbility(self, upgrade)
    if not upgrade.ability then
        return true
    end
    local ability = self.unit:FindAbilityByName(upgrade.ability)
    if (not ability) or (ability:GetLevel() == 0) then
        return false
    end
    return true
end
function CustomPlayerHeroNPC.prototype.ValidateUpgradeAttackCapabilities(self, upgrade)
    if not upgrade.attackCapability then
        return true
    end
    if ((upgrade.attackCapability == DOTA_UNIT_CAP_MELEE_ATTACK) and (not self:IsMeele())) or ((upgrade.attackCapability == DOTA_UNIT_CAP_RANGED_ATTACK) and (not self:IsRanged())) then
        return false
    end
    return true
end
function CustomPlayerHeroNPC.prototype.ValidateUpgradeLevel(self, upgrade)
    if not upgrade.minLevel then
        return true
    end
    if GameRules.Addon.currentRoom < (upgrade.minLevel - 1) then
        return false
    end
    return true
end
function CustomPlayerHeroNPC.prototype.ValidateUpgradeStacks(self, upgrade)
    local heroUpgrade = __TS__ArrayFilter(
        self.heroUpgrades,
        function(____, heroUpgrade) return heroUpgrade.id == upgrade.id end
    )[1]
    if not heroUpgrade then
        return true
    end
    if heroUpgrade.level >= upgrade.maxStacks then
        return false
    end
    return true
end
return ____exports
