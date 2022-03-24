--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 5,["8"] = 5,["9"] = 6,["10"] = 6,["11"] = 7,["12"] = 7,["13"] = 8,["14"] = 8,["15"] = 11,["16"] = 11,["17"] = 13,["18"] = 14,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 20,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 24,["36"] = 24,["37"] = 41,["38"] = 41,["39"] = 41,["40"] = 41,["41"] = 41,["42"] = 59,["43"] = 41,["44"] = 43,["45"] = 44,["46"] = 45,["47"] = 46,["48"] = 50,["49"] = 51,["50"] = 54,["51"] = 55,["52"] = 56,["53"] = 61,["54"] = 62,["55"] = 63,["56"] = 64,["57"] = 65,["58"] = 66,["59"] = 67,["60"] = 68,["61"] = 69,["62"] = 71,["63"] = 72,["64"] = 72,["65"] = 72,["66"] = 73,["67"] = 72,["68"] = 72,["69"] = 75,["70"] = 75,["71"] = 75,["72"] = 76,["73"] = 75,["74"] = 75,["75"] = 79,["76"] = 79,["77"] = 79,["78"] = 79,["79"] = 79,["80"] = 59,["81"] = 82,["82"] = 83,["83"] = 83,["84"] = 83,["85"] = 86,["86"] = 86,["87"] = 86,["88"] = 83,["89"] = 83,["90"] = 83,["91"] = 83,["92"] = 90,["93"] = 82,["94"] = 93,["95"] = 94,["96"] = 95,["97"] = 96,["98"] = 96,["99"] = 96,["100"] = 97,["101"] = 98,["102"] = 99,["103"] = 101,["104"] = 101,["105"] = 101,["106"] = 101,["107"] = 96,["108"] = 96,["109"] = 93,["110"] = 110,["111"] = 111,["112"] = 113,["113"] = 114,["114"] = 114,["115"] = 114,["116"] = 114,["117"] = 115,["118"] = 116,["119"] = 117,["120"] = 118,["122"] = 122,["123"] = 110,["124"] = 125,["125"] = 126,["126"] = 127,["127"] = 127,["128"] = 127,["129"] = 128,["130"] = 129,["131"] = 130,["132"] = 131,["135"] = 127,["136"] = 127,["137"] = 136,["138"] = 137,["140"] = 125,["141"] = 141,["142"] = 142,["143"] = 143,["144"] = 143,["145"] = 143,["146"] = 144,["147"] = 145,["148"] = 146,["149"] = 147,["152"] = 143,["153"] = 143,["154"] = 152,["155"] = 153,["157"] = 141,["158"] = 157,["159"] = 41,["160"] = 159,["161"] = 161,["162"] = 162,["164"] = 164,["165"] = 165,["167"] = 167,["168"] = 168,["170"] = 170,["171"] = 171,["173"] = 173,["174"] = 174,["176"] = 157,["177"] = 178,["178"] = 179,["179"] = 180,["180"] = 180,["181"] = 180,["182"] = 180,["184"] = 182,["185"] = 183,["187"] = 185,["188"] = 186,["191"] = 178,["192"] = 191,["193"] = 192,["194"] = 193,["196"] = 196,["197"] = 197,["198"] = 198,["200"] = 200,["203"] = 203,["204"] = 204,["206"] = 191,["207"] = 208,["208"] = 209,["209"] = 209,["210"] = 209,["211"] = 210,["212"] = 211,["213"] = 212,["215"] = 214,["216"] = 215,["218"] = 209,["219"] = 209,["220"] = 208,["221"] = 221,["222"] = 222,["223"] = 222,["224"] = 222,["225"] = 223,["226"] = 222,["227"] = 222,["228"] = 221,["229"] = 227,["230"] = 228,["231"] = 229,["232"] = 230,["233"] = 231,["234"] = 232,["236"] = 234,["237"] = 234,["238"] = 234,["239"] = 235,["240"] = 234,["241"] = 234,["242"] = 227,["243"] = 239,["244"] = 240,["245"] = 241,["246"] = 242,["247"] = 243,["248"] = 244,["250"] = 239,["251"] = 248,["252"] = 249,["253"] = 249,["254"] = 249,["255"] = 250,["256"] = 251,["257"] = 251,["258"] = 251,["259"] = 251,["260"] = 252,["261"] = 253,["263"] = 249,["264"] = 249,["265"] = 248,["266"] = 258,["267"] = 259,["268"] = 259,["269"] = 259,["270"] = 260,["271"] = 261,["272"] = 262,["273"] = 263,["274"] = 264,["277"] = 259,["278"] = 259,["279"] = 258,["280"] = 270,["281"] = 271,["282"] = 272,["283"] = 273,["285"] = 275,["286"] = 270,["287"] = 278,["288"] = 279,["289"] = 280,["290"] = 281,["291"] = 278,["292"] = 284,["293"] = 285,["294"] = 285,["295"] = 285,["296"] = 286,["297"] = 287,["298"] = 288,["299"] = 285,["300"] = 285,["301"] = 290,["302"] = 290,["303"] = 290,["304"] = 291,["305"] = 292,["307"] = 290,["308"] = 290,["309"] = 284,["310"] = 297,["311"] = 298,["312"] = 299,["313"] = 299,["314"] = 299,["315"] = 299,["316"] = 299,["317"] = 299,["318"] = 297,["319"] = 302,["320"] = 303,["321"] = 304,["322"] = 302,["323"] = 307,["324"] = 308,["325"] = 308,["326"] = 308,["327"] = 308,["328"] = 308,["329"] = 307,["330"] = 311,["331"] = 312,["332"] = 311,["333"] = 41,["334"] = 41});
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
____exports.default = (function()
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
                __TS__ArrayPush(
                    self.spawners,
                    __TS__New(Spawner, {delayTime = 2, remainingTime = 2, origin = origin, name = npc})
                )
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
        if rewardsReady and (self.phases[self.phaseIndex + 1] == ____exports.RoomPhases.REWARD_OFFERING) then
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
        if upgradesReady and (self.phases[self.phaseIndex + 1] == ____exports.RoomPhases.REWARD_CLAIM) then
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
            if self.currentWave == (#self.waves - 1) then
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
                    __TS__ArrayPush(self.ais, ai)
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
                        __TS__ArrayPush(self.rewardEntities, rewardEntity)
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
    return Room
end)()
return ____exports
