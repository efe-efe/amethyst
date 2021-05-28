--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 20,["12"] = 20,["13"] = 20,["14"] = 20,["15"] = 20,["16"] = 31,["17"] = 20,["18"] = 22,["19"] = 23,["20"] = 24,["21"] = 28,["22"] = 29,["23"] = 33,["24"] = 34,["25"] = 35,["26"] = 36,["27"] = 37,["28"] = 38,["29"] = 31,["30"] = 42,["31"] = 43,["32"] = 44,["33"] = 48,["34"] = 42,["35"] = 51,["36"] = 52,["37"] = 53,["38"] = 54,["39"] = 54,["40"] = 54,["41"] = 55,["42"] = 56,["43"] = 57,["44"] = 58,["45"] = 54,["46"] = 54,["47"] = 51,["48"] = 62,["49"] = 63,["50"] = 64,["51"] = 64,["52"] = 64,["53"] = 64,["54"] = 65,["55"] = 66,["56"] = 67,["58"] = 69,["59"] = 62,["60"] = 72,["61"] = 73,["62"] = 73,["63"] = 73,["64"] = 73,["65"] = 74,["66"] = 75,["68"] = 72,["69"] = 79,["70"] = 80,["71"] = 81,["72"] = 81,["73"] = 81,["74"] = 82,["75"] = 83,["76"] = 84,["77"] = 85,["80"] = 81,["81"] = 81,["82"] = 90,["83"] = 91,["85"] = 79,["86"] = 95,["87"] = 20,["88"] = 98,["89"] = 99,["90"] = 100,["91"] = 101,["92"] = 102,["94"] = 104,["95"] = 105,["97"] = 107,["98"] = 108,["101"] = 111,["104"] = 114,["105"] = 114,["106"] = 114,["107"] = 115,["108"] = 116,["110"] = 118,["111"] = 119,["112"] = 120,["113"] = 124,["114"] = 124,["115"] = 124,["116"] = 124,["117"] = 124,["118"] = 124,["120"] = 114,["121"] = 114,["122"] = 128,["123"] = 128,["124"] = 128,["125"] = 129,["126"] = 128,["127"] = 128,["129"] = 95,["130"] = 134,["131"] = 135,["132"] = 135,["133"] = 135,["134"] = 136,["135"] = 137,["136"] = 138,["138"] = 135,["139"] = 135,["140"] = 134,["141"] = 142,["142"] = 143,["143"] = 144,["144"] = 142,["145"] = 147,["146"] = 148,["147"] = 148,["148"] = 148,["149"] = 149,["150"] = 150,["152"] = 152,["153"] = 153,["154"] = 148,["155"] = 148,["156"] = 155,["157"] = 155,["158"] = 155,["159"] = 156,["160"] = 157,["162"] = 155,["163"] = 155,["164"] = 147,["165"] = 162,["166"] = 163,["167"] = 164,["168"] = 162,["169"] = 167,["170"] = 168,["171"] = 168,["172"] = 168,["173"] = 168,["174"] = 168,["175"] = 168,["176"] = 168,["177"] = 168,["178"] = 168,["179"] = 168,["180"] = 167,["181"] = 177,["182"] = 178,["183"] = 178,["184"] = 178,["185"] = 178,["186"] = 178,["187"] = 177,["188"] = 181,["189"] = 182,["190"] = 181,["191"] = 20,["192"] = 20});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local ____settings = require("settings")
local settings = ____settings.default
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Room = ____exports.default
    Room.name = "Room"
    __TS__ClassExtends(Room, GameState)
    function Room.prototype.____constructor(self, alliances, duration, waves, stage)
        GameState.prototype.____constructor(self, alliances, duration)
        self.upgradesDelay = 3 * 30
        self.spawnQueue = {}
        self.ais = {}
        self.remainingWaveNpcs = 0
        self.currentWave = 0
        self.waves = waves
        self.totalNpcs = self:GetTotalNPCs(waves)
        self.remainingTotalNpcs = self.totalNpcs
        self.stage = stage
        self:StartWave(self.currentWave)
        self:SendDataToClient()
    end
    function Room.prototype.SendDataToClient(self)
        local tableName = "main"
        local data = {remainingEnemies = self.totalNpcs - self.remainingTotalNpcs, maxEnemies = self.totalNpcs}
        CustomNetTables:SetTableValue(tableName, "stage", data)
    end
    function Room.prototype.StartWave(self, waveNumber)
        local wave = self.waves[waveNumber + 1]
        self.remainingWaveNpcs = #wave.npcs
        __TS__ArrayForEach(
            wave.npcs,
            function(____, npc)
                local x = RandomInt(-1500, 1500)
                local y = RandomInt(-1500, 1500)
                local origin = Vector(x, y, 128)
                self:SchedulAiSpawn(origin, npc, 1)
            end
        )
    end
    function Room.prototype.OnUnitDies(self, unit)
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
    function Room.prototype.OnUnitHurt(self, unit)
        local ai = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit == unit end
        )[1]
        if ai then
            ai:OnHurt()
        end
    end
    function Room.prototype.OnHeroUpgrade(self)
        local upgradesReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc:IsUpgrading() then
                        upgradesReady = false
                    end
                end
            end
        )
        if upgradesReady then
            self:SetDuration(settings.PreStageDuration)
        end
    end
    function Room.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.remainingWaveNpcs <= 0 then
            if self.currentWave == (#self.waves - 1) then
                if self.upgradesDelay == 0 then
                    self:GenerateUpgrades()
                    self.upgradesDelay = self.upgradesDelay - 1
                end
                if self.upgradesDelay > 0 then
                    self.upgradesDelay = self.upgradesDelay - 1
                end
                if self.time_remaining == 0 then
                    self:End()
                end
            else
                self:IncrementWave()
            end
        else
            __TS__ArrayForEach(
                self.spawnQueue,
                function(____, scheduledSpawn)
                    if scheduledSpawn.remainingTime > 0 then
                        scheduledSpawn.remainingTime = scheduledSpawn.remainingTime - 1
                    else
                        local ai = CustomAIMeta[scheduledSpawn.name]:factory(scheduledSpawn.origin)
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
        end
    end
    function Room.prototype.GenerateUpgrades(self)
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:RequestUpgrades()
                end
            end
        )
    end
    function Room.prototype.IncrementWave(self)
        self.currentWave = self.currentWave + 1
        self:StartWave(self.currentWave)
    end
    function Room.prototype.SkipWave(self)
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
    function Room.prototype.SkipRoom(self)
        self.currentWave = #self.waves - 1
        self:SkipWave()
    end
    function Room.prototype.SchedulAiSpawn(self, origin, name, delayTime)
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
    function Room.prototype.GetTotalNPCs(self, waves)
        return __TS__ArrayReduce(
            waves,
            function(____, a, wave) return a + #wave.npcs end,
            0
        )
    end
    function Room.prototype.End(self)
        self.stage:OnRoomCompleted()
    end
    return Room
end)()
return ____exports
