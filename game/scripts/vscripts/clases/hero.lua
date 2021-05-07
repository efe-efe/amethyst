--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 5,["9"] = 6,["10"] = 7,["11"] = 8,["12"] = 10,["13"] = 10,["14"] = 10,["15"] = 10,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 10,["20"] = 10,["21"] = 17,["22"] = 17,["23"] = 17,["24"] = 17,["25"] = 17,["26"] = 17,["27"] = 17,["28"] = 17,["29"] = 17,["30"] = 17,["31"] = 17,["32"] = 25,["33"] = 26,["34"] = 27,["35"] = 28,["38"] = 30,["40"] = 30,["41"] = 31,["42"] = 30,["43"] = 31,["44"] = 35,["45"] = 36,["46"] = 37,["47"] = 38,["48"] = 38,["49"] = 38,["50"] = 39,["51"] = 39,["52"] = 39,["53"] = 40,["54"] = 41,["55"] = 43,["56"] = 44,["57"] = 44,["58"] = 44,["59"] = 44,["60"] = 44,["61"] = 44,["62"] = 44,["63"] = 45,["64"] = 45,["65"] = 45,["66"] = 45,["67"] = 45,["68"] = 45,["69"] = 45,["70"] = 45,["71"] = 45,["72"] = 46,["73"] = 46,["74"] = 46,["75"] = 46,["76"] = 46,["77"] = 46,["78"] = 46,["79"] = 46,["81"] = 49,["82"] = 50,["83"] = 51,["85"] = 54,["86"] = 56,["87"] = 57,["89"] = 59,["90"] = 60,["92"] = 63,["93"] = 64,["94"] = 65,["95"] = 66,["97"] = 68,["102"] = 73,["104"] = 76,["105"] = 76,["106"] = 76,["107"] = 77,["108"] = 78,["109"] = 79,["112"] = 76,["113"] = 76,["115"] = 85,["116"] = 86,["117"] = 87,["120"] = 91,["121"] = 92,["123"] = 95,["124"] = 96,["125"] = 95,["126"] = 99,["127"] = 100,["128"] = 99,["129"] = 103,["130"] = 104,["131"] = 103,["132"] = 107,["133"] = 108,["134"] = 107,["135"] = 111,["136"] = 112,["137"] = 111,["138"] = 115,["139"] = 116,["140"] = 115,["141"] = 119,["142"] = 120,["143"] = 119,["144"] = 123,["145"] = 124,["146"] = 123,["147"] = 127,["148"] = 128,["149"] = 129,["150"] = 130,["151"] = 132,["152"] = 133,["153"] = 134,["155"] = 136,["156"] = 137,["158"] = 139,["159"] = 140,["160"] = 141,["162"] = 143,["163"] = 144,["164"] = 145,["165"] = 146,["167"] = 148,["168"] = 149,["169"] = 150,["170"] = 151,["172"] = 153,["173"] = 154,["175"] = 156,["176"] = 157,["177"] = 158,["179"] = 160,["180"] = 161,["181"] = 162,["183"] = 164,["184"] = 165,["185"] = 166,["187"] = 168,["188"] = 169,["189"] = 170,["192"] = 173,["193"] = 174,["194"] = 175,["195"] = 176,["197"] = 178,["198"] = 179,["199"] = 180,["200"] = 181,["202"] = 183,["203"] = 184,["204"] = 185,["207"] = 188,["208"] = 189,["209"] = 190,["210"] = 191,["212"] = 193,["213"] = 194,["214"] = 195,["217"] = 198,["218"] = 199,["219"] = 200,["220"] = 201,["222"] = 203,["223"] = 204,["224"] = 205,["226"] = 207,["227"] = 208,["228"] = 209,["231"] = 212,["232"] = 213,["233"] = 214,["234"] = 215,["236"] = 217,["237"] = 218,["239"] = 220,["240"] = 221,["242"] = 223,["243"] = 224,["244"] = 225,["247"] = 228,["248"] = 229,["249"] = 230,["251"] = 232,["252"] = 233,["253"] = 234,["255"] = 236,["256"] = 237,["257"] = 238,["259"] = 240,["260"] = 241,["263"] = 245,["264"] = 127,["265"] = 248,["266"] = 249,["267"] = 250,["268"] = 252,["269"] = 253,["270"] = 254,["272"] = 256,["273"] = 257,["274"] = 258,["276"] = 260,["277"] = 261,["278"] = 262,["280"] = 264,["281"] = 265,["282"] = 266,["284"] = 268,["285"] = 269,["286"] = 270,["287"] = 271,["289"] = 274,["290"] = 275,["291"] = 276,["294"] = 279,["295"] = 280,["296"] = 281,["298"] = 283,["299"] = 284,["302"] = 287,["303"] = 248,["304"] = 290,["305"] = 291,["306"] = 292,["307"] = 295,["308"] = 296,["310"] = 299,["311"] = 300,["312"] = 301,["313"] = 302,["314"] = 304,["315"] = 305,["317"] = 307,["320"] = 310,["321"] = 310,["322"] = 311,["323"] = 312,["324"] = 313,["327"] = 310,["331"] = 319,["332"] = 323,["335"] = 326,["337"] = 329,["338"] = 330,["340"] = 333,["341"] = 334,["342"] = 334,["343"] = 334,["344"] = 336,["345"] = 337,["346"] = 338,["347"] = 338,["348"] = 338,["349"] = 338,["350"] = 338,["351"] = 338,["352"] = 338,["353"] = 338,["354"] = 338,["355"] = 339,["356"] = 339,["357"] = 339,["358"] = 339,["359"] = 339,["360"] = 339,["361"] = 339,["364"] = 290,["365"] = 344,["366"] = 345,["367"] = 345,["368"] = 345,["369"] = 345,["370"] = 345,["371"] = 346,["372"] = 346,["373"] = 346,["374"] = 347,["375"] = 348,["376"] = 351,["377"] = 352,["378"] = 353,["379"] = 355,["380"] = 356,["382"] = 346,["383"] = 346,["384"] = 344,["385"] = 30});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local DEBUG = false
local EAST = Vector(1, 0, 0)
local WEST = Vector(-1, 0, 0)
local NORTH = Vector(0, 1, 0)
local SOUTH = Vector(0, -1, 0)
local CollisionTypes = {}
CollisionTypes.SUCCESS = 0
CollisionTypes[CollisionTypes.SUCCESS] = "SUCCESS"
CollisionTypes.UNIT = 1
CollisionTypes[CollisionTypes.UNIT] = "UNIT"
CollisionTypes.WALL = 2
CollisionTypes[CollisionTypes.WALL] = "WALL"
CollisionTypes.TREE = 3
CollisionTypes[CollisionTypes.TREE] = "TREE"
local Orientations = {}
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
local NORTH_EAST = Vector(1, 1, 0):Normalized()
local NORTH_WEST = Vector(-1, 1, 0):Normalized()
local SOUTH_EAST = Vector(1, -1, 0):Normalized()
local SOUTH_WEST = Vector(-1, -1, 0):Normalized()
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Hero = ____exports.default
    Hero.name = "Hero"
    __TS__ClassExtends(Hero, UnitEntity)
    function Hero.prototype.____constructor(self, unit)
        UnitEntity.prototype.____constructor(self, {unit = unit})
    end
    function Hero.prototype.Move(self, direction, speed)
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
            __TS__ArrayForEach(
                units,
                function(____, unit)
                    if unit ~= self.unit then
                        if not unit:IsPhased() then
                            return CollisionTypes.UNIT
                        end
                    end
                end
            )
        end
        if not CustomEntitiesLegacy:IsAnimating(self.unit) then
            if not self.unit:HasModifier("modifier_hero_movement") then
                self.unit:AddNewModifier(self.unit, nil, "modifier_hero_movement", {})
            end
        end
        self.unit:SetAbsOrigin(futureOrigin)
        return CollisionTypes.SUCCESS
    end
    function Hero.prototype.IsEast(self, angle)
        return (angle > 345) or (angle <= 15)
    end
    function Hero.prototype.IsNorthEast(self, angle)
        return (angle > 15) and (angle <= 75)
    end
    function Hero.prototype.IsNorth(self, angle)
        return (angle > 75) and (angle <= 105)
    end
    function Hero.prototype.IsNorthWest(self, angle)
        return (angle > 105) and (angle <= 165)
    end
    function Hero.prototype.IsWest(self, angle)
        return (angle > 165) and (angle <= 195)
    end
    function Hero.prototype.IsSouthWest(self, angle)
        return (angle > 195) and (angle <= 255)
    end
    function Hero.prototype.IsSouth(self, angle)
        return (angle > 255) and (angle <= 285)
    end
    function Hero.prototype.IsSouthEast(self, angle)
        return (angle > 285) and (angle <= 345)
    end
    function Hero.prototype.AlternativeDirectionsWalls(self, direction)
        local directions = {}
        local collisionDirection = CustomEntitiesLegacy:GetCollisionDirection(self.unit)
        local angle = VectorToAngles(direction).y
        if self:IsNorthEast(angle) then
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                return directions
            end
            __TS__ArrayPush(directions, NORTH)
            __TS__ArrayPush(directions, EAST)
        end
        if self:IsNorthWest(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, NORTH)
                __TS__ArrayPush(directions, WEST)
                return directions
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, NORTH)
                __TS__ArrayPush(directions, WEST)
                return directions
            end
            __TS__ArrayPush(directions, NORTH)
            __TS__ArrayPush(directions, WEST)
        end
        if self:IsSouthEast(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, SOUTH)
                __TS__ArrayPush(directions, EAST)
            end
            if collisionDirection == Orientations.HORIZONTAL then
                __TS__ArrayPush(directions, EAST)
                __TS__ArrayPush(directions, SOUTH)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, SOUTH)
                __TS__ArrayPush(directions, EAST)
            end
        end
        if self:IsSouthWest(angle) then
            if collisionDirection == Orientations.HORIZONTAL then
                __TS__ArrayPush(directions, WEST)
                __TS__ArrayPush(directions, SOUTH)
            end
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, SOUTH_WEST)
                __TS__ArrayPush(directions, WEST)
                __TS__ArrayPush(directions, SOUTH)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, SOUTH)
                __TS__ArrayPush(directions, WEST)
            end
        end
        if self:IsEast(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, NORTH_EAST)
                __TS__ArrayPush(directions, NORTH)
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, SOUTH_EAST)
                __TS__ArrayPush(directions, SOUTH)
            end
        end
        if self:IsWest(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, SOUTH_EAST)
                __TS__ArrayPush(directions, SOUTH)
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, NORTH_WEST)
                __TS__ArrayPush(directions, NORTH)
            end
            if collisionDirection == Orientations.HORIZONTAL then
                __TS__ArrayPush(directions, SOUTH)
                __TS__ArrayPush(directions, NORTH)
            end
        end
        if self:IsNorth(angle) then
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, NORTH_EAST)
                __TS__ArrayPush(directions, EAST)
            end
            if collisionDirection == Orientations.HORIZONTAL then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, WEST)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, NORTH_WEST)
                __TS__ArrayPush(directions, WEST)
            end
        end
        if self:IsSouth(angle) then
            if collisionDirection == Orientations.HORIZONTAL then
                return directions
            end
            if collisionDirection == Orientations.DIAGONAL_RIGHT then
                __TS__ArrayPush(directions, SOUTH_WEST)
                __TS__ArrayPush(directions, WEST)
            end
            if collisionDirection == Orientations.DIAGONAL_LEFT then
                __TS__ArrayPush(directions, SOUTH_EAST)
                __TS__ArrayPush(directions, EAST)
            end
            if collisionDirection == Orientations.VERTICAL then
                __TS__ArrayPush(directions, EAST)
            end
        end
        return directions
    end
    function Hero.prototype.AlternativeDirections(self, direction)
        local directions = {}
        local angle = VectorToAngles(direction).y
        if self:IsNorthEast(angle) then
            __TS__ArrayPush(directions, NORTH)
            __TS__ArrayPush(directions, EAST)
        end
        if self:IsNorthWest(angle) then
            __TS__ArrayPush(directions, NORTH)
            __TS__ArrayPush(directions, WEST)
        end
        if self:IsSouthEast(angle) then
            __TS__ArrayPush(directions, SOUTH)
            __TS__ArrayPush(directions, EAST)
        end
        if self:IsSouthWest(angle) then
            __TS__ArrayPush(directions, SOUTH)
            __TS__ArrayPush(directions, WEST)
        end
        if self:IsEast(angle) or self:IsWest(angle) then
            if self.unit:GetAbsOrigin().y < 0 then
                __TS__ArrayPush(directions, SOUTH)
                __TS__ArrayPush(directions, NORTH)
            end
            if self.unit:GetAbsOrigin().y > 0 then
                __TS__ArrayPush(directions, NORTH)
                __TS__ArrayPush(directions, SOUTH)
            end
        end
        if self:IsNorth(angle) or self:IsSouth(angle) then
            if self.unit:GetAbsOrigin().x < 0 then
                __TS__ArrayPush(directions, WEST)
            end
            if self.unit:GetAbsOrigin().x > 0 then
                __TS__ArrayPush(directions, EAST)
            end
        end
        return directions
    end
    function Hero.prototype.Update(self)
        local direction = CustomEntitiesLegacy:GetDirection(self.unit):Normalized()
        local speed = self.unit:GetIdealSpeed() / 25
        if CustomEntitiesLegacy:IsAnimating(self.unit) then
            self.unit:RemoveModifierByName("modifier_hero_movement")
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
            self.unit:RemoveModifierByName("modifier_hero_movement")
        end
        if self.unit:IsAlive() then
            self:PickupItems()
        end
        if IsInToolsMode() and DEBUG then
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
    function Hero.prototype.PickupItems(self)
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
    return Hero
end)()
return ____exports
