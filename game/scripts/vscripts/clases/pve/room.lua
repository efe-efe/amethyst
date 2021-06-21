--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 6,["12"] = 6,["13"] = 7,["14"] = 7,["15"] = 8,["16"] = 8,["17"] = 12,["18"] = 13,["19"] = 13,["20"] = 14,["21"] = 14,["22"] = 15,["23"] = 15,["24"] = 16,["25"] = 16,["26"] = 17,["27"] = 17,["28"] = 20,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 24,["36"] = 24,["37"] = 50,["38"] = 50,["39"] = 59,["40"] = 60,["41"] = 61,["42"] = 62,["43"] = 63,["44"] = 64,["45"] = 59,["46"] = 67,["47"] = 68,["50"] = 71,["51"] = 72,["53"] = 74,["54"] = 75,["55"] = 78,["57"] = 67,["58"] = 82,["59"] = 83,["60"] = 92,["61"] = 82,["62"] = 97,["63"] = 98,["64"] = 99,["65"] = 100,["67"] = 103,["68"] = 104,["70"] = 97,["71"] = 108,["72"] = 109,["73"] = 110,["74"] = 111,["76"] = 108,["77"] = 115,["78"] = 116,["79"] = 115,["80"] = 119,["81"] = 119,["82"] = 119,["83"] = 119,["84"] = 119,["85"] = 137,["86"] = 119,["87"] = 121,["88"] = 122,["89"] = 123,["90"] = 124,["91"] = 128,["92"] = 129,["93"] = 132,["94"] = 133,["95"] = 134,["96"] = 139,["97"] = 140,["98"] = 141,["99"] = 142,["100"] = 143,["101"] = 144,["102"] = 145,["103"] = 146,["104"] = 147,["105"] = 149,["106"] = 150,["107"] = 150,["108"] = 150,["109"] = 151,["110"] = 150,["111"] = 150,["112"] = 153,["113"] = 153,["114"] = 153,["115"] = 154,["116"] = 153,["117"] = 153,["118"] = 157,["119"] = 157,["120"] = 157,["121"] = 157,["122"] = 157,["123"] = 158,["124"] = 158,["125"] = 158,["126"] = 158,["127"] = 158,["128"] = 137,["129"] = 161,["130"] = 162,["131"] = 162,["132"] = 162,["133"] = 165,["134"] = 165,["135"] = 165,["136"] = 162,["137"] = 162,["138"] = 162,["139"] = 162,["140"] = 169,["141"] = 161,["142"] = 172,["143"] = 173,["144"] = 174,["145"] = 175,["146"] = 175,["147"] = 175,["148"] = 176,["149"] = 177,["150"] = 178,["151"] = 180,["152"] = 180,["153"] = 180,["154"] = 180,["155"] = 175,["156"] = 175,["157"] = 172,["158"] = 189,["159"] = 190,["160"] = 192,["161"] = 193,["162"] = 193,["163"] = 193,["164"] = 193,["165"] = 194,["166"] = 195,["167"] = 196,["168"] = 197,["170"] = 201,["171"] = 189,["172"] = 204,["173"] = 205,["174"] = 206,["175"] = 206,["176"] = 206,["177"] = 206,["178"] = 207,["179"] = 208,["181"] = 204,["182"] = 212,["183"] = 213,["184"] = 214,["185"] = 214,["186"] = 214,["187"] = 215,["188"] = 216,["189"] = 217,["190"] = 218,["193"] = 214,["194"] = 214,["195"] = 223,["196"] = 224,["198"] = 212,["199"] = 228,["200"] = 229,["201"] = 230,["202"] = 230,["203"] = 230,["204"] = 231,["205"] = 232,["206"] = 233,["207"] = 234,["210"] = 230,["211"] = 230,["212"] = 239,["213"] = 240,["215"] = 228,["216"] = 244,["217"] = 119,["218"] = 246,["219"] = 248,["220"] = 249,["222"] = 251,["223"] = 252,["225"] = 254,["226"] = 255,["228"] = 257,["229"] = 258,["231"] = 260,["232"] = 261,["234"] = 244,["235"] = 265,["236"] = 266,["237"] = 267,["238"] = 267,["239"] = 267,["240"] = 267,["242"] = 269,["243"] = 270,["245"] = 272,["246"] = 273,["249"] = 265,["250"] = 278,["251"] = 279,["252"] = 280,["254"] = 283,["255"] = 284,["256"] = 285,["258"] = 287,["261"] = 290,["262"] = 291,["264"] = 278,["265"] = 295,["266"] = 296,["267"] = 296,["268"] = 296,["269"] = 297,["270"] = 298,["271"] = 299,["273"] = 301,["274"] = 302,["276"] = 296,["277"] = 296,["278"] = 295,["279"] = 308,["280"] = 309,["281"] = 309,["282"] = 309,["283"] = 310,["284"] = 309,["285"] = 309,["286"] = 308,["287"] = 314,["288"] = 315,["289"] = 316,["290"] = 317,["291"] = 318,["292"] = 319,["294"] = 321,["295"] = 321,["296"] = 321,["297"] = 322,["298"] = 321,["299"] = 321,["300"] = 314,["301"] = 326,["302"] = 327,["303"] = 328,["304"] = 329,["305"] = 330,["306"] = 331,["308"] = 326,["309"] = 335,["310"] = 336,["311"] = 336,["312"] = 336,["313"] = 337,["314"] = 338,["315"] = 338,["316"] = 338,["317"] = 338,["318"] = 339,["319"] = 340,["321"] = 336,["322"] = 336,["323"] = 335,["324"] = 345,["325"] = 346,["326"] = 346,["327"] = 346,["328"] = 347,["329"] = 348,["330"] = 349,["331"] = 350,["332"] = 351,["335"] = 346,["336"] = 346,["337"] = 345,["338"] = 357,["339"] = 358,["340"] = 359,["341"] = 360,["343"] = 362,["344"] = 357,["345"] = 365,["346"] = 366,["347"] = 367,["348"] = 368,["349"] = 365,["350"] = 371,["351"] = 372,["352"] = 372,["353"] = 372,["354"] = 373,["355"] = 374,["356"] = 375,["357"] = 372,["358"] = 372,["359"] = 377,["360"] = 377,["361"] = 377,["362"] = 378,["363"] = 379,["365"] = 377,["366"] = 377,["367"] = 371,["368"] = 384,["369"] = 385,["370"] = 386,["371"] = 386,["372"] = 386,["373"] = 386,["374"] = 386,["375"] = 386,["376"] = 384,["377"] = 389,["378"] = 390,["379"] = 391,["380"] = 389,["381"] = 394,["382"] = 395,["383"] = 395,["384"] = 395,["385"] = 395,["386"] = 395,["387"] = 394,["388"] = 398,["389"] = 399,["390"] = 398,["391"] = 119,["392"] = 119});
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
local Spawner = __TS__Class()
Spawner.name = "Spawner"
function Spawner.prototype.____constructor(self, options)
    self.delayTime = options.delayTime
    self.remainingTime = options.remainingTime * 30
    self.origin = options.origin
    self.name = options.name
    self:CreateEFX()
end
function Spawner.prototype.Update(self)
    if self.remainingTime == -1 then
        return
    end
    if self.remainingTime > 0 then
        self.remainingTime = self.remainingTime - 1
    else
        self.ai = CustomAIMeta[self.name]:factory(self.origin)
        EFX("particles/ai_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.ai.unit, {release = true})
        self:Destroy()
    end
end
function Spawner.prototype.CreateEFX(self)
    self.marker = CreateTimedRadiusMarker(nil, self.origin, 150, self.delayTime, 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName("radius_marker_thinker")
    self.efx = EFX("particles/econ/events/ti10/portal/portal_open_good.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = self.origin})
end
function Spawner.prototype.CleanEFX(self)
    if self.efx then
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
    if self.marker then
        self.marker:Destroy()
    end
end
function Spawner.prototype.Destroy(self)
    if self.remainingTime ~= -1 then
        self:CleanEFX()
        self.remainingTime = -1
    end
end
function Spawner.prototype.GetAi(self)
    return self.ai
end
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
