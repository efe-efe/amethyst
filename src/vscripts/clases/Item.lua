--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 5,["9"] = 5,["10"] = 5,["11"] = 5,["13"] = 7,["14"] = 5,["15"] = 9,["16"] = 10,["17"] = 11,["18"] = 9,["19"] = 14,["20"] = 15,["21"] = 14,["22"] = 18,["23"] = 19,["24"] = 19,["25"] = 19,["26"] = 20,["27"] = 18,["28"] = 23,["29"] = 24,["30"] = 23,["31"] = 5,["32"] = 5});
local ____exports = {}
local ____custom_items = require("util.custom_items")
local CustomItems = ____custom_items.CustomItems
local customItems = CustomItems:GetInstance()
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Item = ____exports.default
    Item.name = "Item"
    function Item.prototype.____constructor(self)
        self.picked = false
    end
    function Item.prototype.SetItem(self, item)
        self.item = item
        customItems:AddItem(self)
    end
    function Item.prototype.GetItem(self)
        return self.item
    end
    function Item.prototype.OnPickedUp(self)
        UTIL_Remove(
            self:GetItem()
        )
        self.picked = true
    end
    function Item.prototype.Alive(self)
        return not self.picked
    end
    return Item
end)()
return ____exports
