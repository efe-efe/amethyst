--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 12,["18"] = 13,["19"] = 13,["20"] = 14,["21"] = 14,["22"] = 15,["23"] = 15,["24"] = 16,["25"] = 16,["26"] = 17,["27"] = 17,["28"] = 20,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 24,["36"] = 24,["37"] = 50,["38"] = 50,["39"] = 50,["40"] = 50,["41"] = 50,["42"] = 68,["43"] = 50,["44"] = 52,["45"] = 53,["46"] = 54,["47"] = 55,["48"] = 59,["49"] = 60,["50"] = 63,["51"] = 64,["52"] = 65,["53"] = 70,["54"] = 71,["55"] = 72,["56"] = 73,["57"] = 74,["58"] = 75,["59"] = 76,["60"] = 77,["61"] = 78,["62"] = 80,["63"] = 81,["64"] = 81,["65"] = 81,["66"] = 82,["67"] = 81,["68"] = 81,["69"] = 84,["70"] = 84,["71"] = 84,["72"] = 85,["73"] = 84,["74"] = 84,["75"] = 88,["76"] = 88,["77"] = 88,["78"] = 88,["79"] = 88,["80"] = 89,["81"] = 89,["82"] = 89,["83"] = 89,["84"] = 89,["85"] = 68,["86"] = 92,["87"] = 93,["88"] = 93,["89"] = 93,["90"] = 96,["91"] = 96,["92"] = 96,["93"] = 93,["94"] = 93,["95"] = 93,["96"] = 93,["97"] = 100,["98"] = 92,["99"] = 103,["100"] = 104,["101"] = 105,["102"] = 106,["103"] = 106,["104"] = 106,["105"] = 107,["106"] = 108,["107"] = 109,["108"] = 110,["109"] = 106,["110"] = 106,["111"] = 103,["112"] = 114,["113"] = 115,["114"] = 117,["115"] = 118,["116"] = 118,["117"] = 118,["118"] = 118,["119"] = 119,["120"] = 120,["121"] = 121,["122"] = 122,["124"] = 126,["125"] = 114,["126"] = 129,["127"] = 130,["128"] = 131,["129"] = 131,["130"] = 131,["131"] = 131,["132"] = 132,["133"] = 133,["135"] = 129,["136"] = 137,["137"] = 138,["138"] = 139,["139"] = 139,["140"] = 139,["141"] = 140,["142"] = 141,["143"] = 142,["144"] = 143,["147"] = 139,["148"] = 139,["149"] = 148,["150"] = 149,["152"] = 137,["153"] = 153,["154"] = 154,["155"] = 155,["156"] = 155,["157"] = 155,["158"] = 156,["159"] = 157,["160"] = 158,["161"] = 159,["164"] = 155,["165"] = 155,["166"] = 164,["167"] = 165,["169"] = 153,["170"] = 169,["171"] = 50,["172"] = 171,["173"] = 173,["174"] = 174,["176"] = 176,["177"] = 177,["179"] = 179,["180"] = 180,["182"] = 182,["183"] = 183,["185"] = 185,["186"] = 186,["188"] = 169,["189"] = 190,["190"] = 191,["191"] = 192,["192"] = 192,["193"] = 192,["194"] = 192,["196"] = 194,["197"] = 195,["199"] = 197,["200"] = 198,["203"] = 190,["204"] = 203,["205"] = 204,["206"] = 205,["208"] = 208,["209"] = 209,["210"] = 210,["212"] = 212,["215"] = 215,["216"] = 215,["217"] = 215,["218"] = 216,["219"] = 217,["221"] = 219,["222"] = 220,["223"] = 221,["224"] = 225,["225"] = 225,["226"] = 225,["227"] = 225,["228"] = 225,["229"] = 225,["231"] = 215,["232"] = 215,["233"] = 229,["234"] = 229,["235"] = 229,["236"] = 230,["237"] = 229,["238"] = 229,["240"] = 203,["241"] = 235,["242"] = 236,["243"] = 237,["244"] = 238,["245"] = 239,["246"] = 240,["248"] = 242,["249"] = 242,["250"] = 242,["251"] = 243,["252"] = 242,["253"] = 242,["254"] = 235,["255"] = 247,["256"] = 248,["257"] = 249,["258"] = 250,["259"] = 251,["260"] = 252,["262"] = 247,["263"] = 256,["264"] = 257,["265"] = 257,["266"] = 257,["267"] = 258,["268"] = 259,["269"] = 259,["270"] = 259,["271"] = 259,["272"] = 260,["273"] = 261,["275"] = 257,["276"] = 257,["277"] = 256,["278"] = 266,["279"] = 267,["280"] = 267,["281"] = 267,["282"] = 268,["283"] = 269,["284"] = 270,["285"] = 271,["286"] = 272,["289"] = 267,["290"] = 267,["291"] = 266,["292"] = 278,["293"] = 279,["294"] = 280,["295"] = 281,["297"] = 283,["298"] = 278,["299"] = 286,["300"] = 287,["301"] = 288,["302"] = 289,["303"] = 286,["304"] = 292,["305"] = 293,["306"] = 293,["307"] = 293,["308"] = 294,["309"] = 295,["311"] = 297,["312"] = 298,["313"] = 293,["314"] = 293,["315"] = 300,["316"] = 300,["317"] = 300,["318"] = 301,["319"] = 302,["321"] = 300,["322"] = 300,["323"] = 292,["324"] = 307,["325"] = 308,["326"] = 309,["327"] = 307,["328"] = 312,["329"] = 313,["330"] = 313,["331"] = 313,["332"] = 313,["333"] = 313,["334"] = 313,["335"] = 313,["336"] = 313,["337"] = 313,["338"] = 313,["339"] = 312,["340"] = 322,["341"] = 323,["342"] = 323,["343"] = 323,["344"] = 323,["345"] = 323,["346"] = 322,["347"] = 326,["348"] = 327,["349"] = 326,["350"] = 50,["351"] = 50});
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
local RewardsManager = ____rewards.RewardsManager
local ____gem = require("clases.gem")
local Diamond = ____gem.Diamond
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
        self.spawnQueue = {}
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
                self:SchedulAiSpawn(origin, npc, 1)
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
