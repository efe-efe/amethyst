--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 3,["13"] = 11,["14"] = 45,["15"] = 45,["16"] = 45,["17"] = 45,["18"] = 45,["19"] = 53,["20"] = 45,["21"] = 50,["22"] = 51,["23"] = 55,["24"] = 56,["25"] = 57,["26"] = 58,["27"] = 53,["28"] = 61,["29"] = 62,["30"] = 63,["31"] = 66,["32"] = 61,["33"] = 69,["34"] = 45,["35"] = 71,["36"] = 72,["38"] = 74,["39"] = 75,["40"] = 76,["42"] = 78,["45"] = 69,["46"] = 83,["47"] = 84,["48"] = 85,["50"] = 87,["51"] = 88,["53"] = 90,["54"] = 83,["55"] = 93,["56"] = 94,["57"] = 96,["58"] = 96,["59"] = 96,["60"] = 96,["61"] = 96,["62"] = 96,["63"] = 96,["64"] = 96,["65"] = 96,["66"] = 96,["67"] = 96,["68"] = 93,["69"] = 103,["70"] = 104,["71"] = 108,["72"] = 109,["73"] = 109,["74"] = 109,["75"] = 110,["77"] = 112,["78"] = 112,["79"] = 113,["80"] = 114,["81"] = 112,["85"] = 117,["86"] = 117,["87"] = 118,["88"] = 119,["89"] = 120,["91"] = 117,["94"] = 109,["95"] = 109,["96"] = 125,["97"] = 103,["98"] = 128,["99"] = 129,["100"] = 130,["102"] = 132,["103"] = 133,["105"] = 138,["106"] = 139,["108"] = 140,["109"] = 140,["110"] = 141,["111"] = 141,["112"] = 141,["113"] = 141,["114"] = 140,["117"] = 144,["118"] = 128,["119"] = 147,["120"] = 148,["121"] = 148,["122"] = 148,["123"] = 148,["124"] = 147,["125"] = 151,["126"] = 152,["127"] = 153,["129"] = 151,["130"] = 157,["131"] = 158,["132"] = 159,["134"] = 157,["135"] = 163,["136"] = 164,["137"] = 165,["138"] = 166,["140"] = 168,["142"] = 170,["143"] = 171,["144"] = 163,["145"] = 174,["146"] = 175,["147"] = 174,["148"] = 45,["149"] = 45});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
local CustomAITier = ____custom_ai.CustomAITier
local ____room = require("clases.pve.room")
local Room = ____room.default
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
        return __TS__New(
            Room,
            self.alliances,
            -1,
            self,
            {
                waves = self:GenerateWaves(____type),
                spawnDiamond = spawnDiamond,
                type = ____type
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
