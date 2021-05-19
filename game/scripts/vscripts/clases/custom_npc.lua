--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 5,["12"] = 7,["13"] = 7,["14"] = 7,["15"] = 7,["16"] = 7,["17"] = 7,["18"] = 7,["19"] = 7,["20"] = 7,["21"] = 14,["22"] = 14,["23"] = 14,["24"] = 14,["25"] = 14,["26"] = 14,["27"] = 14,["28"] = 14,["29"] = 14,["30"] = 14,["31"] = 14,["32"] = 21,["33"] = 21,["34"] = 21,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 23,["39"] = 23,["40"] = 23,["41"] = 23,["42"] = 21,["43"] = 25,["44"] = 26,["45"] = 27,["47"] = 29,["48"] = 22,["49"] = 31,["51"] = 32,["52"] = 32,["53"] = 33,["54"] = 34,["55"] = 35,["56"] = 36,["59"] = 32,["62"] = 31,["63"] = 41,["64"] = 42,["65"] = 43,["66"] = 44,["67"] = 44,["68"] = 44,["69"] = 45,["70"] = 45,["71"] = 45,["72"] = 46,["73"] = 47,["74"] = 49,["75"] = 50,["76"] = 50,["77"] = 50,["78"] = 50,["79"] = 50,["80"] = 50,["81"] = 50,["82"] = 51,["83"] = 51,["84"] = 51,["85"] = 51,["86"] = 51,["87"] = 51,["88"] = 51,["89"] = 51,["90"] = 51,["91"] = 52,["92"] = 52,["93"] = 52,["94"] = 52,["95"] = 52,["96"] = 52,["97"] = 52,["98"] = 52,["100"] = 55,["101"] = 56,["102"] = 57,["104"] = 60,["105"] = 62,["106"] = 63,["108"] = 65,["109"] = 66,["111"] = 69,["112"] = 70,["113"] = 70,["114"] = 70,["115"] = 70,["116"] = 70,["117"] = 70,["118"] = 70,["119"] = 70,["120"] = 70,["121"] = 70,["122"] = 70,["124"] = 82,["125"] = 82,["126"] = 83,["127"] = 84,["128"] = 85,["129"] = 86,["132"] = 82,["136"] = 92,["137"] = 93,["138"] = 94,["141"] = 98,["142"] = 99,["143"] = 41,["144"] = 101,["145"] = 102,["146"] = 103,["147"] = 104,["148"] = 106,["149"] = 107,["150"] = 108,["152"] = 110,["153"] = 111,["155"] = 113,["156"] = 114,["157"] = 115,["159"] = 117,["160"] = 118,["161"] = 119,["162"] = 120,["164"] = 122,["165"] = 123,["166"] = 124,["167"] = 125,["169"] = 127,["170"] = 128,["172"] = 130,["173"] = 131,["174"] = 132,["176"] = 134,["177"] = 135,["178"] = 136,["180"] = 138,["181"] = 139,["182"] = 140,["184"] = 142,["185"] = 143,["186"] = 144,["189"] = 147,["190"] = 148,["191"] = 149,["192"] = 150,["194"] = 152,["195"] = 153,["196"] = 154,["197"] = 155,["199"] = 157,["200"] = 158,["201"] = 159,["204"] = 162,["205"] = 163,["206"] = 164,["207"] = 165,["209"] = 167,["210"] = 168,["211"] = 169,["214"] = 172,["215"] = 173,["216"] = 174,["217"] = 175,["219"] = 177,["220"] = 178,["221"] = 179,["223"] = 181,["224"] = 182,["225"] = 183,["228"] = 186,["229"] = 187,["230"] = 188,["231"] = 189,["233"] = 191,["234"] = 192,["236"] = 194,["237"] = 195,["239"] = 197,["240"] = 198,["241"] = 199,["244"] = 202,["245"] = 203,["246"] = 204,["248"] = 206,["249"] = 207,["250"] = 208,["252"] = 210,["253"] = 211,["254"] = 212,["256"] = 214,["257"] = 215,["260"] = 219,["261"] = 101,["262"] = 221,["263"] = 222,["264"] = 223,["265"] = 225,["266"] = 226,["267"] = 227,["269"] = 229,["270"] = 230,["271"] = 231,["273"] = 233,["274"] = 234,["275"] = 235,["277"] = 237,["278"] = 238,["279"] = 239,["281"] = 241,["282"] = 242,["283"] = 243,["284"] = 244,["286"] = 247,["287"] = 248,["288"] = 249,["291"] = 252,["292"] = 253,["293"] = 254,["295"] = 256,["296"] = 257,["299"] = 260,["300"] = 221,["301"] = 262,["302"] = 263,["303"] = 264,["304"] = 266,["305"] = 267,["307"] = 270,["308"] = 271,["309"] = 272,["310"] = 273,["311"] = 275,["312"] = 276,["314"] = 278,["317"] = 281,["318"] = 281,["319"] = 282,["320"] = 283,["321"] = 284,["324"] = 281,["328"] = 290,["329"] = 294,["332"] = 297,["334"] = 300,["335"] = 301,["336"] = 302,["337"] = 302,["338"] = 302,["339"] = 304,["340"] = 305,["341"] = 306,["342"] = 306,["343"] = 306,["344"] = 306,["345"] = 306,["346"] = 306,["347"] = 306,["348"] = 306,["349"] = 306,["350"] = 307,["351"] = 307,["352"] = 307,["353"] = 307,["354"] = 307,["355"] = 307,["356"] = 307,["360"] = 262,["361"] = 312,["362"] = 21,["363"] = 314,["364"] = 312,["365"] = 21,["366"] = 21,["367"] = 318,["368"] = 318,["369"] = 318,["370"] = 318,["371"] = 319,["372"] = 318,["373"] = 321,["374"] = 322,["375"] = 319,["376"] = 325,["377"] = 318,["378"] = 327,["379"] = 328,["381"] = 325,["382"] = 332,["383"] = 333,["384"] = 333,["385"] = 333,["386"] = 333,["387"] = 333,["388"] = 334,["389"] = 334,["390"] = 334,["391"] = 335,["392"] = 336,["393"] = 339,["394"] = 340,["395"] = 341,["396"] = 343,["397"] = 344,["399"] = 334,["400"] = 334,["401"] = 332});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
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
        self:LevelAllAbilities(1)
        if self.unit:IsRealHero() then
            self.unit:SetAbilityPoints(2)
        end
        customEntities:Disarm(self.unit)
    end
    function CustomNPC.prototype.LevelAllAbilities(self, level)
        do
            local i = 0
            while i <= 23 do
                local ability = self.unit:GetAbilityByIndex(i)
                if ability then
                    if CustomAbilities:IsNotTalentNorAttribute(ability) then
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
____exports.PlayerNPC = __TS__Class()
local PlayerNPC = ____exports.PlayerNPC
PlayerNPC.name = "PlayerNPC"
__TS__ClassExtends(PlayerNPC, ____exports.default)
function PlayerNPC.prototype.____constructor(self, unit)
    PlayerNPC.____super.prototype.____constructor(self, unit)
    customEntities:HideHealthBar(self.unit)
    customEntities:SetUseEnergy(self.unit)
end
function PlayerNPC.prototype.Update(self)
    PlayerNPC.____super.prototype.Update(self)
    if self.unit:IsAlive() then
        self:PickupItems()
    end
end
function PlayerNPC.prototype.PickupItems(self)
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
return ____exports
