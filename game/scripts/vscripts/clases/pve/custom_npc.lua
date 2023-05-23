local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 2,["13"] = 3,["14"] = 3,["15"] = 7,["16"] = 7,["17"] = 9,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 29,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 30,["43"] = 31,["44"] = 31,["45"] = 31,["46"] = 31,["47"] = 29,["48"] = 33,["49"] = 34,["50"] = 35,["51"] = 30,["52"] = 37,["54"] = 38,["55"] = 38,["56"] = 39,["57"] = 40,["58"] = 41,["59"] = 42,["62"] = 38,["65"] = 37,["66"] = 47,["67"] = 48,["68"] = 49,["69"] = 50,["70"] = 51,["71"] = 52,["72"] = 53,["73"] = 55,["74"] = 56,["75"] = 56,["76"] = 56,["77"] = 56,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 57,["82"] = 57,["83"] = 57,["84"] = 57,["85"] = 57,["86"] = 57,["87"] = 57,["88"] = 58,["89"] = 58,["90"] = 58,["91"] = 58,["92"] = 58,["93"] = 58,["94"] = 58,["95"] = 58,["97"] = 61,["98"] = 62,["99"] = 63,["101"] = 66,["102"] = 68,["103"] = 69,["105"] = 71,["106"] = 72,["108"] = 75,["109"] = 76,["110"] = 76,["111"] = 76,["112"] = 76,["113"] = 76,["114"] = 76,["115"] = 76,["116"] = 76,["117"] = 76,["118"] = 76,["119"] = 76,["121"] = 88,["122"] = 88,["123"] = 89,["124"] = 90,["125"] = 91,["126"] = 92,["129"] = 88,["133"] = 98,["134"] = 99,["135"] = 100,["138"] = 104,["139"] = 105,["140"] = 47,["141"] = 107,["142"] = 108,["143"] = 109,["144"] = 110,["145"] = 112,["146"] = 113,["147"] = 114,["149"] = 116,["150"] = 117,["152"] = 119,["153"] = 120,["154"] = 121,["156"] = 123,["157"] = 124,["158"] = 125,["159"] = 126,["161"] = 128,["162"] = 129,["163"] = 130,["164"] = 131,["166"] = 133,["167"] = 134,["169"] = 136,["170"] = 137,["171"] = 138,["173"] = 140,["174"] = 141,["175"] = 142,["177"] = 144,["178"] = 145,["179"] = 146,["181"] = 148,["182"] = 149,["183"] = 150,["186"] = 153,["187"] = 154,["188"] = 155,["189"] = 156,["191"] = 158,["192"] = 159,["193"] = 160,["194"] = 161,["196"] = 163,["197"] = 164,["198"] = 165,["201"] = 168,["202"] = 169,["203"] = 170,["204"] = 171,["206"] = 173,["207"] = 174,["208"] = 175,["211"] = 178,["212"] = 179,["213"] = 180,["214"] = 181,["216"] = 183,["217"] = 184,["218"] = 185,["220"] = 187,["221"] = 188,["222"] = 189,["225"] = 192,["226"] = 193,["227"] = 194,["228"] = 195,["230"] = 197,["231"] = 198,["233"] = 200,["234"] = 201,["236"] = 203,["237"] = 204,["238"] = 205,["241"] = 208,["242"] = 209,["243"] = 210,["245"] = 212,["246"] = 213,["247"] = 214,["249"] = 216,["250"] = 217,["251"] = 218,["253"] = 220,["254"] = 221,["257"] = 225,["258"] = 107,["259"] = 227,["260"] = 228,["261"] = 229,["262"] = 231,["263"] = 232,["264"] = 233,["266"] = 235,["267"] = 236,["268"] = 237,["270"] = 239,["271"] = 240,["272"] = 241,["274"] = 243,["275"] = 244,["276"] = 245,["278"] = 247,["279"] = 248,["280"] = 249,["281"] = 250,["283"] = 253,["284"] = 254,["285"] = 255,["288"] = 258,["289"] = 259,["290"] = 260,["292"] = 262,["293"] = 263,["296"] = 266,["297"] = 227,["298"] = 268,["299"] = 269,["300"] = 270,["301"] = 272,["302"] = 273,["303"] = 274,["305"] = 277,["306"] = 278,["307"] = 279,["308"] = 280,["309"] = 282,["310"] = 283,["312"] = 285,["315"] = 288,["316"] = 288,["317"] = 289,["318"] = 290,["319"] = 291,["322"] = 288,["326"] = 298,["327"] = 302,["330"] = 305,["331"] = 306,["332"] = 307,["335"] = 310,["337"] = 313,["338"] = 314,["339"] = 315,["340"] = 317,["341"] = 318,["342"] = 319,["343"] = 319,["344"] = 319,["345"] = 319,["346"] = 319,["347"] = 319,["348"] = 319,["349"] = 326,["350"] = 326,["351"] = 326,["352"] = 326,["353"] = 326,["354"] = 326,["355"] = 326,["359"] = 268,["360"] = 331,["361"] = 29,["362"] = 333,["363"] = 331,["364"] = 336,["365"] = 336,["366"] = 336,["367"] = 336,["368"] = 337,["369"] = 336,["370"] = 339,["371"] = 337,["372"] = 342,["373"] = 342,["374"] = 342,["375"] = 342,["376"] = 343,["377"] = 342,["378"] = 345,["379"] = 343,["380"] = 348,["381"] = 348,["382"] = 348,["383"] = 348,["384"] = 353,["385"] = 348,["386"] = 349,["387"] = 351,["388"] = 355,["389"] = 356,["390"] = 357,["391"] = 358,["392"] = 359,["393"] = 360,["395"] = 353,["396"] = 365,["397"] = 366,["398"] = 367,["399"] = 368,["400"] = 369,["401"] = 370,["402"] = 371,["406"] = 365,["407"] = 377,["408"] = 348,["409"] = 379,["410"] = 380,["411"] = 381,["412"] = 382,["413"] = 383,["415"] = 386,["416"] = 387,["418"] = 377,["419"] = 391,["420"] = 392,["421"] = 392,["422"] = 392,["423"] = 392,["424"] = 392,["425"] = 393,["426"] = 393,["427"] = 393,["428"] = 394,["429"] = 395,["430"] = 398,["431"] = 399,["432"] = 400,["433"] = 402,["434"] = 403,["436"] = 393,["437"] = 393,["438"] = 391,["439"] = 408,["440"] = 409,["441"] = 408,["442"] = 412,["443"] = 413,["444"] = 412,["445"] = 416,["446"] = 417,["447"] = 418,["448"] = 418,["449"] = 418,["450"] = 418,["451"] = 422,["452"] = 416,["453"] = 425,["454"] = 426,["455"] = 427,["456"] = 427,["457"] = 427,["458"] = 427,["459"] = 431,["460"] = 425,["461"] = 434,["462"] = 434,["463"] = 438,["464"] = 439,["465"] = 440,["466"] = 440,["467"] = 440,["468"] = 441,["469"] = 441,["470"] = 441,["471"] = 441,["472"] = 443,["473"] = 444,["475"] = 440,["476"] = 440,["477"] = 448,["478"] = 452,["479"] = 456,["481"] = 459,["482"] = 462,["483"] = 438,["484"] = 465,["485"] = 466,["486"] = 468,["487"] = 465,["488"] = 473,["489"] = 474,["490"] = 476,["491"] = 473,["492"] = 481,["493"] = 482,["494"] = 483,["495"] = 484,["496"] = 485,["497"] = 490,["498"] = 493,["499"] = 481,["500"] = 496,["501"] = 497,["502"] = 500,["503"] = 500,["504"] = 500,["505"] = 500,["506"] = 500,["507"] = 496});
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
