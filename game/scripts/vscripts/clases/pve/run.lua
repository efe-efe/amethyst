--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 9,["14"] = 9,["15"] = 9,["16"] = 9,["17"] = 9,["18"] = 15,["19"] = 9,["20"] = 13,["21"] = 17,["22"] = 18,["23"] = 15,["24"] = 21,["25"] = 9,["26"] = 23,["27"] = 24,["29"] = 26,["30"] = 27,["32"] = 29,["35"] = 21,["36"] = 34,["37"] = 35,["38"] = 34,["39"] = 38,["40"] = 39,["41"] = 40,["43"] = 38,["44"] = 44,["45"] = 45,["46"] = 46,["48"] = 44,["49"] = 50,["50"] = 51,["51"] = 52,["53"] = 50,["54"] = 56,["55"] = 57,["56"] = 58,["57"] = 56,["58"] = 61,["59"] = 62,["60"] = 61,["61"] = 9,["62"] = 9});
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
    function Run.prototype.OnStageEnd(self)
        self.currentStage = self.currentStage + 1
        self.stage = nil
    end
    function Run.prototype.End(self)
        GameRules.Addon:SetState(CustomGameState.POST_RUN)
    end
    return Run
end)()
return ____exports
