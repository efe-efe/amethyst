--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 5,["12"] = 5,["13"] = 6,["14"] = 6,["15"] = 7,["16"] = 7,["17"] = 9,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["23"] = 11,["24"] = 11,["25"] = 11,["26"] = 11,["27"] = 18,["28"] = 18,["29"] = 18,["30"] = 18,["31"] = 18,["32"] = 18,["33"] = 18,["34"] = 18,["35"] = 18,["36"] = 18,["37"] = 18,["38"] = 30,["39"] = 30,["40"] = 30,["41"] = 30,["42"] = 30,["43"] = 31,["44"] = 32,["45"] = 32,["46"] = 32,["47"] = 32,["48"] = 30,["49"] = 34,["50"] = 35,["51"] = 31,["52"] = 37,["54"] = 38,["55"] = 38,["56"] = 39,["57"] = 40,["58"] = 41,["59"] = 42,["62"] = 38,["65"] = 37,["66"] = 47,["67"] = 48,["68"] = 49,["69"] = 50,["70"] = 50,["71"] = 50,["72"] = 51,["73"] = 51,["74"] = 51,["75"] = 52,["76"] = 53,["77"] = 55,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 56,["85"] = 57,["86"] = 57,["87"] = 57,["88"] = 57,["89"] = 57,["90"] = 57,["91"] = 57,["92"] = 57,["93"] = 57,["94"] = 58,["95"] = 58,["96"] = 58,["97"] = 58,["98"] = 58,["99"] = 58,["100"] = 58,["101"] = 58,["103"] = 61,["104"] = 62,["105"] = 63,["107"] = 66,["108"] = 68,["109"] = 69,["111"] = 71,["112"] = 72,["114"] = 75,["115"] = 76,["116"] = 76,["117"] = 76,["118"] = 76,["119"] = 76,["120"] = 76,["121"] = 76,["122"] = 76,["123"] = 76,["124"] = 76,["125"] = 76,["127"] = 88,["128"] = 88,["129"] = 89,["130"] = 90,["131"] = 91,["132"] = 92,["135"] = 88,["139"] = 98,["140"] = 99,["141"] = 100,["144"] = 104,["145"] = 105,["146"] = 47,["147"] = 107,["148"] = 108,["149"] = 109,["150"] = 110,["151"] = 112,["152"] = 113,["153"] = 114,["155"] = 116,["156"] = 117,["158"] = 119,["159"] = 120,["160"] = 121,["162"] = 123,["163"] = 124,["164"] = 125,["165"] = 126,["167"] = 128,["168"] = 129,["169"] = 130,["170"] = 131,["172"] = 133,["173"] = 134,["175"] = 136,["176"] = 137,["177"] = 138,["179"] = 140,["180"] = 141,["181"] = 142,["183"] = 144,["184"] = 145,["185"] = 146,["187"] = 148,["188"] = 149,["189"] = 150,["192"] = 153,["193"] = 154,["194"] = 155,["195"] = 156,["197"] = 158,["198"] = 159,["199"] = 160,["200"] = 161,["202"] = 163,["203"] = 164,["204"] = 165,["207"] = 168,["208"] = 169,["209"] = 170,["210"] = 171,["212"] = 173,["213"] = 174,["214"] = 175,["217"] = 178,["218"] = 179,["219"] = 180,["220"] = 181,["222"] = 183,["223"] = 184,["224"] = 185,["226"] = 187,["227"] = 188,["228"] = 189,["231"] = 192,["232"] = 193,["233"] = 194,["234"] = 195,["236"] = 197,["237"] = 198,["239"] = 200,["240"] = 201,["242"] = 203,["243"] = 204,["244"] = 205,["247"] = 208,["248"] = 209,["249"] = 210,["251"] = 212,["252"] = 213,["253"] = 214,["255"] = 216,["256"] = 217,["257"] = 218,["259"] = 220,["260"] = 221,["263"] = 225,["264"] = 107,["265"] = 227,["266"] = 228,["267"] = 229,["268"] = 231,["269"] = 232,["270"] = 233,["272"] = 235,["273"] = 236,["274"] = 237,["276"] = 239,["277"] = 240,["278"] = 241,["280"] = 243,["281"] = 244,["282"] = 245,["284"] = 247,["285"] = 248,["286"] = 249,["287"] = 250,["289"] = 253,["290"] = 254,["291"] = 255,["294"] = 258,["295"] = 259,["296"] = 260,["298"] = 262,["299"] = 263,["302"] = 266,["303"] = 227,["304"] = 268,["305"] = 269,["306"] = 270,["307"] = 272,["308"] = 273,["309"] = 274,["311"] = 277,["312"] = 278,["313"] = 279,["314"] = 280,["315"] = 282,["316"] = 283,["318"] = 285,["321"] = 288,["322"] = 288,["323"] = 289,["324"] = 290,["325"] = 291,["328"] = 288,["332"] = 297,["333"] = 301,["336"] = 304,["337"] = 305,["338"] = 306,["341"] = 309,["343"] = 312,["344"] = 313,["345"] = 314,["346"] = 314,["347"] = 314,["348"] = 316,["349"] = 317,["350"] = 318,["351"] = 318,["352"] = 318,["353"] = 318,["354"] = 318,["355"] = 318,["356"] = 318,["357"] = 318,["358"] = 318,["359"] = 319,["360"] = 319,["361"] = 319,["362"] = 319,["363"] = 319,["364"] = 319,["365"] = 319,["369"] = 268,["370"] = 324,["371"] = 30,["372"] = 326,["373"] = 324,["374"] = 30,["375"] = 30,["376"] = 329,["377"] = 329,["378"] = 329,["379"] = 329,["380"] = 330,["381"] = 329,["382"] = 332,["383"] = 333,["384"] = 330,["385"] = 336,["386"] = 336,["387"] = 336,["388"] = 336,["389"] = 337,["390"] = 336,["391"] = 339,["392"] = 337,["393"] = 342,["394"] = 342,["395"] = 342,["396"] = 342,["397"] = 347,["398"] = 342,["399"] = 343,["400"] = 345,["401"] = 349,["402"] = 350,["403"] = 351,["404"] = 352,["405"] = 353,["406"] = 354,["407"] = 355,["408"] = 355,["409"] = 355,["410"] = 356,["411"] = 356,["412"] = 356,["414"] = 358,["415"] = 359,["417"] = 347,["418"] = 363,["419"] = 342,["420"] = 365,["421"] = 366,["422"] = 367,["423"] = 368,["424"] = 369,["426"] = 372,["427"] = 373,["429"] = 363,["430"] = 377,["431"] = 378,["432"] = 378,["433"] = 378,["434"] = 378,["435"] = 378,["436"] = 379,["437"] = 379,["438"] = 379,["439"] = 380,["440"] = 381,["441"] = 384,["442"] = 385,["443"] = 386,["444"] = 388,["445"] = 389,["447"] = 379,["448"] = 379,["449"] = 377,["450"] = 395,["451"] = 396,["452"] = 395,["453"] = 399,["454"] = 400,["455"] = 399,["456"] = 403,["457"] = 404,["458"] = 405,["459"] = 405,["460"] = 405,["461"] = 405,["462"] = 405,["463"] = 405,["464"] = 406,["465"] = 403,["466"] = 409,["467"] = 410,["468"] = 411,["469"] = 411,["470"] = 411,["471"] = 411,["472"] = 411,["473"] = 411,["474"] = 412,["475"] = 409,["476"] = 415,["477"] = 416,["478"] = 417,["479"] = 418,["480"] = 419,["481"] = 419,["482"] = 419,["483"] = 420,["484"] = 421,["485"] = 422,["487"] = 427,["488"] = 419,["489"] = 419,["490"] = 430,["491"] = 431,["494"] = 438,["495"] = 439,["497"] = 442,["498"] = 443,["499"] = 444,["500"] = 415,["501"] = 448,["502"] = 449,["503"] = 450,["504"] = 451,["505"] = 448,["506"] = 454,["507"] = 455,["508"] = 456,["509"] = 457,["510"] = 458,["511"] = 460,["512"] = 463,["513"] = 454,["514"] = 466,["515"] = 467,["516"] = 467,["517"] = 467,["518"] = 470,["519"] = 470,["520"] = 470,["521"] = 470,["522"] = 470,["523"] = 470,["524"] = 470,["525"] = 466,["526"] = 473,["527"] = 474,["528"] = 474,["529"] = 474,["530"] = 474,["531"] = 474,["532"] = 474,["533"] = 476,["534"] = 477,["537"] = 481,["538"] = 481,["539"] = 481,["540"] = 481,["541"] = 486,["542"] = 487,["543"] = 487,["544"] = 487,["545"] = 487,["546"] = 487,["547"] = 487,["548"] = 487,["549"] = 473,["550"] = 490,["551"] = 491,["552"] = 493,["553"] = 494,["554"] = 495,["557"] = 499,["558"] = 499,["559"] = 499,["560"] = 499,["561"] = 504,["562"] = 505,["563"] = 505,["564"] = 505,["565"] = 505,["566"] = 505,["567"] = 505,["568"] = 505,["569"] = 490,["570"] = 508,["571"] = 509,["572"] = 511,["573"] = 512,["574"] = 513,["577"] = 517,["578"] = 517,["579"] = 517,["580"] = 517,["581"] = 522,["582"] = 523,["583"] = 523,["584"] = 523,["585"] = 523,["586"] = 523,["587"] = 523,["588"] = 523,["589"] = 508,["590"] = 526,["591"] = 527,["592"] = 529,["593"] = 530,["594"] = 531,["597"] = 535,["598"] = 535,["599"] = 535,["600"] = 535,["601"] = 540,["602"] = 541,["603"] = 541,["604"] = 541,["605"] = 541,["606"] = 541,["607"] = 541,["608"] = 541,["609"] = 526,["610"] = 544,["611"] = 545,["612"] = 545,["613"] = 545,["614"] = 545,["615"] = 547,["616"] = 548,["617"] = 549,["620"] = 553,["621"] = 553,["622"] = 553,["623"] = 553,["624"] = 558,["625"] = 559,["626"] = 559,["627"] = 559,["628"] = 559,["629"] = 559,["630"] = 559,["631"] = 559,["632"] = 544});
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
