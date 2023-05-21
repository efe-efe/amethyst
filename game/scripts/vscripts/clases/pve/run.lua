--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 10,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 10,["20"] = 16,["21"] = 10,["22"] = 14,["23"] = 18,["24"] = 19,["25"] = 20,["26"] = 22,["27"] = 22,["28"] = 22,["29"] = 23,["30"] = 24,["31"] = 25,["33"] = 22,["34"] = 22,["35"] = 16,["36"] = 30,["37"] = 31,["38"] = 32,["39"] = 35,["40"] = 30,["41"] = 38,["42"] = 10,["43"] = 40,["44"] = 41,["46"] = 43,["47"] = 44,["49"] = 46,["52"] = 38,["53"] = 51,["54"] = 52,["55"] = 51,["56"] = 55,["57"] = 56,["58"] = 57,["59"] = 58,["60"] = 55,["61"] = 61,["62"] = 62,["63"] = 61,["64"] = 10,["65"] = 10});
local ____exports = {}
local ____rewards = require("rewards.rewards")
local Rewards = ____rewards.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
local ____stage = require("clases.pve.stage")
local Stage = ____stage.default
local RunStates = RunStates or ({})
RunStates.ROOM = 0
RunStates[RunStates.ROOM] = "ROOM"
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Run = ____exports.default
    Run.name = "Run"
    __TS__ClassExtends(Run, GameState)
    function Run.prototype.____constructor(self, alliances, stagesData)
        GameState.prototype.____constructor(self, alliances, -1)
        self.currentStage = 0
        self.alliances = alliances
        self.stagesData = stagesData
        self:SendDataToClient()
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:SelectReward(Rewards[1])
                end
            end
        )
    end
    function Run.prototype.SendDataToClient(self)
        local tableName = "main"
        local data = {currentStage = self.currentStage + 1}
        CustomNetTables:SetTableValue(tableName, "pve", data)
    end
    function Run.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.stage then
            self.stage:Update()
        else
            if self.stagesData[self.currentStage + 1] then
                self.stage = self:GenerateStage(self.stagesData[self.currentStage + 1])
            else
                self:End()
            end
        end
    end
    function Run.prototype.GenerateStage(self, stageData)
        return __TS__New(Stage, self.alliances, stageData, self)
    end
    function Run.prototype.OnStageEnd(self)
        self.currentStage = self.currentStage + 1
        self.stage = nil
        self:SendDataToClient()
    end
    function Run.prototype.End(self)
        GameRules.Addon:SetState(CustomGameState.POST_RUN)
    end
    return Run
end)()
return ____exports
