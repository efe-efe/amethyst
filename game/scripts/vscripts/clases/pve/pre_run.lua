--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 5,["17"] = 9,["18"] = 6,["19"] = 12,["20"] = 5,["21"] = 14,["22"] = 15,["23"] = 15,["24"] = 15,["26"] = 17,["27"] = 18,["29"] = 12,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 26,["37"] = 27,["38"] = 28,["41"] = 24,["42"] = 24,["43"] = 33,["44"] = 34,["46"] = 22,["47"] = 38,["48"] = 39,["49"] = 38,["50"] = 5,["51"] = 5});
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
        self:SetDuration(settings.PreStageDuration)
    end
    function PreRun.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.timeRemaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.timeRemaining / 30)
            )
        end
        if self.timeRemaining == 0 then
            self:End()
        end
    end
    function PreRun.prototype.OnLearnedAbilityEvent(self)
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
