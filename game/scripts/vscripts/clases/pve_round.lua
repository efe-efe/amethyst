--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 5,["15"] = 9,["16"] = 5,["17"] = 7,["18"] = 12,["19"] = 12,["20"] = 12,["21"] = 12,["22"] = 9,["23"] = 15,["24"] = 5,["25"] = 19,["26"] = 20,["27"] = 21,["29"] = 23,["32"] = 15,["33"] = 28,["34"] = 29,["35"] = 28,["36"] = 5,["37"] = 5});
local ____exports = {}
local ____boss = require("clases.boss")
local Queen = ____boss.Queen
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local PveRound = ____exports.default
    PveRound.name = "PveRound"
    __TS__ClassExtends(PveRound, GameState)
    function PveRound.prototype.____constructor(self, alliances, duration)
        GameState.prototype.____constructor(self, alliances, duration)
        self.helper = 3 * 30
        self.boss = __TS__New(
            Queen,
            Vector(150, 0, 128)
        )
    end
    function PveRound.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.boss then
            if self.helper == 0 then
                self.boss:Update()
            else
                self.helper = self.helper - 1
            end
        end
    end
    function PveRound.prototype.PveRound(self)
        GameRules.Addon:SetState(CustomGameState.NONE)
    end
    return PveRound
end)()
return ____exports
