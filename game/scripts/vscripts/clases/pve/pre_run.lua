local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 5,["14"] = 5,["15"] = 5,["16"] = 5,["17"] = 6,["18"] = 5,["19"] = 9,["20"] = 6,["21"] = 12,["22"] = 5,["23"] = 14,["24"] = 15,["26"] = 17,["27"] = 18,["29"] = 12,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 26,["37"] = 27,["38"] = 28,["41"] = 24,["42"] = 24,["43"] = 33,["44"] = 34,["46"] = 22,["47"] = 38,["48"] = 39,["49"] = 38});
local ____exports = {}
local ____settings = require("settings")
local settings = ____settings.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
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
        self:UpdateGameTimer(math.floor(self.timeRemaining / 30))
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
return ____exports
