--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 3,["8"] = 3,["9"] = 11,["10"] = 6,["11"] = 7,["12"] = 8,["13"] = 9,["14"] = 12,["15"] = 13,["16"] = 11,["17"] = 16,["18"] = 17,["19"] = 18,["20"] = 16,["21"] = 21,["22"] = 22,["23"] = 21,["24"] = 25,["25"] = 26,["26"] = 25,["27"] = 29,["28"] = 30,["29"] = 29,["30"] = 33,["31"] = 34,["32"] = 33,["33"] = 37,["34"] = 38,["35"] = 37,["36"] = 3,["37"] = 3});
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Player = ____exports.default
    Player.name = "Player"
    function Player.prototype.____constructor(self, id, userid)
        self.hero = nil
        self.alliance = nil
        self.team = DOTA_TEAM_NOTEAM
        self.cursor_position = Vector(0, 0, 0)
        self.id = id
        self.userid = userid
    end
    function Player.prototype.SetHero(self, hero)
        self.hero = hero
        CustomEntitiesLegacy:SendDataToClient(hero)
    end
    function Player.prototype.GetId(self)
        return self.id
    end
    function Player.prototype.GetCursorPosition(self)
        return self.cursor_position
    end
    function Player.prototype.SetTeam(self, team)
        self.team = team
    end
    function Player.prototype.SetAlliance(self, alliance)
        self.alliance = alliance
    end
    function Player.prototype.UpdateCursorPosition(self, position)
        self.cursor_position = position
    end
    return Player
end)()
return ____exports
