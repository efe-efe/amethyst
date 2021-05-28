--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 5,["17"] = 6,["18"] = 10,["19"] = 5,["20"] = 12,["21"] = 13,["22"] = 13,["23"] = 13,["25"] = 15,["26"] = 16,["28"] = 10,["29"] = 20,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 22,["34"] = 23,["35"] = 24,["36"] = 25,["37"] = 26,["40"] = 22,["41"] = 22,["42"] = 31,["43"] = 32,["45"] = 20,["46"] = 36,["47"] = 37,["48"] = 36,["49"] = 5,["50"] = 5});
local ____exports = {}
local ____settings = require("settings")
local settings = ____settings.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local PreRun = ____exports.default
    PreRun.name = "PreRun"
    __TS__ClassExtends(PreRun, GameState)
    function PreRun.prototype.____constructor(self, alliances, duration)
        GameState.prototype.____constructor(self, alliances, duration)
    end
    function PreRun.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.time_remaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.time_remaining / 30)
            )
        end
        if self.time_remaining == 0 then
            self:End()
        end
    end
    function PreRun.prototype.OnAbilityLearned(self)
        local abilitiesReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local hero = player.hero
                if hero then
                    if hero:GetAbilityPoints() > 0 then
                        abilitiesReady = false
                    end
                end
            end
        )
        if abilitiesReady then
            self:SetDuration(settings.PreStageDuration)
        end
    end
    function PreRun.prototype.End(self)
        GameRules.Addon:SetState(CustomGameState.RUN_IN_PROGRESS)
    end
    return PreRun
end)()
return ____exports
