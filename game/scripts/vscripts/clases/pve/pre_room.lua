--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 5,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 12,["23"] = 13,["24"] = 14,["26"] = 11,["27"] = 11,["29"] = 6,["30"] = 20,["31"] = 5,["32"] = 22,["33"] = 23,["34"] = 23,["35"] = 23,["37"] = 25,["38"] = 26,["40"] = 20,["41"] = 30,["42"] = 31,["43"] = 32,["44"] = 32,["45"] = 32,["46"] = 33,["47"] = 34,["48"] = 35,["49"] = 36,["52"] = 32,["53"] = 32,["54"] = 40,["55"] = 30,["56"] = 43,["57"] = 44,["58"] = 45,["59"] = 45,["60"] = 45,["61"] = 46,["62"] = 47,["63"] = 48,["64"] = 49,["67"] = 45,["68"] = 45,["69"] = 53,["70"] = 43,["71"] = 56,["72"] = 57,["73"] = 58,["74"] = 59,["75"] = 59,["76"] = 59,["77"] = 60,["78"] = 61,["79"] = 62,["81"] = 59,["82"] = 59,["84"] = 56,["85"] = 68,["86"] = 69,["87"] = 71,["88"] = 72,["90"] = 68,["91"] = 76,["92"] = 77,["93"] = 76,["94"] = 5,["95"] = 5});
local ____exports = {}
local ____settings = require("settings")
local settings = ____settings.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local PreRoom = ____exports.default
    PreRoom.name = "PreRoom"
    __TS__ClassExtends(PreRoom, GameState)
    function PreRoom.prototype.____constructor(self, alliances, duration)
        GameState.prototype.____constructor(self, alliances, duration)
        local abilitiesReady = self:CheckAbilitiesReady()
        if abilitiesReady then
            __TS__ArrayForEach(
                self:GetAllPlayers(),
                function(____, player)
                    local customNpc = player.customNpc
                    if customNpc then
                        customNpc:RequestUpgrades()
                    end
                end
            )
        end
    end
    function PreRoom.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.time_remaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.time_remaining / 30)
            )
        end
        if self.time_remaining == 0 then
            self:End()
        end
    end
    function PreRoom.prototype.CheckAbilitiesReady(self)
        local abilitiesReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local hero = player.hero
                if hero then
                    if hero:GetAbilityPoints() > 0 then
                        abilitiesReady = false
                    end
                end
            end
        )
        return abilitiesReady
    end
    function PreRoom.prototype.CheckUpgradesaReady(self)
        local upgradesReady = true
        __TS__ArrayForEach(
            self:GetAllPlayers(),
            function(____, player)
                local customNpc = player.customNpc
                if customNpc then
                    if customNpc:IsUpgrading() then
                        upgradesReady = false
                    end
                end
            end
        )
        return upgradesReady
    end
    function PreRoom.prototype.OnAbilityLearned(self)
        local abilitiesReady = self:CheckAbilitiesReady()
        if abilitiesReady then
            __TS__ArrayForEach(
                self:GetAllPlayers(),
                function(____, player)
                    local customNpc = player.customNpc
                    if customNpc then
                        customNpc:RequestUpgrades()
                    end
                end
            )
        end
    end
    function PreRoom.prototype.OnHeroUpgrade(self)
        local upgradesReady = self:CheckAbilitiesReady()
        if upgradesReady then
            self:SetDuration(settings.PreLevelDuration)
        end
    end
    function PreRoom.prototype.End(self)
        GameRules.Addon:SetState(CustomGameState.ROOM_IN_PROGRESS)
    end
    return PreRoom
end)()
return ____exports
