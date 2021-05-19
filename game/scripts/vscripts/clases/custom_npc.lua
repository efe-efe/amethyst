--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 5,["12"] = 7,["13"] = 7,["14"] = 7,["15"] = 7,["16"] = 7,["17"] = 7,["18"] = 7,["19"] = 7,["20"] = 7,["21"] = 14,["22"] = 14,["23"] = 14,["24"] = 14,["25"] = 14,["26"] = 14,["27"] = 14,["28"] = 14,["29"] = 14,["30"] = 14,["31"] = 14,["32"] = 21,["33"] = 21,["34"] = 21,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 23,["39"] = 23,["40"] = 23,["41"] = 23,["42"] = 21,["43"] = 25,["44"] = 26,["45"] = 27,["47"] = 29,["48"] = 30,["49"] = 22,["50"] = 32,["52"] = 33,["53"] = 33,["54"] = 34,["55"] = 35,["56"] = 36,["57"] = 37,["60"] = 33,["63"] = 32,["64"] = 42,["65"] = 43,["66"] = 44,["67"] = 45,["68"] = 45,["69"] = 45,["70"] = 46,["71"] = 46,["72"] = 46,["73"] = 47,["74"] = 48,["75"] = 50,["76"] = 51,["77"] = 51,["78"] = 51,["79"] = 51,["80"] = 51,["81"] = 51,["82"] = 51,["83"] = 52,["84"] = 52,["85"] = 52,["86"] = 52,["87"] = 52,["88"] = 52,["89"] = 52,["90"] = 52,["91"] = 52,["92"] = 53,["93"] = 53,["94"] = 53,["95"] = 53,["96"] = 53,["97"] = 53,["98"] = 53,["99"] = 53,["101"] = 56,["102"] = 57,["103"] = 58,["105"] = 61,["106"] = 63,["107"] = 64,["109"] = 66,["110"] = 67,["112"] = 70,["113"] = 71,["114"] = 71,["115"] = 71,["116"] = 71,["117"] = 71,["118"] = 71,["119"] = 71,["120"] = 71,["121"] = 71,["122"] = 71,["123"] = 71,["125"] = 83,["126"] = 83,["127"] = 84,["128"] = 85,["129"] = 86,["130"] = 87,["133"] = 83,["137"] = 93,["138"] = 94,["139"] = 95,["142"] = 99,["143"] = 100,["144"] = 42,["145"] = 102,["146"] = 103,["147"] = 104,["148"] = 105,["149"] = 107,["150"] = 108,["151"] = 109,["153"] = 111,["154"] = 112,["156"] = 114,["157"] = 115,["158"] = 116,["160"] = 118,["161"] = 119,["162"] = 120,["163"] = 121,["165"] = 123,["166"] = 124,["167"] = 125,["168"] = 126,["170"] = 128,["171"] = 129,["173"] = 131,["174"] = 132,["175"] = 133,["177"] = 135,["178"] = 136,["179"] = 137,["181"] = 139,["182"] = 140,["183"] = 141,["185"] = 143,["186"] = 144,["187"] = 145,["190"] = 148,["191"] = 149,["192"] = 150,["193"] = 151,["195"] = 153,["196"] = 154,["197"] = 155,["198"] = 156,["200"] = 158,["201"] = 159,["202"] = 160,["205"] = 163,["206"] = 164,["207"] = 165,["208"] = 166,["210"] = 168,["211"] = 169,["212"] = 170,["215"] = 173,["216"] = 174,["217"] = 175,["218"] = 176,["220"] = 178,["221"] = 179,["222"] = 180,["224"] = 182,["225"] = 183,["226"] = 184,["229"] = 187,["230"] = 188,["231"] = 189,["232"] = 190,["234"] = 192,["235"] = 193,["237"] = 195,["238"] = 196,["240"] = 198,["241"] = 199,["242"] = 200,["245"] = 203,["246"] = 204,["247"] = 205,["249"] = 207,["250"] = 208,["251"] = 209,["253"] = 211,["254"] = 212,["255"] = 213,["257"] = 215,["258"] = 216,["261"] = 220,["262"] = 102,["263"] = 222,["264"] = 223,["265"] = 224,["266"] = 226,["267"] = 227,["268"] = 228,["270"] = 230,["271"] = 231,["272"] = 232,["274"] = 234,["275"] = 235,["276"] = 236,["278"] = 238,["279"] = 239,["280"] = 240,["282"] = 242,["283"] = 243,["284"] = 244,["285"] = 245,["287"] = 248,["288"] = 249,["289"] = 250,["292"] = 253,["293"] = 254,["294"] = 255,["296"] = 257,["297"] = 258,["300"] = 261,["301"] = 222,["302"] = 263,["303"] = 264,["304"] = 265,["305"] = 267,["306"] = 268,["308"] = 271,["309"] = 272,["310"] = 273,["311"] = 274,["312"] = 276,["313"] = 277,["315"] = 279,["318"] = 282,["319"] = 282,["320"] = 283,["321"] = 284,["322"] = 285,["325"] = 282,["329"] = 291,["330"] = 295,["333"] = 298,["335"] = 301,["336"] = 302,["337"] = 303,["338"] = 303,["339"] = 303,["340"] = 305,["341"] = 306,["342"] = 307,["343"] = 307,["344"] = 307,["345"] = 307,["346"] = 307,["347"] = 307,["348"] = 307,["349"] = 307,["350"] = 307,["351"] = 308,["352"] = 308,["353"] = 308,["354"] = 308,["355"] = 308,["356"] = 308,["357"] = 308,["361"] = 263,["362"] = 313,["363"] = 21,["364"] = 315,["365"] = 313,["366"] = 21,["367"] = 21,["368"] = 319,["369"] = 319,["370"] = 319,["371"] = 319,["372"] = 320,["373"] = 319,["374"] = 322,["375"] = 323,["376"] = 320,["377"] = 326,["378"] = 319,["379"] = 328,["380"] = 329,["382"] = 326,["383"] = 333,["384"] = 334,["385"] = 334,["386"] = 334,["387"] = 334,["388"] = 334,["389"] = 335,["390"] = 335,["391"] = 335,["392"] = 336,["393"] = 337,["394"] = 340,["395"] = 341,["396"] = 342,["397"] = 344,["398"] = 345,["400"] = 335,["401"] = 335,["402"] = 333});
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
