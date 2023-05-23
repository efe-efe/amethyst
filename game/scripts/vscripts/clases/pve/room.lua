local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 11,["23"] = 11,["24"] = 13,["25"] = 14,["26"] = 14,["27"] = 15,["28"] = 15,["29"] = 16,["30"] = 16,["31"] = 17,["32"] = 17,["33"] = 18,["34"] = 18,["35"] = 20,["36"] = 21,["37"] = 21,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 41,["45"] = 41,["46"] = 41,["47"] = 41,["48"] = 60,["49"] = 41,["50"] = 43,["51"] = 44,["52"] = 45,["53"] = 46,["54"] = 50,["55"] = 51,["56"] = 54,["57"] = 55,["58"] = 56,["59"] = 66,["60"] = 67,["61"] = 68,["62"] = 69,["63"] = 70,["64"] = 71,["65"] = 72,["66"] = 73,["67"] = 74,["68"] = 76,["69"] = 77,["70"] = 77,["71"] = 77,["72"] = 78,["73"] = 77,["74"] = 77,["75"] = 80,["76"] = 80,["77"] = 80,["78"] = 81,["79"] = 80,["80"] = 80,["81"] = 84,["82"] = 84,["83"] = 84,["84"] = 84,["85"] = 84,["86"] = 59,["87"] = 91,["88"] = 92,["89"] = 92,["90"] = 92,["91"] = 95,["92"] = 95,["93"] = 95,["94"] = 92,["95"] = 92,["96"] = 92,["97"] = 92,["98"] = 99,["99"] = 91,["100"] = 102,["101"] = 103,["102"] = 104,["103"] = 105,["104"] = 105,["105"] = 105,["106"] = 106,["107"] = 107,["108"] = 108,["109"] = 110,["110"] = 110,["111"] = 105,["112"] = 105,["113"] = 102,["114"] = 121,["115"] = 122,["116"] = 124,["117"] = 125,["118"] = 125,["119"] = 125,["120"] = 125,["121"] = 126,["122"] = 127,["123"] = 128,["124"] = 129,["126"] = 138,["127"] = 121,["128"] = 141,["129"] = 142,["130"] = 143,["131"] = 143,["132"] = 143,["133"] = 144,["134"] = 145,["135"] = 146,["136"] = 147,["139"] = 143,["140"] = 143,["141"] = 153,["142"] = 156,["144"] = 141,["145"] = 160,["146"] = 161,["147"] = 162,["148"] = 162,["149"] = 162,["150"] = 163,["151"] = 164,["152"] = 165,["153"] = 166,["156"] = 162,["157"] = 162,["158"] = 172,["159"] = 175,["161"] = 160,["162"] = 179,["163"] = 41,["164"] = 181,["165"] = 183,["166"] = 184,["168"] = 186,["169"] = 187,["171"] = 189,["172"] = 190,["174"] = 192,["175"] = 193,["177"] = 195,["178"] = 196,["180"] = 179,["181"] = 200,["182"] = 201,["183"] = 202,["184"] = 202,["185"] = 202,["186"] = 202,["188"] = 204,["189"] = 205,["191"] = 207,["192"] = 208,["195"] = 200,["196"] = 213,["197"] = 214,["198"] = 215,["200"] = 218,["201"] = 219,["202"] = 220,["204"] = 222,["207"] = 225,["208"] = 226,["210"] = 213,["211"] = 230,["212"] = 231,["213"] = 231,["214"] = 231,["215"] = 232,["216"] = 233,["217"] = 234,["219"] = 236,["220"] = 236,["221"] = 237,["223"] = 231,["224"] = 231,["225"] = 230,["226"] = 242,["227"] = 243,["228"] = 243,["229"] = 243,["230"] = 244,["231"] = 243,["232"] = 243,["233"] = 242,["234"] = 248,["235"] = 249,["236"] = 250,["237"] = 251,["238"] = 252,["239"] = 253,["241"] = 255,["242"] = 255,["243"] = 255,["244"] = 256,["245"] = 255,["246"] = 255,["247"] = 248,["248"] = 260,["249"] = 261,["250"] = 262,["251"] = 263,["252"] = 264,["253"] = 265,["255"] = 260,["256"] = 269,["257"] = 270,["258"] = 270,["259"] = 270,["260"] = 271,["261"] = 272,["262"] = 272,["263"] = 272,["264"] = 272,["265"] = 275,["266"] = 276,["268"] = 270,["269"] = 270,["270"] = 269,["271"] = 284,["272"] = 285,["273"] = 285,["274"] = 285,["275"] = 286,["276"] = 287,["277"] = 288,["278"] = 292,["279"] = 293,["280"] = 293,["283"] = 285,["284"] = 285,["285"] = 284,["286"] = 299,["287"] = 300,["288"] = 301,["289"] = 302,["291"] = 304,["292"] = 299,["293"] = 307,["294"] = 308,["295"] = 309,["296"] = 310,["297"] = 307,["298"] = 313,["299"] = 314,["300"] = 314,["301"] = 314,["302"] = 315,["303"] = 316,["304"] = 317,["305"] = 314,["306"] = 314,["307"] = 319,["308"] = 319,["309"] = 319,["310"] = 320,["311"] = 321,["313"] = 319,["314"] = 319,["315"] = 313,["316"] = 326,["317"] = 327,["318"] = 328,["319"] = 328,["320"] = 328,["321"] = 329,["322"] = 328,["323"] = 328,["324"] = 326,["325"] = 333,["326"] = 334,["327"] = 335,["328"] = 333,["329"] = 338,["330"] = 339,["331"] = 339,["332"] = 339,["333"] = 339,["334"] = 339,["335"] = 338,["336"] = 342,["337"] = 343,["338"] = 342});
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
