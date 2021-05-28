--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 10,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 10,["20"] = 16,["21"] = 10,["22"] = 14,["23"] = 18,["24"] = 19,["25"] = 20,["26"] = 23,["27"] = 23,["28"] = 23,["29"] = 24,["30"] = 25,["31"] = 26,["33"] = 23,["34"] = 23,["35"] = 16,["36"] = 32,["37"] = 33,["38"] = 34,["39"] = 37,["40"] = 32,["41"] = 40,["42"] = 10,["43"] = 42,["44"] = 43,["46"] = 45,["47"] = 46,["49"] = 48,["52"] = 40,["53"] = 53,["54"] = 54,["55"] = 53,["56"] = 57,["57"] = 58,["58"] = 59,["60"] = 57,["61"] = 63,["62"] = 64,["63"] = 65,["65"] = 63,["66"] = 69,["67"] = 70,["68"] = 71,["69"] = 72,["70"] = 69,["71"] = 75,["72"] = 76,["73"] = 75,["74"] = 10,["75"] = 10});
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
        CustomNetTables:SetTableValue(tableName, "stage", data)
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
    function Run.prototype.OnUnitHurt(self, unit)
        if self.stage then
            self.stage:OnUnitHurt(unit)
        end
    end
    function Run.prototype.OnUnitDies(self, unit)
        if self.stage then
            self.stage:OnUnitDies(unit)
        end
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
