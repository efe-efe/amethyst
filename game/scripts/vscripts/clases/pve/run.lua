local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 1,["10"] = 1,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 6,["17"] = 6,["18"] = 6,["19"] = 10,["20"] = 10,["21"] = 10,["22"] = 10,["23"] = 16,["24"] = 10,["25"] = 14,["26"] = 18,["27"] = 19,["28"] = 20,["29"] = 22,["30"] = 22,["31"] = 22,["32"] = 23,["33"] = 24,["34"] = 25,["36"] = 22,["37"] = 22,["38"] = 16,["39"] = 30,["40"] = 31,["41"] = 32,["42"] = 35,["43"] = 30,["44"] = 38,["45"] = 10,["46"] = 40,["47"] = 41,["49"] = 43,["50"] = 44,["52"] = 46,["55"] = 38,["56"] = 51,["57"] = 52,["58"] = 51,["59"] = 55,["60"] = 56,["61"] = 57,["62"] = 58,["63"] = 55,["64"] = 61,["65"] = 62,["66"] = 61});
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
return ____exports
