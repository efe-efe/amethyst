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
end