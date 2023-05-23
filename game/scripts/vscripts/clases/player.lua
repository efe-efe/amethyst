local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 4,["7"] = 4,["8"] = 4,["9"] = 13,["10"] = 7,["11"] = 8,["12"] = 9,["13"] = 10,["14"] = 11,["15"] = 14,["16"] = 15,["17"] = 13,["18"] = 18,["19"] = 19,["20"] = 20,["21"] = 18,["22"] = 23,["23"] = 24,["24"] = 23,["25"] = 27,["26"] = 28,["27"] = 27,["28"] = 31,["29"] = 32,["30"] = 31,["31"] = 35,["32"] = 36,["33"] = 35,["34"] = 39,["35"] = 40,["36"] = 39,["37"] = 43,["38"] = 44,["39"] = 43});
local ____exports = {}
____exports.default = __TS__Class()
local Player = ____exports.default
Player.name = "Player"
function Player.prototype.____constructor(self, id, userid)
    self.hero = nil
    self.alliance = nil
    self.customNpc = nil
    self.team = DOTA_TEAM_NOTEAM
    self.cursorPosition = Vector(0, 0, 0)
    self.id = id
    self.userid = userid
end
function Player.prototype.SetHero(self, hero)
    self.hero = hero
    CustomEntitiesLegacy:SendDataToClient(hero)
end
function Player.prototype.SetCustomNPC(self, customNpc)
    self.customNpc = customNpc
end
function Player.prototype.GetId(self)
    return self.id
end
function Player.prototype.GetCursorPosition(self)
    return self.cursorPosition
end
function Player.prototype.SetTeam(self, team)
    self.team = team
end
function Player.prototype.SetAlliance(self, alliance)
    self.alliance = alliance
end
function Player.prototype.UpdateCursorPosition(self, position)
    self.cursorPosition = position
end
return ____exports
