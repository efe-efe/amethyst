--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 19,["11"] = 19,["12"] = 19,["13"] = 19,["14"] = 19,["15"] = 27,["16"] = 19,["17"] = 20,["18"] = 21,["19"] = 25,["20"] = 29,["21"] = 30,["22"] = 31,["23"] = 32,["24"] = 34,["25"] = 27,["26"] = 37,["27"] = 38,["28"] = 39,["29"] = 44,["30"] = 37,["31"] = 47,["32"] = 48,["33"] = 49,["34"] = 49,["35"] = 49,["37"] = 50,["38"] = 50,["39"] = 51,["40"] = 52,["41"] = 53,["42"] = 53,["43"] = 53,["45"] = 54,["46"] = 55,["47"] = 50,["50"] = 49,["51"] = 49,["52"] = 47,["53"] = 62,["54"] = 63,["55"] = 64,["56"] = 64,["57"] = 64,["58"] = 64,["59"] = 65,["60"] = 66,["61"] = 67,["63"] = 69,["64"] = 62,["65"] = 72,["66"] = 73,["67"] = 73,["68"] = 73,["69"] = 73,["70"] = 74,["71"] = 75,["73"] = 72,["74"] = 79,["75"] = 19,["76"] = 82,["77"] = 82,["78"] = 82,["79"] = 83,["80"] = 82,["81"] = 82,["82"] = 86,["83"] = 87,["84"] = 88,["86"] = 90,["87"] = 91,["90"] = 79,["91"] = 96,["92"] = 97,["93"] = 96,["94"] = 19,["95"] = 19});
local ____exports = {}
local ____custom_ai = require("clases.custom_ai")
local CustomAIFactories = ____custom_ai.CustomAIFactories
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Level = ____exports.default
    Level.name = "Level"
    __TS__ClassExtends(Level, GameState)
    function Level.prototype.____constructor(self, alliances, duration, level)
        GameState.prototype.____constructor(self, alliances, duration)
        self.helper = 3 * 30
        self.ais = {}
        self.currentWave = 0
        self.level = level
        self.remainingTotalNpcs = level.totalNpcs
        self.remainingWaveNpcs = self.level.waves[self.currentWave + 1].totalNpcs
        self:StartWave(self.currentWave)
        self:SendDataToClient()
    end
    function Level.prototype.SendDataToClient(self)
        local tableName = "main"
        local data = {remainingEnemies = self.level.totalNpcs - self.remainingTotalNpcs, currentLevel = self.level.currentLevel + 1, maxEnemies = self.level.totalNpcs}
        CustomNetTables:SetTableValue(tableName, "level", data)
    end
    function Level.prototype.StartWave(self, waveNumber)
        self.remainingWaveNpcs = self.level.waves[waveNumber + 1].totalNpcs
        __TS__ArrayForEach(
            self.level.waves[waveNumber + 1].npcGroups,
            function(____, npcGroup)
                do
                    local i = 0
                    while i < npcGroup.ammount do
                        local x = RandomInt(-1500, 1500)
                        local y = RandomInt(-1500, 1500)
                        local ai = CustomAIFactories[npcGroup.name](
                            CustomAIFactories,
                            Vector(x, y, 128)
                        )
                        __TS__ArrayPush(self.ais, ai)
                        EFX("particles/ai_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, ai.unit, {release = true})
                        i = i + 1
                    end
                end
            end
        )
    end
    function Level.prototype.OnUnitDies(self, unit)
        local previousNpcs = #self.ais
        self.ais = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit ~= unit end
        )
        if previousNpcs > #self.ais then
            self.remainingWaveNpcs = self.remainingWaveNpcs - 1
            self.remainingTotalNpcs = self.remainingTotalNpcs - 1
        end
        self:SendDataToClient()
    end
    function Level.prototype.OnUnitHurt(self, unit)
        local ai = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit == unit end
        )[1]
        if ai then
            ai:OnHurt()
        end
    end
    function Level.prototype.Update(self)
        GameState.prototype.Update(self)
        __TS__ArrayForEach(
            self.ais,
            function(____, ai)
                ai:Update()
            end
        )
        if self.remainingWaveNpcs <= 0 then
            if self.currentWave == (#self.level.waves - 1) then
                self:EndLevel()
            else
                self.currentWave = self.currentWave + 1
                self:StartWave(self.currentWave)
            end
        end
    end
    function Level.prototype.EndLevel(self)
        GameRules.Addon:SetState(CustomGameState.PRE_LEVEL)
    end
    return Level
end)()
return ____exports
