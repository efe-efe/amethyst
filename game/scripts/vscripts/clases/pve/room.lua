--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 27,["11"] = 27,["12"] = 27,["13"] = 27,["14"] = 27,["15"] = 36,["16"] = 27,["17"] = 28,["18"] = 29,["19"] = 30,["20"] = 34,["21"] = 38,["22"] = 39,["23"] = 40,["24"] = 41,["25"] = 42,["26"] = 36,["27"] = 45,["28"] = 46,["29"] = 47,["30"] = 52,["31"] = 45,["32"] = 55,["33"] = 56,["34"] = 57,["35"] = 57,["36"] = 57,["38"] = 58,["39"] = 58,["40"] = 59,["41"] = 60,["42"] = 61,["43"] = 62,["44"] = 58,["47"] = 57,["48"] = 57,["49"] = 55,["50"] = 67,["51"] = 68,["52"] = 69,["53"] = 69,["54"] = 69,["55"] = 69,["56"] = 70,["57"] = 71,["58"] = 72,["60"] = 74,["61"] = 67,["62"] = 77,["63"] = 78,["64"] = 78,["65"] = 78,["66"] = 78,["67"] = 79,["68"] = 80,["70"] = 77,["71"] = 84,["72"] = 27,["73"] = 87,["74"] = 87,["75"] = 87,["76"] = 88,["77"] = 89,["79"] = 91,["80"] = 92,["81"] = 93,["82"] = 97,["83"] = 97,["84"] = 97,["85"] = 97,["86"] = 97,["87"] = 97,["89"] = 87,["90"] = 87,["91"] = 101,["92"] = 101,["93"] = 101,["94"] = 102,["95"] = 101,["96"] = 101,["97"] = 105,["98"] = 106,["99"] = 107,["100"] = 108,["102"] = 110,["103"] = 111,["106"] = 114,["107"] = 115,["110"] = 84,["111"] = 120,["112"] = 121,["113"] = 121,["114"] = 121,["115"] = 122,["116"] = 123,["118"] = 125,["119"] = 126,["120"] = 121,["121"] = 121,["122"] = 128,["123"] = 128,["124"] = 128,["125"] = 129,["126"] = 130,["128"] = 128,["129"] = 128,["130"] = 120,["131"] = 135,["132"] = 136,["133"] = 137,["134"] = 135,["135"] = 140,["136"] = 141,["137"] = 141,["138"] = 141,["139"] = 141,["140"] = 141,["141"] = 141,["142"] = 141,["143"] = 141,["144"] = 141,["145"] = 141,["146"] = 140,["147"] = 150,["148"] = 151,["149"] = 150,["150"] = 27,["151"] = 27});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
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
        self.remainingAfterTime = 3 * 30
        self.spawnQueue = {}
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
                        local origin = Vector(x, y, 128)
                        self:SchedulAiSpawn(origin, npcGroup.name, 1)
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
            self.spawnQueue,
            function(____, scheduledSpawn)
                if scheduledSpawn.remainingTime > 0 then
                    scheduledSpawn.remainingTime = scheduledSpawn.remainingTime - 1
                else
                    local ai = CustomAIFactories[scheduledSpawn.name](CustomAIFactories, scheduledSpawn.origin)
                    __TS__ArrayPush(self.ais, ai)
                    EFX("particles/ai_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, ai.unit, {release = true})
                    self.spawnQueue = __TS__ArrayFilter(
                        self.spawnQueue,
                        function(____, spawn)
                            local ____ = spawn ~= scheduledSpawn
                        end
                    )
                end
            end
        )
        __TS__ArrayForEach(
            self.ais,
            function(____, ai)
                ai:Update()
            end
        )
        if self.remainingWaveNpcs <= 0 then
            if self.currentWave == (#self.level.waves - 1) then
                if self.remainingAfterTime == 0 then
                    self:EndLevel()
                end
                if self.remainingAfterTime > 0 then
                    self.remainingAfterTime = self.remainingAfterTime - 1
                end
            else
                self.currentWave = self.currentWave + 1
                self:StartWave(self.currentWave)
            end
        end
    end
    function Level.prototype.SkipWave(self)
        __TS__ArrayForEach(
            self.spawnQueue,
            function(____, scheduledSpawn)
                if scheduledSpawn.marker then
                    scheduledSpawn.marker:Destroy()
                end
                self.remainingWaveNpcs = self.remainingWaveNpcs - 1
                self.remainingTotalNpcs = self.remainingTotalNpcs - 1
            end
        )
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
    function Level.prototype.SchedulAiSpawn(self, origin, name, delayTime)
        __TS__ArrayPush(
            self.spawnQueue,
            {
                delayTime = delayTime * 30,
                remainingTime = delayTime * 30,
                origin = origin,
                name = name,
                marker = CreateTimedRadiusMarker(nil, origin, 150, delayTime, 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName("radius_marker_thinker")
            }
        )
    end
    function Level.prototype.EndLevel(self)
        GameRules.Addon:SetState(CustomGameState.PRE_LEVEL)
    end
    return Level
end)()
return ____exports
