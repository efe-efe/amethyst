local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 4,["8"] = 5,["9"] = 5,["10"] = 6,["11"] = 6,["12"] = 7,["13"] = 7,["14"] = 8,["15"] = 8,["16"] = 9,["17"] = 9,["18"] = 10,["19"] = 10,["20"] = 11,["21"] = 11,["22"] = 12,["23"] = 12,["24"] = 15,["25"] = 15,["26"] = 15,["27"] = 20,["28"] = 21,["29"] = 22,["30"] = 23,["31"] = 20,["32"] = 26,["33"] = 27,["34"] = 28,["36"] = 26,["37"] = 32,["38"] = 33,["39"] = 35,["40"] = 35,["41"] = 35,["42"] = 36,["43"] = 36,["44"] = 36,["45"] = 37,["46"] = 36,["47"] = 36,["48"] = 35,["49"] = 35,["50"] = 41,["51"] = 32,["52"] = 44,["53"] = 45,["54"] = 44,["55"] = 48,["56"] = 49,["57"] = 48,["58"] = 52,["59"] = 53,["60"] = 54,["61"] = 55,["62"] = 56,["63"] = 57,["64"] = 58,["65"] = 59,["66"] = 66,["67"] = 52});
local ____exports = {}
____exports.CustomGameState = CustomGameState or ({})
____exports.CustomGameState.NONE = 0
____exports.CustomGameState[____exports.CustomGameState.NONE] = "NONE"
____exports.CustomGameState.PRE_WARMUP = 1
____exports.CustomGameState[____exports.CustomGameState.PRE_WARMUP] = "PRE_WARMUP"
____exports.CustomGameState.WARMUP_IN_PROGRESS = 2
____exports.CustomGameState[____exports.CustomGameState.WARMUP_IN_PROGRESS] = "WARMUP_IN_PROGRESS"
____exports.CustomGameState.PRE_ROUND = 3
____exports.CustomGameState[____exports.CustomGameState.PRE_ROUND] = "PRE_ROUND"
____exports.CustomGameState.ROUND_IN_PROGRESS = 4
____exports.CustomGameState[____exports.CustomGameState.ROUND_IN_PROGRESS] = "ROUND_IN_PROGRESS"
____exports.CustomGameState.PRE_RUN = 5
____exports.CustomGameState[____exports.CustomGameState.PRE_RUN] = "PRE_RUN"
____exports.CustomGameState.RUN_IN_PROGRESS = 6
____exports.CustomGameState[____exports.CustomGameState.RUN_IN_PROGRESS] = "RUN_IN_PROGRESS"
____exports.CustomGameState.POST_RUN = 7
____exports.CustomGameState[____exports.CustomGameState.POST_RUN] = "POST_RUN"
____exports.default = __TS__Class()
local GameState = ____exports.default
GameState.name = "GameState"
function GameState.prototype.____constructor(self, alliances, duration)
    self.alliances = alliances
    self.timeRemaining = duration * 30
    self.infinite = duration == -1
end
function GameState.prototype.Update(self)
    if self.timeRemaining > 0 then
        self.timeRemaining = self.timeRemaining - 1
    end
end
function GameState.prototype.GetAllPlayers(self)
    local players = {}
    __TS__ArrayForEach(
        self.alliances,
        function(____, alliance)
            __TS__ArrayForEach(
                alliance.players,
                function(____, player)
                    players[#players + 1] = player
                end
            )
        end
    )
    return players
end
function GameState.prototype.GetDuration(self)
    return math.floor(self.timeRemaining / 30)
end
function GameState.prototype.SetDuration(self, duration)
    self.timeRemaining = duration * 30
end
function GameState.prototype.UpdateGameTimer(self, time)
    local minutes = math.floor(time / 60)
    local seconds = time - minutes * 60
    local m10 = math.floor(minutes / 10)
    local m01 = minutes - m10 * 10
    local s10 = math.floor(seconds / 10)
    local s01 = seconds - s10 * 10
    local broadcast_gametimer = {timer_minute_10 = m10, timer_minute_01 = m01, timer_second_10 = s10, timer_second_01 = s01}
    CustomGameEventManager:Send_ServerToAllClients("countdown", broadcast_gametimer)
end
return ____exports
