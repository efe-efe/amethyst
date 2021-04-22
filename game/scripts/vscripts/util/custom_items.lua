--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 3,["9"] = 5,["10"] = 7,["11"] = 11,["12"] = 12,["13"] = 13,["15"] = 16,["16"] = 11,["17"] = 19,["18"] = 20,["19"] = 20,["20"] = 20,["21"] = 20,["22"] = 19,["23"] = 23,["24"] = 24,["25"] = 23});
local ____exports = {}
____exports.CustomItems = __TS__Class()
local CustomItems = ____exports.CustomItems
CustomItems.name = "CustomItems"
function CustomItems.prototype.____constructor(self)
    self.items = {}
end
function CustomItems.GetInstance(self)
    if not ____exports.CustomItems.instance then
        ____exports.CustomItems.instance = __TS__New(____exports.CustomItems)
    end
    return ____exports.CustomItems.instance
end
function CustomItems.prototype.GetParent(self, item)
    return __TS__ArrayFilter(
        self.items,
        function(____, _item) return _item:GetItem() == item end
    )[1]
end
function CustomItems.prototype.AddItem(self, item)
    __TS__ArrayPush(self.items, item)
end
return ____exports
