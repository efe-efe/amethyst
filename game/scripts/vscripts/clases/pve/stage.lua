--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 6,["15"] = 6,["16"] = 12,["17"] = 55,["18"] = 55,["19"] = 55,["20"] = 55,["21"] = 55,["22"] = 63,["23"] = 55,["24"] = 60,["25"] = 61,["26"] = 65,["27"] = 66,["28"] = 67,["29"] = 68,["30"] = 63,["31"] = 71,["32"] = 72,["33"] = 73,["34"] = 76,["35"] = 71,["36"] = 79,["37"] = 55,["38"] = 81,["39"] = 82,["41"] = 84,["42"] = 85,["43"] = 87,["45"] = 89,["48"] = 79,["49"] = 94,["50"] = 95,["51"] = 96,["53"] = 98,["54"] = 99,["56"] = 101,["57"] = 102,["59"] = 104,["60"] = 94,["61"] = 107,["62"] = 108,["63"] = 110,["64"] = 110,["65"] = 110,["66"] = 110,["67"] = 110,["68"] = 110,["69"] = 110,["70"] = 110,["71"] = 110,["72"] = 110,["73"] = 110,["74"] = 110,["75"] = 110,["76"] = 107,["77"] = 119,["78"] = 120,["79"] = 121,["81"] = 128,["82"] = 129,["84"] = 137,["85"] = 119,["86"] = 144,["87"] = 145,["88"] = 147,["89"] = 147,["90"] = 147,["91"] = 148,["92"] = 149,["93"] = 150,["94"] = 150,["95"] = 150,["96"] = 150,["97"] = 150,["98"] = 150,["99"] = 154,["100"] = 155,["101"] = 156,["104"] = 147,["105"] = 147,["106"] = 165,["107"] = 144,["108"] = 168,["109"] = 169,["110"] = 171,["111"] = 172,["113"] = 174,["114"] = 175,["116"] = 177,["117"] = 168,["118"] = 180,["119"] = 181,["120"] = 185,["121"] = 186,["122"] = 186,["123"] = 186,["124"] = 187,["126"] = 189,["127"] = 189,["128"] = 190,["129"] = 191,["130"] = 189,["134"] = 194,["135"] = 194,["136"] = 195,["137"] = 196,["138"] = 197,["140"] = 194,["143"] = 186,["144"] = 186,["145"] = 202,["146"] = 180,["147"] = 205,["148"] = 206,["149"] = 207,["151"] = 209,["152"] = 210,["154"] = 217,["155"] = 218,["156"] = 219,["158"] = 222,["160"] = 223,["161"] = 223,["162"] = 224,["163"] = 224,["164"] = 224,["165"] = 224,["166"] = 223,["169"] = 227,["170"] = 205,["171"] = 230,["172"] = 231,["173"] = 231,["174"] = 231,["175"] = 231,["176"] = 230,["177"] = 234,["178"] = 235,["179"] = 237,["180"] = 242,["182"] = 244,["184"] = 246,["185"] = 247,["186"] = 234,["187"] = 250,["188"] = 251,["189"] = 250,["190"] = 55,["191"] = 55});
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
local mobsDistribution = {{{tier = CustomAITier.BASIC, base = 5, optional = 1}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 2, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}}
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
        if ____type == RoomType.FIRST_ROOM then
            amount = 1
        end
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
