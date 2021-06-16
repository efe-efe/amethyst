--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 12,["18"] = 13,["19"] = 13,["20"] = 14,["21"] = 14,["22"] = 15,["23"] = 15,["24"] = 16,["25"] = 16,["26"] = 19,["27"] = 20,["28"] = 20,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 49,["36"] = 49,["37"] = 49,["38"] = 49,["39"] = 49,["40"] = 67,["41"] = 49,["42"] = 51,["43"] = 52,["44"] = 53,["45"] = 54,["46"] = 58,["47"] = 59,["48"] = 62,["49"] = 63,["50"] = 64,["51"] = 69,["52"] = 70,["53"] = 71,["54"] = 72,["55"] = 73,["56"] = 74,["57"] = 75,["58"] = 76,["59"] = 77,["60"] = 79,["61"] = 80,["62"] = 80,["63"] = 80,["64"] = 81,["65"] = 80,["66"] = 80,["67"] = 83,["68"] = 83,["69"] = 83,["70"] = 84,["71"] = 83,["72"] = 83,["73"] = 87,["74"] = 87,["75"] = 87,["76"] = 87,["77"] = 87,["78"] = 88,["79"] = 88,["80"] = 88,["81"] = 88,["82"] = 88,["83"] = 67,["84"] = 91,["85"] = 92,["86"] = 98,["87"] = 91,["88"] = 101,["89"] = 102,["90"] = 103,["91"] = 104,["92"] = 104,["93"] = 104,["94"] = 105,["95"] = 106,["96"] = 107,["97"] = 108,["98"] = 104,["99"] = 104,["100"] = 101,["101"] = 112,["102"] = 113,["103"] = 115,["104"] = 116,["105"] = 116,["106"] = 116,["107"] = 116,["108"] = 117,["109"] = 118,["110"] = 119,["111"] = 120,["113"] = 124,["114"] = 112,["115"] = 127,["116"] = 128,["117"] = 129,["118"] = 129,["119"] = 129,["120"] = 129,["121"] = 130,["122"] = 131,["124"] = 127,["125"] = 135,["126"] = 136,["127"] = 137,["128"] = 137,["129"] = 137,["130"] = 138,["131"] = 139,["132"] = 140,["133"] = 141,["136"] = 137,["137"] = 137,["138"] = 146,["139"] = 147,["141"] = 135,["142"] = 151,["143"] = 152,["144"] = 153,["145"] = 153,["146"] = 153,["147"] = 154,["148"] = 155,["149"] = 156,["150"] = 157,["153"] = 153,["154"] = 153,["155"] = 162,["156"] = 163,["158"] = 151,["159"] = 167,["160"] = 49,["161"] = 169,["162"] = 171,["163"] = 172,["165"] = 174,["166"] = 175,["168"] = 177,["169"] = 178,["171"] = 180,["172"] = 181,["174"] = 183,["175"] = 184,["177"] = 167,["178"] = 188,["179"] = 189,["180"] = 190,["181"] = 190,["182"] = 190,["183"] = 190,["185"] = 192,["186"] = 193,["188"] = 195,["189"] = 196,["192"] = 188,["193"] = 201,["194"] = 202,["195"] = 203,["197"] = 206,["198"] = 207,["199"] = 208,["201"] = 210,["204"] = 213,["205"] = 213,["206"] = 213,["207"] = 214,["208"] = 215,["210"] = 217,["211"] = 218,["212"] = 219,["213"] = 223,["214"] = 223,["215"] = 223,["216"] = 223,["217"] = 223,["218"] = 223,["220"] = 213,["221"] = 213,["222"] = 227,["223"] = 227,["224"] = 227,["225"] = 228,["226"] = 227,["227"] = 227,["229"] = 201,["230"] = 233,["231"] = 234,["232"] = 235,["233"] = 236,["234"] = 237,["235"] = 238,["237"] = 240,["238"] = 240,["239"] = 240,["240"] = 241,["241"] = 240,["242"] = 240,["243"] = 233,["244"] = 245,["245"] = 246,["246"] = 247,["247"] = 248,["248"] = 249,["249"] = 250,["251"] = 245,["252"] = 254,["253"] = 255,["254"] = 255,["255"] = 255,["256"] = 256,["257"] = 257,["258"] = 257,["259"] = 257,["260"] = 257,["261"] = 258,["262"] = 259,["264"] = 255,["265"] = 255,["266"] = 254,["267"] = 264,["268"] = 265,["269"] = 265,["270"] = 265,["271"] = 266,["272"] = 267,["273"] = 268,["274"] = 269,["275"] = 270,["278"] = 265,["279"] = 265,["280"] = 264,["281"] = 276,["282"] = 277,["283"] = 278,["284"] = 279,["286"] = 276,["287"] = 283,["288"] = 284,["289"] = 285,["290"] = 283,["291"] = 288,["292"] = 289,["293"] = 289,["294"] = 289,["295"] = 290,["296"] = 291,["298"] = 293,["299"] = 294,["300"] = 289,["301"] = 289,["302"] = 296,["303"] = 296,["304"] = 296,["305"] = 297,["306"] = 298,["308"] = 296,["309"] = 296,["310"] = 288,["311"] = 303,["312"] = 304,["313"] = 305,["314"] = 303,["315"] = 308,["316"] = 309,["317"] = 309,["318"] = 309,["319"] = 309,["320"] = 309,["321"] = 309,["322"] = 309,["323"] = 309,["324"] = 309,["325"] = 309,["326"] = 308,["327"] = 318,["328"] = 319,["329"] = 319,["330"] = 319,["331"] = 319,["332"] = 319,["333"] = 318,["334"] = 322,["335"] = 323,["336"] = 322,["337"] = 49,["338"] = 49});
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
____exports.RoomType.LEVELUP = 1
____exports.RoomType[____exports.RoomType.LEVELUP] = "LEVELUP"
____exports.RoomType.BOSS = 2
____exports.RoomType[____exports.RoomType.BOSS] = "BOSS"
____exports.RoomType.BONUS = 3
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
        local data = {remainingEnemies = self.totalNpcs - self.remainingTotalNpcs, maxEnemies = self.totalNpcs, roomPhase = ____exports.RoomPhases[self.phases[self.phaseIndex + 1]], roomType = ____exports.RoomType[self.type]}
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
