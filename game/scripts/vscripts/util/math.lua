local ____lualib = require("lualib_bundle")
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 10,["17"] = 11,["18"] = 1,["19"] = 13,["20"] = 14,["21"] = 1,["22"] = 16,["23"] = 17,["24"] = 1,["25"] = 19,["26"] = 20,["27"] = 1,["28"] = 22,["29"] = 23,["30"] = 1,["31"] = 25,["32"] = 26,["33"] = 1,["34"] = 28,["35"] = 29,["36"] = 1,["37"] = 31,["38"] = 32,["39"] = 1,["40"] = 34,["41"] = 35,["42"] = 36,["43"] = 37,["45"] = 40,["46"] = 41,["47"] = 41,["48"] = 41,["49"] = 41,["51"] = 43,["52"] = 43,["53"] = 44,["54"] = 45,["55"] = 46,["56"] = 47,["57"] = 47,["58"] = 47,["59"] = 47,["60"] = 43,["63"] = 49,["64"] = 1,["65"] = 1,["66"] = 53});
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
        return angle > 345 or angle <= 15
    end,
    IsNorthEast = function(self, angle)
        return angle > 15 and angle <= 75
    end,
    IsNorth = function(self, angle)
        return angle > 75 and angle <= 105
    end,
    IsNorthWest = function(self, angle)
        return angle > 105 and angle <= 165
    end,
    IsWest = function(self, angle)
        return angle > 165 and angle <= 195
    end,
    IsSouthWest = function(self, angle)
        return angle > 195 and angle <= 255
    end,
    IsSouth = function(self, angle)
        return angle > 255 and angle <= 285
    end,
    IsSouthEast = function(self, angle)
        return angle > 285 and angle <= 345
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
                result[#result + 1] = element
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
