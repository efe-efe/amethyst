--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 7,["12"] = 7,["13"] = 8,["14"] = 8,["15"] = 23,["16"] = 23,["17"] = 23,["18"] = 23,["19"] = 23,["20"] = 35,["21"] = 23,["22"] = 25,["23"] = 26,["24"] = 27,["25"] = 28,["26"] = 32,["27"] = 33,["28"] = 37,["29"] = 38,["30"] = 39,["31"] = 40,["32"] = 41,["33"] = 42,["34"] = 44,["35"] = 45,["36"] = 45,["37"] = 45,["38"] = 46,["39"] = 45,["40"] = 45,["41"] = 48,["42"] = 48,["43"] = 48,["44"] = 49,["45"] = 48,["46"] = 48,["47"] = 35,["48"] = 53,["49"] = 54,["50"] = 55,["51"] = 59,["52"] = 53,["53"] = 62,["54"] = 63,["55"] = 64,["56"] = 65,["57"] = 65,["58"] = 65,["59"] = 66,["60"] = 67,["61"] = 68,["62"] = 69,["63"] = 65,["64"] = 65,["65"] = 62,["66"] = 73,["67"] = 74,["68"] = 75,["69"] = 75,["70"] = 75,["71"] = 75,["72"] = 76,["73"] = 77,["74"] = 78,["76"] = 80,["77"] = 73,["78"] = 83,["79"] = 84,["80"] = 84,["81"] = 84,["82"] = 84,["83"] = 85,["84"] = 86,["86"] = 83,["87"] = 90,["88"] = 91,["89"] = 92,["90"] = 92,["91"] = 92,["92"] = 93,["93"] = 94,["94"] = 95,["95"] = 96,["98"] = 92,["99"] = 92,["100"] = 101,["101"] = 102,["103"] = 90,["104"] = 106,["105"] = 107,["106"] = 108,["107"] = 108,["108"] = 108,["109"] = 109,["110"] = 110,["111"] = 111,["112"] = 112,["115"] = 108,["116"] = 108,["117"] = 117,["118"] = 118,["120"] = 106,["121"] = 122,["122"] = 23,["123"] = 125,["124"] = 126,["125"] = 127,["126"] = 128,["127"] = 129,["129"] = 131,["130"] = 132,["132"] = 135,["133"] = 136,["134"] = 137,["136"] = 139,["137"] = 140,["139"] = 143,["140"] = 144,["143"] = 147,["146"] = 150,["147"] = 150,["148"] = 150,["149"] = 151,["150"] = 152,["152"] = 154,["153"] = 155,["154"] = 156,["155"] = 160,["156"] = 160,["157"] = 160,["158"] = 160,["159"] = 160,["160"] = 160,["162"] = 150,["163"] = 150,["164"] = 164,["165"] = 164,["166"] = 164,["167"] = 165,["168"] = 164,["169"] = 164,["171"] = 122,["172"] = 170,["173"] = 171,["174"] = 171,["175"] = 171,["176"] = 172,["177"] = 173,["178"] = 174,["179"] = 175,["181"] = 177,["182"] = 178,["184"] = 180,["185"] = 181,["188"] = 171,["189"] = 171,["190"] = 170,["191"] = 187,["192"] = 188,["193"] = 188,["194"] = 188,["195"] = 189,["196"] = 190,["197"] = 191,["199"] = 188,["200"] = 188,["201"] = 187,["202"] = 196,["203"] = 197,["204"] = 198,["205"] = 196,["206"] = 201,["207"] = 202,["208"] = 202,["209"] = 202,["210"] = 203,["211"] = 204,["213"] = 206,["214"] = 207,["215"] = 202,["216"] = 202,["217"] = 209,["218"] = 209,["219"] = 209,["220"] = 210,["221"] = 211,["223"] = 209,["224"] = 209,["225"] = 201,["226"] = 216,["227"] = 217,["228"] = 218,["229"] = 216,["230"] = 221,["231"] = 222,["232"] = 222,["233"] = 222,["234"] = 222,["235"] = 222,["236"] = 222,["237"] = 222,["238"] = 222,["239"] = 222,["240"] = 222,["241"] = 221,["242"] = 231,["243"] = 232,["244"] = 232,["245"] = 232,["246"] = 232,["247"] = 232,["248"] = 231,["249"] = 235,["250"] = 236,["251"] = 235,["252"] = 23,["253"] = 23});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local ____settings = require("settings")
local settings = ____settings.default
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
        self.applyRewardsDelay = 1 * 30
        self.rewardsMenuDelay = -1
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
            "pve:current_reward_applied",
            function()
                self:OnRewardApplied()
            end
        )
        customEvents:RegisterListener(
            "pve:next_reward_selected",
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
    function Room.prototype.OnRewardApplied(self)
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
            self.rewardsMenuDelay = 2 * 30
        end
    end
    function Room.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.remainingWaveNpcs <= 0 then
            if self.currentWave == (#self.waves - 1) then
                if self.applyRewardsDelay == 0 then
                    self:ApplyRewards()
                    self.applyRewardsDelay = self.applyRewardsDelay - 1
                end
                if self.applyRewardsDelay > 0 then
                    self.applyRewardsDelay = self.applyRewardsDelay - 1
                end
                if self.rewardsMenuDelay == 0 then
                    self:GenerateBounties()
                    self.rewardsMenuDelay = self.rewardsMenuDelay - 1
                end
                if self.rewardsMenuDelay > 0 then
                    self.rewardsMenuDelay = self.rewardsMenuDelay - 1
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
    function Room.prototype.ApplyRewards(self)
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
                        customNpc:ApplyTarrasque()
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
