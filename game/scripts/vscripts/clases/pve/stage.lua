local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 2,["16"] = 2,["17"] = 3,["18"] = 3,["19"] = 6,["20"] = 6,["21"] = 12,["22"] = 16,["23"] = 16,["24"] = 16,["25"] = 16,["26"] = 16,["27"] = 16,["28"] = 16,["29"] = 16,["30"] = 16,["31"] = 55,["32"] = 55,["33"] = 55,["34"] = 55,["35"] = 63,["36"] = 55,["37"] = 60,["38"] = 61,["39"] = 65,["40"] = 66,["41"] = 67,["42"] = 68,["43"] = 63,["44"] = 71,["45"] = 72,["46"] = 73,["47"] = 76,["48"] = 71,["49"] = 79,["50"] = 55,["51"] = 81,["52"] = 82,["54"] = 84,["55"] = 85,["56"] = 87,["58"] = 89,["61"] = 79,["62"] = 94,["63"] = 95,["64"] = 96,["66"] = 98,["67"] = 99,["69"] = 101,["70"] = 102,["72"] = 104,["73"] = 94,["74"] = 107,["75"] = 108,["76"] = 110,["77"] = 110,["78"] = 110,["79"] = 110,["80"] = 110,["81"] = 110,["82"] = 110,["83"] = 110,["84"] = 110,["85"] = 110,["86"] = 110,["87"] = 110,["88"] = 110,["89"] = 107,["90"] = 119,["91"] = 120,["92"] = 121,["94"] = 128,["95"] = 129,["97"] = 137,["98"] = 119,["99"] = 144,["100"] = 145,["101"] = 147,["102"] = 147,["103"] = 147,["104"] = 148,["105"] = 149,["106"] = 150,["107"] = 150,["108"] = 150,["109"] = 150,["110"] = 154,["111"] = 155,["112"] = 156,["115"] = 147,["116"] = 147,["117"] = 165,["118"] = 144,["119"] = 168,["120"] = 169,["121"] = 171,["122"] = 172,["124"] = 174,["125"] = 175,["127"] = 177,["128"] = 168,["129"] = 180,["130"] = 181,["131"] = 185,["132"] = 186,["133"] = 186,["134"] = 186,["135"] = 187,["137"] = 189,["138"] = 189,["139"] = 190,["140"] = 191,["141"] = 191,["142"] = 189,["146"] = 194,["147"] = 194,["148"] = 195,["149"] = 196,["150"] = 197,["151"] = 197,["153"] = 194,["156"] = 186,["157"] = 186,["158"] = 202,["159"] = 180,["160"] = 205,["161"] = 206,["162"] = 207,["164"] = 209,["165"] = 210,["167"] = 217,["168"] = 218,["169"] = 219,["171"] = 222,["173"] = 223,["174"] = 223,["175"] = 224,["176"] = 223,["179"] = 227,["180"] = 205,["181"] = 230,["182"] = 231,["183"] = 231,["184"] = 231,["185"] = 231,["186"] = 230,["187"] = 234,["188"] = 235,["189"] = 237,["190"] = 242,["192"] = 244,["194"] = 246,["195"] = 247,["196"] = 234,["197"] = 250,["198"] = 251,["199"] = 250});
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
