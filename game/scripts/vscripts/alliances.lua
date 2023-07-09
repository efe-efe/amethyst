local ____lualib = require("lualib_bundle")
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 14,["13"] = 16,["15"] = 17,["16"] = 17,["17"] = 17,["18"] = 17,["19"] = 17,["20"] = 17,["21"] = 17,["22"] = 17,["24"] = 27,["25"] = 28,["26"] = 28,["27"] = 28,["28"] = 28,["29"] = 28,["30"] = 28,["31"] = 28,["32"] = 28,["33"] = 27,["34"] = 31,["35"] = 32,["36"] = 32,["37"] = 32,["38"] = 32,["39"] = 32,["40"] = 32,["41"] = 32,["42"] = 32,["43"] = 31,["44"] = 35,["45"] = 36,["46"] = 36,["47"] = 36,["48"] = 36,["49"] = 36,["50"] = 35,["51"] = 39,["52"] = 40,["53"] = 39,["54"] = 44,["55"] = 45,["56"] = 45,["57"] = 45,["58"] = 45,["59"] = 45,["60"] = 45,["61"] = 45,["62"] = 44,["63"] = 48,["64"] = 49,["65"] = 49,["66"] = 49,["67"] = 49,["68"] = 49,["69"] = 49,["70"] = 49,["71"] = 48,["72"] = 52,["73"] = 53,["74"] = 53,["75"] = 53,["76"] = 53,["77"] = 53,["78"] = 53,["79"] = 53,["80"] = 53,["81"] = 53,["82"] = 52});
local ____exports = {}
local ____alliance_definitions = require("alliance_definitions")
local allianceDefinitions = ____alliance_definitions.allianceDefinitions
local ____modifier_shield = require("modifiers.modifier_shield")
local getUnitShieldPoints = ____modifier_shield.getUnitShieldPoints
____exports.alliances = {}
for ____, definition in ipairs(allianceDefinitions) do
    local ____exports_alliances_0 = ____exports.alliances
    ____exports_alliances_0[#____exports_alliances_0 + 1] = {
        id = definition.id,
        teams = definition.teams,
        players = {},
        gems = 0,
        wins = 0,
        active = false
    }
end
function ____exports.getAllianceHealth(self, alliance)
    return __TS__ArrayReduce(
        alliance.players,
        function(____, a, b)
            local ____opt_1 = b.entity
            return (____opt_1 and ____opt_1.handle:GetHealth() or 0) + a
        end,
        0
    )
end
function ____exports.getAllianceMaxHealth(self, alliance)
    return __TS__ArrayReduce(
        alliance.players,
        function(____, a, b)
            local ____opt_3 = b.entity
            return (____opt_3 and ____opt_3.handle:GetMaxHealth() or 0) + a
        end,
        0
    )
end
function ____exports.getAllianceShield(self, alliance)
    return __TS__ArrayReduce(
        alliance.players,
        function(____, a, b) return (b.entity and getUnitShieldPoints(nil, b.entity.handle) or 0) + a end,
        0
    )
end
function ____exports.setAllianceGems(self, alliance, gems)
    alliance.gems = gems
end
function ____exports.findAllianceByUnit(self, unit)
    return __TS__ArrayFind(
        ____exports.alliances,
        function(____, alliance) return __TS__ArraySome(
            alliance.teams,
            function(____, team) return team == unit:GetTeam() end
        ) end
    )
end
function ____exports.findAllianceByTeam(self, team)
    return __TS__ArrayFind(
        ____exports.alliances,
        function(____, alliance) return __TS__ArrayFind(
            alliance.teams,
            function(____, allianceTeam) return allianceTeam == team end
        ) end
    )
end
function ____exports.findFirstAliveAlliancePlayer(self, alliance)
    local ____opt_7 = __TS__ArrayFind(
        alliance.players,
        function(____, player)
            local ____opt_9 = player.entity
            return ____opt_9 and ____opt_9.handle:IsAlive()
        end
    )
    local ____opt_5 = ____opt_7 and ____opt_7.entity
    return ____opt_5 and ____opt_5.handle
end
return ____exports
