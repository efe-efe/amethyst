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
        current = current + player.hero:GetShield()
    end

    return current
end

function Alliance:GetAmethyst()
    return self.amethysts
end

function Alliance:AddPlayer(player)
    table.insert(self.players, player)
end

function Alliance:GetName()
    return self.name
end

function Alliance:GetScore()
    return self.wins
end

function Alliance:SetAmethysts(amethysts)
    self.amethysts = amethysts
end