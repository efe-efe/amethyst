--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 11,["7"] = 11,["8"] = 11,["9"] = 11,["10"] = 20,["11"] = 15,["12"] = 16,["13"] = 17,["14"] = 18,["15"] = 21,["16"] = 22,["17"] = 23,["18"] = 20,["19"] = 26,["20"] = 27,["21"] = 28,["22"] = 28,["23"] = 28,["24"] = 28,["25"] = 28,["26"] = 28,["27"] = 28,["28"] = 28,["29"] = 37,["30"] = 38,["32"] = 26,["33"] = 42,["34"] = 43,["35"] = 45,["36"] = 45,["37"] = 45,["38"] = 46,["39"] = 47,["40"] = 48,["42"] = 45,["43"] = 45,["44"] = 52,["45"] = 42,["46"] = 55,["47"] = 56,["48"] = 57,["49"] = 55,["50"] = 60,["51"] = 61,["52"] = 63,["53"] = 63,["54"] = 63,["55"] = 64,["56"] = 65,["57"] = 66,["59"] = 63,["60"] = 63,["61"] = 70,["62"] = 60,["63"] = 73,["64"] = 74,["65"] = 76,["66"] = 76,["67"] = 76,["68"] = 77,["69"] = 78,["70"] = 79,["72"] = 76,["73"] = 76,["74"] = 83,["75"] = 73,["76"] = 86,["77"] = 87,["78"] = 86,["79"] = 90,["80"] = 91,["81"] = 90,["82"] = 94,["83"] = 95,["84"] = 96,["85"] = 97,["87"] = 100,["88"] = 94,["89"] = 103,["90"] = 104,["91"] = 103,["92"] = 107,["93"] = 108,["94"] = 107,["95"] = 111,["96"] = 112,["97"] = 113,["98"] = 111,["99"] = 116,["100"] = 117,["101"] = 117,["102"] = 117,["103"] = 116,["104"] = 120,["105"] = 121,["106"] = 120,["107"] = 11,["108"] = 11});
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
