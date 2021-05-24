--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 6,["11"] = 6,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 9,["16"] = 6,["17"] = 7,["18"] = 9,["19"] = 13,["20"] = 6,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 16,["26"] = 18,["27"] = 19,["29"] = 22,["30"] = 23,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 25,["35"] = 26,["37"] = 23,["38"] = 23,["39"] = 29,["41"] = 13,["42"] = 33,["43"] = 34,["44"] = 35,["45"] = 35,["46"] = 35,["47"] = 36,["48"] = 37,["49"] = 38,["50"] = 39,["53"] = 35,["54"] = 35,["55"] = 44,["56"] = 33,["57"] = 47,["58"] = 48,["59"] = 47,["60"] = 6,["61"] = 6});
local ____exports = {}
local ____settings = require("settings")
local settings = ____settings.default
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
        self.ready = false
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
        if self.ready and (self.time_remaining < 0) then
            __TS__ArrayForEach(
                self:GetAllPlayers(),
                function(____, player)
                    local customNpc = player.customNpc
                    if customNpc then
                        customNpc:RequestUpgrades()
                    end
                end
            )
            self:SetDuration(settings.PreLevelDuration)
        end
    end
    function PreLevel.prototype.OnAbilityLearned(self)
        local ready = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local hero = player.hero
                if hero then
                    if hero:GetAbilityPoints() > 0 then
                        ready = false
                    end
                end
            end
        )
        self.ready = ready
    end
    function PreLevel.prototype.EndPreLevel(self)
        GameRules.Addon:SetState(CustomGameState.LEVEL_IN_PROGRESS)
    end
    return PreLevel
end)()
return ____exports
