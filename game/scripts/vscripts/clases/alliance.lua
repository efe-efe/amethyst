local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 11,["15"] = 11,["16"] = 11,["17"] = 21,["18"] = 15,["19"] = 16,["20"] = 17,["21"] = 18,["22"] = 24,["23"] = 25,["24"] = 26,["25"] = 20,["26"] = 29,["27"] = 30,["28"] = 31,["29"] = 31,["30"] = 31,["31"] = 31,["32"] = 31,["33"] = 31,["34"] = 31,["35"] = 31,["36"] = 40,["37"] = 41,["39"] = 29,["40"] = 45,["41"] = 46,["42"] = 48,["43"] = 48,["44"] = 48,["45"] = 49,["46"] = 50,["47"] = 51,["49"] = 48,["50"] = 48,["51"] = 55,["52"] = 45,["53"] = 58,["54"] = 59,["55"] = 60,["56"] = 58,["57"] = 63,["58"] = 64,["59"] = 66,["60"] = 66,["61"] = 66,["62"] = 67,["63"] = 68,["64"] = 69,["66"] = 66,["67"] = 66,["68"] = 73,["69"] = 63,["70"] = 76,["71"] = 77,["72"] = 79,["73"] = 79,["74"] = 79,["75"] = 80,["76"] = 81,["77"] = 82,["79"] = 79,["80"] = 79,["81"] = 86,["82"] = 76,["83"] = 89,["84"] = 90,["85"] = 89,["86"] = 93,["87"] = 94,["88"] = 93,["89"] = 97,["90"] = 98,["91"] = 98,["92"] = 99,["93"] = 100,["95"] = 103,["96"] = 97,["97"] = 106,["98"] = 107,["99"] = 106,["100"] = 110,["101"] = 111,["102"] = 110,["103"] = 114,["104"] = 115,["105"] = 116,["106"] = 114,["107"] = 119,["108"] = 120,["109"] = 119,["110"] = 123,["111"] = 124,["112"] = 123});
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
