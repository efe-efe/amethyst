--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 23,["18"] = 23,["19"] = 23,["20"] = 23,["21"] = 23,["22"] = 37,["23"] = 37,["24"] = 37,["26"] = 23,["27"] = 25,["28"] = 26,["29"] = 27,["30"] = 28,["31"] = 32,["32"] = 33,["33"] = 39,["34"] = 40,["35"] = 41,["36"] = 42,["37"] = 43,["38"] = 44,["39"] = 45,["40"] = 47,["41"] = 48,["42"] = 48,["43"] = 48,["44"] = 49,["45"] = 48,["46"] = 48,["47"] = 51,["48"] = 51,["49"] = 51,["50"] = 52,["51"] = 51,["52"] = 51,["53"] = 37,["54"] = 56,["55"] = 57,["56"] = 58,["57"] = 62,["58"] = 56,["59"] = 65,["60"] = 66,["61"] = 67,["62"] = 68,["63"] = 68,["64"] = 68,["65"] = 69,["66"] = 70,["67"] = 71,["68"] = 72,["69"] = 68,["70"] = 68,["71"] = 65,["72"] = 76,["73"] = 77,["74"] = 78,["75"] = 78,["76"] = 78,["77"] = 78,["78"] = 79,["79"] = 80,["80"] = 81,["81"] = 82,["83"] = 86,["84"] = 76,["85"] = 89,["86"] = 90,["87"] = 90,["88"] = 90,["89"] = 90,["90"] = 91,["91"] = 92,["93"] = 89,["94"] = 96,["95"] = 97,["96"] = 98,["97"] = 98,["98"] = 98,["99"] = 99,["100"] = 100,["101"] = 101,["102"] = 102,["105"] = 98,["106"] = 98,["107"] = 107,["108"] = 108,["110"] = 96,["111"] = 112,["112"] = 113,["113"] = 114,["114"] = 114,["115"] = 114,["116"] = 115,["117"] = 116,["118"] = 117,["119"] = 118,["122"] = 114,["123"] = 114,["124"] = 123,["125"] = 124,["127"] = 112,["128"] = 128,["129"] = 23,["130"] = 131,["131"] = 132,["132"] = 133,["133"] = 134,["134"] = 134,["135"] = 134,["136"] = 134,["137"] = 135,["139"] = 137,["140"] = 138,["141"] = 139,["142"] = 140,["144"] = 142,["145"] = 143,["147"] = 146,["148"] = 147,["149"] = 148,["151"] = 150,["152"] = 151,["154"] = 154,["155"] = 155,["159"] = 159,["162"] = 162,["163"] = 162,["164"] = 162,["165"] = 163,["166"] = 164,["168"] = 166,["169"] = 167,["170"] = 168,["171"] = 172,["172"] = 172,["173"] = 172,["174"] = 172,["175"] = 172,["176"] = 172,["178"] = 162,["179"] = 162,["180"] = 176,["181"] = 176,["182"] = 176,["183"] = 177,["184"] = 176,["185"] = 176,["187"] = 181,["188"] = 182,["189"] = 183,["191"] = 185,["194"] = 128,["195"] = 191,["196"] = 192,["197"] = 192,["198"] = 192,["199"] = 193,["200"] = 194,["201"] = 195,["202"] = 196,["204"] = 198,["205"] = 199,["207"] = 201,["208"] = 202,["210"] = 204,["211"] = 205,["213"] = 207,["214"] = 208,["217"] = 192,["218"] = 192,["219"] = 191,["220"] = 214,["221"] = 215,["222"] = 215,["223"] = 215,["224"] = 216,["225"] = 217,["226"] = 218,["228"] = 215,["229"] = 215,["230"] = 214,["231"] = 223,["232"] = 224,["233"] = 225,["234"] = 223,["235"] = 228,["236"] = 229,["237"] = 229,["238"] = 229,["239"] = 230,["240"] = 231,["242"] = 233,["243"] = 234,["244"] = 229,["245"] = 229,["246"] = 236,["247"] = 236,["248"] = 236,["249"] = 237,["250"] = 238,["252"] = 236,["253"] = 236,["254"] = 228,["255"] = 243,["256"] = 244,["257"] = 245,["258"] = 243,["259"] = 248,["260"] = 249,["261"] = 249,["262"] = 249,["263"] = 249,["264"] = 249,["265"] = 249,["266"] = 249,["267"] = 249,["268"] = 249,["269"] = 249,["270"] = 248,["271"] = 258,["272"] = 259,["273"] = 259,["274"] = 259,["275"] = 259,["276"] = 259,["277"] = 258,["278"] = 262,["279"] = 263,["280"] = 262,["281"] = 23,["282"] = 23});
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
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Room = ____exports.default
    Room.name = "Room"
    __TS__ClassExtends(Room, GameState)
    function Room.prototype.____constructor(self, alliances, duration, waves, stage, spawnDiamond)
        if spawnDiamond == nil then
            spawnDiamond = false
        end
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
        self.spawnDiamond = spawnDiamond
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
                        Vector(0, 0, 256)
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
