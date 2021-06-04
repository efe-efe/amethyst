--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 11,["15"] = 45,["16"] = 45,["17"] = 45,["18"] = 45,["19"] = 45,["20"] = 53,["21"] = 45,["22"] = 50,["23"] = 51,["24"] = 55,["25"] = 56,["26"] = 57,["27"] = 58,["28"] = 53,["29"] = 61,["30"] = 62,["31"] = 63,["32"] = 66,["33"] = 61,["34"] = 69,["35"] = 45,["36"] = 71,["37"] = 72,["39"] = 74,["40"] = 75,["41"] = 76,["43"] = 78,["46"] = 69,["47"] = 83,["48"] = 84,["49"] = 85,["51"] = 87,["52"] = 88,["54"] = 90,["55"] = 83,["56"] = 93,["57"] = 94,["58"] = 95,["59"] = 97,["60"] = 97,["61"] = 97,["62"] = 97,["63"] = 97,["64"] = 97,["65"] = 97,["66"] = 97,["67"] = 97,["68"] = 97,["69"] = 97,["70"] = 97,["71"] = 93,["72"] = 105,["73"] = 106,["74"] = 110,["75"] = 111,["76"] = 111,["77"] = 111,["78"] = 112,["80"] = 114,["81"] = 114,["82"] = 115,["83"] = 116,["84"] = 114,["88"] = 119,["89"] = 119,["90"] = 120,["91"] = 121,["92"] = 122,["94"] = 119,["97"] = 111,["98"] = 111,["99"] = 127,["100"] = 105,["101"] = 130,["102"] = 131,["103"] = 132,["105"] = 134,["106"] = 135,["108"] = 140,["109"] = 141,["111"] = 142,["112"] = 142,["113"] = 143,["114"] = 143,["115"] = 143,["116"] = 143,["117"] = 142,["120"] = 146,["121"] = 130,["122"] = 149,["123"] = 150,["124"] = 150,["125"] = 150,["126"] = 150,["127"] = 149,["128"] = 153,["129"] = 154,["130"] = 155,["132"] = 153,["133"] = 159,["134"] = 160,["135"] = 161,["137"] = 159,["138"] = 165,["139"] = 166,["140"] = 167,["141"] = 168,["143"] = 170,["145"] = 172,["146"] = 173,["147"] = 165,["148"] = 176,["149"] = 177,["150"] = 176,["151"] = 45,["152"] = 45});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local CustomAITier = ____custom_ai.CustomAITier
local ____room = require("clases.pve.room")
local Room = ____room.default
local RoomCompletionCriteria = ____room.RoomCompletionCriteria
local RoomType = ____room.RoomType
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
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
            return RoomType.BONUS
        end
        return RoomType.REGULAR
    end
    function Stage.prototype.GenerateRoom(self, spawnDiamond)
        local ____type = self:GenerateRoomType()
        local completitionCriteria = RoomCompletionCriteria.KILL_ALL_ENEMIES
        return __TS__New(
            Room,
            self.alliances,
            -1,
            self,
            {
                waves = self:GenerateWaves(____type),
                spawnDiamond = spawnDiamond,
                type = ____type,
                completitionCriteria = completitionCriteria
            }
        )
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
    function Stage.prototype.OnUnitHurt(self, unit)
        if self.room then
            self.room:OnUnitHurt(unit)
        end
    end
    function Stage.prototype.OnUnitDies(self, unit)
        if self.room then
            self.room:OnUnitDies(unit)
        end
    end
    function Stage.prototype.OnRoomCompleted(self)
        if self.room then
            if (self.room.type == RoomType.REGULAR) or (self.room.type == RoomType.BOSS) then
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
