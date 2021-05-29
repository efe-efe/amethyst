--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 8,["19"] = 10,["20"] = 10,["21"] = 10,["22"] = 10,["23"] = 10,["24"] = 10,["25"] = 10,["26"] = 10,["27"] = 10,["28"] = 17,["29"] = 17,["30"] = 17,["31"] = 17,["32"] = 17,["33"] = 17,["34"] = 17,["35"] = 17,["36"] = 17,["37"] = 17,["38"] = 17,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 30,["45"] = 31,["46"] = 31,["47"] = 31,["48"] = 31,["49"] = 29,["50"] = 33,["51"] = 34,["52"] = 30,["53"] = 36,["55"] = 37,["56"] = 37,["57"] = 38,["58"] = 39,["59"] = 40,["60"] = 41,["63"] = 37,["66"] = 36,["67"] = 46,["68"] = 47,["69"] = 48,["70"] = 49,["71"] = 49,["72"] = 49,["73"] = 50,["74"] = 50,["75"] = 50,["76"] = 51,["77"] = 52,["78"] = 54,["79"] = 55,["80"] = 55,["81"] = 55,["82"] = 55,["83"] = 55,["84"] = 55,["85"] = 55,["86"] = 56,["87"] = 56,["88"] = 56,["89"] = 56,["90"] = 56,["91"] = 56,["92"] = 56,["93"] = 56,["94"] = 56,["95"] = 57,["96"] = 57,["97"] = 57,["98"] = 57,["99"] = 57,["100"] = 57,["101"] = 57,["102"] = 57,["104"] = 60,["105"] = 61,["106"] = 62,["108"] = 65,["109"] = 67,["110"] = 68,["112"] = 70,["113"] = 71,["115"] = 74,["116"] = 75,["117"] = 75,["118"] = 75,["119"] = 75,["120"] = 75,["121"] = 75,["122"] = 75,["123"] = 75,["124"] = 75,["125"] = 75,["126"] = 75,["128"] = 87,["129"] = 87,["130"] = 88,["131"] = 89,["132"] = 90,["133"] = 91,["136"] = 87,["140"] = 97,["141"] = 98,["142"] = 99,["145"] = 103,["146"] = 104,["147"] = 46,["148"] = 106,["149"] = 107,["150"] = 108,["151"] = 109,["152"] = 111,["153"] = 112,["154"] = 113,["156"] = 115,["157"] = 116,["159"] = 118,["160"] = 119,["161"] = 120,["163"] = 122,["164"] = 123,["165"] = 124,["166"] = 125,["168"] = 127,["169"] = 128,["170"] = 129,["171"] = 130,["173"] = 132,["174"] = 133,["176"] = 135,["177"] = 136,["178"] = 137,["180"] = 139,["181"] = 140,["182"] = 141,["184"] = 143,["185"] = 144,["186"] = 145,["188"] = 147,["189"] = 148,["190"] = 149,["193"] = 152,["194"] = 153,["195"] = 154,["196"] = 155,["198"] = 157,["199"] = 158,["200"] = 159,["201"] = 160,["203"] = 162,["204"] = 163,["205"] = 164,["208"] = 167,["209"] = 168,["210"] = 169,["211"] = 170,["213"] = 172,["214"] = 173,["215"] = 174,["218"] = 177,["219"] = 178,["220"] = 179,["221"] = 180,["223"] = 182,["224"] = 183,["225"] = 184,["227"] = 186,["228"] = 187,["229"] = 188,["232"] = 191,["233"] = 192,["234"] = 193,["235"] = 194,["237"] = 196,["238"] = 197,["240"] = 199,["241"] = 200,["243"] = 202,["244"] = 203,["245"] = 204,["248"] = 207,["249"] = 208,["250"] = 209,["252"] = 211,["253"] = 212,["254"] = 213,["256"] = 215,["257"] = 216,["258"] = 217,["260"] = 219,["261"] = 220,["264"] = 224,["265"] = 106,["266"] = 226,["267"] = 227,["268"] = 228,["269"] = 230,["270"] = 231,["271"] = 232,["273"] = 234,["274"] = 235,["275"] = 236,["277"] = 238,["278"] = 239,["279"] = 240,["281"] = 242,["282"] = 243,["283"] = 244,["285"] = 246,["286"] = 247,["287"] = 248,["288"] = 249,["290"] = 252,["291"] = 253,["292"] = 254,["295"] = 257,["296"] = 258,["297"] = 259,["299"] = 261,["300"] = 262,["303"] = 265,["304"] = 226,["305"] = 267,["306"] = 268,["307"] = 269,["308"] = 271,["309"] = 272,["310"] = 273,["312"] = 276,["313"] = 277,["314"] = 278,["315"] = 279,["316"] = 281,["317"] = 282,["319"] = 284,["322"] = 287,["323"] = 287,["324"] = 288,["325"] = 289,["326"] = 290,["329"] = 287,["333"] = 296,["334"] = 300,["337"] = 303,["338"] = 304,["339"] = 305,["342"] = 308,["344"] = 311,["345"] = 312,["346"] = 313,["347"] = 313,["348"] = 313,["349"] = 315,["350"] = 316,["351"] = 317,["352"] = 317,["353"] = 317,["354"] = 317,["355"] = 317,["356"] = 317,["357"] = 317,["358"] = 317,["359"] = 317,["360"] = 318,["361"] = 318,["362"] = 318,["363"] = 318,["364"] = 318,["365"] = 318,["366"] = 318,["370"] = 267,["371"] = 323,["372"] = 29,["373"] = 325,["374"] = 323,["375"] = 29,["376"] = 29,["377"] = 328,["378"] = 328,["379"] = 328,["380"] = 328,["381"] = 329,["382"] = 328,["383"] = 331,["384"] = 332,["385"] = 329,["386"] = 335,["387"] = 335,["388"] = 335,["389"] = 335,["390"] = 336,["391"] = 335,["392"] = 338,["393"] = 336,["394"] = 341,["395"] = 341,["396"] = 341,["397"] = 341,["398"] = 346,["399"] = 341,["400"] = 342,["401"] = 344,["402"] = 348,["403"] = 349,["404"] = 350,["405"] = 351,["406"] = 352,["407"] = 353,["409"] = 355,["410"] = 356,["412"] = 346,["413"] = 360,["414"] = 341,["415"] = 362,["416"] = 363,["417"] = 364,["418"] = 365,["419"] = 366,["421"] = 369,["422"] = 370,["424"] = 360,["425"] = 374,["426"] = 375,["427"] = 375,["428"] = 375,["429"] = 375,["430"] = 375,["431"] = 376,["432"] = 376,["433"] = 376,["434"] = 377,["435"] = 378,["436"] = 381,["437"] = 382,["438"] = 383,["439"] = 385,["440"] = 386,["442"] = 376,["443"] = 376,["444"] = 374,["445"] = 392,["446"] = 393,["447"] = 392,["448"] = 396,["449"] = 397,["450"] = 396,["451"] = 400,["452"] = 401,["453"] = 402,["454"] = 402,["455"] = 402,["456"] = 402,["457"] = 402,["458"] = 402,["459"] = 403,["460"] = 400,["461"] = 406,["462"] = 407,["463"] = 408,["464"] = 408,["465"] = 408,["466"] = 408,["467"] = 408,["468"] = 408,["469"] = 409,["470"] = 406,["471"] = 412,["472"] = 413,["473"] = 414,["474"] = 415,["475"] = 416,["476"] = 416,["477"] = 416,["478"] = 417,["479"] = 418,["480"] = 419,["482"] = 424,["483"] = 416,["484"] = 416,["485"] = 427,["486"] = 428,["489"] = 435,["490"] = 436,["492"] = 439,["493"] = 440,["494"] = 441,["495"] = 412,["496"] = 445,["497"] = 446,["498"] = 447,["499"] = 448,["500"] = 445,["501"] = 451,["502"] = 452,["503"] = 453,["504"] = 454,["505"] = 455,["506"] = 457,["507"] = 460,["508"] = 451,["509"] = 463,["510"] = 464,["511"] = 464,["512"] = 464,["513"] = 467,["514"] = 467,["515"] = 467,["516"] = 467,["517"] = 467,["518"] = 467,["519"] = 467,["520"] = 463,["521"] = 470,["522"] = 471,["523"] = 471,["524"] = 471,["525"] = 471,["526"] = 476,["527"] = 477,["528"] = 477,["529"] = 477,["530"] = 477,["531"] = 477,["532"] = 477,["533"] = 477,["534"] = 470,["535"] = 480,["536"] = 481,["537"] = 481,["538"] = 481,["539"] = 481,["540"] = 486,["541"] = 487,["542"] = 487,["543"] = 487,["544"] = 487,["545"] = 487,["546"] = 487,["547"] = 487,["548"] = 480,["549"] = 490,["550"] = 491,["551"] = 491,["552"] = 491,["553"] = 491,["554"] = 496,["555"] = 497,["556"] = 497,["557"] = 497,["558"] = 497,["559"] = 497,["560"] = 497,["561"] = 497,["562"] = 490,["563"] = 500,["564"] = 501,["565"] = 501,["566"] = 501,["567"] = 501,["568"] = 505,["569"] = 505,["570"] = 505,["571"] = 505,["572"] = 500,["573"] = 508,["574"] = 509,["575"] = 509,["576"] = 509,["577"] = 509,["578"] = 518,["579"] = 518,["580"] = 518,["581"] = 518,["582"] = 508,["583"] = 521,["584"] = 522,["585"] = 523,["586"] = 524,["589"] = 527,["590"] = 521,["591"] = 530,["592"] = 531,["593"] = 532,["595"] = 534,["596"] = 530,["597"] = 537,["598"] = 538,["599"] = 539,["601"] = 542,["602"] = 543,["603"] = 544,["605"] = 547,["606"] = 537,["607"] = 550,["608"] = 551,["609"] = 552,["611"] = 554,["612"] = 555,["614"] = 558,["615"] = 550,["616"] = 561,["617"] = 562,["618"] = 562,["619"] = 562,["620"] = 562,["621"] = 564,["622"] = 565,["624"] = 568,["625"] = 561,["626"] = 571,["627"] = 572,["628"] = 573,["630"] = 575,["631"] = 576,["633"] = 578,["634"] = 571,["635"] = 581,["636"] = 582,["637"] = 582,["638"] = 582,["639"] = 582,["640"] = 584,["641"] = 585,["643"] = 588,["644"] = 589,["646"] = 592,["647"] = 581});
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
