--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 6,["15"] = 6,["16"] = 12,["17"] = 46,["18"] = 46,["19"] = 46,["20"] = 46,["21"] = 46,["22"] = 54,["23"] = 46,["24"] = 51,["25"] = 52,["26"] = 56,["27"] = 57,["28"] = 58,["29"] = 59,["30"] = 54,["31"] = 62,["32"] = 63,["33"] = 64,["34"] = 67,["35"] = 62,["36"] = 70,["37"] = 46,["38"] = 72,["39"] = 73,["41"] = 75,["42"] = 76,["43"] = 77,["45"] = 79,["48"] = 70,["49"] = 84,["50"] = 85,["51"] = 86,["53"] = 88,["54"] = 89,["56"] = 91,["57"] = 92,["59"] = 94,["60"] = 84,["61"] = 97,["62"] = 98,["63"] = 100,["64"] = 100,["65"] = 100,["66"] = 100,["67"] = 100,["68"] = 100,["69"] = 100,["70"] = 100,["71"] = 100,["72"] = 100,["73"] = 100,["74"] = 100,["75"] = 100,["76"] = 97,["77"] = 109,["78"] = 110,["79"] = 111,["81"] = 118,["82"] = 119,["84"] = 127,["85"] = 109,["86"] = 134,["87"] = 135,["88"] = 137,["89"] = 137,["90"] = 137,["91"] = 138,["92"] = 139,["93"] = 140,["94"] = 140,["95"] = 140,["96"] = 140,["97"] = 140,["98"] = 140,["99"] = 144,["100"] = 145,["101"] = 146,["104"] = 137,["105"] = 137,["106"] = 156,["107"] = 134,["108"] = 159,["109"] = 160,["110"] = 162,["111"] = 163,["113"] = 165,["114"] = 166,["116"] = 168,["117"] = 159,["118"] = 171,["119"] = 172,["120"] = 176,["121"] = 177,["122"] = 177,["123"] = 177,["124"] = 178,["126"] = 180,["127"] = 180,["128"] = 181,["129"] = 182,["130"] = 180,["134"] = 185,["135"] = 185,["136"] = 186,["137"] = 187,["138"] = 188,["140"] = 185,["143"] = 177,["144"] = 177,["145"] = 193,["146"] = 171,["147"] = 196,["148"] = 197,["149"] = 198,["151"] = 200,["152"] = 201,["154"] = 206,["155"] = 207,["157"] = 208,["158"] = 208,["159"] = 209,["160"] = 209,["161"] = 209,["162"] = 209,["163"] = 208,["166"] = 212,["167"] = 196,["168"] = 215,["169"] = 216,["170"] = 216,["171"] = 216,["172"] = 216,["173"] = 215,["174"] = 219,["175"] = 220,["176"] = 222,["177"] = 227,["179"] = 229,["181"] = 231,["182"] = 232,["183"] = 219,["184"] = 235,["185"] = 236,["186"] = 235,["187"] = 46,["188"] = 46});
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
local mobsDistribution = {{{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 2, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}}
____exports.default = (function()
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
                local spawnDiamond = (self.currentRoomNumber == 2) or (self.currentRoomNumber == 6)
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
        if self.currentNpcRoomNumber == (self.totalNpcRooms - 1) then
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
                        {
                            amount = self:GetRewardsAmount()
                        }
                    )
                    local currentReward = customNpc.reward
                    if currentReward then
                        __TS__ArrayPush(heroesData, {customNpc = customNpc, nextRewardOfferings = nextRewardOfferings, currentReward = currentReward})
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
        if (percentage >= 75) and (percentage < 90) then
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
                        __TS__ArrayPush(wave.npcs, npcs[index + 1])
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < mobTier.optional do
                        local index = RandomInt(0, #npcs - 1)
                        if RandomInt(1, 2) == 1 then
                            __TS__ArrayPush(wave.npcs, npcs[index + 1])
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
        local waves = {}
        do
            local i = 0
            while i < amount do
                __TS__ArrayPush(
                    waves,
                    self:GenerateWave()
                )
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
            if (((self.room.type == RoomType.REGULAR) or (self.room.type == RoomType.BOSS)) or (self.room.type == RoomType.LEVELUP)) or (self.room.type == RoomType.FIRST_ROOM) then
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
    return Stage
end)()
return ____exports
