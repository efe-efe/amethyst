--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 22,["16"] = 22,["17"] = 22,["18"] = 22,["19"] = 22,["20"] = 34,["21"] = 22,["22"] = 24,["23"] = 25,["24"] = 26,["25"] = 27,["26"] = 31,["27"] = 32,["28"] = 36,["29"] = 37,["30"] = 38,["31"] = 39,["32"] = 40,["33"] = 41,["34"] = 43,["35"] = 44,["36"] = 44,["37"] = 44,["38"] = 45,["39"] = 44,["40"] = 44,["41"] = 47,["42"] = 47,["43"] = 47,["44"] = 48,["45"] = 47,["46"] = 47,["47"] = 34,["48"] = 52,["49"] = 53,["50"] = 54,["51"] = 58,["52"] = 52,["53"] = 61,["54"] = 62,["55"] = 63,["56"] = 64,["57"] = 64,["58"] = 64,["59"] = 65,["60"] = 66,["61"] = 67,["62"] = 68,["63"] = 64,["64"] = 64,["65"] = 61,["66"] = 72,["67"] = 73,["68"] = 74,["69"] = 74,["70"] = 74,["71"] = 74,["72"] = 75,["73"] = 76,["74"] = 77,["76"] = 79,["77"] = 72,["78"] = 82,["79"] = 83,["80"] = 83,["81"] = 83,["82"] = 83,["83"] = 84,["84"] = 85,["86"] = 82,["87"] = 89,["88"] = 90,["89"] = 91,["90"] = 91,["91"] = 91,["92"] = 92,["93"] = 93,["94"] = 94,["95"] = 95,["98"] = 91,["99"] = 91,["100"] = 100,["101"] = 101,["103"] = 89,["104"] = 105,["105"] = 106,["106"] = 107,["107"] = 107,["108"] = 107,["109"] = 108,["110"] = 109,["111"] = 110,["112"] = 111,["115"] = 107,["116"] = 107,["117"] = 116,["118"] = 117,["120"] = 105,["121"] = 121,["122"] = 22,["123"] = 124,["124"] = 125,["125"] = 126,["126"] = 127,["127"] = 128,["129"] = 130,["130"] = 131,["132"] = 134,["133"] = 135,["134"] = 136,["136"] = 138,["137"] = 139,["139"] = 142,["140"] = 143,["143"] = 146,["146"] = 149,["147"] = 149,["148"] = 149,["149"] = 150,["150"] = 151,["152"] = 153,["153"] = 154,["154"] = 155,["155"] = 159,["156"] = 159,["157"] = 159,["158"] = 159,["159"] = 159,["160"] = 159,["162"] = 149,["163"] = 149,["164"] = 163,["165"] = 163,["166"] = 163,["167"] = 164,["168"] = 163,["169"] = 163,["171"] = 121,["172"] = 169,["173"] = 170,["174"] = 170,["175"] = 170,["176"] = 171,["177"] = 172,["178"] = 173,["179"] = 174,["181"] = 176,["182"] = 177,["184"] = 179,["185"] = 180,["187"] = 182,["188"] = 183,["190"] = 185,["191"] = 186,["194"] = 170,["195"] = 170,["196"] = 169,["197"] = 192,["198"] = 193,["199"] = 193,["200"] = 193,["201"] = 194,["202"] = 195,["203"] = 196,["205"] = 193,["206"] = 193,["207"] = 192,["208"] = 201,["209"] = 202,["210"] = 203,["211"] = 201,["212"] = 206,["213"] = 207,["214"] = 207,["215"] = 207,["216"] = 208,["217"] = 209,["219"] = 211,["220"] = 212,["221"] = 207,["222"] = 207,["223"] = 214,["224"] = 214,["225"] = 214,["226"] = 215,["227"] = 216,["229"] = 214,["230"] = 214,["231"] = 206,["232"] = 221,["233"] = 222,["234"] = 223,["235"] = 221,["236"] = 226,["237"] = 227,["238"] = 227,["239"] = 227,["240"] = 227,["241"] = 227,["242"] = 227,["243"] = 227,["244"] = 227,["245"] = 227,["246"] = 227,["247"] = 226,["248"] = 236,["249"] = 237,["250"] = 237,["251"] = 237,["252"] = 237,["253"] = 237,["254"] = 236,["255"] = 240,["256"] = 241,["257"] = 240,["258"] = 22,["259"] = 22});
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
        CustomNetTables:SetTableValue(tableName, "pve", data)
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
                    self:GenerateRewards()
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
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.KNOWLEDGE) then
                        customNpc:RequestKnowledge()
                    end
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.TARRASQUE) then
                        customNpc:ApplyTarrasque()
                    end
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.ITEM) then
                        customNpc:RequestItems()
                    end
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.SHARD) then
                        customNpc:RequestShards()
                    end
                end
            end
        )
    end
    function Room.prototype.GenerateRewards(self)
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:RequestRewards()
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
