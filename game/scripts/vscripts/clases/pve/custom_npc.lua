--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 7,["20"] = 9,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 11,["28"] = 11,["29"] = 11,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 18,["39"] = 18,["40"] = 18,["41"] = 30,["42"] = 30,["43"] = 30,["44"] = 30,["45"] = 30,["46"] = 31,["47"] = 32,["48"] = 32,["49"] = 32,["50"] = 32,["51"] = 30,["52"] = 34,["53"] = 35,["54"] = 31,["55"] = 37,["57"] = 38,["58"] = 38,["59"] = 39,["60"] = 40,["61"] = 41,["62"] = 42,["65"] = 38,["68"] = 37,["69"] = 47,["70"] = 48,["71"] = 49,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 51,["76"] = 51,["77"] = 51,["78"] = 52,["79"] = 53,["80"] = 55,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 56,["85"] = 56,["86"] = 56,["87"] = 56,["88"] = 57,["89"] = 57,["90"] = 57,["91"] = 57,["92"] = 57,["93"] = 57,["94"] = 57,["95"] = 57,["96"] = 57,["97"] = 58,["98"] = 58,["99"] = 58,["100"] = 58,["101"] = 58,["102"] = 58,["103"] = 58,["104"] = 58,["106"] = 61,["107"] = 62,["108"] = 63,["110"] = 66,["111"] = 68,["112"] = 69,["114"] = 71,["115"] = 72,["117"] = 75,["118"] = 76,["119"] = 76,["120"] = 76,["121"] = 76,["122"] = 76,["123"] = 76,["124"] = 76,["125"] = 76,["126"] = 76,["127"] = 76,["128"] = 76,["130"] = 88,["131"] = 88,["132"] = 89,["133"] = 90,["134"] = 91,["135"] = 92,["138"] = 88,["142"] = 98,["143"] = 99,["144"] = 100,["147"] = 104,["148"] = 105,["149"] = 47,["150"] = 107,["151"] = 108,["152"] = 109,["153"] = 110,["154"] = 112,["155"] = 113,["156"] = 114,["158"] = 116,["159"] = 117,["161"] = 119,["162"] = 120,["163"] = 121,["165"] = 123,["166"] = 124,["167"] = 125,["168"] = 126,["170"] = 128,["171"] = 129,["172"] = 130,["173"] = 131,["175"] = 133,["176"] = 134,["178"] = 136,["179"] = 137,["180"] = 138,["182"] = 140,["183"] = 141,["184"] = 142,["186"] = 144,["187"] = 145,["188"] = 146,["190"] = 148,["191"] = 149,["192"] = 150,["195"] = 153,["196"] = 154,["197"] = 155,["198"] = 156,["200"] = 158,["201"] = 159,["202"] = 160,["203"] = 161,["205"] = 163,["206"] = 164,["207"] = 165,["210"] = 168,["211"] = 169,["212"] = 170,["213"] = 171,["215"] = 173,["216"] = 174,["217"] = 175,["220"] = 178,["221"] = 179,["222"] = 180,["223"] = 181,["225"] = 183,["226"] = 184,["227"] = 185,["229"] = 187,["230"] = 188,["231"] = 189,["234"] = 192,["235"] = 193,["236"] = 194,["237"] = 195,["239"] = 197,["240"] = 198,["242"] = 200,["243"] = 201,["245"] = 203,["246"] = 204,["247"] = 205,["250"] = 208,["251"] = 209,["252"] = 210,["254"] = 212,["255"] = 213,["256"] = 214,["258"] = 216,["259"] = 217,["260"] = 218,["262"] = 220,["263"] = 221,["266"] = 225,["267"] = 107,["268"] = 227,["269"] = 228,["270"] = 229,["271"] = 231,["272"] = 232,["273"] = 233,["275"] = 235,["276"] = 236,["277"] = 237,["279"] = 239,["280"] = 240,["281"] = 241,["283"] = 243,["284"] = 244,["285"] = 245,["287"] = 247,["288"] = 248,["289"] = 249,["290"] = 250,["292"] = 253,["293"] = 254,["294"] = 255,["297"] = 258,["298"] = 259,["299"] = 260,["301"] = 262,["302"] = 263,["305"] = 266,["306"] = 227,["307"] = 268,["308"] = 269,["309"] = 270,["310"] = 272,["311"] = 273,["312"] = 274,["314"] = 277,["315"] = 278,["316"] = 279,["317"] = 280,["318"] = 282,["319"] = 283,["321"] = 285,["324"] = 288,["325"] = 288,["326"] = 289,["327"] = 290,["328"] = 291,["331"] = 288,["335"] = 297,["336"] = 301,["339"] = 304,["340"] = 305,["341"] = 306,["344"] = 309,["346"] = 312,["347"] = 313,["348"] = 314,["349"] = 314,["350"] = 314,["351"] = 316,["352"] = 317,["353"] = 318,["354"] = 318,["355"] = 318,["356"] = 318,["357"] = 318,["358"] = 318,["359"] = 318,["360"] = 318,["361"] = 318,["362"] = 319,["363"] = 319,["364"] = 319,["365"] = 319,["366"] = 319,["367"] = 319,["368"] = 319,["372"] = 268,["373"] = 324,["374"] = 30,["375"] = 326,["376"] = 324,["377"] = 30,["378"] = 30,["379"] = 329,["380"] = 329,["381"] = 329,["382"] = 329,["383"] = 330,["384"] = 329,["385"] = 332,["386"] = 333,["387"] = 330,["388"] = 336,["389"] = 336,["390"] = 336,["391"] = 336,["392"] = 337,["393"] = 336,["394"] = 339,["395"] = 337,["396"] = 342,["397"] = 342,["398"] = 342,["399"] = 342,["400"] = 347,["401"] = 342,["402"] = 343,["403"] = 345,["404"] = 349,["405"] = 350,["406"] = 351,["407"] = 352,["408"] = 353,["409"] = 354,["411"] = 356,["412"] = 357,["414"] = 347,["415"] = 361,["416"] = 342,["417"] = 363,["418"] = 364,["419"] = 365,["420"] = 366,["421"] = 367,["423"] = 370,["424"] = 371,["426"] = 361,["427"] = 375,["428"] = 376,["429"] = 376,["430"] = 376,["431"] = 376,["432"] = 376,["433"] = 377,["434"] = 377,["435"] = 377,["436"] = 378,["437"] = 379,["438"] = 382,["439"] = 383,["440"] = 384,["441"] = 386,["442"] = 387,["444"] = 377,["445"] = 377,["446"] = 375,["447"] = 393,["448"] = 394,["449"] = 393,["450"] = 397,["451"] = 398,["452"] = 397,["453"] = 401,["454"] = 402,["455"] = 403,["456"] = 403,["457"] = 403,["458"] = 403,["459"] = 403,["460"] = 403,["461"] = 404,["462"] = 401,["463"] = 407,["464"] = 408,["465"] = 409,["466"] = 409,["467"] = 409,["468"] = 409,["469"] = 409,["470"] = 409,["471"] = 410,["472"] = 407,["473"] = 413,["474"] = 414,["475"] = 415,["476"] = 416,["477"] = 417,["478"] = 417,["479"] = 417,["480"] = 418,["481"] = 419,["482"] = 420,["484"] = 425,["485"] = 417,["486"] = 417,["487"] = 428,["488"] = 429,["491"] = 436,["492"] = 437,["494"] = 440,["495"] = 441,["496"] = 442,["497"] = 413,["498"] = 446,["499"] = 447,["500"] = 448,["501"] = 449,["502"] = 446,["503"] = 452,["504"] = 453,["505"] = 454,["506"] = 455,["507"] = 456,["508"] = 458,["509"] = 461,["510"] = 452,["511"] = 464,["512"] = 465,["513"] = 465,["514"] = 465,["515"] = 468,["516"] = 468,["517"] = 468,["518"] = 468,["519"] = 468,["520"] = 468,["521"] = 468,["522"] = 464,["523"] = 471,["524"] = 472,["525"] = 472,["526"] = 472,["527"] = 472,["528"] = 477,["529"] = 478,["530"] = 478,["531"] = 478,["532"] = 478,["533"] = 478,["534"] = 478,["535"] = 478,["536"] = 471,["537"] = 481,["538"] = 482,["539"] = 482,["540"] = 482,["541"] = 482,["542"] = 487,["543"] = 488,["544"] = 488,["545"] = 488,["546"] = 488,["547"] = 488,["548"] = 488,["549"] = 488,["550"] = 481,["551"] = 491,["552"] = 492,["553"] = 492,["554"] = 492,["555"] = 492,["556"] = 497,["557"] = 498,["558"] = 498,["559"] = 498,["560"] = 498,["561"] = 498,["562"] = 498,["563"] = 498,["564"] = 491,["565"] = 501,["566"] = 502,["567"] = 502,["568"] = 502,["569"] = 502,["570"] = 507,["571"] = 508,["572"] = 508,["573"] = 508,["574"] = 508,["575"] = 508,["576"] = 508,["577"] = 508,["578"] = 501,["579"] = 511,["580"] = 512,["581"] = 512,["582"] = 512,["583"] = 512,["584"] = 516,["585"] = 516,["586"] = 516,["587"] = 516,["588"] = 511,["589"] = 519,["590"] = 520,["591"] = 520,["592"] = 520,["593"] = 520,["594"] = 529,["595"] = 529,["596"] = 529,["597"] = 529,["598"] = 519,["599"] = 532,["600"] = 533,["601"] = 533,["602"] = 533,["603"] = 533,["604"] = 537,["605"] = 537,["606"] = 537,["607"] = 537,["608"] = 532,["609"] = 540,["610"] = 541,["611"] = 542,["612"] = 543,["615"] = 546,["616"] = 540,["617"] = 549,["618"] = 550,["619"] = 551,["621"] = 553,["622"] = 549,["623"] = 556,["624"] = 557,["625"] = 558,["627"] = 561,["628"] = 562,["629"] = 563,["631"] = 566,["632"] = 556,["633"] = 569,["634"] = 570,["635"] = 571,["637"] = 573,["638"] = 574,["640"] = 577,["641"] = 569,["642"] = 580,["643"] = 581,["644"] = 581,["645"] = 581,["646"] = 581,["647"] = 583,["648"] = 584,["650"] = 587,["651"] = 580,["652"] = 590,["653"] = 591,["654"] = 592,["656"] = 594,["657"] = 595,["659"] = 597,["660"] = 590,["661"] = 600,["662"] = 601,["663"] = 601,["664"] = 601,["665"] = 601,["666"] = 603,["667"] = 604,["669"] = 607,["670"] = 608,["672"] = 611,["673"] = 600});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
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
function CustomPlayerHeroNPC.prototype.RequestItems(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateItems(3)
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
function CustomPlayerHeroNPC.prototype.RequestFavors(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3, false)
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
function CustomPlayerHeroNPC.prototype.RequestEnhancements(self)
    local data = {
        playerId = self.unit:GetPlayerOwnerID(),
        upgrades = self:GenerateUpgrades(3, true)
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
function CustomPlayerHeroNPC.prototype.GenerateUpgrades(self, amount, existingOnly)
    local upgrades = __TS__ArrayFilter(
        Upgrades,
        function(____, upgrade) return ((((self:ValidateUpgradeHero(upgrade) and self:ValidateUpgradeAbility(upgrade)) and self:ValidateUpgradeAttackCapabilities(upgrade)) and self:ValidateUpgradeStacks(upgrade)) and self:ValidateUpgradeLevel(upgrade)) and ((existingOnly and (function() return self:ValidateUpgradeExisting(upgrade) end)) or (function() return not self:ValidateUpgradeExisting(upgrade) end))() end
    )
    return Math:GetRandomElementsFromArray(
        upgrades,
        Clamp(amount, #upgrades, 0)
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
function CustomPlayerHeroNPC.prototype.ValidateReward(self, reward)
    if reward.type == RewardTypes.ENHANCEMENT then
        if #self.heroUpgrades < 2 then
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
