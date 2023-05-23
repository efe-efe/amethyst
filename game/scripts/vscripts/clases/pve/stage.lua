local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 2,["16"] = 2,["17"] = 3,["18"] = 3,["19"] = 6,["20"] = 6,["21"] = 12,["22"] = 16,["23"] = 16,["24"] = 16,["25"] = 16,["26"] = 16,["27"] = 16,["28"] = 16,["29"] = 16,["30"] = 16,["31"] = 55,["32"] = 55,["33"] = 55,["34"] = 55,["35"] = 63,["36"] = 55,["37"] = 60,["38"] = 61,["39"] = 65,["40"] = 66,["41"] = 67,["42"] = 68,["43"] = 63,["44"] = 71,["45"] = 72,["46"] = 73,["47"] = 76,["48"] = 71,["49"] = 79,["50"] = 55,["51"] = 81,["52"] = 82,["54"] = 84,["55"] = 85,["56"] = 86,["58"] = 88,["61"] = 79,["62"] = 93,["63"] = 94,["64"] = 95,["66"] = 97,["67"] = 98,["69"] = 100,["70"] = 101,["72"] = 103,["73"] = 93,["74"] = 106,["75"] = 107,["76"] = 109,["77"] = 109,["78"] = 109,["79"] = 109,["80"] = 109,["81"] = 109,["82"] = 109,["83"] = 109,["84"] = 109,["85"] = 109,["86"] = 109,["87"] = 109,["88"] = 109,["89"] = 106,["90"] = 118,["91"] = 119,["92"] = 120,["94"] = 123,["95"] = 124,["97"] = 127,["98"] = 118,["99"] = 130,["100"] = 131,["101"] = 133,["102"] = 133,["103"] = 133,["104"] = 134,["105"] = 135,["106"] = 136,["107"] = 136,["108"] = 136,["109"] = 136,["110"] = 140,["111"] = 141,["112"] = 142,["115"] = 133,["116"] = 133,["117"] = 151,["118"] = 130,["119"] = 154,["120"] = 155,["121"] = 157,["122"] = 158,["124"] = 160,["125"] = 161,["127"] = 163,["128"] = 154,["129"] = 166,["130"] = 167,["131"] = 171,["132"] = 172,["133"] = 172,["134"] = 172,["135"] = 173,["137"] = 175,["138"] = 175,["139"] = 176,["140"] = 177,["141"] = 177,["142"] = 175,["146"] = 180,["147"] = 180,["148"] = 181,["149"] = 182,["150"] = 183,["151"] = 183,["153"] = 180,["156"] = 172,["157"] = 172,["158"] = 188,["159"] = 166,["160"] = 191,["161"] = 192,["162"] = 193,["164"] = 195,["165"] = 196,["167"] = 203,["168"] = 204,["169"] = 205,["171"] = 208,["173"] = 209,["174"] = 209,["175"] = 210,["176"] = 209,["179"] = 213,["180"] = 191,["181"] = 216,["182"] = 217,["183"] = 217,["184"] = 217,["185"] = 217,["186"] = 216,["187"] = 220,["188"] = 221,["189"] = 223,["190"] = 228,["192"] = 230,["194"] = 232,["195"] = 233,["196"] = 220,["197"] = 236,["198"] = 237,["199"] = 236});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local CustomAITier = ____custom_ai.CustomAITier
local ____room = require("clases.pve.room")
local Room = ____room.default
local RoomPhases = ____room.RoomPhases
local RoomType = ____room.RoomType
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local ____rewards = require("rewards.rewards")
local RewardsManager = ____rewards.RewardsManager
local mobsDistribution = {
    {{tier = CustomAITier.BASIC, base = 5, optional = 1}, {tier = CustomAITier.MID, base = 0, optional = 0}},
    {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 0, optional = 0}},
    {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 0}},
    {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}},
    {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 1, optional = 0}},
    {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 2, optional = 0}},
    {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}},
    {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}
}
____exports.default = __TS__Class()
local Stage = ____exports.default
Stage.name = "Stage"
__TS__ClassExtends(Stage, GameState)
function Stage.prototype.____constructor(self, alliances, stageData, run)
    GameState.prototype.____constructor(self, alliances, -1)
    self.currentRoomNumber = 0
    self.currentNpcRoomNumber = 0
    self.run = run
    self.possibleNPCs = stageData.possibleNPCs
    self.totalNpcRooms = RandomInt(6, 8)
    self:SendDataToClient()
end
function Stage.prototype.SendDataToClient(self)
    local tableName = "main"
    local data = {currentRoom = self.currentNpcRoomNumber + 1}
    CustomNetTables:SetTableValue(tableName, "pve", data)
end
function Stage.prototype.Update(self)
    GameState.prototype.Update(self)
    if self.room then
        self.room:Update()
    else
        if self.currentNpcRoomNumber < self.totalNpcRooms then
            local spawnDiamond = self.currentRoomNumber == 2 or self.currentRoomNumber == 6
            self.room = self:GenerateRoom(spawnDiamond)
        else
            self:End()
        end
    end
end
function Stage.prototype.GenerateRoomType(self)
    if self.currentNpcRoomNumber == 0 then
        return RoomType.FIRST_ROOM
    end
    if self.currentNpcRoomNumber == self.totalNpcRooms - 1 then
        return RoomType.BOSS
    end
    if self.currentNpcRoomNumber == 3 then
        return RoomType.LEVELUP
    end
    return RoomType.REGULAR
end
function Stage.prototype.GenerateRoom(self, spawnDiamond)
    local ____type = self:GenerateRoomType()
    return __TS__New(
        Room,
        self.alliances,
        -1,
        self,
        {
            waves = self:GenerateWaves(____type),
            spawnDiamond = spawnDiamond,
            heroesData = self:GenerateHeroesData(),
            type = ____type,
            phases = self:GeneratePhases(____type)
        }
    )
end
function Stage.prototype.GeneratePhases(self, ____type)
    if ____type == RoomType.FIRST_ROOM then
        return {RoomPhases.REWARD_CLAIM, RoomPhases.WAVES, RoomPhases.REWARD_OFFERING}
    end
    if ____type == RoomType.LEVELUP then
        return {RoomPhases.DIAMOND, RoomPhases.WAVES, RoomPhases.REWARD_CLAIM, RoomPhases.REWARD_OFFERING}
    end
    return {RoomPhases.WAVES, RoomPhases.REWARD_CLAIM, RoomPhases.REWARD_OFFERING}
end
function Stage.prototype.GenerateHeroesData(self)
    local heroesData = {}
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local customNpc = player.customNpc
            if customNpc then
                local nextRewardOfferings = RewardsManager:GenerateRewards(
                    customNpc,
                    {amount = self:GetRewardsAmount()}
                )
                local currentReward = customNpc.reward
                if currentReward then
                    heroesData[#heroesData + 1] = {customNpc = customNpc, nextRewardOfferings = nextRewardOfferings, currentReward = currentReward}
                end
            end
        end
    )
    return heroesData
end
function Stage.prototype.GetRewardsAmount(self)
    local percentage = RandomInt(1, 100)
    if percentage < 75 then
        return 1
    end
    if percentage >= 75 and percentage < 90 then
        return 2
    end
    return 3
end
function Stage.prototype.GenerateWave(self)
    local wave = {npcs = {}}
    local distribution = mobsDistribution[self.currentNpcRoomNumber + 1]
    __TS__ArrayForEach(
        distribution,
        function(____, mobTier)
            local npcs = self:GetAllNpcsOfTier(mobTier.tier)
            do
                local i = 0
                while i < mobTier.base do
                    local index = RandomInt(0, #npcs - 1)
                    local ____wave_npcs_0 = wave.npcs
                    ____wave_npcs_0[#____wave_npcs_0 + 1] = npcs[index + 1]
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < mobTier.optional do
                    local index = RandomInt(0, #npcs - 1)
                    if RandomInt(1, 2) == 1 then
                        local ____wave_npcs_1 = wave.npcs
                        ____wave_npcs_1[#____wave_npcs_1 + 1] = npcs[index + 1]
                    end
                    i = i + 1
                end
            end
        end
    )
    return wave
end
function Stage.prototype.GenerateWaves(self, ____type)
    if ____type == RoomType.BONUS then
        return {{npcs = {}}}
    end
    if ____type == RoomType.BOSS then
        return {{npcs = {self.possibleNPCs[#self.possibleNPCs]}}}
    end
    local amount = RandomInt(2, 3)
    if ____type == RoomType.FIRST_ROOM then
        amount = 1
    end
    local waves = {}
    do
        local i = 0
        while i < amount do
            waves[#waves + 1] = self:GenerateWave()
            i = i + 1
        end
    end
    return waves
end
function Stage.prototype.GetAllNpcsOfTier(self, tier)
    return __TS__ArrayFilter(
        self.possibleNPCs,
        function(____, npc) return CustomAIMeta[npc].tier == tier end
    )
end
function Stage.prototype.OnRoomCompleted(self)
    if self.room then
        if self.room.type == RoomType.REGULAR or self.room.type == RoomType.BOSS or self.room.type == RoomType.LEVELUP or self.room.type == RoomType.FIRST_ROOM then
            self.currentNpcRoomNumber = self.currentNpcRoomNumber + 1
        end
        self.currentRoomNumber = self.currentRoomNumber + 1
    end
    self.room = nil
    self:SendDataToClient()
end
function Stage.prototype.End(self)
    self.run:OnStageEnd()
end
return ____exports
