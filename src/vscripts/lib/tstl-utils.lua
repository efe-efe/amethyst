--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 3,["9"] = 6,["10"] = 7,["11"] = 8,["12"] = 9,["14"] = 12,["15"] = 13,["16"] = 6});
local ____exports = {}
local global = _G
if global.reloadCache == nil then
    global.reloadCache = {}
end
function ____exports.reloadable(self, constructor)
    local className = constructor.name
    if global.reloadCache[className] == nil then
        global.reloadCache[className] = constructor
    end
    __TS__ObjectAssign(global.reloadCache[className].prototype, constructor.prototype)
    return global.reloadCache[className]
end
return ____exports
