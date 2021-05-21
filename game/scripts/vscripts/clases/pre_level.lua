--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 5,["9"] = 5,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 6,["16"] = 10,["17"] = 5,["18"] = 12,["19"] = 13,["20"] = 13,["21"] = 13,["23"] = 15,["24"] = 16,["26"] = 10,["27"] = 20,["28"] = 21,["29"] = 20,["30"] = 5,["31"] = 5});
local ____exports = {}
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local PreLevel = ____exports.default
    PreLevel.name = "PreLevel"
    __TS__ClassExtends(PreLevel, GameState)
    function PreLevel.prototype.____constructor(self, alliances, duration)
        GameState.prototype.____constructor(self, alliances, duration)
    end
    function PreLevel.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.time_remaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.time_remaining / 30)
            )
        end
        if self.time_remaining == 0 then
            self:EndPreLevel()
        end
    end
    function PreLevel.prototype.EndPreLevel(self)
        GameRules.Addon:SetState(CustomGameState.LEVEL_IN_PROGRESS)
    end
    return PreLevel
end)()
return ____exports
