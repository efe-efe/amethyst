--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 11,["13"] = 11,["14"] = 11,["15"] = 11,["16"] = 11,["17"] = 11,["18"] = 11,["19"] = 17,["20"] = 49,["21"] = 49,["22"] = 49,["23"] = 49,["24"] = 49,["25"] = 56,["26"] = 49,["27"] = 54,["28"] = 58,["29"] = 59,["30"] = 60,["31"] = 61,["32"] = 56,["33"] = 64,["34"] = 65,["35"] = 66,["36"] = 69,["37"] = 64,["38"] = 72,["39"] = 49,["40"] = 74,["41"] = 75,["43"] = 77,["44"] = 78,["45"] = 79,["47"] = 81,["50"] = 72,["51"] = 86,["52"] = 87,["53"] = 88,["54"] = 92,["56"] = 94,["57"] = 95,["59"] = 97,["60"] = 98,["62"] = 100,["63"] = 100,["64"] = 100,["65"] = 100,["66"] = 100,["67"] = 100,["68"] = 100,["69"] = 86,["70"] = 103,["71"] = 104,["72"] = 108,["73"] = 109,["74"] = 109,["75"] = 109,["76"] = 110,["77"] = 111,["79"] = 113,["80"] = 113,["81"] = 114,["82"] = 113,["86"] = 117,["87"] = 117,["88"] = 118,["89"] = 119,["91"] = 117,["94"] = 109,["95"] = 109,["96"] = 124,["97"] = 103,["98"] = 127,["99"] = 128,["100"] = 129,["102"] = 130,["103"] = 130,["104"] = 131,["105"] = 131,["106"] = 131,["107"] = 131,["108"] = 130,["111"] = 134,["112"] = 127,["113"] = 137,["114"] = 138,["115"] = 138,["116"] = 138,["117"] = 138,["118"] = 137,["119"] = 141,["120"] = 142,["121"] = 143,["123"] = 141,["124"] = 147,["125"] = 148,["126"] = 149,["128"] = 147,["129"] = 153,["130"] = 154,["131"] = 155,["132"] = 156,["133"] = 153,["134"] = 159,["135"] = 160,["136"] = 159,["137"] = 49,["138"] = 49});
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
local mobsDistribution = {{{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 0, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}}, {{tier = CustomAITier.BASIC, base = 4, optional = 1}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 1, optional = 0}}, {{tier = CustomAITier.BASIC, base = 4, optional = 2}, {tier = CustomAITier.MID, base = 1, optional = 1}, {tier = CustomAITier.HIGH, base = 2, optional = 0}}, {{tier = CustomAITier.BASIC, base = 2, optional = 1}, {tier = CustomAITier.MID, base = 2, optional = 1}, {tier = CustomAITier.HIGH, base = 3, optional = 0}}, {{tier = CustomAITier.BOSS, base = 1, optional = 0}}}
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
        CustomNetTables:SetTableValue(tableName, "stage", data)
    end
    function Stage.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.room then
            self.room:Update()
        else
            if self.currentRoom < self.rooms then
                local roomType = ((self.currentRoom == (self.rooms - 2)) and RoomType.BOSS) or (((self.currentRoom == 0) and RoomType.BONUS) or RoomType.REGULAR)
                self.room = self:GenerateRoom(roomType)
            else
                self:End()
            end
        end
    end
    function Stage.prototype.GenerateRoom(self, roomType)
        if roomType == RoomType.BOSS then
            local waves = {{npcs = {self.possibleNPCs[#self.possibleNPCs]}}}
            return __TS__New(Room, self.alliances, -1, waves, self)
        end
        if roomType == RoomType.BONUS then
            return __TS__New(Room, self.alliances, -1, {{npcs = {}}}, self)
        end
        if RandomInt(1, 100) < 5 then
            return __TS__New(Room, self.alliances, -1, {{npcs = {}}}, self)
        end
        return __TS__New(
            Room,
            self.alliances,
            -1,
            self:GenerateWaves(),
            self
        )
    end
    function Stage.prototype.GenerateWave(self)
        local wave = {npcs = {}}
        local distribution = mobsDistribution[self.currentRoom + 1]
        __TS__ArrayForEach(
            distribution,
            function(____, mobTier)
                local npcs = self:GetAllNpcsOfTier(mobTier.tier)
                local index = RandomInt(0, #npcs - 1)
                do
                    local i = 0
                    while i < mobTier.base do
                        __TS__ArrayPush(wave.npcs, npcs[index + 1])
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < mobTier.optional do
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
