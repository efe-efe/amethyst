local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 4,["12"] = 6,["13"] = 6,["14"] = 6,["15"] = 6,["16"] = 10,["17"] = 6,["18"] = 12,["19"] = 13,["20"] = 15,["21"] = 15,["22"] = 15,["23"] = 16,["24"] = 17,["25"] = 18,["27"] = 15,["28"] = 15,["29"] = 10,["30"] = 23,["31"] = 6,["32"] = 25,["33"] = 26,["35"] = 28,["36"] = 29,["38"] = 23,["39"] = 33,["40"] = 34,["41"] = 34,["42"] = 34,["43"] = 35,["44"] = 36,["45"] = 37,["46"] = 38,["47"] = 39,["48"] = 41,["49"] = 42,["50"] = 43,["51"] = 44,["53"] = 47,["54"] = 48,["55"] = 49,["56"] = 50,["57"] = 51,["60"] = 34,["61"] = 34,["62"] = 58,["63"] = 33});
local ____exports = {}
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
local ADRENALINE_DURATION = 25
____exports.default = __TS__Class()
local PreRound = ____exports.default
PreRound.name = "PreRound"
__TS__ClassExtends(PreRound, GameState)
function PreRound.prototype.____constructor(self, alliances, duration)
    GameState.prototype.____constructor(self, alliances, duration)
    self.radiant_spawn = Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin()
    self.dire_spawn = Entities:FindByName(nil, "dire_spawn"):GetAbsOrigin()
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local hero = player.hero
            if hero then
                hero:AddNewModifier(hero, nil, "modifier_restricted", {})
            end
        end
    )
end
function PreRound.prototype.Update(self)
    GameState.prototype.Update(self)
    if self.timeRemaining >= 0 then
        self:UpdateGameTimer(math.floor(self.timeRemaining / 30))
    end
    if self.timeRemaining == 0 then
        self:EndPreRound()
    end
end
function PreRound.prototype.EndPreRound(self)
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local hero = player.hero
            if hero then
                if player.alliance then
                    local allianceName = player.alliance.name
                    local target = nil
                    if allianceName == "DOTA_ALLIANCE_RADIANT" then
                        target = self.radiant_spawn
                    elseif allianceName == "DOTA_ALLIANCE_DIRE" then
                        target = self.dire_spawn
                    end
                    FindClearSpaceForUnit(hero, target, true)
                    CustomEntitiesLegacy:Reset(hero)
                    CustomEntitiesLegacy:AutoUpgradeAbilities(hero)
                    hero:RemoveModifierByName("modifier_restricted")
                    hero:AddNewModifier(hero, nil, "modifier_adrenaline", {duration = ADRENALINE_DURATION})
                end
            end
        end
    )
    GameRules.Addon:SetState(CustomGameState.ROUND_IN_PROGRESS)
end
return ____exports
