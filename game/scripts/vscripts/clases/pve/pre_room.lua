--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 4,["9"] = 4,["10"] = 4,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 8,["16"] = 9,["17"] = 10,["18"] = 10,["19"] = 10,["20"] = 11,["21"] = 12,["22"] = 13,["24"] = 10,["25"] = 10,["27"] = 5,["28"] = 19,["29"] = 4,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 22,["35"] = 24,["36"] = 25,["38"] = 19,["39"] = 29,["40"] = 30,["41"] = 31,["42"] = 31,["43"] = 31,["44"] = 32,["45"] = 33,["46"] = 34,["47"] = 35,["50"] = 31,["51"] = 31,["52"] = 39,["53"] = 29,["54"] = 42,["55"] = 43,["56"] = 44,["57"] = 44,["58"] = 44,["59"] = 45,["60"] = 46,["61"] = 47,["62"] = 48,["65"] = 44,["66"] = 44,["67"] = 52,["68"] = 42,["69"] = 55,["70"] = 56,["71"] = 57,["72"] = 58,["73"] = 58,["74"] = 58,["75"] = 59,["76"] = 60,["77"] = 61,["79"] = 58,["80"] = 58,["82"] = 55,["83"] = 67,["84"] = 68,["85"] = 67,["86"] = 4,["87"] = 4});
local ____exports = {}
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
    function PreRoom.prototype.End(self)
        GameRules.Addon:SetState(CustomGameState.RUN_IN_PROGRESS)
    end
    return PreRoom
end)()
return ____exports
