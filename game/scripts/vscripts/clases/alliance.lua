Alliance = Alliance or class({})

DOTA_ALLIANCE_RADIANT = 1
DOTA_ALLIANCE_DIRE = 2
DOTA_ALLIANCE_LEGION = 3
DOTA_ALLIANCE_VOID = 4

local ALLIANCE_NAMES = {
    [1] = "DOTA_ALLIANCE_RADIANT",
    [2] = "DOTA_ALLIANCE_DIRE",
    [3] = "DOTA_ALLIANCE_LEGION",
    [4] = "DOTA_ALLIANCE_VOID",
}

function Alliance:constructor(number, teams)
    self.teams = teams
    self.number = number
    self.name = ALLIANCE_NAMES[number]
    self.players = {}
    self.amethysts = 0
    self.wins = 0
    self.active = false
end

function Alliance:SendDataToClient()
    if self.active then
        local data = {
            health = self:GetCurrentHealth(),
            max_health = self:GetMaxHealth(),
            shield = self:GetShield(),
            name = self.name,
            amethysts = self.amethysts,
            score = self.wins,
        }
        CustomNetTables:SetTableValue("alliances", self.name, data)
    end
end

function Alliance:GetCurrentHealth()
    local current = 0

    for _,player in pairs(self.players) do
        current = current + player.hero:GetHealth()
    end

    return current
end

function Alliance:GetMaxHealth()
    local max = 0

    for _,player in pairs(self.players) do
        max = max + player.hero:GetMaxHealth()
    end

    return max
end

function Alliance:GetShield()
    local current = 0

    for _,player in pairs(self.players) do           
        current = current + CustomEntities:GetShield(player.hero)
    end

    return current
end

function Alliance:GetAmethysts()
    return self.amethysts
end

function Alliance:GetPlayers()
    return self.players
end

function Alliance:AddPlayer(player)
    table.insert(self.players, player)
    if not self.active then
        self.active = true
    end
    
    self:SendDataToClient()
end

function Alliance:GetName()
    return self.name
end

function Alliance:GetScore()
    return self.wins
end

function Alliance:SetScore(nScore)
    self.wins = nScore
    self:SendDataToClient()
end

function Alliance:SetAmethysts(amethysts)
    self.amethysts = amethysts
    self:SendDataToClient()
end

function Alliance:AddAmethsyt()
    self:SetAmethysts(self:GetAmethysts() + 1)
end