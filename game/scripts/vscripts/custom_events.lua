local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 6,["10"] = 6,["11"] = 6,["13"] = 8,["14"] = 10,["15"] = 14,["16"] = 15,["17"] = 16,["19"] = 19,["20"] = 14,["21"] = 22,["22"] = 23,["23"] = 23,["24"] = 22,["25"] = 29,["26"] = 30,["27"] = 30,["28"] = 30,["29"] = 30,["30"] = 31,["31"] = 31,["32"] = 31,["33"] = 32,["34"] = 31,["35"] = 31,["36"] = 29});
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
    local ____self_listeners_0 = self.listeners
    ____self_listeners_0[#____self_listeners_0 + 1] = {eventName = eventName, callback = callback}
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
