--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 7,["18"] = 7,["19"] = 9,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 11,["28"] = 11,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 18,["39"] = 18,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 31,["47"] = 31,["48"] = 31,["49"] = 31,["50"] = 29,["51"] = 33,["52"] = 34,["53"] = 30,["54"] = 36,["56"] = 37,["57"] = 37,["58"] = 38,["59"] = 39,["60"] = 40,["61"] = 41,["64"] = 37,["67"] = 36,["68"] = 46,["69"] = 47,["70"] = 48,["71"] = 49,["72"] = 49,["73"] = 49,["74"] = 50,["75"] = 50,["76"] = 50,["77"] = 51,["78"] = 52,["79"] = 54,["80"] = 55,["81"] = 55,["82"] = 55,["83"] = 55,["84"] = 55,["85"] = 55,["86"] = 55,["87"] = 56,["88"] = 56,["89"] = 56,["90"] = 56,["91"] = 56,["92"] = 56,["93"] = 56,["94"] = 56,["95"] = 56,["96"] = 57,["97"] = 57,["98"] = 57,["99"] = 57,["100"] = 57,["101"] = 57,["102"] = 57,["103"] = 57,["105"] = 60,["106"] = 61,["107"] = 62,["109"] = 65,["110"] = 67,["111"] = 68,["113"] = 70,["114"] = 71,["116"] = 74,["117"] = 75,["118"] = 75,["119"] = 75,["120"] = 75,["121"] = 75,["122"] = 75,["123"] = 75,["124"] = 75,["125"] = 75,["126"] = 75,["127"] = 75,["129"] = 87,["130"] = 87,["131"] = 88,["132"] = 89,["133"] = 90,["134"] = 91,["137"] = 87,["141"] = 97,["142"] = 98,["143"] = 99,["146"] = 103,["147"] = 104,["148"] = 46,["149"] = 106,["150"] = 107,["151"] = 108,["152"] = 109,["153"] = 111,["154"] = 112,["155"] = 113,["157"] = 115,["158"] = 116,["160"] = 118,["161"] = 119,["162"] = 120,["164"] = 122,["165"] = 123,["166"] = 124,["167"] = 125,["169"] = 127,["170"] = 128,["171"] = 129,["172"] = 130,["174"] = 132,["175"] = 133,["177"] = 135,["178"] = 136,["179"] = 137,["181"] = 139,["182"] = 140,["183"] = 141,["185"] = 143,["186"] = 144,["187"] = 145,["189"] = 147,["190"] = 148,["191"] = 149,["194"] = 152,["195"] = 153,["196"] = 154,["197"] = 155,["199"] = 157,["200"] = 158,["201"] = 159,["202"] = 160,["204"] = 162,["205"] = 163,["206"] = 164,["209"] = 167,["210"] = 168,["211"] = 169,["212"] = 170,["214"] = 172,["215"] = 173,["216"] = 174,["219"] = 177,["220"] = 178,["221"] = 179,["222"] = 180,["224"] = 182,["225"] = 183,["226"] = 184,["228"] = 186,["229"] = 187,["230"] = 188,["233"] = 191,["234"] = 192,["235"] = 193,["236"] = 194,["238"] = 196,["239"] = 197,["241"] = 199,["242"] = 200,["244"] = 202,["245"] = 203,["246"] = 204,["249"] = 207,["250"] = 208,["251"] = 209,["253"] = 211,["254"] = 212,["255"] = 213,["257"] = 215,["258"] = 216,["259"] = 217,["261"] = 219,["262"] = 220,["265"] = 224,["266"] = 106,["267"] = 226,["268"] = 227,["269"] = 228,["270"] = 230,["271"] = 231,["272"] = 232,["274"] = 234,["275"] = 235,["276"] = 236,["278"] = 238,["279"] = 239,["280"] = 240,["282"] = 242,["283"] = 243,["284"] = 244,["286"] = 246,["287"] = 247,["288"] = 248,["289"] = 249,["291"] = 252,["292"] = 253,["293"] = 254,["296"] = 257,["297"] = 258,["298"] = 259,["300"] = 261,["301"] = 262,["304"] = 265,["305"] = 226,["306"] = 267,["307"] = 268,["308"] = 269,["309"] = 271,["310"] = 272,["311"] = 273,["313"] = 276,["314"] = 277,["315"] = 278,["316"] = 279,["317"] = 281,["318"] = 282,["320"] = 284,["323"] = 287,["324"] = 287,["325"] = 288,["326"] = 289,["327"] = 290,["330"] = 287,["334"] = 296,["335"] = 300,["338"] = 303,["339"] = 304,["340"] = 305,["343"] = 308,["345"] = 311,["346"] = 312,["347"] = 313,["348"] = 313,["349"] = 313,["350"] = 315,["351"] = 316,["352"] = 317,["353"] = 317,["354"] = 317,["355"] = 317,["356"] = 317,["357"] = 317,["358"] = 317,["359"] = 317,["360"] = 317,["361"] = 318,["362"] = 318,["363"] = 318,["364"] = 318,["365"] = 318,["366"] = 318,["367"] = 318,["371"] = 267,["372"] = 323,["373"] = 29,["374"] = 325,["375"] = 323,["376"] = 29,["377"] = 29,["378"] = 328,["379"] = 328,["380"] = 328,["381"] = 328,["382"] = 329,["383"] = 328,["384"] = 331,["385"] = 332,["386"] = 329,["387"] = 335,["388"] = 335,["389"] = 335,["390"] = 335,["391"] = 336,["392"] = 335,["393"] = 338,["394"] = 336,["395"] = 341,["396"] = 341,["397"] = 341,["398"] = 341,["399"] = 346,["400"] = 341,["401"] = 342,["402"] = 344,["403"] = 348,["404"] = 349,["405"] = 350,["406"] = 351,["407"] = 352,["408"] = 353,["409"] = 354,["410"] = 354,["411"] = 354,["412"] = 355,["413"] = 355,["414"] = 355,["415"] = 357,["416"] = 357,["417"] = 357,["418"] = 357,["419"] = 357,["421"] = 359,["422"] = 360,["424"] = 346,["425"] = 364,["426"] = 365,["427"] = 366,["428"] = 367,["429"] = 368,["430"] = 369,["431"] = 370,["432"] = 370,["433"] = 370,["437"] = 364,["438"] = 376,["439"] = 341,["440"] = 378,["441"] = 379,["442"] = 380,["443"] = 381,["444"] = 382,["446"] = 385,["447"] = 386,["449"] = 376,["450"] = 390,["451"] = 391,["452"] = 391,["453"] = 391,["454"] = 391,["455"] = 391,["456"] = 392,["457"] = 392,["458"] = 392,["459"] = 393,["460"] = 394,["461"] = 397,["462"] = 398,["463"] = 399,["464"] = 401,["465"] = 402,["467"] = 392,["468"] = 392,["469"] = 390,["470"] = 408,["471"] = 409,["472"] = 408,["473"] = 412,["474"] = 413,["475"] = 412,["476"] = 416,["477"] = 417,["478"] = 418,["479"] = 418,["480"] = 418,["481"] = 418,["482"] = 418,["483"] = 418,["484"] = 419,["485"] = 416,["486"] = 422,["487"] = 423,["488"] = 424,["489"] = 424,["490"] = 424,["491"] = 424,["492"] = 424,["493"] = 424,["494"] = 425,["495"] = 422,["496"] = 428,["497"] = 428,["498"] = 432,["499"] = 433,["500"] = 434,["501"] = 435,["502"] = 436,["503"] = 438,["504"] = 439,["505"] = 439,["506"] = 439,["507"] = 440,["508"] = 441,["509"] = 442,["511"] = 447,["512"] = 439,["513"] = 439,["514"] = 450,["515"] = 451,["516"] = 451,["517"] = 451,["518"] = 451,["521"] = 458,["522"] = 459,["524"] = 462,["525"] = 463,["527"] = 465,["528"] = 466,["530"] = 468,["531"] = 469,["534"] = 473,["535"] = 474,["536"] = 475,["537"] = 432,["538"] = 478,["539"] = 479,["540"] = 480,["541"] = 480,["542"] = 480,["543"] = 481,["544"] = 481,["545"] = 481,["546"] = 481,["547"] = 483,["548"] = 484,["550"] = 480,["551"] = 480,["552"] = 488,["553"] = 492,["554"] = 494,["556"] = 497,["557"] = 500,["558"] = 478,["559"] = 503,["560"] = 504,["561"] = 506,["562"] = 503,["563"] = 511,["564"] = 512,["565"] = 514,["566"] = 511,["567"] = 519,["568"] = 520,["569"] = 521,["570"] = 522,["571"] = 524,["572"] = 525,["573"] = 519,["574"] = 534,["575"] = 535,["576"] = 536,["577"] = 537,["578"] = 538,["579"] = 540,["580"] = 543,["581"] = 534,["582"] = 546,["583"] = 547,["584"] = 547,["585"] = 547,["586"] = 550,["587"] = 550,["588"] = 550,["589"] = 550,["590"] = 550,["591"] = 550,["592"] = 550,["593"] = 546,["594"] = 553,["595"] = 554,["596"] = 554,["597"] = 554,["598"] = 554,["599"] = 554,["600"] = 554,["601"] = 556,["602"] = 557,["605"] = 561,["606"] = 561,["607"] = 561,["608"] = 561,["609"] = 566,["610"] = 567,["611"] = 567,["612"] = 567,["613"] = 567,["614"] = 567,["615"] = 567,["616"] = 567,["617"] = 553,["618"] = 570,["619"] = 571,["620"] = 573,["621"] = 574,["622"] = 575,["625"] = 579,["626"] = 579,["627"] = 579,["628"] = 579,["629"] = 584,["630"] = 585,["631"] = 585,["632"] = 585,["633"] = 585,["634"] = 585,["635"] = 585,["636"] = 585,["637"] = 570,["638"] = 588,["639"] = 589,["640"] = 591,["641"] = 592,["642"] = 593,["645"] = 597,["646"] = 597,["647"] = 597,["648"] = 597,["649"] = 602,["650"] = 603,["651"] = 603,["652"] = 603,["653"] = 603,["654"] = 603,["655"] = 603,["656"] = 603,["657"] = 588,["658"] = 606,["659"] = 607,["660"] = 609,["661"] = 610,["662"] = 611,["665"] = 615,["666"] = 615,["667"] = 615,["668"] = 615,["669"] = 620,["670"] = 621,["671"] = 621,["672"] = 621,["673"] = 621,["674"] = 621,["675"] = 621,["676"] = 621,["677"] = 606,["678"] = 624,["679"] = 625,["680"] = 625,["681"] = 625,["682"] = 625,["683"] = 627,["684"] = 628,["685"] = 629,["688"] = 633,["689"] = 633,["690"] = 633,["691"] = 633,["692"] = 638,["693"] = 639,["694"] = 639,["695"] = 639,["696"] = 639,["697"] = 639,["698"] = 639,["699"] = 639,["700"] = 624});
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
local UpgradeManager = ____upgrades.UpgradeManager
local ____rewards = require("rewards.rewards")
local RewardsManager = ____rewards.RewardsManager
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
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
        customEntities:ChangeMS(self.unit, 50)
        self.unit:RemoveAbility(
            self.unit:GetAbilityByIndex(7):GetName()
        )
        self.unit:RemoveAbility(
            self.unit:GetAbilityByIndex(8):GetName()
        )
        ListenToGameEvent(
            "dota_player_learned_ability",
            function(event) return self:OnLearnedAbilityEvent(event) end,
            nil
        )
    else
        self:LevelAllAbilities(1)
        self.unit:SetAbilityPoints(2)
    end
end
function CustomPlayerHeroNPC.prototype.OnLearnedAbilityEvent(self, event)
    if event.PlayerID == self.unit:GetPlayerOwnerID() then
        local ability = self.unit:FindAbilityByName(event.abilityname)
        if ability then
            if ability:GetLevel() == 2 then
                ability:SetLevel(1)
                self.unit:SetAbilityPoints(
                    self.unit:GetAbilityPoints() + 1
                )
            end
        end
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
function CustomPlayerHeroNPC.prototype.ReleaseAbility(self, abilityName)
end
function CustomPlayerHeroNPC.prototype.ApplyUpgrade(self, upgrade)
    if upgrade then
        if upgrade and upgrade.modifier then
            local ability = ((upgrade.ability and (function() return self.unit:FindAbilityByName(upgrade.ability) end)) or (function() return nil end))()
            self.unit:AddNewModifier(self.unit, ability, upgrade.modifier.name, {duration = upgrade.modifier.duration})
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
                __TS__ArrayPush(
                    self.heroUpgrades,
                    __TS__ObjectAssign({}, upgrade, {level = 1})
                )
            end
        end
        if upgrade.effect then
            upgrade:effect(self.unit)
        end
        if upgrade.type == UpgradeTypes.ITEM then
            self:ApplyItem(upgrade)
        end
        if upgrade.type == UpgradeTypes.FAVOR then
            self:ApplyFavor(upgrade)
        end
        if upgrade.type == UpgradeTypes.SHARD then
            self:ApplyShard(upgrade)
        end
    end
    self:ClearTable("custom_npc_favors")
    local customEvents = CustomEvents:GetInstance()
    customEvents:EmitEvent("pve:current_reward_applied", {customNpc = self})
end
function CustomPlayerHeroNPC.prototype.ApplyItem(self, upgrade)
    if upgrade.ingredients then
        __TS__ArrayForEach(
            upgrade.ingredients,
            function(____, ingredientId)
                local ingredientUpgrade = __TS__ArrayFilter(
                    self.heroUpgrades,
                    function(____, _heroUpgrade) return _heroUpgrade.id == ingredientId end
                )[1]
                if ingredientUpgrade then
                    self.unit:RemoveModifierByName(ingredientUpgrade.modifier.name)
                end
            end
        )
        EFX("particles/items_fx/item_sheepstick.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.unit, {release = true})
        self.unit:AddNewModifier(self.unit, nil, "modifier_combine_util", {duration = 1.5})
        EmitSoundOn("DOTA_Item.RepairKit.Target", self.unit)
    end
    EFX("particles/econ/events/ti10/mekanism_ti10.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.unit, {release = true})
    EmitSoundOn("DOTA_Item.Overwhelming_Blink.NailedIt", self.unit)
end
function CustomPlayerHeroNPC.prototype.ApplyFavor(self, upgrade)
    EmitSoundOn("DOTA_Item.Mekansm.Target", self.unit)
    EFX("particles/econ/events/ti10/hero_levelup_ti10.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.unit, {release = true})
end
function CustomPlayerHeroNPC.prototype.ApplyShard(self, upgrade)
    EmitSoundOn("Item.MoonShard.Consume", self.unit)
    EFX("particles/econ/events/ti10/hero_levelup_ti10.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.unit, {release = true})
end
function CustomPlayerHeroNPC.prototype.ApplyTarrasque(self)
    self.unit:AddNewModifier(self.unit, nil, "modifier_upgrade_tarrasque", {})
    local customEvents = CustomEvents:GetInstance()
    customEvents:EmitEvent("pve:current_reward_applied", {customNpc = self})
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", self.unit)
    EFX("particles/gems/emerald.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.unit, {cp3 = {ent = self.unit, point = "attach_hitloc"}, release = true})
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
    local rewards = RewardsManager:GenerateRewards(
        self,
        {
            amount = RandomInt(1, 3)
        }
    )
    if #rewards == 0 then
        print("Skipping rewards selection. No rewards available")
        return
    end
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        rewards = rewards
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
    local upgrades = UpgradeManager:GenerateFavors(self, 3)
    if #upgrades == 0 then
        print("Skipping favors selection. No rewards available")
        self:ApplyUpgrade(nil)
        return
    end
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = upgrades
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
    local upgrades = UpgradeManager:GenerateShards(self, 3)
    if #upgrades == 0 then
        print("Skipping shards selection. No rewards available")
        self:ApplyUpgrade(nil)
        return
    end
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = upgrades
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
    local upgrades = UpgradeManager:GenerateKnowledge(self, 3)
    if #upgrades == 0 then
        print("Skipping knowledge selection. No rewards available")
        self:ApplyUpgrade(nil)
        return
    end
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = upgrades
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
    local upgrades = UpgradeManager:GenerateItems(
        self,
        RandomInt(4, 6)
    )
    if #upgrades == 0 then
        print("Skipping items selection. No rewards available")
        self:ApplyUpgrade(nil)
        return
    end
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = upgrades
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
return ____exports
