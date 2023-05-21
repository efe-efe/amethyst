--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 11,["7"] = 11,["8"] = 11,["9"] = 11,["10"] = 21,["11"] = 15,["12"] = 16,["13"] = 17,["14"] = 18,["15"] = 24,["16"] = 25,["17"] = 26,["18"] = 20,["19"] = 29,["20"] = 30,["21"] = 31,["22"] = 31,["23"] = 31,["24"] = 31,["25"] = 31,["26"] = 31,["27"] = 31,["28"] = 31,["29"] = 40,["30"] = 41,["32"] = 29,["33"] = 45,["34"] = 46,["35"] = 48,["36"] = 48,["37"] = 48,["38"] = 49,["39"] = 50,["40"] = 51,["42"] = 48,["43"] = 48,["44"] = 55,["45"] = 45,["46"] = 58,["47"] = 59,["48"] = 60,["49"] = 58,["50"] = 63,["51"] = 64,["52"] = 66,["53"] = 66,["54"] = 66,["55"] = 67,["56"] = 68,["57"] = 69,["59"] = 66,["60"] = 66,["61"] = 73,["62"] = 63,["63"] = 76,["64"] = 77,["65"] = 79,["66"] = 79,["67"] = 79,["68"] = 80,["69"] = 81,["70"] = 82,["72"] = 79,["73"] = 79,["74"] = 86,["75"] = 76,["76"] = 89,["77"] = 90,["78"] = 89,["79"] = 93,["80"] = 94,["81"] = 93,["82"] = 97,["83"] = 98,["84"] = 99,["85"] = 100,["87"] = 103,["88"] = 97,["89"] = 106,["90"] = 107,["91"] = 106,["92"] = 110,["93"] = 111,["94"] = 110,["95"] = 114,["96"] = 115,["97"] = 116,["98"] = 114,["99"] = 119,["100"] = 120,["101"] = 120,["102"] = 120,["103"] = 119,["104"] = 123,["105"] = 124,["106"] = 123,["107"] = 11,["108"] = 11});
local ____exports = {}
local ALLIANCE_NAMES = {[0] = "DOTA_NO_ALLIANCE", [1] = "DOTA_ALLIANCE_RADIANT", [2] = "DOTA_ALLIANCE_DIRE", [3] = "DOTA_ALLIANCE_LEGION", [4] = "DOTA_ALLIANCE_VOID"}
____exports.default = (function()
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
        __TS__ArrayPush(self.players, player)
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
        self:SetAmethysts(
            self:GetAmethysts() + 1
        )
    end
    function Alliance.prototype.IsActive(self)
        return self.active
    end
    return Alliance
end)()
return ____exports
