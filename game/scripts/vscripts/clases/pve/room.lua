--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 22,["16"] = 22,["17"] = 22,["18"] = 22,["19"] = 22,["20"] = 34,["21"] = 22,["22"] = 24,["23"] = 25,["24"] = 26,["25"] = 27,["26"] = 31,["27"] = 32,["28"] = 36,["29"] = 37,["30"] = 38,["31"] = 39,["32"] = 40,["33"] = 41,["34"] = 43,["35"] = 44,["36"] = 44,["37"] = 44,["38"] = 45,["39"] = 44,["40"] = 44,["41"] = 47,["42"] = 47,["43"] = 47,["44"] = 48,["45"] = 47,["46"] = 47,["47"] = 34,["48"] = 52,["49"] = 53,["50"] = 54,["51"] = 58,["52"] = 52,["53"] = 61,["54"] = 62,["55"] = 63,["56"] = 64,["57"] = 64,["58"] = 64,["59"] = 65,["60"] = 66,["61"] = 67,["62"] = 68,["63"] = 64,["64"] = 64,["65"] = 61,["66"] = 72,["67"] = 73,["68"] = 74,["69"] = 74,["70"] = 74,["71"] = 74,["72"] = 75,["73"] = 76,["74"] = 77,["75"] = 78,["77"] = 82,["78"] = 72,["79"] = 85,["80"] = 86,["81"] = 86,["82"] = 86,["83"] = 86,["84"] = 87,["85"] = 88,["87"] = 85,["88"] = 92,["89"] = 93,["90"] = 94,["91"] = 94,["92"] = 94,["93"] = 95,["94"] = 96,["95"] = 97,["96"] = 98,["99"] = 94,["100"] = 94,["101"] = 103,["102"] = 104,["104"] = 92,["105"] = 108,["106"] = 109,["107"] = 110,["108"] = 110,["109"] = 110,["110"] = 111,["111"] = 112,["112"] = 113,["113"] = 114,["116"] = 110,["117"] = 110,["118"] = 119,["119"] = 120,["121"] = 108,["122"] = 124,["123"] = 22,["124"] = 127,["125"] = 128,["126"] = 129,["127"] = 130,["128"] = 131,["130"] = 133,["131"] = 134,["133"] = 137,["134"] = 138,["135"] = 139,["137"] = 141,["138"] = 142,["140"] = 145,["141"] = 146,["144"] = 149,["147"] = 152,["148"] = 152,["149"] = 152,["150"] = 153,["151"] = 154,["153"] = 156,["154"] = 157,["155"] = 158,["156"] = 162,["157"] = 162,["158"] = 162,["159"] = 162,["160"] = 162,["161"] = 162,["163"] = 152,["164"] = 152,["165"] = 166,["166"] = 166,["167"] = 166,["168"] = 167,["169"] = 166,["170"] = 166,["172"] = 124,["173"] = 172,["174"] = 173,["175"] = 173,["176"] = 173,["177"] = 174,["178"] = 175,["179"] = 176,["180"] = 177,["182"] = 179,["183"] = 180,["185"] = 182,["186"] = 183,["188"] = 185,["189"] = 186,["191"] = 188,["192"] = 189,["195"] = 173,["196"] = 173,["197"] = 172,["198"] = 195,["199"] = 196,["200"] = 196,["201"] = 196,["202"] = 197,["203"] = 198,["204"] = 199,["206"] = 196,["207"] = 196,["208"] = 195,["209"] = 204,["210"] = 205,["211"] = 206,["212"] = 204,["213"] = 209,["214"] = 210,["215"] = 210,["216"] = 210,["217"] = 211,["218"] = 212,["220"] = 214,["221"] = 215,["222"] = 210,["223"] = 210,["224"] = 217,["225"] = 217,["226"] = 217,["227"] = 218,["228"] = 219,["230"] = 217,["231"] = 217,["232"] = 209,["233"] = 224,["234"] = 225,["235"] = 226,["236"] = 224,["237"] = 229,["238"] = 230,["239"] = 230,["240"] = 230,["241"] = 230,["242"] = 230,["243"] = 230,["244"] = 230,["245"] = 230,["246"] = 230,["247"] = 230,["248"] = 229,["249"] = 239,["250"] = 240,["251"] = 240,["252"] = 240,["253"] = 240,["254"] = 240,["255"] = 239,["256"] = 243,["257"] = 244,["258"] = 243,["259"] = 22,["260"] = 22});
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
            EFX("particles/econ/events/new_bloom/dragon_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {release = true})
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
                    if customNpc.reward and (customNpc.reward.type == RewardTypes.VITALITY) then
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
