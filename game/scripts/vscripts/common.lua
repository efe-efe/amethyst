local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 8,["15"] = 6,["16"] = 11,["17"] = 12,["18"] = 13,["19"] = 14,["20"] = 15,["21"] = 16,["22"] = 17,["23"] = 18,["24"] = 20,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 21,["30"] = 21,["31"] = 21,["32"] = 22,["33"] = 22,["34"] = 22,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 23,["41"] = 23,["42"] = 23,["43"] = 23,["44"] = 23,["45"] = 23,["46"] = 23,["48"] = 26,["49"] = 27,["50"] = 28,["52"] = 31,["53"] = 32,["55"] = 35,["56"] = 36,["57"] = 37,["59"] = 40,["60"] = 41,["61"] = 41,["62"] = 41,["63"] = 41,["64"] = 41,["65"] = 41,["66"] = 41,["67"] = 41,["68"] = 41,["69"] = 41,["70"] = 41,["71"] = 41,["72"] = 41,["73"] = 41,["74"] = 53,["75"] = 53,["76"] = 53,["77"] = 53,["78"] = 54,["81"] = 62,["82"] = 63,["83"] = 11,["84"] = 66,["85"] = 67,["86"] = 68,["87"] = 75,["88"] = 76,["89"] = 78,["90"] = 79,["91"] = 81,["95"] = 87,["96"] = 87,["97"] = 88,["98"] = 89,["99"] = 90,["102"] = 87,["106"] = 97,["107"] = 101,["110"] = 104,["113"] = 112,["114"] = 113,["115"] = 113,["116"] = 113,["117"] = 113,["118"] = 115,["119"] = 116,["120"] = 117,["121"] = 117,["122"] = 117,["123"] = 117,["124"] = 117,["125"] = 117,["126"] = 117,["127"] = 124,["128"] = 124,["129"] = 124,["130"] = 124,["131"] = 124,["132"] = 124,["133"] = 124,["136"] = 5});
local ____exports = {}
local ____game = require("game")
local findPlayerById = ____game.findPlayerById
local ____util = require("util")
local canUnitWalk = ____util.canUnitWalk
local fullyFaceTowards = ____util.fullyFaceTowards
function ____exports.updateMovement(self, entity)
    local function isAnimating(self, entity)
        return false
    end
    local function moveEntity(self, entity, direction, speed)
        local offset = 70
        local unit = entity.handle
        local origin = unit:GetAbsOrigin()
        local futureOrigin = origin:__add(direction:__mul(speed))
        local testOrigin = futureOrigin:__add(direction:__mul(offset))
        futureOrigin.z = GetGroundPosition(futureOrigin, unit).z
        local normal = CustomEntitiesLegacy:GetNormal(unit, futureOrigin)
        if IsInToolsMode() then
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
        if unit:HasModifier("modifier_spectre_special_attack_buff") then
            unit:SetAbsOrigin(futureOrigin)
            return "success"
        end
        if normal.z <= 0.9 then
            return "wall"
        end
        local trees = GridNav:GetAllTreesAroundPoint(testOrigin, 5, true)
        if #trees > 0 then
            return "tree"
        end
        if not unit:IsPhased() then
            local units = __TS__ArrayFilter(
                FindUnitsInRadius(
                    unit:GetTeamNumber(),
                    testOrigin,
                    nil,
                    5,
                    3,
                    55,
                    0,
                    0,
                    false
                ),
                function(____, collisionUnit) return collisionUnit ~= unit end
            )
            if __TS__ArraySome(
                units,
                function(____, unit) return not unit:IsPhased() end
            ) then
                return "unit"
            end
        end
        unit:SetAbsOrigin(futureOrigin)
        return "success"
    end
    local direction = entity.direction
    local unit = entity.handle
    local speed = unit:GetIdealSpeed() / 25
    if (direction.x ~= 0 or direction.y ~= 0) and canUnitWalk(nil, unit) then
        local output = moveEntity(nil, entity, direction, speed)
        if output ~= "success" then
            local alternativeDirections = {}
            if output == "wall" then
            else
            end
            do
                local i = 0
                while i < #alternativeDirections do
                    local alternativeDireaction = alternativeDirections[i + 1]
                    local newOutput = moveEntity(nil, entity, alternativeDireaction, speed * 0.8)
                    if newOutput == "success" then
                        break
                    end
                    i = i + 1
                end
            end
        end
        if not unit:HasModifier("modifier_casting") and not unit:HasModifier("modifier_mars_counter_countering") and not unit:HasModifier("modifier_spectre_counter_countering") then
            fullyFaceTowards(nil, unit, direction)
        end
    else
        if unit:GetUnitName() == "npc_dota_dire_tower" then
        end
    end
    if IsInToolsMode() and unit:IsRealHero() then
        local player = findPlayerById(
            nil,
            unit:GetPlayerID()
        )
        if player then
            local mouse = player.cursorPosition
            DebugDrawLine_vCol(
                unit:GetAbsOrigin(),
                unit:GetAbsOrigin():__add(unit:GetForwardVector():__mul(500)),
                Vector(0, 0, 255),
                true,
                0.03
            )
            DebugDrawLine_vCol(
                unit:GetAbsOrigin(),
                mouse,
                Vector(0, 255, 0),
                true,
                0.03
            )
        end
    end
end
return ____exports
