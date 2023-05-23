local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 5,["13"] = 7,["14"] = 5,["15"] = 9,["16"] = 10,["17"] = 11,["18"] = 9,["19"] = 14,["20"] = 15,["21"] = 14,["22"] = 18,["23"] = 19,["24"] = 20,["25"] = 18,["26"] = 23,["27"] = 24,["28"] = 23});
local ____exports = {}
local ____custom_items = require("util.custom_items")
local CustomItems = ____custom_items.CustomItems
local customItems = CustomItems:GetInstance()
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
    UTIL_Remove(self:GetItem())
    self.picked = true
end
function Item.prototype.Alive(self)
    return not self.picked
end
return ____exports
