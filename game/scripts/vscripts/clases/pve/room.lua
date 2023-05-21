--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 5,["8"] = 5,["9"] = 6,["10"] = 6,["11"] = 7,["12"] = 7,["13"] = 8,["14"] = 8,["15"] = 11,["16"] = 11,["17"] = 13,["18"] = 14,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 20,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 24,["36"] = 24,["37"] = 41,["38"] = 41,["39"] = 41,["40"] = 41,["41"] = 41,["42"] = 60,["43"] = 41,["44"] = 43,["45"] = 44,["46"] = 45,["47"] = 46,["48"] = 50,["49"] = 51,["50"] = 54,["51"] = 55,["52"] = 56,["53"] = 66,["54"] = 67,["55"] = 68,["56"] = 69,["57"] = 70,["58"] = 71,["59"] = 72,["60"] = 73,["61"] = 74,["62"] = 76,["63"] = 77,["64"] = 77,["65"] = 77,["66"] = 78,["67"] = 77,["68"] = 77,["69"] = 80,["70"] = 80,["71"] = 80,["72"] = 81,["73"] = 80,["74"] = 80,["75"] = 84,["76"] = 84,["77"] = 84,["78"] = 84,["79"] = 84,["80"] = 59,["81"] = 91,["82"] = 92,["83"] = 92,["84"] = 92,["85"] = 95,["86"] = 95,["87"] = 95,["88"] = 92,["89"] = 92,["90"] = 92,["91"] = 92,["92"] = 99,["93"] = 91,["94"] = 102,["95"] = 103,["96"] = 104,["97"] = 105,["98"] = 105,["99"] = 105,["100"] = 106,["101"] = 107,["102"] = 108,["103"] = 110,["104"] = 110,["105"] = 110,["106"] = 110,["107"] = 105,["108"] = 105,["109"] = 102,["110"] = 121,["111"] = 122,["112"] = 124,["113"] = 125,["114"] = 125,["115"] = 125,["116"] = 125,["117"] = 126,["118"] = 127,["119"] = 128,["120"] = 129,["122"] = 138,["123"] = 121,["124"] = 141,["125"] = 142,["126"] = 143,["127"] = 143,["128"] = 143,["129"] = 144,["130"] = 145,["131"] = 146,["132"] = 147,["135"] = 143,["136"] = 143,["137"] = 153,["138"] = 156,["140"] = 141,["141"] = 160,["142"] = 161,["143"] = 162,["144"] = 162,["145"] = 162,["146"] = 163,["147"] = 164,["148"] = 165,["149"] = 166,["152"] = 162,["153"] = 162,["154"] = 172,["155"] = 175,["157"] = 160,["158"] = 179,["159"] = 41,["160"] = 181,["161"] = 183,["162"] = 184,["164"] = 186,["165"] = 187,["167"] = 189,["168"] = 190,["170"] = 192,["171"] = 193,["173"] = 195,["174"] = 196,["176"] = 179,["177"] = 200,["178"] = 201,["179"] = 202,["180"] = 202,["181"] = 202,["182"] = 202,["184"] = 204,["185"] = 205,["187"] = 207,["188"] = 208,["191"] = 200,["192"] = 213,["193"] = 214,["194"] = 215,["196"] = 218,["197"] = 219,["198"] = 220,["200"] = 222,["203"] = 225,["204"] = 226,["206"] = 213,["207"] = 230,["208"] = 231,["209"] = 231,["210"] = 231,["211"] = 232,["212"] = 233,["213"] = 234,["215"] = 236,["216"] = 237,["218"] = 231,["219"] = 231,["220"] = 230,["221"] = 242,["222"] = 243,["223"] = 243,["224"] = 243,["225"] = 244,["226"] = 243,["227"] = 243,["228"] = 242,["229"] = 248,["230"] = 249,["231"] = 250,["232"] = 251,["233"] = 252,["234"] = 253,["236"] = 255,["237"] = 255,["238"] = 255,["239"] = 256,["240"] = 255,["241"] = 255,["242"] = 248,["243"] = 260,["244"] = 261,["245"] = 262,["246"] = 263,["247"] = 264,["248"] = 265,["250"] = 260,["251"] = 269,["252"] = 270,["253"] = 270,["254"] = 270,["255"] = 271,["256"] = 272,["257"] = 272,["258"] = 272,["259"] = 272,["260"] = 275,["261"] = 276,["263"] = 270,["264"] = 270,["265"] = 269,["266"] = 284,["267"] = 285,["268"] = 285,["269"] = 285,["270"] = 286,["271"] = 287,["272"] = 288,["273"] = 292,["274"] = 293,["277"] = 285,["278"] = 285,["279"] = 284,["280"] = 299,["281"] = 300,["282"] = 301,["283"] = 302,["285"] = 304,["286"] = 299,["287"] = 307,["288"] = 308,["289"] = 309,["290"] = 310,["291"] = 307,["292"] = 313,["293"] = 314,["294"] = 314,["295"] = 314,["296"] = 315,["297"] = 316,["298"] = 317,["299"] = 314,["300"] = 314,["301"] = 319,["302"] = 319,["303"] = 319,["304"] = 320,["305"] = 321,["307"] = 319,["308"] = 319,["309"] = 313,["310"] = 326,["311"] = 327,["312"] = 328,["313"] = 328,["314"] = 328,["315"] = 329,["316"] = 328,["317"] = 328,["318"] = 326,["319"] = 333,["320"] = 334,["321"] = 335,["322"] = 333,["323"] = 338,["324"] = 339,["325"] = 339,["326"] = 339,["327"] = 339,["328"] = 339,["329"] = 338,["330"] = 342,["331"] = 343,["332"] = 342,["333"] = 41,["334"] = 41});
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
