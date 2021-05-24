--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 6,["11"] = 6,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 7,["16"] = 6,["17"] = 10,["18"] = 11,["19"] = 12,["20"] = 12,["21"] = 12,["22"] = 13,["23"] = 14,["24"] = 15,["26"] = 12,["27"] = 12,["29"] = 7,["30"] = 21,["31"] = 6,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 24,["37"] = 26,["38"] = 27,["40"] = 21,["41"] = 31,["42"] = 32,["43"] = 33,["44"] = 33,["45"] = 33,["46"] = 34,["47"] = 35,["48"] = 36,["49"] = 37,["52"] = 33,["53"] = 33,["54"] = 41,["55"] = 31,["56"] = 44,["57"] = 45,["58"] = 46,["59"] = 46,["60"] = 46,["61"] = 47,["62"] = 48,["63"] = 49,["64"] = 50,["67"] = 46,["68"] = 46,["69"] = 54,["70"] = 44,["71"] = 57,["72"] = 58,["73"] = 59,["74"] = 60,["75"] = 60,["76"] = 60,["77"] = 61,["78"] = 62,["79"] = 63,["81"] = 60,["82"] = 60,["84"] = 57,["85"] = 69,["86"] = 70,["87"] = 72,["88"] = 73,["90"] = 69,["91"] = 77,["92"] = 78,["93"] = 77,["94"] = 6,["95"] = 6});
local ____exports = {}
local ____settings = require("settings")
local settings = ____settings.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local PreLevel = ____exports.default
    PreLevel.name = "PreLevel"
    __TS__ClassExtends(PreLevel, GameState)
    function PreLevel.prototype.____constructor(self, alliances, duration)
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
    function PreLevel.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.time_remaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.time_remaining / 30)
            )
        end
        if self.time_remaining == 0 then
            self:EndPreLevel()
        end
    end
    function PreLevel.prototype.CheckAbilitiesReady(self)
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
    function PreLevel.prototype.CheckUpgradesaReady(self)
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
    function PreLevel.prototype.OnAbilityLearned(self)
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
    function PreLevel.prototype.OnHeroUpgrade(self)
        local upgradesReady = self:CheckAbilitiesReady()
        if upgradesReady then
            self:SetDuration(settings.PreLevelDuration)
        end
    end
    function PreLevel.prototype.EndPreLevel(self)
        GameRules.Addon:SetState(CustomGameState.LEVEL_IN_PROGRESS)
    end
    return PreLevel
end)()
return ____exports
