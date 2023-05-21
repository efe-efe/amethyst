--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 4,["7"] = 5,["9"] = 8,["10"] = 11,["11"] = 12,["12"] = 13,["14"] = 16,["15"] = 17,["16"] = 8});
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
