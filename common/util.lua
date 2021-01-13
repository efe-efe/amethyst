--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 3,["8"] = 1,["9"] = 1});
local ____exports = {}
____exports.Math = {
    Clamp = function(self, number, minimum, maximum)
        return ((number <= minimum) and minimum) or (((number >= maximum) and maximum) or number)
    end
}
return ____exports
