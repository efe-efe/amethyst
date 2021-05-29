--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 5,["17"] = 8,["18"] = 8,["19"] = 8,["20"] = 8,["21"] = 8,["22"] = 6,["23"] = 11,["24"] = 5,["25"] = 13,["26"] = 14,["27"] = 14,["28"] = 14,["30"] = 16,["31"] = 17,["33"] = 11,["34"] = 21,["35"] = 22,["36"] = 23,["37"] = 23,["38"] = 23,["39"] = 24,["40"] = 25,["41"] = 26,["42"] = 27,["45"] = 23,["46"] = 23,["47"] = 32,["48"] = 33,["50"] = 21,["51"] = 37,["52"] = 38,["53"] = 37,["54"] = 5,["55"] = 5});
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
        ListenToGameEvent(
            "dota_player_learned_ability",
            function() return self:OnAbilityLearned() end,
            nil
        )
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