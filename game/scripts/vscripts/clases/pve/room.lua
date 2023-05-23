local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 11,["23"] = 11,["24"] = 13,["25"] = 14,["26"] = 14,["27"] = 15,["28"] = 15,["29"] = 16,["30"] = 16,["31"] = 17,["32"] = 17,["33"] = 18,["34"] = 18,["35"] = 20,["36"] = 21,["37"] = 21,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 41,["45"] = 41,["46"] = 41,["47"] = 41,["48"] = 59,["49"] = 41,["50"] = 43,["51"] = 44,["52"] = 45,["53"] = 46,["54"] = 50,["55"] = 51,["56"] = 54,["57"] = 55,["58"] = 56,["59"] = 61,["60"] = 62,["61"] = 63,["62"] = 64,["63"] = 65,["64"] = 66,["65"] = 67,["66"] = 68,["67"] = 69,["68"] = 71,["69"] = 72,["70"] = 72,["71"] = 72,["72"] = 73,["73"] = 72,["74"] = 72,["75"] = 75,["76"] = 75,["77"] = 75,["78"] = 76,["79"] = 75,["80"] = 75,["81"] = 79,["82"] = 79,["83"] = 79,["84"] = 79,["85"] = 79,["86"] = 59,["87"] = 82,["88"] = 83,["89"] = 83,["90"] = 83,["91"] = 86,["92"] = 86,["93"] = 86,["94"] = 83,["95"] = 83,["96"] = 83,["97"] = 83,["98"] = 90,["99"] = 82,["100"] = 93,["101"] = 94,["102"] = 95,["103"] = 96,["104"] = 96,["105"] = 96,["106"] = 97,["107"] = 98,["108"] = 99,["109"] = 101,["110"] = 101,["111"] = 96,["112"] = 96,["113"] = 93,["114"] = 112,["115"] = 113,["116"] = 115,["117"] = 116,["118"] = 116,["119"] = 116,["120"] = 116,["121"] = 117,["122"] = 118,["123"] = 119,["124"] = 120,["126"] = 124,["127"] = 112,["128"] = 127,["129"] = 128,["130"] = 129,["131"] = 129,["132"] = 129,["133"] = 130,["134"] = 131,["135"] = 132,["136"] = 133,["139"] = 129,["140"] = 129,["141"] = 138,["142"] = 139,["144"] = 127,["145"] = 143,["146"] = 144,["147"] = 145,["148"] = 145,["149"] = 145,["150"] = 146,["151"] = 147,["152"] = 148,["153"] = 149,["156"] = 145,["157"] = 145,["158"] = 154,["159"] = 155,["161"] = 143,["162"] = 159,["163"] = 41,["164"] = 161,["165"] = 163,["166"] = 164,["168"] = 166,["169"] = 167,["171"] = 169,["172"] = 170,["174"] = 172,["175"] = 173,["177"] = 175,["178"] = 176,["180"] = 159,["181"] = 180,["182"] = 181,["183"] = 182,["184"] = 182,["185"] = 182,["186"] = 182,["188"] = 184,["189"] = 185,["191"] = 187,["192"] = 188,["195"] = 180,["196"] = 193,["197"] = 194,["198"] = 195,["200"] = 198,["201"] = 199,["202"] = 200,["204"] = 202,["207"] = 205,["208"] = 206,["210"] = 193,["211"] = 210,["212"] = 211,["213"] = 211,["214"] = 211,["215"] = 212,["216"] = 213,["217"] = 214,["219"] = 216,["220"] = 216,["221"] = 217,["223"] = 211,["224"] = 211,["225"] = 210,["226"] = 222,["227"] = 223,["228"] = 223,["229"] = 223,["230"] = 224,["231"] = 223,["232"] = 223,["233"] = 222,["234"] = 228,["235"] = 229,["236"] = 230,["237"] = 231,["238"] = 232,["239"] = 233,["241"] = 235,["242"] = 235,["243"] = 235,["244"] = 236,["245"] = 235,["246"] = 235,["247"] = 228,["248"] = 240,["249"] = 241,["250"] = 242,["251"] = 243,["252"] = 244,["253"] = 245,["255"] = 240,["256"] = 249,["257"] = 250,["258"] = 250,["259"] = 250,["260"] = 251,["261"] = 252,["262"] = 252,["263"] = 252,["264"] = 252,["265"] = 253,["266"] = 254,["268"] = 250,["269"] = 250,["270"] = 249,["271"] = 259,["272"] = 260,["273"] = 260,["274"] = 260,["275"] = 261,["276"] = 262,["277"] = 263,["278"] = 264,["279"] = 265,["280"] = 265,["283"] = 260,["284"] = 260,["285"] = 259,["286"] = 271,["287"] = 272,["288"] = 273,["289"] = 274,["291"] = 276,["292"] = 271,["293"] = 279,["294"] = 280,["295"] = 281,["296"] = 282,["297"] = 279,["298"] = 285,["299"] = 286,["300"] = 286,["301"] = 286,["302"] = 287,["303"] = 288,["304"] = 289,["305"] = 286,["306"] = 286,["307"] = 291,["308"] = 291,["309"] = 291,["310"] = 292,["311"] = 293,["313"] = 291,["314"] = 291,["315"] = 285,["316"] = 298,["317"] = 299,["318"] = 300,["319"] = 300,["320"] = 300,["321"] = 301,["322"] = 300,["323"] = 300,["324"] = 298,["325"] = 305,["326"] = 306,["327"] = 307,["328"] = 305,["329"] = 310,["330"] = 311,["331"] = 311,["332"] = 311,["333"] = 311,["334"] = 311,["335"] = 310,["336"] = 314,["337"] = 315,["338"] = 314});
local ____exports = {}
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local ____settings = require("settings")
local settings = ____settings.default
local ____custom_events = require("custom_events")
local CustomEvents = ____custom_events.CustomEvents
local ____rewards = require("rewards.rewards")
local RewardsManager = ____rewards.RewardsManager
local ____gem = require("clases.gem")
local Diamond = ____gem.Diamond
local ____spawner = require("clases.pve.spawner")
local Spawner = ____spawner.default
____exports.RoomType = RoomType or ({})
____exports.RoomType.REGULAR = 0
____exports.RoomType[____exports.RoomType.REGULAR] = "REGULAR"
____exports.RoomType.FIRST_ROOM = 1
____exports.RoomType[____exports.RoomType.FIRST_ROOM] = "FIRST_ROOM"
____exports.RoomType.LEVELUP = 2
____exports.RoomType[____exports.RoomType.LEVELUP] = "LEVELUP"
____exports.RoomType.BOSS = 3
____exports.RoomType[____exports.RoomType.BOSS] = "BOSS"
____exports.RoomType.BONUS = 4
____exports.RoomType[____exports.RoomType.BONUS] = "BONUS"
____exports.RoomPhases = RoomPhases or ({})
____exports.RoomPhases.DIAMOND = 0
____exports.RoomPhases[____exports.RoomPhases.DIAMOND] = "DIAMOND"
____exports.RoomPhases.WAVES = 1
____exports.RoomPhases[____exports.RoomPhases.WAVES] = "WAVES"
____exports.RoomPhases.REWARD_CLAIM = 2
____exports.RoomPhases[____exports.RoomPhases.REWARD_CLAIM] = "REWARD_CLAIM"
____exports.RoomPhases.REWARD_OFFERING = 3
____exports.RoomPhases[____exports.RoomPhases.REWARD_OFFERING] = "REWARD_OFFERING"
____exports.default = __TS__Class()
local Room = ____exports.default
Room.name = "Room"
__TS__ClassExtends(Room, GameState)
function Room.prototype.____constructor(self, alliances, duration, stage, options)
    GameState.prototype.____constructor(self, alliances, duration)
    self.claimRewardsDelay = 1 * 30
    self.rewardsMenuDelay = 2 * 30
    self.spawners = {}
    self.ais = {}
    self.remainingWaveNpcs = 0
    self.currentWave = -1
    self.rewardEntities = {}
    self.phases = {}
    self.phaseIndex = 0
    self.waves = options.waves
    self.totalNpcs = self:GetTotalNPCs(self.waves)
    self.remainingTotalNpcs = self.totalNpcs
    self.stage = stage
    self.heroesData = options.heroesData
    self.phases = options.phases
    self.phaseIndex = 0
    self.type = options.type
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
    ListenToGameEvent(
        "entity_killed",
        function(event) return self:OnUnitDies(event) end,
        nil
    )
end
function Room.prototype.SendDataToClient(self)
    local data = {
        remainingEnemies = self.totalNpcs - self.remainingTotalNpcs,
        maxEnemies = self.totalNpcs,
        roomPhases = __TS__ArrayMap(
            self.phases,
            function(____, phase) return ____exports.RoomPhases[phase] end
        ),
        roomPhaseIndex = self.phaseIndex,
        roomType = ____exports.RoomType[self.type]
    }
    CustomNetTables:SetTableValue("main", "pve", data)
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
            local ____self_spawners_0 = self.spawners
            ____self_spawners_0[#____self_spawners_0 + 1] = __TS__New(Spawner, {delayTime = 2, remainingTime = 2, origin = origin, name = npc})
        end
    )
end
function Room.prototype.OnUnitDies(self, event)
    local killed = EntIndexToHScript(event.entindex_killed)
    local previousNpcs = #self.ais
    self.ais = __TS__ArrayFilter(
        self.ais,
        function(____, ai) return ai.unit ~= killed end
    )
    if previousNpcs > #self.ais then
        self.remainingWaveNpcs = self.remainingWaveNpcs - 1
        self.remainingTotalNpcs = self.remainingTotalNpcs - 1
        EFX("particles/econ/events/new_bloom/dragon_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, killed, {release = true})
    end
    self:SendDataToClient()
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
    if rewardsReady and self.phases[self.phaseIndex + 1] == ____exports.RoomPhases.REWARD_OFFERING then
        self:IncrementPhase()
    end
end
function Room.prototype.OnRewardApplied(self)
    local upgradesReady = true
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local customNpc = player.customNpc
            if customNpc then
                if customNpc:IsSelectingUpgrade() then
                    upgradesReady = false
                end
            end
        end
    )
    if upgradesReady and self.phases[self.phaseIndex + 1] == ____exports.RoomPhases.REWARD_CLAIM then
        self:IncrementPhase()
    end
end
function Room.prototype.Update(self)
    GameState.prototype.Update(self)
    local currentPhase = self.phases[self.phaseIndex + 1]
    if currentPhase == ____exports.RoomPhases.DIAMOND then
        self:UpdateDiamond()
    end
    if currentPhase == ____exports.RoomPhases.WAVES then
        self:UpdateWaves()
    end
    if currentPhase == ____exports.RoomPhases.REWARD_CLAIM then
        self:UpdateRewardClaim()
    end
    if currentPhase == ____exports.RoomPhases.REWARD_OFFERING then
        self:UpdateRewardOffering()
    end
    if self.timeRemaining == 0 then
        self:End()
    end
end
function Room.prototype.UpdateDiamond(self)
    if not self.diamond then
        self.diamond = __TS__New(
            Diamond,
            Vector(0, 0, 300)
        )
    else
        if self.diamond.unit:IsAlive() then
            self.diamond:Update()
        else
            self.diamond = nil
            self:IncrementPhase()
        end
    end
end
function Room.prototype.UpdateWaves(self)
    if self.currentWave == -1 then
        self:IncrementWave()
    end
    if self.remainingWaveNpcs <= 0 then
        if self.currentWave == #self.waves - 1 then
            self:IncrementPhase()
        else
            self:IncrementWave()
        end
    else
        self:UpdateSpanwers()
        self:UpdateAis()
    end
end
function Room.prototype.UpdateSpanwers(self)
    __TS__ArrayForEach(
        self.spawners,
        function(____, spawner)
            local ai = spawner:GetAi()
            if not ai then
                spawner:Update()
            else
                local ____self_ais_1 = self.ais
                ____self_ais_1[#____self_ais_1 + 1] = ai
                self:RemoveSpawner(spawner)
            end
        end
    )
end
function Room.prototype.UpdateAis(self)
    __TS__ArrayForEach(
        self.ais,
        function(____, ai)
            ai:Update()
        end
    )
end
function Room.prototype.UpdateRewardClaim(self)
    if self.claimRewardsDelay == 0 then
        self:ClaimRewards()
        self.claimRewardsDelay = self.claimRewardsDelay - 1
    elseif self.claimRewardsDelay > 0 then
        self.claimRewardsDelay = self.claimRewardsDelay - 1
    end
    __TS__ArrayForEach(
        self.rewardEntities,
        function(____, rewardEntity)
            rewardEntity:Update()
        end
    )
end
function Room.prototype.UpdateRewardOffering(self)
    if self.rewardsMenuDelay == 0 then
        self:OfferRewards()
        self.rewardsMenuDelay = self.rewardsMenuDelay - 1
    elseif self.rewardsMenuDelay > 0 then
        self.rewardsMenuDelay = self.rewardsMenuDelay - 1
    end
end
function Room.prototype.OfferRewards(self)
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local customNpc = player.customNpc
            local heroData = __TS__ArrayFilter(
                self.heroesData,
                function(____, heroData) return heroData.customNpc == customNpc end
            )[1]
            if customNpc and heroData then
                RewardsManager:OfferRewardsForHero(customNpc, heroData.nextRewardOfferings)
            end
        end
    )
end
function Room.prototype.ClaimRewards(self)
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local customNpc = player.customNpc
            if customNpc and customNpc.reward then
                local rewardEntity = RewardsManager:ClaimRewardForHero(customNpc, customNpc.reward)
                if rewardEntity then
                    local ____self_rewardEntities_2 = self.rewardEntities
                    ____self_rewardEntities_2[#____self_rewardEntities_2 + 1] = rewardEntity
                end
            end
        end
    )
end
function Room.prototype.IncrementPhase(self)
    self.phaseIndex = self.phaseIndex + 1
    if not self.phases[self.phaseIndex + 1] then
        self:SetDuration(settings.PreStageDuration)
    end
    self:SendDataToClient()
end
function Room.prototype.IncrementWave(self)
    self.currentWave = self.currentWave + 1
    self:StartWave(self.currentWave)
    self:SendDataToClient()
end
function Room.prototype.SkipWave(self)
    __TS__ArrayForEach(
        self.spawners,
        function(____, spawner)
            self:RemoveSpawner(spawner)
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
function Room.prototype.RemoveSpawner(self, spawner)
    spawner:Destroy()
    self.spawners = __TS__ArrayFilter(
        self.spawners,
        function(____, _spawner)
            local ____ = spawner ~= _spawner
        end
    )
end
function Room.prototype.SkipRoom(self)
    self.currentWave = #self.waves - 1
    self:SkipWave()
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
return ____exports
