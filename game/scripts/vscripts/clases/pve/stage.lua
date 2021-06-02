--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 11,["13"] = 11,["14"] = 11,["15"] = 11,["16"] = 11,["17"] = 11,["18"] = 11,["19"] = 17,["20"] = 51,["21"] = 51,["22"] = 51,["23"] = 51,["24"] = 51,["25"] = 58,["26"] = 51,["27"] = 56,["28"] = 60,["29"] = 61,["30"] = 62,["31"] = 63,["32"] = 58,["33"] = 66,["34"] = 67,["35"] = 68,["36"] = 71,["37"] = 66,["38"] = 74,["39"] = 51,["40"] = 76,["41"] = 77,["43"] = 79,["44"] = 80,["45"] = 81,["47"] = 83,["50"] = 74,["51"] = 88,["52"] = 89,["53"] = 90,["54"] = 94,["56"] = 96,["57"] = 97,["59"] = 99,["61"] = 102,["62"] = 102,["63"] = 102,["64"] = 102,["65"] = 102,["66"] = 102,["67"] = 102,["68"] = 102,["69"] = 88,["70"] = 105,["71"] = 106,["72"] = 110,["73"] = 111,["74"] = 111,["75"] = 111,["76"] = 112,["78"] = 114,["79"] = 114,["80"] = 115,["81"] = 116,["82"] = 114,["86"] = 119,["87"] = 119,["88"] = 120,["89"] = 121,["90"] = 122,["92"] = 119,["95"] = 111,["96"] = 111,["97"] = 127,["98"] = 105,["99"] = 130,["100"] = 131,["101"] = 132,["103"] = 133,["104"] = 133,["105"] = 134,["106"] = 134,["107"] = 134,["108"] = 134,["109"] = 133,["112"] = 137,["113"] = 130,["114"] = 140,["115"] = 141,["116"] = 141,["117"] = 141,["118"] = 141,["119"] = 140,["120"] = 144,["121"] = 145,["122"] = 146,["124"] = 144,["125"] = 150,["126"] = 151,["127"] = 152,["129"] = 150,["130"] = 156,["131"] = 157,["132"] = 158,["133"] = 159,["134"] = 156,["135"] = 162,["136"] = 163,["137"] = 162,["138"] = 51,["139"] = 51});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local CustomAITier = ____custom_ai.CustomAITier
local ____room = require("clases.pve.room")
local Room = ____room.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local RoomType = RoomType or ({})
RoomType.REGULAR = 0
RoomType[RoomType.REGULAR] = "REGULAR"
RoomType.BOSS = 1
RoomType[RoomType.BOSS] = "BOSS"
RoomType.BONUS = 2
RoomType[RoomType.BONUS] = "BONUS"
local mobsDistribution = {{{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 2, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Stage = ____exports.default
    Stage.name = "Stage"
    __TS__ClassExtends(Stage, GameState)
    function Stage.prototype.____constructor(self, alliances, stageData, run)
        GameState.prototype.____constructor(self, alliances, -1)
        self.currentRoom = 0
        self.run = run
        self.possibleNPCs = stageData.possibleNPCs
        self.rooms = RandomInt(6, 8)
        self:SendDataToClient()
    end
    function Stage.prototype.SendDataToClient(self)
        local tableName = "main"
        local data = {currentRoom = self.currentRoom + 1}
        CustomNetTables:SetTableValue(tableName, "pve", data)
    end
    function Stage.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.room then
            self.room:Update()
        else
            if self.currentRoom < self.rooms then
                local roomType = ((self.currentRoom == (self.rooms - 2)) and RoomType.BOSS) or ((((self.currentRoom == 0) or (self.currentRoom == (self.rooms - 1))) and RoomType.BONUS) or RoomType.REGULAR)
                self.room = self:GenerateRoom(roomType, (self.currentRoom == 2) or (self.currentRoom == 6))
            else
                self:End()
            end
        end
    end
    function Stage.prototype.GenerateRoom(self, roomType, spawnDiamond)
        if roomType == RoomType.BOSS then
            local waves = {{npcs = {self.possibleNPCs[#self.possibleNPCs]}}}
            return __TS__New(Room, self.alliances, -1, waves, self, spawnDiamond)
        end
        if roomType == RoomType.BONUS then
            return __TS__New(Room, self.alliances, -1, {{npcs = {}}}, self, spawnDiamond)
        end
        if RandomInt(1, 100) < 5 then
        end
        return __TS__New(
            Room,
            self.alliances,
            -1,
            self:GenerateWaves(),
            self,
            spawnDiamond
        )
    end
    function Stage.prototype.GenerateWave(self)
        local wave = {npcs = {}}
        local distribution = mobsDistribution[self.currentRoom + 1]
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
    function Stage.prototype.GenerateWaves(self)
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
        self.currentRoom = self.currentRoom + 1
        self.room = nil
        self:SendDataToClient()
    end
    function Stage.prototype.End(self)
        self.run:OnStageEnd()
    end
    return Stage
end)()
return ____exports
