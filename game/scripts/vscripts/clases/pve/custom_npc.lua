local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 7,["16"] = 7,["17"] = 9,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 29,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 30,["43"] = 31,["44"] = 31,["45"] = 31,["46"] = 31,["47"] = 29,["48"] = 33,["49"] = 34,["50"] = 35,["51"] = 30,["52"] = 37,["54"] = 38,["55"] = 38,["56"] = 39,["57"] = 40,["58"] = 41,["59"] = 42,["62"] = 38,["65"] = 37,["66"] = 47,["67"] = 48,["68"] = 49,["69"] = 50,["70"] = 51,["71"] = 52,["72"] = 53,["73"] = 55,["74"] = 56,["75"] = 56,["76"] = 56,["77"] = 56,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 63,["82"] = 63,["83"] = 63,["84"] = 63,["85"] = 63,["86"] = 63,["87"] = 63,["88"] = 70,["89"] = 70,["90"] = 70,["91"] = 70,["92"] = 70,["93"] = 70,["94"] = 70,["95"] = 70,["97"] = 73,["98"] = 74,["99"] = 75,["101"] = 78,["102"] = 80,["103"] = 81,["105"] = 83,["106"] = 84,["108"] = 87,["109"] = 88,["110"] = 88,["111"] = 88,["112"] = 88,["113"] = 88,["114"] = 88,["115"] = 88,["116"] = 88,["117"] = 88,["118"] = 88,["119"] = 88,["121"] = 100,["122"] = 100,["123"] = 101,["124"] = 102,["125"] = 103,["126"] = 104,["129"] = 100,["133"] = 110,["134"] = 111,["135"] = 112,["138"] = 121,["139"] = 122,["140"] = 47,["141"] = 124,["142"] = 125,["143"] = 126,["144"] = 129,["145"] = 131,["146"] = 132,["147"] = 133,["149"] = 135,["150"] = 136,["152"] = 138,["153"] = 139,["154"] = 140,["156"] = 142,["157"] = 143,["158"] = 144,["159"] = 145,["161"] = 147,["162"] = 148,["163"] = 149,["164"] = 150,["166"] = 152,["167"] = 153,["169"] = 155,["170"] = 156,["171"] = 157,["173"] = 159,["174"] = 160,["175"] = 161,["177"] = 163,["178"] = 164,["179"] = 165,["181"] = 167,["182"] = 168,["183"] = 169,["186"] = 172,["187"] = 173,["188"] = 174,["189"] = 175,["191"] = 177,["192"] = 178,["193"] = 179,["194"] = 180,["196"] = 182,["197"] = 183,["198"] = 184,["201"] = 187,["202"] = 188,["203"] = 189,["204"] = 190,["206"] = 192,["207"] = 193,["208"] = 194,["211"] = 197,["212"] = 198,["213"] = 199,["214"] = 200,["216"] = 202,["217"] = 203,["218"] = 204,["220"] = 206,["221"] = 207,["222"] = 208,["225"] = 211,["226"] = 212,["227"] = 213,["228"] = 214,["230"] = 216,["231"] = 217,["233"] = 219,["234"] = 220,["236"] = 222,["237"] = 223,["238"] = 224,["241"] = 227,["242"] = 228,["243"] = 229,["245"] = 231,["246"] = 232,["247"] = 233,["249"] = 235,["250"] = 236,["251"] = 237,["253"] = 239,["254"] = 240,["257"] = 244,["258"] = 124,["259"] = 246,["260"] = 247,["261"] = 248,["262"] = 250,["263"] = 251,["264"] = 252,["266"] = 254,["267"] = 255,["268"] = 256,["270"] = 258,["271"] = 259,["272"] = 260,["274"] = 262,["275"] = 263,["276"] = 264,["278"] = 266,["279"] = 267,["280"] = 268,["281"] = 269,["283"] = 272,["284"] = 273,["285"] = 274,["288"] = 277,["289"] = 278,["290"] = 279,["292"] = 281,["293"] = 282,["296"] = 285,["297"] = 246,["298"] = 287,["299"] = 288,["300"] = 289,["301"] = 291,["302"] = 292,["303"] = 293,["305"] = 297,["306"] = 300,["307"] = 301,["308"] = 302,["309"] = 304,["310"] = 305,["312"] = 307,["315"] = 310,["316"] = 310,["317"] = 311,["318"] = 312,["319"] = 313,["322"] = 310,["326"] = 320,["327"] = 324,["330"] = 327,["331"] = 328,["332"] = 329,["335"] = 337,["337"] = 340,["338"] = 341,["339"] = 342,["340"] = 346,["341"] = 347,["342"] = 348,["343"] = 348,["344"] = 348,["345"] = 348,["346"] = 348,["347"] = 348,["348"] = 348,["349"] = 357,["350"] = 357,["351"] = 357,["352"] = 357,["353"] = 357,["354"] = 357,["355"] = 357,["359"] = 287,["360"] = 368,["361"] = 29,["362"] = 370,["363"] = 368,["364"] = 373,["365"] = 373,["366"] = 373,["367"] = 373,["368"] = 374,["369"] = 373,["370"] = 376,["371"] = 374,["372"] = 379,["373"] = 379,["374"] = 379,["375"] = 379,["376"] = 380,["377"] = 379,["378"] = 382,["379"] = 380,["380"] = 385,["381"] = 385,["382"] = 385,["383"] = 385,["384"] = 390,["385"] = 385,["386"] = 386,["387"] = 388,["388"] = 392,["389"] = 393,["390"] = 394,["391"] = 395,["392"] = 396,["393"] = 397,["395"] = 390,["396"] = 402,["397"] = 403,["398"] = 404,["399"] = 405,["400"] = 406,["401"] = 407,["402"] = 408,["406"] = 402,["407"] = 416,["408"] = 385,["409"] = 418,["410"] = 419,["411"] = 420,["412"] = 421,["413"] = 422,["415"] = 425,["416"] = 426,["418"] = 416,["419"] = 430,["420"] = 431,["421"] = 431,["422"] = 431,["423"] = 431,["424"] = 431,["425"] = 436,["426"] = 436,["427"] = 436,["428"] = 437,["429"] = 438,["430"] = 442,["431"] = 447,["432"] = 448,["433"] = 450,["434"] = 451,["436"] = 436,["437"] = 436,["438"] = 430,["439"] = 456,["440"] = 457,["441"] = 456,["442"] = 463,["443"] = 464,["444"] = 463,["445"] = 470,["446"] = 471,["447"] = 472,["448"] = 472,["449"] = 472,["450"] = 472,["451"] = 476,["452"] = 470,["453"] = 479,["454"] = 480,["455"] = 481,["456"] = 481,["457"] = 481,["458"] = 481,["459"] = 485,["460"] = 479,["461"] = 488,["462"] = 488,["463"] = 492,["464"] = 493,["465"] = 494,["466"] = 494,["467"] = 494,["468"] = 495,["469"] = 495,["470"] = 495,["471"] = 495,["472"] = 499,["473"] = 500,["475"] = 494,["476"] = 494,["477"] = 504,["478"] = 513,["479"] = 517,["481"] = 520,["482"] = 528,["483"] = 492,["484"] = 531,["485"] = 532,["486"] = 534,["487"] = 531,["488"] = 544,["489"] = 545,["490"] = 547,["491"] = 544,["492"] = 557,["493"] = 558,["494"] = 559,["495"] = 560,["496"] = 561,["497"] = 566,["498"] = 569,["499"] = 557,["500"] = 572,["501"] = 573,["502"] = 576,["503"] = 576,["504"] = 576,["505"] = 576,["506"] = 576,["507"] = 572});
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
    local futureOrigin = origin:__add(direction:__mul(speed))
    local testOrigin = futureOrigin:__add(direction:__mul(offset))
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
            futureOrigin:__add(normal:__mul(200)),
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
        directions[#directions + 1] = Math.NORTH
        directions[#directions + 1] = Math.EAST
    end
    if Math:IsNorthWest(angle) then
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            return directions
        end
        if collisionDirection == Orientations.DIAGONAL_LEFT then
            directions[#directions + 1] = Math.NORTH
            directions[#directions + 1] = Math.WEST
            return directions
        end
        if collisionDirection == Orientations.VERTICAL then
            directions[#directions + 1] = Math.NORTH
            directions[#directions + 1] = Math.WEST
            return directions
        end
        directions[#directions + 1] = Math.NORTH
        directions[#directions + 1] = Math.WEST
    end
    if Math:IsSouthEast(angle) then
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            return directions
        end
        if collisionDirection == Orientations.DIAGONAL_LEFT then
            directions[#directions + 1] = Math.SOUTH
            directions[#directions + 1] = Math.EAST
        end
        if collisionDirection == Orientations.HORIZONTAL then
            directions[#directions + 1] = Math.EAST
            directions[#directions + 1] = Math.SOUTH
        end
        if collisionDirection == Orientations.VERTICAL then
            directions[#directions + 1] = Math.SOUTH
            directions[#directions + 1] = Math.EAST
        end
    end
    if Math:IsSouthWest(angle) then
        if collisionDirection == Orientations.HORIZONTAL then
            directions[#directions + 1] = Math.WEST
            directions[#directions + 1] = Math.SOUTH
        end
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            directions[#directions + 1] = Math.SOUTH_WEST
            directions[#directions + 1] = Math.WEST
            directions[#directions + 1] = Math.SOUTH
        end
        if collisionDirection == Orientations.VERTICAL then
            directions[#directions + 1] = Math.SOUTH
            directions[#directions + 1] = Math.WEST
        end
    end
    if Math:IsEast(angle) then
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            directions[#directions + 1] = Math.NORTH_EAST
            directions[#directions + 1] = Math.NORTH
        end
        if collisionDirection == Orientations.DIAGONAL_LEFT then
            directions[#directions + 1] = Math.SOUTH_EAST
            directions[#directions + 1] = Math.SOUTH
        end
    end
    if Math:IsWest(angle) then
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            directions[#directions + 1] = Math.SOUTH_EAST
            directions[#directions + 1] = Math.SOUTH
        end
        if collisionDirection == Orientations.DIAGONAL_LEFT then
            directions[#directions + 1] = Math.NORTH_WEST
            directions[#directions + 1] = Math.NORTH
        end
        if collisionDirection == Orientations.HORIZONTAL then
            directions[#directions + 1] = Math.SOUTH
            directions[#directions + 1] = Math.NORTH
        end
    end
    if Math:IsNorth(angle) then
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            directions[#directions + 1] = Math.NORTH_EAST
            directions[#directions + 1] = Math.EAST
        end
        if collisionDirection == Orientations.HORIZONTAL then
            return directions
        end
        if collisionDirection == Orientations.DIAGONAL_LEFT then
            directions[#directions + 1] = Math.WEST
        end
        if collisionDirection == Orientations.VERTICAL then
            directions[#directions + 1] = Math.NORTH_WEST
            directions[#directions + 1] = Math.WEST
        end
    end
    if Math:IsSouth(angle) then
        if collisionDirection == Orientations.HORIZONTAL then
            return directions
        end
        if collisionDirection == Orientations.DIAGONAL_RIGHT then
            directions[#directions + 1] = Math.SOUTH_WEST
            directions[#directions + 1] = Math.WEST
        end
        if collisionDirection == Orientations.DIAGONAL_LEFT then
            directions[#directions + 1] = Math.SOUTH_EAST
            directions[#directions + 1] = Math.EAST
        end
        if collisionDirection == Orientations.VERTICAL then
            directions[#directions + 1] = Math.EAST
        end
    end
    return directions
end
function CustomNPC.prototype.AlternativeDirections(self, direction)
    local directions = {}
    local angle = VectorToAngles(direction).y
    if Math:IsNorthEast(angle) then
        directions[#directions + 1] = Math.NORTH
        directions[#directions + 1] = Math.EAST
    end
    if Math:IsNorthWest(angle) then
        directions[#directions + 1] = Math.NORTH
        directions[#directions + 1] = Math.WEST
    end
    if Math:IsSouthEast(angle) then
        directions[#directions + 1] = Math.SOUTH
        directions[#directions + 1] = Math.EAST
    end
    if Math:IsSouthWest(angle) then
        directions[#directions + 1] = Math.SOUTH
        directions[#directions + 1] = Math.WEST
    end
    if Math:IsEast(angle) or Math:IsWest(angle) then
        if self.unit:GetAbsOrigin().y < 0 then
            directions[#directions + 1] = Math.SOUTH
            directions[#directions + 1] = Math.NORTH
        end
        if self.unit:GetAbsOrigin().y > 0 then
            directions[#directions + 1] = Math.NORTH
            directions[#directions + 1] = Math.SOUTH
        end
    end
    if Math:IsNorth(angle) or Math:IsSouth(angle) then
        if self.unit:GetAbsOrigin().x < 0 then
            directions[#directions + 1] = Math.WEST
        end
        if self.unit:GetAbsOrigin().x > 0 then
            directions[#directions + 1] = Math.EAST
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
    if (direction.x ~= 0 or direction.y ~= 0) and CustomEntitiesLegacy:CanWalk(self.unit) then
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
        if not self.unit:HasModifier("modifier_casting") and not self.unit:HasModifier("modifier_mars_counter_countering") and not self.unit:HasModifier("modifier_spectre_counter_countering") then
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
            local player = GameRules.Addon:FindPlayerById(self.unit:GetPlayerID())
            if player then
                local mouse = player:GetCursorPosition()
                DebugDrawLine_vCol(
                    self.unit:GetAbsOrigin(),
                    self.unit:GetAbsOrigin():__add(self.unit:GetForwardVector():__mul(500)),
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
    self:LevelAllAbilities(1)
    if GameRules.Addon:IsPVE() then
        self.unit:SetAbilityPoints(0)
        customEntities:ChangeMS(self.unit, 50)
        self.unit:RemoveAbility(self.unit:GetAbilityByIndex(7):GetName())
        self.unit:RemoveAbility(self.unit:GetAbilityByIndex(8):GetName())
    end
end
function CustomPlayerHeroNPC.prototype.OnLearnedAbilityEvent(self, event)
    if event.PlayerID == self.unit:GetPlayerOwnerID() then
        local ability = self.unit:FindAbilityByName(event.abilityname)
        if ability then
            if ability:GetLevel() == 2 then
                ability:SetLevel(1)
                self.unit:SetAbilityPoints(self.unit:GetAbilityPoints() + 1)
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
            if not owner or owner and CustomEntitiesLegacy:Allies(self.unit, owner) and self.unit ~= owner then
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
        tostring(self.unit:GetPlayerOwnerID())
    )
    return value and value.upgrades ~= nil
end
function CustomPlayerHeroNPC.prototype.IsSelectingReward(self)
    local tableName = "custom_npc_rewards"
    local value = CustomNetTables:GetTableValue(
        tableName,
        tostring(self.unit:GetPlayerOwnerID())
    )
    return value and value.rewards ~= nil
end
function CustomPlayerHeroNPC.prototype.ReleaseAbility(self, abilityName)
end
function CustomPlayerHeroNPC.prototype.ApplyItem(self, upgrade)
    if upgrade.ingredients then
        __TS__ArrayForEach(
            upgrade.ingredients,
            function(____, ingredientId)
                local ingredientUpgrade = __TS__ArrayFind(
                    self.heroUpgrades,
                    function(____, heroUpgrade) return heroUpgrade.id == ingredientId end
                )
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
    local data = {playerId = self.unit:GetPlayerOwnerID()}
    CustomNetTables:SetTableValue(
        name,
        tostring(self.unit:GetPlayerOwnerID()),
        data
    )
end
return ____exports
