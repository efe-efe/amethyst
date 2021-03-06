--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 1,["14"] = 10,["15"] = 11,["16"] = 1,["17"] = 13,["18"] = 14,["19"] = 1,["20"] = 16,["21"] = 17,["22"] = 1,["23"] = 19,["24"] = 20,["25"] = 1,["26"] = 22,["27"] = 23,["28"] = 1,["29"] = 25,["30"] = 26,["31"] = 1,["32"] = 28,["33"] = 29,["34"] = 1,["35"] = 31,["36"] = 32,["37"] = 1,["38"] = 34,["39"] = 35,["40"] = 36,["41"] = 37,["43"] = 40,["44"] = 41,["45"] = 41,["46"] = 41,["47"] = 41,["49"] = 43,["50"] = 43,["51"] = 44,["52"] = 45,["53"] = 46,["54"] = 47,["55"] = 47,["56"] = 47,["57"] = 47,["58"] = 43,["61"] = 49,["62"] = 1,["63"] = 1,["64"] = 53});
local ____exports = {}
local Math = {
    EAST = Vector(1, 0, 0),
    WEST = Vector(-1, 0, 0),
    NORTH = Vector(0, 1, 0),
    SOUTH = Vector(0, -1, 0),
    NORTH_EAST = Vector(1, 1, 0):Normalized(),
    NORTH_WEST = Vector(-1, 1, 0):Normalized(),
    SOUTH_EAST = Vector(1, -1, 0):Normalized(),
    SOUTH_WEST = Vector(-1, -1, 0):Normalized(),
    IsEast = function(self, angle)
        return (angle > 345) or (angle <= 15)
    end,
    IsNorthEast = function(self, angle)
        return (angle > 15) and (angle <= 75)
    end,
    IsNorth = function(self, angle)
        return (angle > 75) and (angle <= 105)
    end,
    IsNorthWest = function(self, angle)
        return (angle > 105) and (angle <= 165)
    end,
    IsWest = function(self, angle)
        return (angle > 165) and (angle <= 195)
    end,
    IsSouthWest = function(self, angle)
        return (angle > 195) and (angle <= 255)
    end,
    IsSouth = function(self, angle)
        return (angle > 255) and (angle <= 285)
    end,
    IsSouthEast = function(self, angle)
        return (angle > 285) and (angle <= 345)
    end,
    GetRandomElementsFromArray = function(self, array, amount)
        if amount > #array then
            print("GetRandomElementsFromArray ERROR: array lenght is smaller than amount requested")
            return {}
        end
        local result = {}
        local available = __TS__ArrayMap(
            array,
            function(____, e) return e end
        )
        do
            local i = 0
            while i < amount do
                local x = RandomInt(0, #available - 1)
                local element = available[x + 1]
                __TS__ArrayPush(result, element)
                available = __TS__ArrayFilter(
                    available,
                    function(____, e) return e ~= element end
                )
                i = i + 1
            end
        end
        return result
    end
}
____exports.default = Math
return ____exports
