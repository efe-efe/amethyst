--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 23,["18"] = 23,["19"] = 23,["20"] = 23,["21"] = 23,["22"] = 35,["23"] = 23,["24"] = 25,["25"] = 26,["26"] = 27,["27"] = 28,["28"] = 32,["29"] = 33,["30"] = 37,["31"] = 38,["32"] = 39,["33"] = 40,["34"] = 41,["35"] = 42,["36"] = 44,["37"] = 45,["38"] = 45,["39"] = 45,["40"] = 46,["41"] = 45,["42"] = 45,["43"] = 48,["44"] = 48,["45"] = 48,["46"] = 49,["47"] = 48,["48"] = 48,["49"] = 35,["50"] = 53,["51"] = 54,["52"] = 55,["53"] = 59,["54"] = 53,["55"] = 62,["56"] = 63,["57"] = 64,["58"] = 65,["59"] = 65,["60"] = 65,["61"] = 66,["62"] = 67,["63"] = 68,["64"] = 69,["65"] = 65,["66"] = 65,["67"] = 62,["68"] = 73,["69"] = 74,["70"] = 75,["71"] = 75,["72"] = 75,["73"] = 75,["74"] = 76,["75"] = 77,["76"] = 78,["78"] = 80,["79"] = 73,["80"] = 83,["81"] = 84,["82"] = 84,["83"] = 84,["84"] = 84,["85"] = 85,["86"] = 86,["88"] = 83,["89"] = 90,["90"] = 91,["91"] = 92,["92"] = 92,["93"] = 92,["94"] = 93,["95"] = 94,["96"] = 95,["97"] = 96,["100"] = 92,["101"] = 92,["102"] = 101,["103"] = 102,["105"] = 90,["106"] = 106,["107"] = 107,["108"] = 108,["109"] = 108,["110"] = 108,["111"] = 109,["112"] = 110,["113"] = 111,["114"] = 112,["117"] = 108,["118"] = 108,["119"] = 117,["120"] = 118,["122"] = 106,["123"] = 122,["124"] = 23,["125"] = 125,["126"] = 126,["127"] = 127,["128"] = 128,["129"] = 129,["131"] = 131,["132"] = 132,["134"] = 135,["135"] = 136,["136"] = 137,["138"] = 139,["139"] = 140,["141"] = 143,["142"] = 144,["145"] = 147,["148"] = 150,["149"] = 150,["150"] = 150,["151"] = 151,["152"] = 152,["154"] = 154,["155"] = 155,["156"] = 156,["157"] = 160,["158"] = 160,["159"] = 160,["160"] = 160,["161"] = 160,["162"] = 160,["164"] = 150,["165"] = 150,["166"] = 164,["167"] = 164,["168"] = 164,["169"] = 165,["170"] = 164,["171"] = 164,["173"] = 122,["174"] = 170,["175"] = 171,["176"] = 171,["177"] = 171,["178"] = 172,["179"] = 173,["180"] = 174,["181"] = 175,["183"] = 177,["184"] = 178,["186"] = 180,["187"] = 181,["188"] = 181,["189"] = 181,["190"] = 181,["191"] = 182,["194"] = 171,["195"] = 171,["196"] = 170,["197"] = 188,["198"] = 189,["199"] = 189,["200"] = 189,["201"] = 190,["202"] = 191,["203"] = 192,["205"] = 189,["206"] = 189,["207"] = 188,["208"] = 197,["209"] = 198,["210"] = 199,["211"] = 197,["212"] = 202,["213"] = 203,["214"] = 203,["215"] = 203,["216"] = 204,["217"] = 205,["219"] = 207,["220"] = 208,["221"] = 203,["222"] = 203,["223"] = 210,["224"] = 210,["225"] = 210,["226"] = 211,["227"] = 212,["229"] = 210,["230"] = 210,["231"] = 202,["232"] = 217,["233"] = 218,["234"] = 219,["235"] = 217,["236"] = 222,["237"] = 223,["238"] = 223,["239"] = 223,["240"] = 223,["241"] = 223,["242"] = 223,["243"] = 223,["244"] = 223,["245"] = 223,["246"] = 223,["247"] = 222,["248"] = 232,["249"] = 233,["250"] = 233,["251"] = 233,["252"] = 233,["253"] = 233,["254"] = 232,["255"] = 236,["256"] = 237,["257"] = 236,["258"] = 23,["259"] = 23});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local ____settings = require("settings")
local settings = ____settings.default
local ____upgrades = require("upgrades.upgrades")
local Upgrades = ____upgrades.default
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
local ____rewards = require("rewards.rewards")
local RewardTypes = ____rewards.RewardTypes
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Room = ____exports.default
    Room.name = "Room"
    __TS__ClassExtends(Room, GameState)
    function Room.prototype.____constructor(self, alliances, duration, waves, stage)
        GameState.prototype.____constructor(self, alliances, duration)
        self.favorsDelay = 1 * 30
        self.rewardsDelay = -1
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
        local customEvents = CustomEvents:GetInstance()
        customEvents:RegisterListener(
            "pve:apply_favor",
            function()
                self:OnFavorApplied()
            end
        )
        customEvents:RegisterListener(
            "pve:reward_selected",
            function()
                self:OnRewardSelected()
            end
        )
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
    function Room.prototype.OnRewardSelected(self)
        local rewardsReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc:IsSelectingReward() then
                        rewardsReady = false
                    end
                end
            end
        )
        if rewardsReady then
            self:SetDuration(settings.PreStageDuration)
        end
    end
    function Room.prototype.OnFavorApplied(self)
        local favorsReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc:IsSelectingFavor() then
                        favorsReady = false
                    end
                end
            end
        )
        if favorsReady then
            self.rewardsDelay = 2 * 30
        end
    end
    function Room.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.remainingWaveNpcs <= 0 then
            if self.currentWave == (#self.waves - 1) then
                if self.favorsDelay == 0 then
                    self:GenerateFavors()
                    self.favorsDelay = self.favorsDelay - 1
                end
                if self.favorsDelay > 0 then
                    self.favorsDelay = self.favorsDelay - 1
                end
                if self.rewardsDelay == 0 then
                    self:GenerateBounties()
                    self.rewardsDelay = self.rewardsDelay - 1
                end
                if self.rewardsDelay > 0 then
                    self.rewardsDelay = self.rewardsDelay - 1
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
    function Room.prototype.GenerateFavors(self)
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.FAVOR) then
                        customNpc:RequestFavors()
                    end
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.ENHANCEMENT) then
                        customNpc:RequestEnhancements()
                    end
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.TARRASQUE) then
                        local regenerationUpgrade = __TS__ArrayFilter(
                            Upgrades,
                            function(____, upgrade) return upgrade.id == "restore_health" end
                        )[1]
                        customNpc:ApplyFavor(regenerationUpgrade)
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
