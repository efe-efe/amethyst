--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 5,["8"] = 5,["9"] = 6,["10"] = 6,["11"] = 7,["12"] = 7,["13"] = 8,["14"] = 8,["15"] = 11,["16"] = 11,["17"] = 13,["18"] = 14,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 20,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 24,["36"] = 24,["37"] = 41,["38"] = 41,["39"] = 41,["40"] = 41,["41"] = 41,["42"] = 59,["43"] = 41,["44"] = 43,["45"] = 44,["46"] = 45,["47"] = 46,["48"] = 50,["49"] = 51,["50"] = 54,["51"] = 55,["52"] = 56,["53"] = 61,["54"] = 62,["55"] = 63,["56"] = 64,["57"] = 65,["58"] = 66,["59"] = 67,["60"] = 68,["61"] = 69,["62"] = 71,["63"] = 72,["64"] = 72,["65"] = 72,["66"] = 73,["67"] = 72,["68"] = 72,["69"] = 75,["70"] = 75,["71"] = 75,["72"] = 76,["73"] = 75,["74"] = 75,["75"] = 79,["76"] = 79,["77"] = 79,["78"] = 79,["79"] = 79,["80"] = 80,["81"] = 80,["82"] = 80,["83"] = 80,["84"] = 80,["85"] = 59,["86"] = 83,["87"] = 84,["88"] = 84,["89"] = 84,["90"] = 87,["91"] = 87,["92"] = 87,["93"] = 84,["94"] = 84,["95"] = 84,["96"] = 84,["97"] = 91,["98"] = 83,["99"] = 94,["100"] = 95,["101"] = 96,["102"] = 97,["103"] = 97,["104"] = 97,["105"] = 98,["106"] = 99,["107"] = 100,["108"] = 102,["109"] = 102,["110"] = 102,["111"] = 102,["112"] = 97,["113"] = 97,["114"] = 94,["115"] = 111,["116"] = 112,["117"] = 114,["118"] = 115,["119"] = 115,["120"] = 115,["121"] = 115,["122"] = 116,["123"] = 117,["124"] = 118,["125"] = 119,["127"] = 123,["128"] = 111,["129"] = 126,["130"] = 127,["131"] = 128,["132"] = 128,["133"] = 128,["134"] = 128,["135"] = 129,["136"] = 130,["138"] = 126,["139"] = 134,["140"] = 135,["141"] = 136,["142"] = 136,["143"] = 136,["144"] = 137,["145"] = 138,["146"] = 139,["147"] = 140,["150"] = 136,["151"] = 136,["152"] = 145,["153"] = 146,["155"] = 134,["156"] = 150,["157"] = 151,["158"] = 152,["159"] = 152,["160"] = 152,["161"] = 153,["162"] = 154,["163"] = 155,["164"] = 156,["167"] = 152,["168"] = 152,["169"] = 161,["170"] = 162,["172"] = 150,["173"] = 166,["174"] = 41,["175"] = 168,["176"] = 170,["177"] = 171,["179"] = 173,["180"] = 174,["182"] = 176,["183"] = 177,["185"] = 179,["186"] = 180,["188"] = 182,["189"] = 183,["191"] = 166,["192"] = 187,["193"] = 188,["194"] = 189,["195"] = 189,["196"] = 189,["197"] = 189,["199"] = 191,["200"] = 192,["202"] = 194,["203"] = 195,["206"] = 187,["207"] = 200,["208"] = 201,["209"] = 202,["211"] = 205,["212"] = 206,["213"] = 207,["215"] = 209,["218"] = 212,["219"] = 213,["221"] = 200,["222"] = 217,["223"] = 218,["224"] = 218,["225"] = 218,["226"] = 219,["227"] = 220,["228"] = 221,["230"] = 223,["231"] = 224,["233"] = 218,["234"] = 218,["235"] = 217,["236"] = 230,["237"] = 231,["238"] = 231,["239"] = 231,["240"] = 232,["241"] = 231,["242"] = 231,["243"] = 230,["244"] = 236,["245"] = 237,["246"] = 238,["247"] = 239,["248"] = 240,["249"] = 241,["251"] = 243,["252"] = 243,["253"] = 243,["254"] = 244,["255"] = 243,["256"] = 243,["257"] = 236,["258"] = 248,["259"] = 249,["260"] = 250,["261"] = 251,["262"] = 252,["263"] = 253,["265"] = 248,["266"] = 257,["267"] = 258,["268"] = 258,["269"] = 258,["270"] = 259,["271"] = 260,["272"] = 260,["273"] = 260,["274"] = 260,["275"] = 261,["276"] = 262,["278"] = 258,["279"] = 258,["280"] = 257,["281"] = 267,["282"] = 268,["283"] = 268,["284"] = 268,["285"] = 269,["286"] = 270,["287"] = 271,["288"] = 272,["289"] = 273,["292"] = 268,["293"] = 268,["294"] = 267,["295"] = 279,["296"] = 280,["297"] = 281,["298"] = 282,["300"] = 284,["301"] = 279,["302"] = 287,["303"] = 288,["304"] = 289,["305"] = 290,["306"] = 287,["307"] = 293,["308"] = 294,["309"] = 294,["310"] = 294,["311"] = 295,["312"] = 296,["313"] = 297,["314"] = 294,["315"] = 294,["316"] = 299,["317"] = 299,["318"] = 299,["319"] = 300,["320"] = 301,["322"] = 299,["323"] = 299,["324"] = 293,["325"] = 306,["326"] = 307,["327"] = 308,["328"] = 308,["329"] = 308,["330"] = 308,["331"] = 308,["332"] = 308,["333"] = 306,["334"] = 311,["335"] = 312,["336"] = 313,["337"] = 311,["338"] = 316,["339"] = 317,["340"] = 317,["341"] = 317,["342"] = 317,["343"] = 317,["344"] = 316,["345"] = 320,["346"] = 321,["347"] = 320,["348"] = 41,["349"] = 41});
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
        ListenToGameEvent(
            "entity_hurt",
            function(event) return self:OnUnitHurt(event) end,
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
    function Room.prototype.OnUnitHurt(self, event)
        local victim = EntIndexToHScript(event.entindex_killed)
        local ai = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit == victim end
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
        if self.time_remaining == 0 then
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
