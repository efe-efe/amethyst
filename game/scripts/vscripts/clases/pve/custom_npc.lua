--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 5,["12"] = 5,["13"] = 6,["14"] = 6,["15"] = 7,["16"] = 7,["17"] = 9,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 30,["39"] = 30,["40"] = 30,["41"] = 30,["42"] = 30,["43"] = 31,["44"] = 32,["45"] = 32,["46"] = 32,["47"] = 32,["48"] = 30,["49"] = 34,["50"] = 35,["51"] = 31,["52"] = 37,["54"] = 38,["55"] = 38,["56"] = 39,["57"] = 40,["58"] = 41,["59"] = 42,["62"] = 38,["65"] = 37,["66"] = 47,["67"] = 48,["68"] = 49,["69"] = 50,["70"] = 50,["71"] = 50,["72"] = 51,["73"] = 51,["74"] = 51,["75"] = 52,["76"] = 53,["77"] = 55,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 56,["85"] = 57,["86"] = 57,["87"] = 57,["88"] = 57,["89"] = 57,["90"] = 57,["91"] = 57,["92"] = 57,["93"] = 57,["94"] = 58,["95"] = 58,["96"] = 58,["97"] = 58,["98"] = 58,["99"] = 58,["100"] = 58,["101"] = 58,["103"] = 61,["104"] = 62,["105"] = 63,["107"] = 66,["108"] = 68,["109"] = 69,["111"] = 71,["112"] = 72,["114"] = 75,["115"] = 76,["116"] = 76,["117"] = 76,["118"] = 76,["119"] = 76,["120"] = 76,["121"] = 76,["122"] = 76,["123"] = 76,["124"] = 76,["125"] = 76,["127"] = 88,["128"] = 88,["129"] = 89,["130"] = 90,["131"] = 91,["132"] = 92,["135"] = 88,["139"] = 98,["140"] = 99,["141"] = 100,["144"] = 104,["145"] = 105,["146"] = 47,["147"] = 107,["148"] = 108,["149"] = 109,["150"] = 110,["151"] = 112,["152"] = 113,["153"] = 114,["155"] = 116,["156"] = 117,["158"] = 119,["159"] = 120,["160"] = 121,["162"] = 123,["163"] = 124,["164"] = 125,["165"] = 126,["167"] = 128,["168"] = 129,["169"] = 130,["170"] = 131,["172"] = 133,["173"] = 134,["175"] = 136,["176"] = 137,["177"] = 138,["179"] = 140,["180"] = 141,["181"] = 142,["183"] = 144,["184"] = 145,["185"] = 146,["187"] = 148,["188"] = 149,["189"] = 150,["192"] = 153,["193"] = 154,["194"] = 155,["195"] = 156,["197"] = 158,["198"] = 159,["199"] = 160,["200"] = 161,["202"] = 163,["203"] = 164,["204"] = 165,["207"] = 168,["208"] = 169,["209"] = 170,["210"] = 171,["212"] = 173,["213"] = 174,["214"] = 175,["217"] = 178,["218"] = 179,["219"] = 180,["220"] = 181,["222"] = 183,["223"] = 184,["224"] = 185,["226"] = 187,["227"] = 188,["228"] = 189,["231"] = 192,["232"] = 193,["233"] = 194,["234"] = 195,["236"] = 197,["237"] = 198,["239"] = 200,["240"] = 201,["242"] = 203,["243"] = 204,["244"] = 205,["247"] = 208,["248"] = 209,["249"] = 210,["251"] = 212,["252"] = 213,["253"] = 214,["255"] = 216,["256"] = 217,["257"] = 218,["259"] = 220,["260"] = 221,["263"] = 225,["264"] = 107,["265"] = 227,["266"] = 228,["267"] = 229,["268"] = 231,["269"] = 232,["270"] = 233,["272"] = 235,["273"] = 236,["274"] = 237,["276"] = 239,["277"] = 240,["278"] = 241,["280"] = 243,["281"] = 244,["282"] = 245,["284"] = 247,["285"] = 248,["286"] = 249,["287"] = 250,["289"] = 253,["290"] = 254,["291"] = 255,["294"] = 258,["295"] = 259,["296"] = 260,["298"] = 262,["299"] = 263,["302"] = 266,["303"] = 227,["304"] = 268,["305"] = 269,["306"] = 270,["307"] = 272,["308"] = 273,["309"] = 274,["311"] = 277,["312"] = 278,["313"] = 279,["314"] = 280,["315"] = 282,["316"] = 283,["318"] = 285,["321"] = 288,["322"] = 288,["323"] = 289,["324"] = 290,["325"] = 291,["328"] = 288,["332"] = 297,["333"] = 301,["336"] = 304,["337"] = 305,["338"] = 306,["341"] = 309,["343"] = 312,["344"] = 313,["345"] = 314,["346"] = 314,["347"] = 314,["348"] = 316,["349"] = 317,["350"] = 318,["351"] = 318,["352"] = 318,["353"] = 318,["354"] = 318,["355"] = 318,["356"] = 318,["357"] = 318,["358"] = 318,["359"] = 319,["360"] = 319,["361"] = 319,["362"] = 319,["363"] = 319,["364"] = 319,["365"] = 319,["369"] = 268,["370"] = 324,["371"] = 30,["372"] = 326,["373"] = 324,["374"] = 30,["375"] = 30,["376"] = 329,["377"] = 329,["378"] = 329,["379"] = 329,["380"] = 330,["381"] = 329,["382"] = 332,["383"] = 333,["384"] = 330,["385"] = 336,["386"] = 336,["387"] = 336,["388"] = 336,["389"] = 337,["390"] = 336,["391"] = 339,["392"] = 337,["393"] = 342,["394"] = 342,["395"] = 342,["396"] = 342,["397"] = 347,["398"] = 342,["399"] = 343,["400"] = 345,["401"] = 349,["402"] = 350,["403"] = 351,["404"] = 352,["405"] = 353,["406"] = 354,["407"] = 355,["408"] = 355,["409"] = 355,["410"] = 356,["411"] = 356,["412"] = 356,["413"] = 358,["414"] = 358,["415"] = 358,["416"] = 358,["417"] = 358,["419"] = 360,["420"] = 361,["422"] = 347,["423"] = 365,["424"] = 366,["425"] = 367,["426"] = 368,["427"] = 369,["428"] = 370,["429"] = 371,["430"] = 371,["431"] = 371,["435"] = 365,["436"] = 377,["437"] = 342,["438"] = 379,["439"] = 380,["440"] = 381,["441"] = 382,["442"] = 383,["444"] = 386,["445"] = 387,["447"] = 377,["448"] = 391,["449"] = 392,["450"] = 392,["451"] = 392,["452"] = 392,["453"] = 392,["454"] = 393,["455"] = 393,["456"] = 393,["457"] = 394,["458"] = 395,["459"] = 398,["460"] = 399,["461"] = 400,["462"] = 402,["463"] = 403,["465"] = 393,["466"] = 393,["467"] = 391,["468"] = 409,["469"] = 410,["470"] = 409,["471"] = 413,["472"] = 414,["473"] = 413,["474"] = 417,["475"] = 418,["476"] = 419,["477"] = 419,["478"] = 419,["479"] = 419,["480"] = 419,["481"] = 419,["482"] = 420,["483"] = 417,["484"] = 423,["485"] = 424,["486"] = 425,["487"] = 425,["488"] = 425,["489"] = 425,["490"] = 425,["491"] = 425,["492"] = 426,["493"] = 423,["494"] = 429,["495"] = 430,["496"] = 431,["497"] = 432,["498"] = 433,["499"] = 433,["500"] = 433,["501"] = 434,["502"] = 435,["503"] = 436,["505"] = 441,["506"] = 433,["507"] = 433,["508"] = 444,["509"] = 445,["512"] = 452,["513"] = 453,["515"] = 456,["516"] = 457,["517"] = 458,["518"] = 429,["519"] = 462,["520"] = 463,["521"] = 464,["522"] = 465,["523"] = 462,["524"] = 468,["525"] = 469,["526"] = 470,["527"] = 471,["528"] = 472,["529"] = 474,["530"] = 477,["531"] = 468,["532"] = 480,["533"] = 481,["534"] = 481,["535"] = 481,["536"] = 484,["537"] = 484,["538"] = 484,["539"] = 484,["540"] = 484,["541"] = 484,["542"] = 484,["543"] = 480,["544"] = 487,["545"] = 488,["546"] = 488,["547"] = 488,["548"] = 488,["549"] = 488,["550"] = 488,["551"] = 490,["552"] = 491,["555"] = 495,["556"] = 495,["557"] = 495,["558"] = 495,["559"] = 500,["560"] = 501,["561"] = 501,["562"] = 501,["563"] = 501,["564"] = 501,["565"] = 501,["566"] = 501,["567"] = 487,["568"] = 504,["569"] = 505,["570"] = 507,["571"] = 508,["572"] = 509,["575"] = 513,["576"] = 513,["577"] = 513,["578"] = 513,["579"] = 518,["580"] = 519,["581"] = 519,["582"] = 519,["583"] = 519,["584"] = 519,["585"] = 519,["586"] = 519,["587"] = 504,["588"] = 522,["589"] = 523,["590"] = 525,["591"] = 526,["592"] = 527,["595"] = 531,["596"] = 531,["597"] = 531,["598"] = 531,["599"] = 536,["600"] = 537,["601"] = 537,["602"] = 537,["603"] = 537,["604"] = 537,["605"] = 537,["606"] = 537,["607"] = 522,["608"] = 540,["609"] = 541,["610"] = 543,["611"] = 544,["612"] = 545,["615"] = 549,["616"] = 549,["617"] = 549,["618"] = 549,["619"] = 554,["620"] = 555,["621"] = 555,["622"] = 555,["623"] = 555,["624"] = 555,["625"] = 555,["626"] = 555,["627"] = 540,["628"] = 558,["629"] = 559,["630"] = 559,["631"] = 559,["632"] = 559,["633"] = 561,["634"] = 562,["635"] = 563,["638"] = 567,["639"] = 567,["640"] = 567,["641"] = 567,["642"] = 572,["643"] = 573,["644"] = 573,["645"] = 573,["646"] = 573,["647"] = 573,["648"] = 573,["649"] = 573,["650"] = 558});
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
function CustomPlayerHeroNPC.prototype.ApplyFavor(self, upgrade)
    if upgrade and upgrade.modifier then
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
