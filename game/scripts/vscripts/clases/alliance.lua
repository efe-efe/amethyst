local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 11,["15"] = 11,["16"] = 11,["17"] = 20,["18"] = 15,["19"] = 16,["20"] = 17,["21"] = 18,["22"] = 21,["23"] = 22,["24"] = 23,["25"] = 20,["26"] = 26,["27"] = 27,["28"] = 28,["29"] = 28,["30"] = 28,["31"] = 28,["32"] = 28,["33"] = 28,["34"] = 28,["35"] = 28,["36"] = 37,["37"] = 38,["39"] = 26,["40"] = 42,["41"] = 43,["42"] = 45,["43"] = 45,["44"] = 45,["45"] = 46,["46"] = 47,["47"] = 48,["49"] = 45,["50"] = 45,["51"] = 52,["52"] = 42,["53"] = 55,["54"] = 56,["55"] = 57,["56"] = 55,["57"] = 60,["58"] = 61,["59"] = 63,["60"] = 63,["61"] = 63,["62"] = 64,["63"] = 65,["64"] = 66,["66"] = 63,["67"] = 63,["68"] = 70,["69"] = 60,["70"] = 73,["71"] = 74,["72"] = 76,["73"] = 76,["74"] = 76,["75"] = 77,["76"] = 78,["77"] = 79,["79"] = 76,["80"] = 76,["81"] = 83,["82"] = 73,["83"] = 86,["84"] = 87,["85"] = 86,["86"] = 90,["87"] = 91,["88"] = 90,["89"] = 94,["90"] = 95,["91"] = 95,["92"] = 96,["93"] = 97,["95"] = 100,["96"] = 94,["97"] = 103,["98"] = 104,["99"] = 103,["100"] = 107,["101"] = 108,["102"] = 107,["103"] = 111,["104"] = 112,["105"] = 113,["106"] = 111,["107"] = 116,["108"] = 117,["109"] = 116,["110"] = 120,["111"] = 121,["112"] = 120});
local ____exports = {}
local ALLIANCE_NAMES = {
    [0] = "DOTA_NO_ALLIANCE",
    [1] = "DOTA_ALLIANCE_RADIANT",
    [2] = "DOTA_ALLIANCE_DIRE",
    [3] = "DOTA_ALLIANCE_LEGION",
    [4] = "DOTA_ALLIANCE_VOID"
}
____exports.default = __TS__Class()
local Alliance = ____exports.default
Alliance.name = "Alliance"
function Alliance.prototype.____constructor(self, allianceNumber, teams)
    self.players = {}
    self.amethysts = 0
    self.wins = 0
    self.active = false
    self.teams = teams
    self.number = allianceNumber
    self.name = ALLIANCE_NAMES[self.number]
end
function Alliance.prototype.SendDataToClient(self)
    if self.active then
        local data = {
            health = self:GetCurrentHealth(),
            max_health = self:GetMaxHealth(),
            shield = self:GetShield(),
            name = self.name,
            amethysts = self.amethysts,
            score = self.wins
        }
        local tableName = "alliances"
        CustomNetTables:SetTableValue(tableName, self.name, data)
    end
end
function Alliance.prototype.GetCurrentHealth(self)
    local current = 0
    __TS__ArrayForEach(
        self.players,
        function(____, player)
            local hero = player.hero
            if hero then
                current = current + hero:GetHealth()
            end
        end
    )
    return current
end
function Alliance.prototype.SetAmethysts(self, amethysts)
    self.amethysts = amethysts
    self:SendDataToClient()
end
function Alliance.prototype.GetMaxHealth(self)
    local max = 0
    __TS__ArrayForEach(
        self.players,
        function(____, player)
            local hero = player.hero
            if hero then
                max = max + hero:GetMaxHealth()
            end
        end
    )
    return max
end
function Alliance.prototype.GetShield(self)
    local current = 0
    __TS__ArrayForEach(
        self.players,
        function(____, player)
            local hero = player.hero
            if hero then
                current = current + CustomEntitiesLegacy:GetShield(hero)
            end
        end
    )
    return current
end
function Alliance.prototype.GetAmethysts(self)
    return self.amethysts
end
function Alliance.prototype.GetPlayers(self)
    return self.players
end
function Alliance.prototype.AddPlayer(self, player)
    local ____self_players_0 = self.players
    ____self_players_0[#____self_players_0 + 1] = player
    if not self.active then
        self.active = true
    end
    self:SendDataToClient()
end
function Alliance.prototype.GetName(self)
    return self.name
end
function Alliance.prototype.GetScore(self)
    return self.wins
end
function Alliance.prototype.SetScore(self, score)
    self.wins = score
    self:SendDataToClient()
end
function Alliance.prototype.AddAmethsyt(self)
    self:SetAmethysts(self:GetAmethysts() + 1)
end
function Alliance.prototype.IsActive(self)
    return self.active
end
return ____exports
