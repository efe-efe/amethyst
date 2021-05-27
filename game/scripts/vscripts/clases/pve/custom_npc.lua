--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 6,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 8,["20"] = 8,["21"] = 8,["22"] = 8,["23"] = 15,["24"] = 15,["25"] = 15,["26"] = 15,["27"] = 15,["28"] = 15,["29"] = 15,["30"] = 15,["31"] = 15,["32"] = 15,["33"] = 15,["34"] = 27,["35"] = 27,["36"] = 27,["37"] = 27,["38"] = 27,["39"] = 28,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 27,["45"] = 31,["46"] = 32,["47"] = 28,["48"] = 34,["50"] = 35,["51"] = 35,["52"] = 36,["53"] = 37,["54"] = 38,["55"] = 39,["58"] = 35,["61"] = 34,["62"] = 44,["63"] = 45,["64"] = 46,["65"] = 47,["66"] = 47,["67"] = 47,["68"] = 48,["69"] = 48,["70"] = 48,["71"] = 49,["72"] = 50,["73"] = 52,["74"] = 53,["75"] = 53,["76"] = 53,["77"] = 53,["78"] = 53,["79"] = 53,["80"] = 53,["81"] = 54,["82"] = 54,["83"] = 54,["84"] = 54,["85"] = 54,["86"] = 54,["87"] = 54,["88"] = 54,["89"] = 54,["90"] = 55,["91"] = 55,["92"] = 55,["93"] = 55,["94"] = 55,["95"] = 55,["96"] = 55,["97"] = 55,["99"] = 58,["100"] = 59,["101"] = 60,["103"] = 63,["104"] = 65,["105"] = 66,["107"] = 68,["108"] = 69,["110"] = 72,["111"] = 73,["112"] = 73,["113"] = 73,["114"] = 73,["115"] = 73,["116"] = 73,["117"] = 73,["118"] = 73,["119"] = 73,["120"] = 73,["121"] = 73,["123"] = 85,["124"] = 85,["125"] = 86,["126"] = 87,["127"] = 88,["128"] = 89,["131"] = 85,["135"] = 95,["136"] = 96,["137"] = 97,["140"] = 101,["141"] = 102,["142"] = 44,["143"] = 104,["144"] = 105,["145"] = 106,["146"] = 107,["147"] = 109,["148"] = 110,["149"] = 111,["151"] = 113,["152"] = 114,["154"] = 116,["155"] = 117,["156"] = 118,["158"] = 120,["159"] = 121,["160"] = 122,["161"] = 123,["163"] = 125,["164"] = 126,["165"] = 127,["166"] = 128,["168"] = 130,["169"] = 131,["171"] = 133,["172"] = 134,["173"] = 135,["175"] = 137,["176"] = 138,["177"] = 139,["179"] = 141,["180"] = 142,["181"] = 143,["183"] = 145,["184"] = 146,["185"] = 147,["188"] = 150,["189"] = 151,["190"] = 152,["191"] = 153,["193"] = 155,["194"] = 156,["195"] = 157,["196"] = 158,["198"] = 160,["199"] = 161,["200"] = 162,["203"] = 165,["204"] = 166,["205"] = 167,["206"] = 168,["208"] = 170,["209"] = 171,["210"] = 172,["213"] = 175,["214"] = 176,["215"] = 177,["216"] = 178,["218"] = 180,["219"] = 181,["220"] = 182,["222"] = 184,["223"] = 185,["224"] = 186,["227"] = 189,["228"] = 190,["229"] = 191,["230"] = 192,["232"] = 194,["233"] = 195,["235"] = 197,["236"] = 198,["238"] = 200,["239"] = 201,["240"] = 202,["243"] = 205,["244"] = 206,["245"] = 207,["247"] = 209,["248"] = 210,["249"] = 211,["251"] = 213,["252"] = 214,["253"] = 215,["255"] = 217,["256"] = 218,["259"] = 222,["260"] = 104,["261"] = 224,["262"] = 225,["263"] = 226,["264"] = 228,["265"] = 229,["266"] = 230,["268"] = 232,["269"] = 233,["270"] = 234,["272"] = 236,["273"] = 237,["274"] = 238,["276"] = 240,["277"] = 241,["278"] = 242,["280"] = 244,["281"] = 245,["282"] = 246,["283"] = 247,["285"] = 250,["286"] = 251,["287"] = 252,["290"] = 255,["291"] = 256,["292"] = 257,["294"] = 259,["295"] = 260,["298"] = 263,["299"] = 224,["300"] = 265,["301"] = 266,["302"] = 267,["303"] = 269,["304"] = 270,["305"] = 271,["307"] = 274,["308"] = 275,["309"] = 276,["310"] = 277,["311"] = 279,["312"] = 280,["314"] = 282,["317"] = 285,["318"] = 285,["319"] = 286,["320"] = 287,["321"] = 288,["324"] = 285,["328"] = 294,["329"] = 298,["332"] = 301,["333"] = 302,["334"] = 303,["337"] = 306,["339"] = 309,["340"] = 310,["341"] = 311,["342"] = 311,["343"] = 311,["344"] = 313,["345"] = 314,["346"] = 315,["347"] = 315,["348"] = 315,["349"] = 315,["350"] = 315,["351"] = 315,["352"] = 315,["353"] = 315,["354"] = 315,["355"] = 316,["356"] = 316,["357"] = 316,["358"] = 316,["359"] = 316,["360"] = 316,["361"] = 316,["365"] = 265,["366"] = 321,["367"] = 27,["368"] = 323,["369"] = 321,["370"] = 27,["371"] = 27,["372"] = 326,["373"] = 326,["374"] = 326,["375"] = 326,["376"] = 327,["377"] = 326,["378"] = 329,["379"] = 330,["380"] = 327,["381"] = 333,["382"] = 333,["383"] = 333,["384"] = 333,["385"] = 334,["386"] = 333,["387"] = 336,["388"] = 334,["389"] = 339,["390"] = 339,["391"] = 339,["392"] = 339,["393"] = 343,["394"] = 339,["395"] = 340,["396"] = 341,["397"] = 345,["398"] = 346,["399"] = 347,["400"] = 348,["401"] = 349,["403"] = 351,["404"] = 352,["406"] = 343,["407"] = 356,["408"] = 339,["409"] = 358,["410"] = 359,["411"] = 360,["412"] = 361,["413"] = 362,["415"] = 365,["416"] = 366,["418"] = 356,["419"] = 370,["420"] = 371,["421"] = 371,["422"] = 371,["423"] = 371,["424"] = 371,["425"] = 372,["426"] = 372,["427"] = 372,["428"] = 373,["429"] = 374,["430"] = 377,["431"] = 378,["432"] = 379,["433"] = 381,["434"] = 382,["436"] = 372,["437"] = 372,["438"] = 370,["439"] = 388,["440"] = 389,["441"] = 388,["442"] = 392,["443"] = 393,["444"] = 392,["445"] = 396,["446"] = 397,["447"] = 398,["448"] = 398,["449"] = 398,["450"] = 398,["451"] = 398,["452"] = 398,["453"] = 399,["454"] = 396,["455"] = 402,["456"] = 403,["457"] = 403,["458"] = 403,["459"] = 407,["460"] = 408,["461"] = 408,["462"] = 408,["463"] = 408,["464"] = 408,["465"] = 408,["466"] = 408,["467"] = 410,["468"] = 411,["470"] = 413,["471"] = 414,["474"] = 418,["475"] = 419,["476"] = 419,["477"] = 419,["478"] = 420,["479"] = 421,["480"] = 422,["482"] = 427,["483"] = 419,["484"] = 419,["485"] = 430,["486"] = 431,["488"] = 402,["489"] = 438,["490"] = 439,["491"] = 439,["492"] = 439,["493"] = 439,["494"] = 444,["495"] = 445,["496"] = 445,["497"] = 445,["498"] = 445,["499"] = 445,["500"] = 445,["501"] = 445,["502"] = 438,["503"] = 448,["504"] = 449,["505"] = 449,["506"] = 449,["507"] = 449,["508"] = 457,["509"] = 457,["510"] = 457,["511"] = 457,["512"] = 448,["513"] = 460,["514"] = 461,["515"] = 462,["517"] = 464,["518"] = 460,["519"] = 467,["520"] = 468,["521"] = 469,["523"] = 472,["524"] = 473,["525"] = 474,["527"] = 477,["528"] = 467,["529"] = 480,["530"] = 481,["531"] = 482,["533"] = 484,["534"] = 485,["536"] = 488,["537"] = 480,["538"] = 491,["539"] = 492,["540"] = 493,["542"] = 495,["543"] = 496,["545"] = 498,["546"] = 491,["547"] = 501,["548"] = 502,["549"] = 502,["550"] = 502,["551"] = 502,["552"] = 504,["553"] = 505,["555"] = 508,["556"] = 509,["558"] = 512,["559"] = 501});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
local ____upgrades = require("upgrades.upgrades")
local Upgrades = ____upgrades.default
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
function CustomPlayerHeroNPC.prototype.ApplyUpgrade(self, upgrade)
    local data = {
        playerId = self.unit:GetPlayerOwnerID()
    }
    local tableName = "custom_npc_upgrades"
    CustomNetTables:SetTableValue(
        tableName,
        tostring(
            self.unit:GetPlayerOwnerID()
        ),
        data
    )
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
function CustomPlayerHeroNPC.prototype.GenerateUpgrades(self, amount)
    local upgrades = __TS__ArrayFilter(
        Upgrades,
        function(____, upgrade) return (((self:ValdateUpgradeHero(upgrade) and self:ValdateUpgradeAbility(upgrade)) and self:ValdateUpgradeAttackCapabilities(upgrade)) and self:ValidateUpgradeStacks(upgrade)) and self:ValidateUpgradeLevel(upgrade) end
    )
    return Math:GetRandomElementsFromArray(
        upgrades,
        Clamp(amount, #upgrades, 0)
    )
end
function CustomPlayerHeroNPC.prototype.ValdateUpgradeHero(self, upgrade)
    if not upgrade.hero then
        return true
    end
    return upgrade.hero == self.unit:GetName()
end
function CustomPlayerHeroNPC.prototype.ValdateUpgradeAbility(self, upgrade)
    if not upgrade.ability then
        return true
    end
    local ability = self.unit:FindAbilityByName(upgrade.ability)
    if (not ability) or (ability:GetLevel() == 0) then
        return false
    end
    return true
end
function CustomPlayerHeroNPC.prototype.ValdateUpgradeAttackCapabilities(self, upgrade)
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
