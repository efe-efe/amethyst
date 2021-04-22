--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 4,["6"] = 5,["7"] = 5,["8"] = 6,["9"] = 6,["10"] = 7,["11"] = 7,["12"] = 8,["13"] = 8,["14"] = 9,["15"] = 9,["16"] = 10,["17"] = 10,["18"] = 13,["19"] = 13,["20"] = 13,["21"] = 13,["22"] = 18,["23"] = 19,["24"] = 20,["25"] = 21,["26"] = 18,["27"] = 24,["28"] = 25,["29"] = 26,["31"] = 24,["32"] = 30,["33"] = 31,["34"] = 32,["35"] = 33,["36"] = 33,["37"] = 33,["38"] = 34,["39"] = 34,["40"] = 34,["41"] = 35,["42"] = 34,["43"] = 34,["44"] = 33,["45"] = 33,["47"] = 40,["48"] = 30,["49"] = 43,["50"] = 44,["51"] = 43,["52"] = 47,["53"] = 48,["54"] = 47,["55"] = 51,["56"] = 52,["57"] = 53,["58"] = 54,["59"] = 55,["60"] = 56,["61"] = 57,["62"] = 58,["63"] = 65,["64"] = 51,["65"] = 13,["66"] = 13});
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
____exports.CustomGameState.PVE_ROUND_IN_PROGRESS = 5
____exports.CustomGameState[____exports.CustomGameState.PVE_ROUND_IN_PROGRESS] = "PVE_ROUND_IN_PROGRESS"
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
