--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 20,["12"] = 20,["13"] = 20,["14"] = 20,["15"] = 20,["16"] = 32,["17"] = 20,["18"] = 22,["19"] = 23,["20"] = 24,["21"] = 25,["22"] = 29,["23"] = 30,["24"] = 34,["25"] = 35,["26"] = 36,["27"] = 37,["28"] = 38,["29"] = 39,["30"] = 32,["31"] = 42,["32"] = 43,["33"] = 44,["34"] = 48,["35"] = 42,["36"] = 51,["37"] = 52,["38"] = 53,["39"] = 54,["40"] = 54,["41"] = 54,["42"] = 55,["43"] = 56,["44"] = 57,["45"] = 58,["46"] = 54,["47"] = 54,["48"] = 51,["49"] = 62,["50"] = 63,["51"] = 64,["52"] = 64,["53"] = 64,["54"] = 64,["55"] = 65,["56"] = 66,["57"] = 67,["59"] = 69,["60"] = 62,["61"] = 72,["62"] = 73,["63"] = 73,["64"] = 73,["65"] = 73,["66"] = 74,["67"] = 75,["69"] = 72,["70"] = 79,["71"] = 80,["72"] = 81,["73"] = 81,["74"] = 81,["75"] = 82,["76"] = 83,["77"] = 84,["78"] = 85,["81"] = 81,["82"] = 81,["83"] = 90,["84"] = 91,["86"] = 79,["87"] = 95,["88"] = 96,["89"] = 97,["90"] = 97,["91"] = 97,["92"] = 98,["93"] = 99,["94"] = 100,["95"] = 101,["98"] = 97,["99"] = 97,["100"] = 106,["101"] = 107,["103"] = 95,["104"] = 111,["105"] = 20,["106"] = 114,["107"] = 115,["108"] = 116,["109"] = 117,["110"] = 118,["112"] = 120,["113"] = 121,["115"] = 124,["116"] = 125,["117"] = 126,["119"] = 128,["120"] = 129,["122"] = 132,["123"] = 133,["126"] = 136,["129"] = 139,["130"] = 139,["131"] = 139,["132"] = 140,["133"] = 141,["135"] = 143,["136"] = 144,["137"] = 145,["138"] = 149,["139"] = 149,["140"] = 149,["141"] = 149,["142"] = 149,["143"] = 149,["145"] = 139,["146"] = 139,["147"] = 153,["148"] = 153,["149"] = 153,["150"] = 154,["151"] = 153,["152"] = 153,["154"] = 111,["155"] = 159,["156"] = 160,["157"] = 160,["158"] = 160,["159"] = 161,["160"] = 162,["161"] = 163,["163"] = 160,["164"] = 160,["165"] = 159,["166"] = 168,["167"] = 169,["168"] = 169,["169"] = 169,["170"] = 170,["171"] = 171,["172"] = 172,["174"] = 169,["175"] = 169,["176"] = 168,["177"] = 177,["178"] = 178,["179"] = 179,["180"] = 177,["181"] = 182,["182"] = 183,["183"] = 183,["184"] = 183,["185"] = 184,["186"] = 185,["188"] = 187,["189"] = 188,["190"] = 183,["191"] = 183,["192"] = 190,["193"] = 190,["194"] = 190,["195"] = 191,["196"] = 192,["198"] = 190,["199"] = 190,["200"] = 182,["201"] = 197,["202"] = 198,["203"] = 199,["204"] = 197,["205"] = 202,["206"] = 203,["207"] = 203,["208"] = 203,["209"] = 203,["210"] = 203,["211"] = 203,["212"] = 203,["213"] = 203,["214"] = 203,["215"] = 203,["216"] = 202,["217"] = 212,["218"] = 213,["219"] = 213,["220"] = 213,["221"] = 213,["222"] = 213,["223"] = 212,["224"] = 216,["225"] = 217,["226"] = 216,["227"] = 20,["228"] = 20});
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
        self.upgradesDelay = 1 * 30
        self.bountiesDelay = -1
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
    function Room.prototype.OnBountySelected(self)
        local bountiesReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc:IsSelectingBounty() then
                        bountiesReady = false
                    end
                end
            end
        )
        if bountiesReady then
            self:SetDuration(settings.PreStageDuration)
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
            self.bountiesDelay = 2 * 30
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
                if self.bountiesDelay == 0 then
                    self:GenerateBounties()
                    self.bountiesDelay = self.bountiesDelay - 1
                end
                if self.bountiesDelay > 0 then
                    self.bountiesDelay = self.bountiesDelay - 1
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
    function Room.prototype.GenerateBounties(self)
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:RequestBounties()
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
