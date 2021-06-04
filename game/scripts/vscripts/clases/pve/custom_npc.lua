--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 7,["18"] = 7,["19"] = 9,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 11,["28"] = 11,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 18,["39"] = 18,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 31,["47"] = 31,["48"] = 31,["49"] = 31,["50"] = 29,["51"] = 33,["52"] = 34,["53"] = 35,["54"] = 30,["55"] = 37,["57"] = 38,["58"] = 38,["59"] = 39,["60"] = 40,["61"] = 41,["62"] = 42,["65"] = 38,["68"] = 37,["69"] = 47,["70"] = 48,["71"] = 49,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 51,["76"] = 51,["77"] = 51,["78"] = 52,["79"] = 53,["80"] = 55,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 56,["85"] = 56,["86"] = 56,["87"] = 56,["88"] = 57,["89"] = 57,["90"] = 57,["91"] = 57,["92"] = 57,["93"] = 57,["94"] = 57,["95"] = 57,["96"] = 57,["97"] = 58,["98"] = 58,["99"] = 58,["100"] = 58,["101"] = 58,["102"] = 58,["103"] = 58,["104"] = 58,["106"] = 61,["107"] = 62,["108"] = 63,["110"] = 66,["111"] = 68,["112"] = 69,["114"] = 71,["115"] = 72,["117"] = 75,["118"] = 76,["119"] = 76,["120"] = 76,["121"] = 76,["122"] = 76,["123"] = 76,["124"] = 76,["125"] = 76,["126"] = 76,["127"] = 76,["128"] = 76,["130"] = 88,["131"] = 88,["132"] = 89,["133"] = 90,["134"] = 91,["135"] = 92,["138"] = 88,["142"] = 98,["143"] = 99,["144"] = 100,["147"] = 104,["148"] = 105,["149"] = 47,["150"] = 107,["151"] = 108,["152"] = 109,["153"] = 110,["154"] = 112,["155"] = 113,["156"] = 114,["158"] = 116,["159"] = 117,["161"] = 119,["162"] = 120,["163"] = 121,["165"] = 123,["166"] = 124,["167"] = 125,["168"] = 126,["170"] = 128,["171"] = 129,["172"] = 130,["173"] = 131,["175"] = 133,["176"] = 134,["178"] = 136,["179"] = 137,["180"] = 138,["182"] = 140,["183"] = 141,["184"] = 142,["186"] = 144,["187"] = 145,["188"] = 146,["190"] = 148,["191"] = 149,["192"] = 150,["195"] = 153,["196"] = 154,["197"] = 155,["198"] = 156,["200"] = 158,["201"] = 159,["202"] = 160,["203"] = 161,["205"] = 163,["206"] = 164,["207"] = 165,["210"] = 168,["211"] = 169,["212"] = 170,["213"] = 171,["215"] = 173,["216"] = 174,["217"] = 175,["220"] = 178,["221"] = 179,["222"] = 180,["223"] = 181,["225"] = 183,["226"] = 184,["227"] = 185,["229"] = 187,["230"] = 188,["231"] = 189,["234"] = 192,["235"] = 193,["236"] = 194,["237"] = 195,["239"] = 197,["240"] = 198,["242"] = 200,["243"] = 201,["245"] = 203,["246"] = 204,["247"] = 205,["250"] = 208,["251"] = 209,["252"] = 210,["254"] = 212,["255"] = 213,["256"] = 214,["258"] = 216,["259"] = 217,["260"] = 218,["262"] = 220,["263"] = 221,["266"] = 225,["267"] = 107,["268"] = 227,["269"] = 228,["270"] = 229,["271"] = 231,["272"] = 232,["273"] = 233,["275"] = 235,["276"] = 236,["277"] = 237,["279"] = 239,["280"] = 240,["281"] = 241,["283"] = 243,["284"] = 244,["285"] = 245,["287"] = 247,["288"] = 248,["289"] = 249,["290"] = 250,["292"] = 253,["293"] = 254,["294"] = 255,["297"] = 258,["298"] = 259,["299"] = 260,["301"] = 262,["302"] = 263,["305"] = 266,["306"] = 227,["307"] = 268,["308"] = 269,["309"] = 270,["310"] = 272,["311"] = 273,["312"] = 274,["314"] = 277,["315"] = 278,["316"] = 279,["317"] = 280,["318"] = 282,["319"] = 283,["321"] = 285,["324"] = 288,["325"] = 288,["326"] = 289,["327"] = 290,["328"] = 291,["331"] = 288,["335"] = 297,["336"] = 301,["339"] = 304,["340"] = 305,["341"] = 306,["344"] = 309,["346"] = 312,["347"] = 313,["348"] = 314,["349"] = 314,["350"] = 314,["351"] = 316,["352"] = 317,["353"] = 318,["354"] = 318,["355"] = 318,["356"] = 318,["357"] = 318,["358"] = 318,["359"] = 318,["360"] = 318,["361"] = 318,["362"] = 319,["363"] = 319,["364"] = 319,["365"] = 319,["366"] = 319,["367"] = 319,["368"] = 319,["372"] = 268,["373"] = 324,["374"] = 29,["375"] = 326,["376"] = 324,["377"] = 29,["378"] = 29,["379"] = 329,["380"] = 329,["381"] = 329,["382"] = 329,["383"] = 330,["384"] = 329,["385"] = 332,["386"] = 330,["387"] = 335,["388"] = 335,["389"] = 335,["390"] = 335,["391"] = 336,["392"] = 335,["393"] = 338,["394"] = 336,["395"] = 341,["396"] = 341,["397"] = 341,["398"] = 341,["399"] = 346,["400"] = 341,["401"] = 342,["402"] = 344,["403"] = 348,["404"] = 349,["405"] = 350,["406"] = 351,["407"] = 352,["408"] = 353,["409"] = 354,["410"] = 354,["411"] = 354,["412"] = 355,["413"] = 355,["414"] = 355,["415"] = 357,["416"] = 357,["417"] = 357,["418"] = 357,["419"] = 357,["421"] = 359,["422"] = 360,["424"] = 346,["425"] = 364,["426"] = 365,["427"] = 366,["428"] = 367,["429"] = 368,["430"] = 369,["431"] = 370,["432"] = 370,["433"] = 370,["437"] = 364,["438"] = 376,["439"] = 341,["440"] = 378,["441"] = 379,["442"] = 380,["443"] = 381,["444"] = 382,["446"] = 385,["447"] = 386,["449"] = 376,["450"] = 390,["451"] = 391,["452"] = 391,["453"] = 391,["454"] = 391,["455"] = 391,["456"] = 392,["457"] = 392,["458"] = 392,["459"] = 393,["460"] = 394,["461"] = 397,["462"] = 398,["463"] = 399,["464"] = 401,["465"] = 402,["467"] = 392,["468"] = 392,["469"] = 390,["470"] = 408,["471"] = 409,["472"] = 408,["473"] = 412,["474"] = 413,["475"] = 412,["476"] = 416,["477"] = 417,["478"] = 418,["479"] = 418,["480"] = 418,["481"] = 418,["482"] = 418,["483"] = 418,["484"] = 419,["485"] = 416,["486"] = 422,["487"] = 423,["488"] = 424,["489"] = 424,["490"] = 424,["491"] = 424,["492"] = 424,["493"] = 424,["494"] = 425,["495"] = 422,["496"] = 428,["497"] = 428,["498"] = 432,["499"] = 433,["500"] = 434,["501"] = 435,["502"] = 436,["503"] = 438,["504"] = 439,["505"] = 439,["506"] = 439,["507"] = 440,["508"] = 441,["509"] = 442,["511"] = 447,["512"] = 439,["513"] = 439,["514"] = 450,["515"] = 451,["516"] = 451,["517"] = 451,["518"] = 451,["521"] = 458,["522"] = 459,["524"] = 462,["525"] = 463,["527"] = 465,["528"] = 466,["530"] = 468,["531"] = 469,["534"] = 473,["535"] = 474,["536"] = 475,["537"] = 432,["538"] = 478,["539"] = 479,["540"] = 480,["541"] = 480,["542"] = 480,["543"] = 481,["544"] = 481,["545"] = 481,["546"] = 481,["547"] = 483,["548"] = 484,["550"] = 480,["551"] = 480,["552"] = 488,["553"] = 492,["554"] = 494,["556"] = 497,["557"] = 500,["558"] = 478,["559"] = 503,["560"] = 504,["561"] = 506,["562"] = 503,["563"] = 511,["564"] = 512,["565"] = 514,["566"] = 511,["567"] = 519,["568"] = 520,["569"] = 521,["570"] = 522,["571"] = 519,["572"] = 525,["573"] = 526,["574"] = 527,["575"] = 528,["576"] = 529,["577"] = 531,["578"] = 534,["579"] = 525,["580"] = 537,["581"] = 538,["582"] = 538,["583"] = 538,["584"] = 541,["585"] = 541,["586"] = 541,["587"] = 541,["588"] = 541,["589"] = 541,["590"] = 541,["591"] = 537,["592"] = 544,["593"] = 545,["594"] = 545,["595"] = 545,["596"] = 545,["597"] = 545,["598"] = 545,["599"] = 547,["600"] = 548,["603"] = 552,["604"] = 552,["605"] = 552,["606"] = 552,["607"] = 557,["608"] = 558,["609"] = 558,["610"] = 558,["611"] = 558,["612"] = 558,["613"] = 558,["614"] = 558,["615"] = 544,["616"] = 561,["617"] = 562,["618"] = 564,["619"] = 565,["620"] = 566,["623"] = 570,["624"] = 570,["625"] = 570,["626"] = 570,["627"] = 575,["628"] = 576,["629"] = 576,["630"] = 576,["631"] = 576,["632"] = 576,["633"] = 576,["634"] = 576,["635"] = 561,["636"] = 579,["637"] = 580,["638"] = 582,["639"] = 583,["640"] = 584,["643"] = 588,["644"] = 588,["645"] = 588,["646"] = 588,["647"] = 593,["648"] = 594,["649"] = 594,["650"] = 594,["651"] = 594,["652"] = 594,["653"] = 594,["654"] = 594,["655"] = 579,["656"] = 597,["657"] = 598,["658"] = 600,["659"] = 601,["660"] = 602,["663"] = 606,["664"] = 606,["665"] = 606,["666"] = 606,["667"] = 611,["668"] = 612,["669"] = 612,["670"] = 612,["671"] = 612,["672"] = 612,["673"] = 612,["674"] = 612,["675"] = 597,["676"] = 615,["677"] = 616,["678"] = 616,["679"] = 616,["680"] = 616,["681"] = 618,["682"] = 619,["683"] = 620,["686"] = 624,["687"] = 624,["688"] = 624,["689"] = 624,["690"] = 629,["691"] = 630,["692"] = 630,["693"] = 630,["694"] = 630,["695"] = 630,["696"] = 630,["697"] = 630,["698"] = 615});
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
        customEntities:HideHealthBar(self.unit)
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
