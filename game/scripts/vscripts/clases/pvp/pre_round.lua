--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 3,["8"] = 5,["9"] = 7,["10"] = 7,["11"] = 7,["12"] = 7,["13"] = 7,["14"] = 11,["15"] = 7,["16"] = 13,["17"] = 14,["18"] = 16,["19"] = 16,["20"] = 16,["21"] = 17,["22"] = 18,["23"] = 19,["25"] = 16,["26"] = 16,["27"] = 11,["28"] = 24,["29"] = 7,["30"] = 26,["31"] = 27,["32"] = 27,["33"] = 27,["35"] = 29,["36"] = 30,["38"] = 24,["39"] = 34,["40"] = 35,["41"] = 35,["42"] = 35,["43"] = 36,["44"] = 37,["45"] = 38,["46"] = 39,["47"] = 40,["48"] = 42,["49"] = 43,["50"] = 44,["51"] = 45,["53"] = 48,["54"] = 49,["55"] = 50,["56"] = 51,["57"] = 52,["60"] = 35,["61"] = 35,["62"] = 57,["63"] = 34,["64"] = 7,["65"] = 7});
local ____exports = {}
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
local ADRENALINE_DURATION = 25
____exports.default = (function()
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
        if self.time_remaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.time_remaining / 30)
            )
        end
        if self.time_remaining == 0 then
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
        GameRules.Addon:SetState(CustomGameState.ROOM_IN_PROGRESS)
    end
    return PreRound
end)()
return ____exports
