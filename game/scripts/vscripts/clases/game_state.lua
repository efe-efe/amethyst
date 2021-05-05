--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 4,["6"] = 5,["7"] = 5,["8"] = 6,["9"] = 6,["10"] = 7,["11"] = 7,["12"] = 8,["13"] = 8,["14"] = 9,["15"] = 9,["16"] = 10,["17"] = 10,["18"] = 11,["19"] = 11,["20"] = 14,["21"] = 14,["22"] = 14,["23"] = 14,["24"] = 19,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 19,["29"] = 25,["30"] = 26,["31"] = 27,["33"] = 25,["34"] = 31,["35"] = 32,["36"] = 33,["37"] = 34,["38"] = 34,["39"] = 34,["40"] = 35,["41"] = 35,["42"] = 35,["43"] = 36,["44"] = 35,["45"] = 35,["46"] = 34,["47"] = 34,["49"] = 41,["50"] = 31,["51"] = 44,["52"] = 45,["53"] = 44,["54"] = 48,["55"] = 49,["56"] = 48,["57"] = 52,["58"] = 53,["59"] = 54,["60"] = 55,["61"] = 56,["62"] = 57,["63"] = 58,["64"] = 59,["65"] = 66,["66"] = 52,["67"] = 14,["68"] = 14});
local ____exports = {}
____exports.CustomGameState = {}
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
____exports.CustomGameState.PRE_WAVE = 5
____exports.CustomGameState[____exports.CustomGameState.PRE_WAVE] = "PRE_WAVE"
____exports.CustomGameState.WAVE_IN_PROGRESS = 6
____exports.CustomGameState[____exports.CustomGameState.WAVE_IN_PROGRESS] = "WAVE_IN_PROGRESS"
____exports.default = (function()
    ____exports.default = __TS__Class()
    local GameState = ____exports.default
    GameState.name = "GameState"
    function GameState.prototype.____constructor(self, alliances, duration)
        self.alliances = alliances
        self.time_remaining = duration * 30
        self.max_duration = duration
    end
    function GameState.prototype.Update(self)
        if self.time_remaining > 0 then
            self.time_remaining = self.time_remaining - 1
        end
    end
    function GameState.prototype.GetAllPlayers(self)
        local players = {}
        if self.alliances then
            __TS__ArrayForEach(
                self.alliances,
                function(____, alliance)
                    __TS__ArrayForEach(
                        alliance.players,
                        function(____, player)
                            __TS__ArrayPush(players, player)
                        end
                    )
                end
            )
        end
        return players
    end
    function GameState.prototype.GetDuration(self)
        return math.floor(self.time_remaining / 30)
    end
    function GameState.prototype.SetDuration(self, duration)
        self.time_remaining = duration * 30
    end
    function GameState.prototype.UpdateGameTimer(self, time)
        local minutes = math.floor(time / 60)
        local seconds = time - (minutes * 60)
        local m10 = math.floor(minutes / 10)
        local m01 = minutes - (m10 * 10)
        local s10 = math.floor(seconds / 10)
        local s01 = seconds - (s10 * 10)
        local broadcast_gametimer = {timer_minute_10 = m10, timer_minute_01 = m01, timer_second_10 = s10, timer_second_01 = s01}
        CustomGameEventManager:Send_ServerToAllClients("countdown", broadcast_gametimer)
    end
    return GameState
end)()
return ____exports
