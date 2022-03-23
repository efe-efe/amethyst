--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 6,["6"] = 6,["7"] = 6,["9"] = 8,["10"] = 10,["11"] = 14,["12"] = 15,["13"] = 16,["15"] = 19,["16"] = 14,["17"] = 22,["18"] = 23,["19"] = 22,["20"] = 29,["21"] = 30,["22"] = 30,["23"] = 30,["24"] = 30,["25"] = 31,["26"] = 31,["27"] = 31,["28"] = 32,["29"] = 31,["30"] = 31,["31"] = 29});
local ____exports = {}
____exports.CustomEvents = __TS__Class()
local CustomEvents = ____exports.CustomEvents
CustomEvents.name = "CustomEvents"
function CustomEvents.prototype.____constructor(self)
    self.listeners = {}
end
function CustomEvents.GetInstance(self)
    if not ____exports.CustomEvents.instance then
        ____exports.CustomEvents.instance = __TS__New(____exports.CustomEvents)
    end
    return ____exports.CustomEvents.instance
end
function CustomEvents.prototype.RegisterListener(self, eventName, callback)
    __TS__ArrayPush(self.listeners, {eventName = eventName, callback = callback})
end
function CustomEvents.prototype.EmitEvent(self, eventName, event)
    local listeners = __TS__ArrayFilter(
        self.listeners,
        function(____, listener) return listener.eventName == eventName end
    )
    __TS__ArrayForEach(
        listeners,
        function(____, listener)
            listener:callback(event)
        end
    )
end
return ____exports
