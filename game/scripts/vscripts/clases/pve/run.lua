--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 9,["14"] = 9,["15"] = 9,["16"] = 9,["17"] = 9,["18"] = 15,["19"] = 9,["20"] = 13,["21"] = 17,["22"] = 18,["23"] = 19,["24"] = 15,["25"] = 22,["26"] = 23,["27"] = 24,["28"] = 27,["29"] = 22,["30"] = 30,["31"] = 9,["32"] = 32,["33"] = 33,["35"] = 35,["36"] = 36,["38"] = 38,["41"] = 30,["42"] = 43,["43"] = 44,["44"] = 43,["45"] = 47,["46"] = 48,["47"] = 49,["49"] = 47,["50"] = 53,["51"] = 54,["52"] = 55,["54"] = 53,["55"] = 59,["56"] = 60,["57"] = 61,["59"] = 59,["60"] = 65,["61"] = 66,["62"] = 67,["64"] = 65,["65"] = 71,["66"] = 72,["67"] = 73,["68"] = 74,["69"] = 71,["70"] = 77,["71"] = 78,["72"] = 77,["73"] = 9,["74"] = 9});
local ____exports = {}
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
    function Run.prototype.OnHeroUpgrade(self)
        if self.stage then
            self.stage:OnHeroUpgrade()
        end
    end
    function Run.prototype.OnBountySelected(self)
        if self.stage then
            self.stage:OnBountySelected()
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
