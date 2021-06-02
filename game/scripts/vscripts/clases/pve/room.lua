--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 10,["18"] = 11,["19"] = 11,["20"] = 12,["21"] = 12,["22"] = 13,["23"] = 13,["24"] = 30,["25"] = 30,["26"] = 30,["27"] = 30,["28"] = 30,["29"] = 45,["30"] = 30,["31"] = 32,["32"] = 33,["33"] = 34,["34"] = 35,["35"] = 39,["36"] = 40,["37"] = 47,["38"] = 48,["39"] = 49,["40"] = 50,["41"] = 51,["42"] = 52,["43"] = 53,["44"] = 54,["45"] = 56,["46"] = 57,["47"] = 57,["48"] = 57,["49"] = 58,["50"] = 57,["51"] = 57,["52"] = 60,["53"] = 60,["54"] = 60,["55"] = 61,["56"] = 60,["57"] = 60,["58"] = 45,["59"] = 65,["60"] = 66,["61"] = 67,["62"] = 71,["63"] = 65,["64"] = 74,["65"] = 75,["66"] = 76,["67"] = 77,["68"] = 77,["69"] = 77,["70"] = 78,["71"] = 79,["72"] = 80,["73"] = 81,["74"] = 77,["75"] = 77,["76"] = 74,["77"] = 85,["78"] = 86,["79"] = 87,["80"] = 87,["81"] = 87,["82"] = 87,["83"] = 88,["84"] = 89,["85"] = 90,["86"] = 91,["88"] = 95,["89"] = 85,["90"] = 98,["91"] = 99,["92"] = 99,["93"] = 99,["94"] = 99,["95"] = 100,["96"] = 101,["98"] = 98,["99"] = 105,["100"] = 106,["101"] = 107,["102"] = 107,["103"] = 107,["104"] = 108,["105"] = 109,["106"] = 110,["107"] = 111,["110"] = 107,["111"] = 107,["112"] = 116,["113"] = 117,["115"] = 105,["116"] = 121,["117"] = 122,["118"] = 123,["119"] = 123,["120"] = 123,["121"] = 124,["122"] = 125,["123"] = 126,["124"] = 127,["127"] = 123,["128"] = 123,["129"] = 132,["130"] = 133,["132"] = 121,["133"] = 137,["134"] = 30,["135"] = 140,["136"] = 141,["137"] = 142,["138"] = 143,["139"] = 143,["140"] = 143,["141"] = 143,["142"] = 144,["144"] = 146,["145"] = 147,["146"] = 148,["147"] = 149,["149"] = 151,["150"] = 152,["152"] = 155,["153"] = 156,["154"] = 157,["156"] = 159,["157"] = 160,["159"] = 163,["160"] = 164,["164"] = 168,["167"] = 171,["168"] = 171,["169"] = 171,["170"] = 172,["171"] = 173,["173"] = 175,["174"] = 176,["175"] = 177,["176"] = 181,["177"] = 181,["178"] = 181,["179"] = 181,["180"] = 181,["181"] = 181,["183"] = 171,["184"] = 171,["185"] = 185,["186"] = 185,["187"] = 185,["188"] = 186,["189"] = 185,["190"] = 185,["192"] = 190,["193"] = 191,["194"] = 192,["196"] = 194,["199"] = 137,["200"] = 200,["201"] = 201,["202"] = 201,["203"] = 201,["204"] = 202,["205"] = 203,["206"] = 204,["207"] = 205,["209"] = 207,["210"] = 208,["212"] = 210,["213"] = 211,["215"] = 213,["216"] = 214,["218"] = 216,["219"] = 217,["222"] = 201,["223"] = 201,["224"] = 200,["225"] = 223,["226"] = 224,["227"] = 224,["228"] = 224,["229"] = 225,["230"] = 226,["231"] = 227,["233"] = 224,["234"] = 224,["235"] = 223,["236"] = 232,["237"] = 233,["238"] = 234,["239"] = 232,["240"] = 237,["241"] = 238,["242"] = 238,["243"] = 238,["244"] = 239,["245"] = 240,["247"] = 242,["248"] = 243,["249"] = 238,["250"] = 238,["251"] = 245,["252"] = 245,["253"] = 245,["254"] = 246,["255"] = 247,["257"] = 245,["258"] = 245,["259"] = 237,["260"] = 252,["261"] = 253,["262"] = 254,["263"] = 252,["264"] = 257,["265"] = 258,["266"] = 258,["267"] = 258,["268"] = 258,["269"] = 258,["270"] = 258,["271"] = 258,["272"] = 258,["273"] = 258,["274"] = 258,["275"] = 257,["276"] = 267,["277"] = 268,["278"] = 268,["279"] = 268,["280"] = 268,["281"] = 268,["282"] = 267,["283"] = 271,["284"] = 272,["285"] = 271,["286"] = 30,["287"] = 30});
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
local ____gem = require("clases.gem")
local Diamond = ____gem.Diamond
____exports.RoomType = RoomType or ({})
____exports.RoomType.REGULAR = 0
____exports.RoomType[____exports.RoomType.REGULAR] = "REGULAR"
____exports.RoomType.BOSS = 1
____exports.RoomType[____exports.RoomType.BOSS] = "BOSS"
____exports.RoomType.BONUS = 2
____exports.RoomType[____exports.RoomType.BONUS] = "BONUS"
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Room = ____exports.default
    Room.name = "Room"
    __TS__ClassExtends(Room, GameState)
    function Room.prototype.____constructor(self, alliances, duration, stage, options)
        GameState.prototype.____constructor(self, alliances, duration)
        self.applyRewardsDelay = 1 * 30
        self.rewardsMenuDelay = -1
        self.spawnQueue = {}
        self.ais = {}
        self.remainingWaveNpcs = 0
        self.currentWave = 0
        self.waves = options.waves
        self.totalNpcs = self:GetTotalNPCs(self.waves)
        self.remainingTotalNpcs = self.totalNpcs
        self.stage = stage
        self.type = options.type
        self.spawnDiamond = options.spawnDiamond
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
        local upgradesReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc:IsSelectingFavor() then
                        upgradesReady = false
                    end
                end
            end
        )
        if upgradesReady then
            self.rewardsMenuDelay = 2 * 30
        end
    end
    function Room.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.remainingWaveNpcs <= 0 then
            if self.currentWave == (#self.waves - 1) then
                if self.spawnDiamond and (not self.diamond) then
                    self.diamond = __TS__New(
                        Diamond,
                        Vector(0, 0, 300)
                    )
                    self.spawnDiamond = false
                end
                if not self.diamond then
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
        if self.diamond then
            if self.diamond.unit:IsAlive() then
                self.diamond:Update()
            else
                self.diamond = nil
            end
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
