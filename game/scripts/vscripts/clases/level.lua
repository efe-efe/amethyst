--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 19,["11"] = 19,["12"] = 19,["13"] = 19,["14"] = 19,["15"] = 27,["16"] = 19,["17"] = 20,["18"] = 21,["19"] = 25,["20"] = 29,["21"] = 30,["22"] = 31,["23"] = 32,["24"] = 33,["25"] = 27,["26"] = 36,["27"] = 37,["28"] = 38,["29"] = 43,["30"] = 36,["31"] = 46,["32"] = 47,["33"] = 48,["34"] = 48,["35"] = 48,["37"] = 49,["38"] = 49,["39"] = 50,["40"] = 51,["41"] = 52,["42"] = 52,["43"] = 52,["45"] = 53,["46"] = 54,["47"] = 49,["50"] = 48,["51"] = 48,["52"] = 46,["53"] = 61,["54"] = 62,["55"] = 63,["56"] = 63,["57"] = 63,["58"] = 63,["59"] = 64,["60"] = 65,["61"] = 66,["63"] = 68,["64"] = 61,["65"] = 71,["66"] = 72,["67"] = 72,["68"] = 72,["69"] = 72,["70"] = 73,["71"] = 74,["73"] = 71,["74"] = 78,["75"] = 19,["76"] = 81,["77"] = 81,["78"] = 81,["79"] = 82,["80"] = 81,["81"] = 81,["82"] = 85,["83"] = 86,["84"] = 87,["86"] = 89,["87"] = 90,["90"] = 78,["91"] = 95,["92"] = 96,["93"] = 96,["94"] = 96,["95"] = 97,["96"] = 98,["98"] = 96,["99"] = 96,["100"] = 95,["101"] = 103,["102"] = 104,["103"] = 105,["104"] = 103,["105"] = 108,["106"] = 109,["107"] = 109,["108"] = 109,["109"] = 110,["110"] = 111,["111"] = 112,["113"] = 109,["114"] = 109,["115"] = 116,["116"] = 108,["117"] = 19,["118"] = 19});
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
    function Level.prototype.SkipWave(self)
        __TS__ArrayForEach(
            self.ais,
            function(____, ai)
                if ai.unit:IsAlive() then
                    ai.unit:ForceKill(false)
                end
            end
        )
    end
    function Level.prototype.SkipLevel(self)
        self.currentWave = #self.level.waves - 1
        self:SkipWave()
    end
    function Level.prototype.EndLevel(self)
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:RequestUpgrades()
                end
            end
        )
        GameRules.Addon:SetState(CustomGameState.PRE_LEVEL)
    end
    return Level
end)()
return ____exports
