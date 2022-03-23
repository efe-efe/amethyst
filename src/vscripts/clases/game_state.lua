--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 4,["6"] = 5,["7"] = 5,["8"] = 6,["9"] = 6,["10"] = 7,["11"] = 7,["12"] = 8,["13"] = 8,["14"] = 9,["15"] = 9,["16"] = 10,["17"] = 10,["18"] = 11,["19"] = 11,["20"] = 12,["21"] = 12,["22"] = 15,["23"] = 15,["24"] = 15,["25"] = 15,["26"] = 20,["27"] = 21,["28"] = 22,["29"] = 23,["30"] = 20,["31"] = 26,["32"] = 27,["33"] = 28,["35"] = 26,["36"] = 32,["37"] = 33,["38"] = 34,["39"] = 35,["40"] = 35,["41"] = 35,["42"] = 36,["43"] = 36,["44"] = 36,["45"] = 37,["46"] = 36,["47"] = 36,["48"] = 35,["49"] = 35,["51"] = 42,["52"] = 32,["53"] = 45,["54"] = 46,["55"] = 45,["56"] = 49,["57"] = 50,["58"] = 49,["59"] = 53,["60"] = 54,["61"] = 55,["62"] = 56,["63"] = 57,["64"] = 58,["65"] = 59,["66"] = 60,["67"] = 67,["68"] = 53,["69"] = 15,["70"] = 15});
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
