local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 3,["9"] = 3,["10"] = 3,["12"] = 5,["13"] = 7,["14"] = 11,["15"] = 12,["16"] = 13,["18"] = 16,["19"] = 11,["20"] = 19,["21"] = 20,["22"] = 20,["23"] = 20,["24"] = 20,["25"] = 19,["26"] = 23,["27"] = 24,["28"] = 24,["29"] = 23});
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
    local ____self_items_0 = self.items
    ____self_items_0[#____self_items_0 + 1] = item
end
return ____exports
