--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 10,["7"] = 10,["8"] = 10,["9"] = 10,["10"] = 19,["11"] = 14,["12"] = 15,["13"] = 16,["14"] = 17,["15"] = 20,["16"] = 21,["17"] = 22,["18"] = 19,["19"] = 25,["20"] = 26,["21"] = 27,["22"] = 27,["23"] = 27,["24"] = 27,["25"] = 27,["26"] = 27,["27"] = 27,["28"] = 27,["29"] = 36,["30"] = 37,["32"] = 25,["33"] = 41,["34"] = 42,["35"] = 44,["36"] = 44,["37"] = 44,["38"] = 45,["39"] = 46,["40"] = 47,["42"] = 44,["43"] = 44,["44"] = 51,["45"] = 41,["46"] = 54,["47"] = 55,["48"] = 56,["49"] = 54,["50"] = 59,["51"] = 60,["52"] = 62,["53"] = 62,["54"] = 62,["55"] = 63,["56"] = 64,["57"] = 65,["59"] = 62,["60"] = 62,["61"] = 69,["62"] = 59,["63"] = 72,["64"] = 73,["65"] = 75,["66"] = 75,["67"] = 75,["68"] = 76,["69"] = 77,["70"] = 78,["72"] = 75,["73"] = 75,["74"] = 82,["75"] = 72,["76"] = 85,["77"] = 86,["78"] = 85,["79"] = 89,["80"] = 90,["81"] = 89,["82"] = 93,["83"] = 94,["84"] = 95,["85"] = 96,["87"] = 99,["88"] = 93,["89"] = 102,["90"] = 103,["91"] = 102,["92"] = 106,["93"] = 107,["94"] = 106,["95"] = 110,["96"] = 111,["97"] = 112,["98"] = 110,["99"] = 115,["100"] = 116,["101"] = 116,["102"] = 116,["103"] = 115,["104"] = 119,["105"] = 120,["106"] = 119,["107"] = 10,["108"] = 10});
local ____exports = {}
local ALLIANCE_NAMES = {[1] = "DOTA_ALLIANCE_RADIANT", [2] = "DOTA_ALLIANCE_DIRE", [3] = "DOTA_ALLIANCE_LEGION", [4] = "DOTA_ALLIANCE_VOID"}
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
