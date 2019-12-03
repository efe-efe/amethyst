Alliances = Alliances or class({})

function Alliances:Initialize()
    local teams_radiant = {}
    local teams_dire = {}
    local teams_legion = {}
    local teams_void = {}

    teams_radiant[0] = DOTA_TEAM_GOODGUYS
    teams_radiant[1] = DOTA_TEAM_BADGUYS

    teams_dire[0] = DOTA_TEAM_CUSTOM_1
    teams_dire[1] = DOTA_TEAM_CUSTOM_2
    
    teams_legion[0] = DOTA_TEAM_CUSTOM_3
    teams_legion[1] = DOTA_TEAM_CUSTOM_4
    
    teams_void[0] = DOTA_TEAM_CUSTOM_5
    teams_void[1] = DOTA_TEAM_CUSTOM_6

    self.alliances = {
        DOTA_ALLIANCE_RADIANT = Alliances:Create("DOTA_ALLIANCE_RADIANT", teams_radiant),
        DOTA_ALLIANCE_DIRE = Alliances:Create("DOTA_ALLIANCE_DIRE", teams_dire),
        DOTA_ALLIANCE_LEGION = Alliances:Create("DOTA_ALLIANCE_LEGION", teams_legion),
        DOTA_ALLIANCE_VOID = Alliances:Create("DOTA_ALLIANCE_VOID", teams_void),
    }
end

function Alliances:Create( name, teams )
    return { 
        teams = teams,
        wins = 0,
        looser = false,
        players = {},
        heroes = {},
        name = name,
        amethysts = 0,
        initialized = false
    }
end

function Alliances:Update( hero )
    local team = hero:GetTeamNumber()
    local playerID = hero:GetPlayerOwnerID()
    local playerOwner = hero:GetPlayerOwner()
    local heroIndex = hero:GetEntityIndex()
    local alliance = self:FindByTeam(team)

    alliance.players[playerID] = playerOwner
    alliance.heroes[heroIndex] = hero
    if alliance.initialized == false then
        alliance.initialized = true
    end
end

function Alliances:FindByTeam( team )
    for _,alliance in pairs(self.alliances) do
        for _,m_team in pairs(alliance.teams) do
            if m_team == team then
                return alliance
            end
        end
    end
end

function Alliances:CheckAllies( hero_a, hero_b )
    local alliance_a = self:FindByTeam(hero_a:GetTeamNumber())
    local alliance_b = self:FindByTeam(hero_b:GetTeamNumber())

    if alliance_a == alliance_b then return true end
    return false
end
