--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 10,["18"] = 11,["19"] = 11,["20"] = 12,["21"] = 12,["22"] = 13,["23"] = 13,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 39,["34"] = 39,["35"] = 39,["36"] = 39,["37"] = 39,["38"] = 55,["39"] = 39,["40"] = 41,["41"] = 42,["42"] = 43,["43"] = 44,["44"] = 48,["45"] = 49,["46"] = 57,["47"] = 58,["48"] = 59,["49"] = 60,["50"] = 61,["51"] = 62,["52"] = 63,["53"] = 64,["54"] = 65,["55"] = 67,["56"] = 68,["57"] = 68,["58"] = 68,["59"] = 69,["60"] = 68,["61"] = 68,["62"] = 71,["63"] = 71,["64"] = 71,["65"] = 72,["66"] = 71,["67"] = 71,["68"] = 55,["69"] = 76,["70"] = 77,["71"] = 78,["72"] = 82,["73"] = 76,["74"] = 85,["75"] = 86,["76"] = 87,["77"] = 88,["78"] = 88,["79"] = 88,["80"] = 89,["81"] = 90,["82"] = 91,["83"] = 92,["84"] = 88,["85"] = 88,["86"] = 85,["87"] = 96,["88"] = 97,["89"] = 98,["90"] = 98,["91"] = 98,["92"] = 98,["93"] = 99,["94"] = 100,["95"] = 101,["96"] = 102,["98"] = 106,["99"] = 96,["100"] = 109,["101"] = 110,["102"] = 110,["103"] = 110,["104"] = 110,["105"] = 111,["106"] = 112,["108"] = 109,["109"] = 116,["110"] = 117,["111"] = 118,["112"] = 118,["113"] = 118,["114"] = 119,["115"] = 120,["116"] = 121,["117"] = 122,["120"] = 118,["121"] = 118,["122"] = 127,["123"] = 128,["125"] = 116,["126"] = 132,["127"] = 133,["128"] = 134,["129"] = 134,["130"] = 134,["131"] = 135,["132"] = 136,["133"] = 137,["134"] = 138,["137"] = 134,["138"] = 134,["139"] = 143,["140"] = 144,["142"] = 132,["143"] = 148,["144"] = 39,["145"] = 151,["146"] = 152,["147"] = 153,["148"] = 154,["149"] = 154,["150"] = 154,["151"] = 154,["152"] = 155,["154"] = 157,["155"] = 158,["156"] = 159,["157"] = 160,["159"] = 162,["160"] = 163,["162"] = 166,["163"] = 167,["164"] = 168,["166"] = 170,["167"] = 171,["169"] = 174,["170"] = 175,["174"] = 179,["177"] = 182,["178"] = 182,["179"] = 182,["180"] = 183,["181"] = 184,["183"] = 186,["184"] = 187,["185"] = 188,["186"] = 192,["187"] = 192,["188"] = 192,["189"] = 192,["190"] = 192,["191"] = 192,["193"] = 182,["194"] = 182,["195"] = 196,["196"] = 196,["197"] = 196,["198"] = 197,["199"] = 196,["200"] = 196,["202"] = 201,["203"] = 202,["204"] = 203,["206"] = 205,["209"] = 148,["210"] = 211,["211"] = 212,["212"] = 212,["213"] = 212,["214"] = 213,["215"] = 214,["216"] = 215,["217"] = 216,["219"] = 218,["220"] = 219,["222"] = 221,["223"] = 222,["225"] = 224,["226"] = 225,["228"] = 227,["229"] = 228,["232"] = 212,["233"] = 212,["234"] = 211,["235"] = 234,["236"] = 235,["237"] = 235,["238"] = 235,["239"] = 236,["240"] = 237,["241"] = 238,["243"] = 235,["244"] = 235,["245"] = 234,["246"] = 243,["247"] = 244,["248"] = 245,["249"] = 243,["250"] = 248,["251"] = 249,["252"] = 249,["253"] = 249,["254"] = 250,["255"] = 251,["257"] = 253,["258"] = 254,["259"] = 249,["260"] = 249,["261"] = 256,["262"] = 256,["263"] = 256,["264"] = 257,["265"] = 258,["267"] = 256,["268"] = 256,["269"] = 248,["270"] = 263,["271"] = 264,["272"] = 265,["273"] = 263,["274"] = 268,["275"] = 269,["276"] = 269,["277"] = 269,["278"] = 269,["279"] = 269,["280"] = 269,["281"] = 269,["282"] = 269,["283"] = 269,["284"] = 269,["285"] = 268,["286"] = 278,["287"] = 279,["288"] = 279,["289"] = 279,["290"] = 279,["291"] = 279,["292"] = 278,["293"] = 282,["294"] = 283,["295"] = 282,["296"] = 39,["297"] = 39});
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
____exports.RoomCompletionCriteria = RoomCompletionCriteria or ({})
____exports.RoomCompletionCriteria.KILL_ALL_ENEMIES = 0
____exports.RoomCompletionCriteria[____exports.RoomCompletionCriteria.KILL_ALL_ENEMIES] = "KILL_ALL_ENEMIES"
____exports.RoomCompletionCriteria.PICKUP_REWARD = 1
____exports.RoomCompletionCriteria[____exports.RoomCompletionCriteria.PICKUP_REWARD] = "PICKUP_REWARD"
____exports.RoomCompletionCriteria.PICKUP_DIAMOND = 2
____exports.RoomCompletionCriteria[____exports.RoomCompletionCriteria.PICKUP_DIAMOND] = "PICKUP_DIAMOND"
____exports.RoomCompletionCriteria.PICKUP_DIAMOND_AND_REWARD = 3
____exports.RoomCompletionCriteria[____exports.RoomCompletionCriteria.PICKUP_DIAMOND_AND_REWARD] = "PICKUP_DIAMOND_AND_REWARD"
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
        self.completitionCriteria = options.completitionCriteria
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
