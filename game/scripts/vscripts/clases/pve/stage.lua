--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 6,["15"] = 6,["16"] = 12,["17"] = 46,["18"] = 46,["19"] = 46,["20"] = 46,["21"] = 46,["22"] = 54,["23"] = 46,["24"] = 51,["25"] = 52,["26"] = 56,["27"] = 57,["28"] = 58,["29"] = 59,["30"] = 54,["31"] = 62,["32"] = 63,["33"] = 64,["34"] = 67,["35"] = 62,["36"] = 70,["37"] = 46,["38"] = 72,["39"] = 73,["41"] = 75,["42"] = 76,["43"] = 77,["45"] = 79,["48"] = 70,["49"] = 84,["50"] = 85,["51"] = 86,["53"] = 88,["54"] = 89,["56"] = 91,["57"] = 84,["58"] = 94,["59"] = 95,["60"] = 97,["61"] = 97,["62"] = 97,["63"] = 97,["64"] = 97,["65"] = 97,["66"] = 97,["67"] = 97,["68"] = 97,["69"] = 97,["70"] = 97,["71"] = 97,["72"] = 97,["73"] = 94,["74"] = 106,["75"] = 107,["76"] = 108,["78"] = 116,["79"] = 106,["80"] = 123,["81"] = 124,["82"] = 126,["83"] = 126,["84"] = 126,["85"] = 127,["86"] = 128,["87"] = 129,["88"] = 129,["89"] = 129,["90"] = 129,["91"] = 129,["92"] = 129,["93"] = 133,["94"] = 134,["95"] = 135,["98"] = 126,["99"] = 126,["100"] = 145,["101"] = 123,["102"] = 148,["103"] = 149,["104"] = 151,["105"] = 152,["107"] = 154,["108"] = 155,["110"] = 157,["111"] = 148,["112"] = 160,["113"] = 161,["114"] = 165,["115"] = 166,["116"] = 166,["117"] = 166,["118"] = 167,["120"] = 169,["121"] = 169,["122"] = 170,["123"] = 171,["124"] = 169,["128"] = 174,["129"] = 174,["130"] = 175,["131"] = 176,["132"] = 177,["134"] = 174,["137"] = 166,["138"] = 166,["139"] = 182,["140"] = 160,["141"] = 185,["142"] = 186,["143"] = 187,["145"] = 189,["146"] = 190,["148"] = 195,["149"] = 196,["151"] = 197,["152"] = 197,["153"] = 198,["154"] = 198,["155"] = 198,["156"] = 198,["157"] = 197,["160"] = 201,["161"] = 185,["162"] = 204,["163"] = 205,["164"] = 205,["165"] = 205,["166"] = 205,["167"] = 204,["168"] = 208,["169"] = 209,["170"] = 210,["171"] = 211,["173"] = 213,["175"] = 215,["176"] = 216,["177"] = 208,["178"] = 219,["179"] = 220,["180"] = 219,["181"] = 46,["182"] = 46});
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
        if self.currentNpcRoomNumber == (self.totalNpcRooms - 1) then
            return RoomType.BOSS
        end
        if self.currentRoomNumber == 0 then
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
            if ((self.room.type == RoomType.REGULAR) or (self.room.type == RoomType.BOSS)) or (self.room.type == RoomType.LEVELUP) then
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
