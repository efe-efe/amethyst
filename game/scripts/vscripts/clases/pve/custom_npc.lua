--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 7,["12"] = 7,["13"] = 9,["14"] = 11,["15"] = 11,["16"] = 11,["17"] = 11,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 18,["24"] = 18,["25"] = 18,["26"] = 18,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 29,["35"] = 29,["36"] = 29,["37"] = 29,["38"] = 29,["39"] = 30,["40"] = 31,["41"] = 31,["42"] = 31,["43"] = 31,["44"] = 29,["45"] = 33,["46"] = 34,["47"] = 35,["48"] = 30,["49"] = 37,["51"] = 38,["52"] = 38,["53"] = 39,["54"] = 40,["55"] = 41,["56"] = 42,["59"] = 38,["62"] = 37,["63"] = 47,["64"] = 48,["65"] = 49,["66"] = 50,["67"] = 50,["68"] = 50,["69"] = 51,["70"] = 51,["71"] = 51,["72"] = 52,["73"] = 53,["74"] = 55,["75"] = 56,["76"] = 56,["77"] = 56,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 56,["82"] = 57,["83"] = 57,["84"] = 57,["85"] = 57,["86"] = 57,["87"] = 57,["88"] = 57,["89"] = 57,["90"] = 57,["91"] = 58,["92"] = 58,["93"] = 58,["94"] = 58,["95"] = 58,["96"] = 58,["97"] = 58,["98"] = 58,["100"] = 61,["101"] = 62,["102"] = 63,["104"] = 66,["105"] = 68,["106"] = 69,["108"] = 71,["109"] = 72,["111"] = 75,["112"] = 76,["113"] = 76,["114"] = 76,["115"] = 76,["116"] = 76,["117"] = 76,["118"] = 76,["119"] = 76,["120"] = 76,["121"] = 76,["122"] = 76,["124"] = 88,["125"] = 88,["126"] = 89,["127"] = 90,["128"] = 91,["129"] = 92,["132"] = 88,["136"] = 98,["137"] = 99,["138"] = 100,["141"] = 104,["142"] = 105,["143"] = 47,["144"] = 107,["145"] = 108,["146"] = 109,["147"] = 110,["148"] = 112,["149"] = 113,["150"] = 114,["152"] = 116,["153"] = 117,["155"] = 119,["156"] = 120,["157"] = 121,["159"] = 123,["160"] = 124,["161"] = 125,["162"] = 126,["164"] = 128,["165"] = 129,["166"] = 130,["167"] = 131,["169"] = 133,["170"] = 134,["172"] = 136,["173"] = 137,["174"] = 138,["176"] = 140,["177"] = 141,["178"] = 142,["180"] = 144,["181"] = 145,["182"] = 146,["184"] = 148,["185"] = 149,["186"] = 150,["189"] = 153,["190"] = 154,["191"] = 155,["192"] = 156,["194"] = 158,["195"] = 159,["196"] = 160,["197"] = 161,["199"] = 163,["200"] = 164,["201"] = 165,["204"] = 168,["205"] = 169,["206"] = 170,["207"] = 171,["209"] = 173,["210"] = 174,["211"] = 175,["214"] = 178,["215"] = 179,["216"] = 180,["217"] = 181,["219"] = 183,["220"] = 184,["221"] = 185,["223"] = 187,["224"] = 188,["225"] = 189,["228"] = 192,["229"] = 193,["230"] = 194,["231"] = 195,["233"] = 197,["234"] = 198,["236"] = 200,["237"] = 201,["239"] = 203,["240"] = 204,["241"] = 205,["244"] = 208,["245"] = 209,["246"] = 210,["248"] = 212,["249"] = 213,["250"] = 214,["252"] = 216,["253"] = 217,["254"] = 218,["256"] = 220,["257"] = 221,["260"] = 225,["261"] = 107,["262"] = 227,["263"] = 228,["264"] = 229,["265"] = 231,["266"] = 232,["267"] = 233,["269"] = 235,["270"] = 236,["271"] = 237,["273"] = 239,["274"] = 240,["275"] = 241,["277"] = 243,["278"] = 244,["279"] = 245,["281"] = 247,["282"] = 248,["283"] = 249,["284"] = 250,["286"] = 253,["287"] = 254,["288"] = 255,["291"] = 258,["292"] = 259,["293"] = 260,["295"] = 262,["296"] = 263,["299"] = 266,["300"] = 227,["301"] = 268,["302"] = 269,["303"] = 270,["304"] = 272,["305"] = 273,["306"] = 274,["308"] = 277,["309"] = 278,["310"] = 279,["311"] = 280,["312"] = 282,["313"] = 283,["315"] = 285,["318"] = 288,["319"] = 288,["320"] = 289,["321"] = 290,["322"] = 291,["325"] = 288,["329"] = 297,["330"] = 301,["333"] = 304,["334"] = 305,["335"] = 306,["338"] = 309,["340"] = 312,["341"] = 313,["342"] = 314,["343"] = 314,["344"] = 314,["345"] = 316,["346"] = 317,["347"] = 318,["348"] = 318,["349"] = 318,["350"] = 318,["351"] = 318,["352"] = 318,["353"] = 318,["354"] = 318,["355"] = 318,["356"] = 319,["357"] = 319,["358"] = 319,["359"] = 319,["360"] = 319,["361"] = 319,["362"] = 319,["366"] = 268,["367"] = 324,["368"] = 29,["369"] = 326,["370"] = 324,["371"] = 29,["372"] = 29,["373"] = 329,["374"] = 329,["375"] = 329,["376"] = 329,["377"] = 330,["378"] = 329,["379"] = 332,["380"] = 330,["381"] = 335,["382"] = 335,["383"] = 335,["384"] = 335,["385"] = 336,["386"] = 335,["387"] = 338,["388"] = 336,["389"] = 341,["390"] = 341,["391"] = 341,["392"] = 341,["393"] = 346,["394"] = 341,["395"] = 342,["396"] = 344,["397"] = 348,["398"] = 349,["399"] = 350,["400"] = 351,["401"] = 352,["402"] = 353,["403"] = 354,["404"] = 354,["405"] = 354,["406"] = 355,["407"] = 355,["408"] = 355,["409"] = 357,["410"] = 357,["411"] = 357,["412"] = 357,["413"] = 357,["415"] = 359,["416"] = 360,["418"] = 346,["419"] = 364,["420"] = 365,["421"] = 366,["422"] = 367,["423"] = 368,["424"] = 369,["425"] = 370,["426"] = 370,["427"] = 370,["431"] = 364,["432"] = 376,["433"] = 341,["434"] = 378,["435"] = 379,["436"] = 380,["437"] = 381,["438"] = 382,["440"] = 385,["441"] = 386,["443"] = 376,["444"] = 390,["445"] = 391,["446"] = 391,["447"] = 391,["448"] = 391,["449"] = 391,["450"] = 392,["451"] = 392,["452"] = 392,["453"] = 393,["454"] = 394,["455"] = 397,["456"] = 398,["457"] = 399,["458"] = 401,["459"] = 402,["461"] = 392,["462"] = 392,["463"] = 390,["464"] = 408,["465"] = 409,["466"] = 408,["467"] = 412,["468"] = 413,["469"] = 412,["470"] = 416,["471"] = 417,["472"] = 418,["473"] = 418,["474"] = 418,["475"] = 418,["476"] = 418,["477"] = 418,["478"] = 419,["479"] = 416,["480"] = 422,["481"] = 423,["482"] = 424,["483"] = 424,["484"] = 424,["485"] = 424,["486"] = 424,["487"] = 424,["488"] = 425,["489"] = 422,["490"] = 428,["491"] = 428,["492"] = 432,["493"] = 433,["494"] = 434,["495"] = 434,["496"] = 434,["497"] = 435,["498"] = 435,["499"] = 435,["500"] = 435,["501"] = 437,["502"] = 438,["504"] = 434,["505"] = 434,["506"] = 442,["507"] = 446,["508"] = 448,["510"] = 451,["511"] = 454,["512"] = 432,["513"] = 457,["514"] = 458,["515"] = 460,["516"] = 457,["517"] = 465,["518"] = 466,["519"] = 468,["520"] = 465,["521"] = 473,["522"] = 474,["523"] = 475,["524"] = 476,["525"] = 477,["526"] = 479,["527"] = 482,["528"] = 473,["529"] = 485,["530"] = 486,["531"] = 486,["532"] = 486,["533"] = 489,["534"] = 489,["535"] = 489,["536"] = 489,["537"] = 489,["538"] = 489,["539"] = 489,["540"] = 485});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
local ____math = require("util.math")
local Math = ____math.default
local ____custom_entities = require("util.custom_entities")
local customEntities = ____custom_entities.default
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
    function CustomNPC.prototype.OnDeath(self, event)
        UnitEntity.prototype.OnDeath(self, event)
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
function CustomPlayerHeroNPC.prototype.IsSelectingUpgrade(self)
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
return ____exports
