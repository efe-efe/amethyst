--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 10,["23"] = 11,["24"] = 13,["25"] = 13,["26"] = 13,["27"] = 13,["28"] = 13,["29"] = 13,["30"] = 13,["31"] = 13,["32"] = 13,["33"] = 20,["34"] = 20,["35"] = 20,["36"] = 20,["37"] = 20,["38"] = 20,["39"] = 20,["40"] = 20,["41"] = 20,["42"] = 20,["43"] = 20,["44"] = 32,["45"] = 32,["46"] = 32,["47"] = 32,["48"] = 32,["49"] = 33,["50"] = 34,["51"] = 34,["52"] = 34,["53"] = 34,["54"] = 32,["55"] = 36,["56"] = 37,["57"] = 33,["58"] = 39,["60"] = 40,["61"] = 40,["62"] = 41,["63"] = 42,["64"] = 43,["65"] = 44,["68"] = 40,["71"] = 39,["72"] = 49,["73"] = 50,["74"] = 51,["75"] = 52,["76"] = 52,["77"] = 52,["78"] = 53,["79"] = 53,["80"] = 53,["81"] = 54,["82"] = 55,["83"] = 57,["84"] = 58,["85"] = 58,["86"] = 58,["87"] = 58,["88"] = 58,["89"] = 58,["90"] = 58,["91"] = 59,["92"] = 59,["93"] = 59,["94"] = 59,["95"] = 59,["96"] = 59,["97"] = 59,["98"] = 59,["99"] = 59,["100"] = 60,["101"] = 60,["102"] = 60,["103"] = 60,["104"] = 60,["105"] = 60,["106"] = 60,["107"] = 60,["109"] = 63,["110"] = 64,["111"] = 65,["113"] = 68,["114"] = 70,["115"] = 71,["117"] = 73,["118"] = 74,["120"] = 77,["121"] = 78,["122"] = 78,["123"] = 78,["124"] = 78,["125"] = 78,["126"] = 78,["127"] = 78,["128"] = 78,["129"] = 78,["130"] = 78,["131"] = 78,["133"] = 90,["134"] = 90,["135"] = 91,["136"] = 92,["137"] = 93,["138"] = 94,["141"] = 90,["145"] = 100,["146"] = 101,["147"] = 102,["150"] = 106,["151"] = 107,["152"] = 49,["153"] = 109,["154"] = 110,["155"] = 111,["156"] = 112,["157"] = 114,["158"] = 115,["159"] = 116,["161"] = 118,["162"] = 119,["164"] = 121,["165"] = 122,["166"] = 123,["168"] = 125,["169"] = 126,["170"] = 127,["171"] = 128,["173"] = 130,["174"] = 131,["175"] = 132,["176"] = 133,["178"] = 135,["179"] = 136,["181"] = 138,["182"] = 139,["183"] = 140,["185"] = 142,["186"] = 143,["187"] = 144,["189"] = 146,["190"] = 147,["191"] = 148,["193"] = 150,["194"] = 151,["195"] = 152,["198"] = 155,["199"] = 156,["200"] = 157,["201"] = 158,["203"] = 160,["204"] = 161,["205"] = 162,["206"] = 163,["208"] = 165,["209"] = 166,["210"] = 167,["213"] = 170,["214"] = 171,["215"] = 172,["216"] = 173,["218"] = 175,["219"] = 176,["220"] = 177,["223"] = 180,["224"] = 181,["225"] = 182,["226"] = 183,["228"] = 185,["229"] = 186,["230"] = 187,["232"] = 189,["233"] = 190,["234"] = 191,["237"] = 194,["238"] = 195,["239"] = 196,["240"] = 197,["242"] = 199,["243"] = 200,["245"] = 202,["246"] = 203,["248"] = 205,["249"] = 206,["250"] = 207,["253"] = 210,["254"] = 211,["255"] = 212,["257"] = 214,["258"] = 215,["259"] = 216,["261"] = 218,["262"] = 219,["263"] = 220,["265"] = 222,["266"] = 223,["269"] = 227,["270"] = 109,["271"] = 229,["272"] = 230,["273"] = 231,["274"] = 233,["275"] = 234,["276"] = 235,["278"] = 237,["279"] = 238,["280"] = 239,["282"] = 241,["283"] = 242,["284"] = 243,["286"] = 245,["287"] = 246,["288"] = 247,["290"] = 249,["291"] = 250,["292"] = 251,["293"] = 252,["295"] = 255,["296"] = 256,["297"] = 257,["300"] = 260,["301"] = 261,["302"] = 262,["304"] = 264,["305"] = 265,["308"] = 268,["309"] = 229,["310"] = 270,["311"] = 271,["312"] = 272,["313"] = 274,["314"] = 275,["315"] = 276,["317"] = 279,["318"] = 280,["319"] = 281,["320"] = 282,["321"] = 284,["322"] = 285,["324"] = 287,["327"] = 290,["328"] = 290,["329"] = 291,["330"] = 292,["331"] = 293,["334"] = 290,["338"] = 299,["339"] = 303,["342"] = 306,["343"] = 307,["344"] = 308,["347"] = 311,["349"] = 314,["350"] = 315,["351"] = 316,["352"] = 316,["353"] = 316,["354"] = 318,["355"] = 319,["356"] = 320,["357"] = 320,["358"] = 320,["359"] = 320,["360"] = 320,["361"] = 320,["362"] = 320,["363"] = 320,["364"] = 320,["365"] = 321,["366"] = 321,["367"] = 321,["368"] = 321,["369"] = 321,["370"] = 321,["371"] = 321,["375"] = 270,["376"] = 326,["377"] = 32,["378"] = 328,["379"] = 326,["380"] = 32,["381"] = 32,["382"] = 331,["383"] = 331,["384"] = 331,["385"] = 331,["386"] = 332,["387"] = 331,["388"] = 334,["389"] = 335,["390"] = 332,["391"] = 338,["392"] = 338,["393"] = 338,["394"] = 338,["395"] = 339,["396"] = 338,["397"] = 341,["398"] = 339,["399"] = 344,["400"] = 344,["401"] = 344,["402"] = 344,["403"] = 349,["404"] = 344,["405"] = 345,["406"] = 347,["407"] = 351,["408"] = 352,["409"] = 353,["410"] = 354,["411"] = 355,["412"] = 356,["414"] = 358,["415"] = 359,["417"] = 349,["418"] = 363,["419"] = 344,["420"] = 365,["421"] = 366,["422"] = 367,["423"] = 368,["424"] = 369,["426"] = 372,["427"] = 373,["429"] = 363,["430"] = 377,["431"] = 378,["432"] = 378,["433"] = 378,["434"] = 378,["435"] = 378,["436"] = 379,["437"] = 379,["438"] = 379,["439"] = 380,["440"] = 381,["441"] = 384,["442"] = 385,["443"] = 386,["444"] = 388,["445"] = 389,["447"] = 379,["448"] = 379,["449"] = 377,["450"] = 395,["451"] = 396,["452"] = 395,["453"] = 399,["454"] = 400,["455"] = 399,["456"] = 403,["457"] = 404,["458"] = 405,["459"] = 405,["460"] = 405,["461"] = 405,["462"] = 405,["463"] = 405,["464"] = 406,["465"] = 403,["466"] = 409,["467"] = 410,["468"] = 411,["469"] = 411,["470"] = 411,["471"] = 411,["472"] = 411,["473"] = 411,["474"] = 412,["475"] = 409,["476"] = 415,["477"] = 416,["478"] = 417,["479"] = 418,["480"] = 419,["481"] = 419,["482"] = 419,["483"] = 420,["484"] = 421,["485"] = 422,["487"] = 427,["488"] = 419,["489"] = 419,["490"] = 430,["491"] = 431,["494"] = 438,["495"] = 439,["497"] = 442,["498"] = 443,["499"] = 444,["500"] = 415,["501"] = 448,["502"] = 449,["503"] = 450,["504"] = 451,["505"] = 448,["506"] = 454,["507"] = 455,["508"] = 456,["509"] = 457,["510"] = 458,["511"] = 460,["512"] = 463,["513"] = 454,["514"] = 466,["515"] = 467,["516"] = 467,["517"] = 467,["518"] = 470,["519"] = 470,["520"] = 470,["521"] = 470,["522"] = 470,["523"] = 470,["524"] = 470,["525"] = 466,["526"] = 473,["527"] = 474,["528"] = 474,["529"] = 474,["530"] = 474,["531"] = 479,["532"] = 480,["533"] = 480,["534"] = 480,["535"] = 480,["536"] = 480,["537"] = 480,["538"] = 480,["539"] = 473,["540"] = 483,["541"] = 484,["542"] = 484,["543"] = 484,["544"] = 484,["545"] = 489,["546"] = 490,["547"] = 490,["548"] = 490,["549"] = 490,["550"] = 490,["551"] = 490,["552"] = 490,["553"] = 483,["554"] = 493,["555"] = 494,["556"] = 494,["557"] = 494,["558"] = 494,["559"] = 499,["560"] = 500,["561"] = 500,["562"] = 500,["563"] = 500,["564"] = 500,["565"] = 500,["566"] = 500,["567"] = 493,["568"] = 503,["569"] = 504,["570"] = 504,["571"] = 504,["572"] = 504,["573"] = 509,["574"] = 510,["575"] = 510,["576"] = 510,["577"] = 510,["578"] = 510,["579"] = 510,["580"] = 510,["581"] = 503,["582"] = 513,["583"] = 514,["584"] = 514,["585"] = 514,["586"] = 514,["587"] = 519,["588"] = 520,["589"] = 520,["590"] = 520,["591"] = 520,["592"] = 520,["593"] = 520,["594"] = 520,["595"] = 513,["596"] = 523,["597"] = 524,["598"] = 524,["599"] = 524,["600"] = 524,["601"] = 528,["602"] = 528,["603"] = 528,["604"] = 528,["605"] = 523,["606"] = 531,["607"] = 532,["608"] = 532,["609"] = 532,["610"] = 532,["611"] = 536,["612"] = 536,["613"] = 536,["614"] = 536,["615"] = 531,["616"] = 539,["617"] = 540,["618"] = 540,["619"] = 540,["620"] = 540,["621"] = 551,["622"] = 552,["623"] = 552,["624"] = 552,["625"] = 553,["626"] = 554,["627"] = 554,["628"] = 554,["629"] = 554,["630"] = 554,["631"] = 554,["632"] = 554,["633"] = 555,["634"] = 555,["635"] = 555,["636"] = 555,["637"] = 556,["638"] = 556,["639"] = 556,["640"] = 556,["641"] = 557,["642"] = 557,["643"] = 557,["644"] = 557,["645"] = 558,["646"] = 558,["647"] = 558,["648"] = 558,["649"] = 559,["650"] = 559,["651"] = 559,["652"] = 559,["653"] = 560,["654"] = 560,["655"] = 560,["656"] = 560,["657"] = 552,["658"] = 552,["660"] = 564,["661"] = 564,["662"] = 564,["663"] = 564,["664"] = 539,["665"] = 567,["666"] = 568,["667"] = 569,["668"] = 570,["671"] = 573,["672"] = 567,["673"] = 576,["674"] = 577,["675"] = 576,["676"] = 580,["677"] = 581,["678"] = 582,["680"] = 584,["681"] = 580,["682"] = 587,["683"] = 588,["684"] = 589,["686"] = 592,["687"] = 593,["688"] = 594,["690"] = 597,["691"] = 587,["692"] = 600,["693"] = 601,["694"] = 602,["696"] = 604,["697"] = 605,["699"] = 608,["700"] = 600,["701"] = 611,["702"] = 612,["703"] = 612,["704"] = 612,["705"] = 612,["706"] = 614,["707"] = 615,["709"] = 618,["710"] = 611,["711"] = 621,["712"] = 622,["713"] = 623,["715"] = 625,["716"] = 626,["718"] = 628,["719"] = 621,["720"] = 631,["721"] = 632,["722"] = 632,["723"] = 632,["724"] = 632,["725"] = 634,["726"] = 635,["728"] = 638,["729"] = 639,["731"] = 642,["732"] = 631});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local ____upgrades = require("upgrades.upgrades")
local Upgrades = ____upgrades.default
local ____rewards = require("rewards.rewards")
local Rewards = ____rewards.default
local RewardTypes = ____rewards.RewardTypes
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
local ____items = require("upgrades.items")
local Items = ____items.default
local DEBUG = false
local DEBUG_VALIDATIONS = false
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
        customEntities:ChangeMS(self.unit, 50)
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
function CustomPlayerHeroNPC.prototype.IsSelectingFavor(self)
    local tableName = "custom_npc_favors"
    local value = CustomNetTables:GetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        )
    )
    return value and (value.upgrades ~= nil)
end
function CustomPlayerHeroNPC.prototype.IsSelectingReward(self)
    local tableName = "custom_npc_rewards"
    local value = CustomNetTables:GetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        )
    )
    return value and (value.rewards ~= nil)
end
function CustomPlayerHeroNPC.prototype.ApplyFavor(self, upgrade)
    if upgrade.modifier then
        self.unit:AddNewModifier(self.unit, nil, upgrade.modifier.name, {duration = upgrade.modifier.duration})
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
    if upgrade.effect then
        upgrade:effect(self.unit)
    end
    self:ClearTable("custom_npc_favors")
    local customEvents = CustomEvents:GetInstance()
    customEvents:EmitEvent("pve:current_reward_applied", {customNpc = self})
end
function CustomPlayerHeroNPC.prototype.ApplyTarrasque(self)
    self.unit:AddNewModifier(self.unit, nil, "modifier_upgrade_tarrasque", {})
    local customEvents = CustomEvents:GetInstance()
    customEvents:EmitEvent("pve:current_reward_applied", {customNpc = self})
end
function CustomPlayerHeroNPC.prototype.SelectReward(self, reward)
    self.reward = reward
    self:ClearTable("custom_npc_rewards")
    local customEvents = CustomEvents:GetInstance()
    customEvents:EmitEvent("pve:next_reward_selected", {customNpc = self, reward = reward})
    local data = {nextReward = self.reward.name}
    CustomNetTables:SetTableValue("main", "pve", data)
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
function CustomPlayerHeroNPC.prototype.RequestRewards(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        rewards = self:GenerateBounties(3)
    }
    local tableName = "custom_npc_rewards"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.RequestFavors(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3, UpgradeTypes.FAVOR, false)
    }
    local tableName = "custom_npc_favors"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.RequestShards(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3, UpgradeTypes.SHARD, false)
    }
    local tableName = "custom_npc_favors"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.RequestKnowledge(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3, UpgradeTypes.SHARD, true)
    }
    local tableName = "custom_npc_favors"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.RequestItems(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3, UpgradeTypes.ITEM, false)
    }
    local tableName = "custom_npc_favors"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
end
function CustomPlayerHeroNPC.prototype.GenerateItems(self, amount)
    local items = __TS__ArrayFilter(
        Items,
        function(____, item) return not self:ValidateUpgradeExisting(item) end
    )
    return Math:GetRandomElementsFromArray(
        items,
        Clamp(amount, #items, 0)
    )
end
function CustomPlayerHeroNPC.prototype.GenerateBounties(self, amount)
    local rewards = __TS__ArrayFilter(
        Rewards,
        function(____, reward) return self:ValidateReward(reward) end
    )
    return Math:GetRandomElementsFromArray(
        rewards,
        Clamp(amount, #rewards, 0)
    )
end
function CustomPlayerHeroNPC.prototype.GenerateUpgrades(self, amount, ____type, existingOnly)
    local upgrades = __TS__ArrayFilter(
        Upgrades,
        function(____, upgrade) return ((((((self:ValidateUpgradeType(upgrade, ____type) and self:ValidateUpgradeType(upgrade, ____type)) and self:ValidateUpgradeHero(upgrade)) and self:ValidateUpgradeAbility(upgrade)) and self:ValidateUpgradeAttackCapabilities(upgrade)) and self:ValidateUpgradeStacks(upgrade)) and self:ValidateUpgradeLevel(upgrade)) and ((existingOnly and (function() return self:ValidateUpgradeExisting(upgrade) end)) or (function() return not self:ValidateUpgradeExisting(upgrade) end))() end
    )
    if DEBUG_VALIDATIONS then
        __TS__ArrayForEach(
            Upgrades,
            function(____, upgrade)
                print("Validating: ", upgrade.name)
                print(
                    "\tValidateUpgradeType",
                    self:ValidateUpgradeType(upgrade, ____type),
                    upgrade.type,
                    "|",
                    ____type
                )
                print(
                    "\tValidateUpgradeHero",
                    self:ValidateUpgradeHero(upgrade)
                )
                print(
                    "\tValidateUpgradeAbility",
                    self:ValidateUpgradeAbility(upgrade)
                )
                print(
                    "\tValidateUpgradeAttackCapabilities",
                    self:ValidateUpgradeAttackCapabilities(upgrade)
                )
                print(
                    "\tValidateUpgradeStacks",
                    self:ValidateUpgradeStacks(upgrade)
                )
                print(
                    "\tValidateUpgradeLevel",
                    self:ValidateUpgradeLevel(upgrade)
                )
                print(
                    "\tValidateUpgradeExisting",
                    self:ValidateUpgradeExisting(upgrade)
                )
            end
        )
    end
    return Math:GetRandomElementsFromArray(
        upgrades,
        Clamp(amount, #upgrades, 0)
    )
end
function CustomPlayerHeroNPC.prototype.ValidateReward(self, reward)
    if reward.type == RewardTypes.KNOWLEDGE then
        if #self.heroUpgrades < 2 then
            return false
        end
    end
    return true
end
function CustomPlayerHeroNPC.prototype.ValidateUpgradeType(self, upgrade, ____type)
    return upgrade.type == ____type
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
function CustomPlayerHeroNPC.prototype.ValidateUpgradeExisting(self, upgrade)
    local heroUpgrade = __TS__ArrayFilter(
        self.heroUpgrades,
        function(____, heroUpgrade) return heroUpgrade.id == upgrade.id end
    )[1]
    if not heroUpgrade then
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
