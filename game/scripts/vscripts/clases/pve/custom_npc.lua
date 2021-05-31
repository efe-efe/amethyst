--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 5,["12"] = 5,["13"] = 6,["14"] = 6,["15"] = 7,["16"] = 7,["17"] = 9,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 29,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 30,["44"] = 31,["45"] = 31,["46"] = 31,["47"] = 31,["48"] = 29,["49"] = 33,["50"] = 34,["51"] = 30,["52"] = 36,["54"] = 37,["55"] = 37,["56"] = 38,["57"] = 39,["58"] = 40,["59"] = 41,["62"] = 37,["65"] = 36,["66"] = 46,["67"] = 47,["68"] = 48,["69"] = 49,["70"] = 49,["71"] = 49,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 51,["76"] = 52,["77"] = 54,["78"] = 55,["79"] = 55,["80"] = 55,["81"] = 55,["82"] = 55,["83"] = 55,["84"] = 55,["85"] = 56,["86"] = 56,["87"] = 56,["88"] = 56,["89"] = 56,["90"] = 56,["91"] = 56,["92"] = 56,["93"] = 56,["94"] = 57,["95"] = 57,["96"] = 57,["97"] = 57,["98"] = 57,["99"] = 57,["100"] = 57,["101"] = 57,["103"] = 60,["104"] = 61,["105"] = 62,["107"] = 65,["108"] = 67,["109"] = 68,["111"] = 70,["112"] = 71,["114"] = 74,["115"] = 75,["116"] = 75,["117"] = 75,["118"] = 75,["119"] = 75,["120"] = 75,["121"] = 75,["122"] = 75,["123"] = 75,["124"] = 75,["125"] = 75,["127"] = 87,["128"] = 87,["129"] = 88,["130"] = 89,["131"] = 90,["132"] = 91,["135"] = 87,["139"] = 97,["140"] = 98,["141"] = 99,["144"] = 103,["145"] = 104,["146"] = 46,["147"] = 106,["148"] = 107,["149"] = 108,["150"] = 109,["151"] = 111,["152"] = 112,["153"] = 113,["155"] = 115,["156"] = 116,["158"] = 118,["159"] = 119,["160"] = 120,["162"] = 122,["163"] = 123,["164"] = 124,["165"] = 125,["167"] = 127,["168"] = 128,["169"] = 129,["170"] = 130,["172"] = 132,["173"] = 133,["175"] = 135,["176"] = 136,["177"] = 137,["179"] = 139,["180"] = 140,["181"] = 141,["183"] = 143,["184"] = 144,["185"] = 145,["187"] = 147,["188"] = 148,["189"] = 149,["192"] = 152,["193"] = 153,["194"] = 154,["195"] = 155,["197"] = 157,["198"] = 158,["199"] = 159,["200"] = 160,["202"] = 162,["203"] = 163,["204"] = 164,["207"] = 167,["208"] = 168,["209"] = 169,["210"] = 170,["212"] = 172,["213"] = 173,["214"] = 174,["217"] = 177,["218"] = 178,["219"] = 179,["220"] = 180,["222"] = 182,["223"] = 183,["224"] = 184,["226"] = 186,["227"] = 187,["228"] = 188,["231"] = 191,["232"] = 192,["233"] = 193,["234"] = 194,["236"] = 196,["237"] = 197,["239"] = 199,["240"] = 200,["242"] = 202,["243"] = 203,["244"] = 204,["247"] = 207,["248"] = 208,["249"] = 209,["251"] = 211,["252"] = 212,["253"] = 213,["255"] = 215,["256"] = 216,["257"] = 217,["259"] = 219,["260"] = 220,["263"] = 224,["264"] = 106,["265"] = 226,["266"] = 227,["267"] = 228,["268"] = 230,["269"] = 231,["270"] = 232,["272"] = 234,["273"] = 235,["274"] = 236,["276"] = 238,["277"] = 239,["278"] = 240,["280"] = 242,["281"] = 243,["282"] = 244,["284"] = 246,["285"] = 247,["286"] = 248,["287"] = 249,["289"] = 252,["290"] = 253,["291"] = 254,["294"] = 257,["295"] = 258,["296"] = 259,["298"] = 261,["299"] = 262,["302"] = 265,["303"] = 226,["304"] = 267,["305"] = 268,["306"] = 269,["307"] = 271,["308"] = 272,["309"] = 273,["311"] = 276,["312"] = 277,["313"] = 278,["314"] = 279,["315"] = 281,["316"] = 282,["318"] = 284,["321"] = 287,["322"] = 287,["323"] = 288,["324"] = 289,["325"] = 290,["328"] = 287,["332"] = 296,["333"] = 300,["336"] = 303,["337"] = 304,["338"] = 305,["341"] = 308,["343"] = 311,["344"] = 312,["345"] = 313,["346"] = 313,["347"] = 313,["348"] = 315,["349"] = 316,["350"] = 317,["351"] = 317,["352"] = 317,["353"] = 317,["354"] = 317,["355"] = 317,["356"] = 317,["357"] = 317,["358"] = 317,["359"] = 318,["360"] = 318,["361"] = 318,["362"] = 318,["363"] = 318,["364"] = 318,["365"] = 318,["369"] = 267,["370"] = 323,["371"] = 29,["372"] = 325,["373"] = 323,["374"] = 29,["375"] = 29,["376"] = 328,["377"] = 328,["378"] = 328,["379"] = 328,["380"] = 329,["381"] = 328,["382"] = 331,["383"] = 332,["384"] = 329,["385"] = 335,["386"] = 335,["387"] = 335,["388"] = 335,["389"] = 336,["390"] = 335,["391"] = 338,["392"] = 336,["393"] = 341,["394"] = 341,["395"] = 341,["396"] = 341,["397"] = 346,["398"] = 341,["399"] = 342,["400"] = 344,["401"] = 348,["402"] = 349,["403"] = 350,["404"] = 351,["405"] = 352,["406"] = 353,["407"] = 354,["408"] = 354,["409"] = 354,["410"] = 355,["411"] = 355,["412"] = 355,["413"] = 357,["414"] = 357,["415"] = 357,["416"] = 357,["417"] = 357,["419"] = 359,["420"] = 360,["422"] = 346,["423"] = 364,["424"] = 365,["425"] = 366,["426"] = 367,["427"] = 368,["428"] = 369,["429"] = 370,["430"] = 370,["431"] = 370,["435"] = 364,["436"] = 376,["437"] = 341,["438"] = 378,["439"] = 379,["440"] = 380,["441"] = 381,["442"] = 382,["444"] = 385,["445"] = 386,["447"] = 376,["448"] = 390,["449"] = 391,["450"] = 391,["451"] = 391,["452"] = 391,["453"] = 391,["454"] = 392,["455"] = 392,["456"] = 392,["457"] = 393,["458"] = 394,["459"] = 397,["460"] = 398,["461"] = 399,["462"] = 401,["463"] = 402,["465"] = 392,["466"] = 392,["467"] = 390,["468"] = 408,["469"] = 409,["470"] = 408,["471"] = 412,["472"] = 413,["473"] = 412,["474"] = 416,["475"] = 417,["476"] = 418,["477"] = 418,["478"] = 418,["479"] = 418,["480"] = 418,["481"] = 418,["482"] = 419,["483"] = 416,["484"] = 422,["485"] = 423,["486"] = 424,["487"] = 424,["488"] = 424,["489"] = 424,["490"] = 424,["491"] = 424,["492"] = 425,["493"] = 422,["494"] = 428,["495"] = 428,["496"] = 432,["497"] = 433,["498"] = 434,["499"] = 435,["500"] = 437,["501"] = 438,["502"] = 438,["503"] = 438,["504"] = 439,["505"] = 440,["506"] = 441,["508"] = 446,["509"] = 438,["510"] = 438,["511"] = 449,["512"] = 450,["513"] = 450,["514"] = 450,["515"] = 450,["517"] = 456,["518"] = 457,["519"] = 457,["520"] = 457,["521"] = 458,["522"] = 458,["523"] = 458,["524"] = 458,["525"] = 460,["526"] = 461,["528"] = 457,["529"] = 457,["530"] = 465,["531"] = 469,["532"] = 471,["535"] = 475,["536"] = 476,["538"] = 479,["539"] = 480,["540"] = 481,["541"] = 432,["542"] = 485,["543"] = 486,["544"] = 487,["545"] = 488,["546"] = 490,["547"] = 491,["548"] = 485,["549"] = 500,["550"] = 501,["551"] = 502,["552"] = 503,["553"] = 504,["554"] = 506,["555"] = 509,["556"] = 500,["557"] = 512,["558"] = 513,["559"] = 513,["560"] = 513,["561"] = 516,["562"] = 516,["563"] = 516,["564"] = 516,["565"] = 516,["566"] = 516,["567"] = 516,["568"] = 512,["569"] = 519,["570"] = 520,["571"] = 520,["572"] = 520,["573"] = 520,["574"] = 520,["575"] = 520,["576"] = 522,["577"] = 523,["580"] = 527,["581"] = 527,["582"] = 527,["583"] = 527,["584"] = 532,["585"] = 533,["586"] = 533,["587"] = 533,["588"] = 533,["589"] = 533,["590"] = 533,["591"] = 533,["592"] = 519,["593"] = 536,["594"] = 537,["595"] = 539,["596"] = 540,["597"] = 541,["600"] = 545,["601"] = 545,["602"] = 545,["603"] = 545,["604"] = 550,["605"] = 551,["606"] = 551,["607"] = 551,["608"] = 551,["609"] = 551,["610"] = 551,["611"] = 551,["612"] = 536,["613"] = 554,["614"] = 555,["615"] = 557,["616"] = 558,["617"] = 559,["620"] = 563,["621"] = 563,["622"] = 563,["623"] = 563,["624"] = 568,["625"] = 569,["626"] = 569,["627"] = 569,["628"] = 569,["629"] = 569,["630"] = 569,["631"] = 569,["632"] = 554,["633"] = 572,["634"] = 573,["635"] = 575,["636"] = 576,["637"] = 577,["640"] = 581,["641"] = 581,["642"] = 581,["643"] = 581,["644"] = 586,["645"] = 587,["646"] = 587,["647"] = 587,["648"] = 587,["649"] = 587,["650"] = 587,["651"] = 587,["652"] = 572,["653"] = 590,["654"] = 591,["655"] = 591,["656"] = 591,["657"] = 591,["658"] = 593,["659"] = 594,["660"] = 595,["663"] = 599,["664"] = 599,["665"] = 599,["666"] = 599,["667"] = 604,["668"] = 605,["669"] = 605,["670"] = 605,["671"] = 605,["672"] = 605,["673"] = 605,["674"] = 605,["675"] = 590});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
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
function CustomPlayerHeroNPC.prototype.ApplyFavor(self, upgrade)
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
    end
    if upgrade and upgrade.effect then
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
        self:ApplyFavor(nil)
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
        self:ApplyFavor(nil)
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
        self:ApplyFavor(nil)
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
        self:ApplyFavor(nil)
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
