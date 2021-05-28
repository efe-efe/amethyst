--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 21,["14"] = 21,["15"] = 21,["16"] = 21,["17"] = 21,["18"] = 33,["19"] = 21,["20"] = 23,["21"] = 24,["22"] = 25,["23"] = 26,["24"] = 30,["25"] = 31,["26"] = 35,["27"] = 36,["28"] = 37,["29"] = 38,["30"] = 39,["31"] = 40,["32"] = 33,["33"] = 43,["34"] = 44,["35"] = 45,["36"] = 49,["37"] = 43,["38"] = 52,["39"] = 53,["40"] = 54,["41"] = 55,["42"] = 55,["43"] = 55,["44"] = 56,["45"] = 57,["46"] = 58,["47"] = 59,["48"] = 55,["49"] = 55,["50"] = 52,["51"] = 63,["52"] = 64,["53"] = 65,["54"] = 65,["55"] = 65,["56"] = 65,["57"] = 66,["58"] = 67,["59"] = 68,["61"] = 70,["62"] = 63,["63"] = 73,["64"] = 74,["65"] = 74,["66"] = 74,["67"] = 74,["68"] = 75,["69"] = 76,["71"] = 73,["72"] = 80,["73"] = 81,["74"] = 82,["75"] = 82,["76"] = 82,["77"] = 83,["78"] = 84,["79"] = 85,["80"] = 86,["83"] = 82,["84"] = 82,["85"] = 91,["86"] = 92,["88"] = 80,["89"] = 96,["90"] = 97,["91"] = 98,["92"] = 98,["93"] = 98,["94"] = 99,["95"] = 100,["96"] = 101,["97"] = 102,["100"] = 98,["101"] = 98,["102"] = 107,["103"] = 108,["105"] = 96,["106"] = 112,["107"] = 21,["108"] = 115,["109"] = 116,["110"] = 117,["111"] = 118,["112"] = 119,["114"] = 121,["115"] = 122,["117"] = 125,["118"] = 126,["119"] = 127,["121"] = 129,["122"] = 130,["124"] = 133,["125"] = 134,["128"] = 137,["131"] = 140,["132"] = 140,["133"] = 140,["134"] = 141,["135"] = 142,["137"] = 144,["138"] = 145,["139"] = 146,["140"] = 150,["141"] = 150,["142"] = 150,["143"] = 150,["144"] = 150,["145"] = 150,["147"] = 140,["148"] = 140,["149"] = 154,["150"] = 154,["151"] = 154,["152"] = 155,["153"] = 154,["154"] = 154,["156"] = 112,["157"] = 160,["158"] = 161,["159"] = 161,["160"] = 161,["161"] = 162,["162"] = 163,["163"] = 164,["164"] = 165,["166"] = 167,["167"] = 168,["169"] = 170,["170"] = 171,["171"] = 171,["172"] = 171,["173"] = 171,["174"] = 172,["175"] = 173,["176"] = 174,["180"] = 161,["181"] = 161,["182"] = 160,["183"] = 181,["184"] = 182,["185"] = 182,["186"] = 182,["187"] = 183,["188"] = 184,["189"] = 185,["191"] = 182,["192"] = 182,["193"] = 181,["194"] = 190,["195"] = 191,["196"] = 192,["197"] = 190,["198"] = 195,["199"] = 196,["200"] = 196,["201"] = 196,["202"] = 197,["203"] = 198,["205"] = 200,["206"] = 201,["207"] = 196,["208"] = 196,["209"] = 203,["210"] = 203,["211"] = 203,["212"] = 204,["213"] = 205,["215"] = 203,["216"] = 203,["217"] = 195,["218"] = 210,["219"] = 211,["220"] = 212,["221"] = 210,["222"] = 215,["223"] = 216,["224"] = 216,["225"] = 216,["226"] = 216,["227"] = 216,["228"] = 216,["229"] = 216,["230"] = 216,["231"] = 216,["232"] = 216,["233"] = 215,["234"] = 225,["235"] = 226,["236"] = 226,["237"] = 226,["238"] = 226,["239"] = 226,["240"] = 225,["241"] = 229,["242"] = 230,["243"] = 229,["244"] = 21,["245"] = 21});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local ____settings = require("settings")
local settings = ____settings.default
local ____upgrades = require("upgrades.upgrades")
local Upgrades = ____upgrades.default
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
                    if customNpc.bounty and (customNpc.bounty.id == "bounty_upgrades") then
                        customNpc:RequestUpgrades()
                    end
                    if customNpc.bounty and (customNpc.bounty.id == "bounty_improvements") then
                        customNpc:RequestImprovements()
                    end
                    if customNpc.bounty and (customNpc.bounty.id == "bounty_regenerate") then
                        local regenerationUpgrade = __TS__ArrayFilter(
                            Upgrades,
                            function(____, upgrade) return upgrade.id == "restore_health" end
                        )[1]
                        customNpc:ApplyUpgrade(regenerationUpgrade)
                        if self.stage.run then
                            self.stage.run:OnHeroUpgrade()
                        end
                    end
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
