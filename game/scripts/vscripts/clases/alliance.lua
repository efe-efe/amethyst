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
    print("[CLASS=ALLIANCE] CREATING ALLIANCE")
    self.teams = teams
    self.number = number
    self.name = ALLIANCE_NAMES[number]
    self.players = {}
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

function Alliance:AddPlayer(player)
    table.insert( self.players, player)
end