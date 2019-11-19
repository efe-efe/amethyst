Alliances = Alliances or class({})

function Alliances:Initialize()
    self.alliances = {}
end

function Alliances:Create( name )
    self.alliances[name] = { 
        teams = {},
        wins = 0,
        looser = false,
        players = {},
        heroes = {},
        name = name,
        amethysts = 0,
    }
end

function Alliances:AddTeam( alliance, team )
	local i = 1
	while self.alliances[alliance].teams[i] ~= nil do
		i = i+1
    end
    
    self.alliances[alliance].teams[i] = team
end

function Alliances:Update( hero )
    local team = hero:GetTeamNumber()
    local playerID = hero:GetPlayerOwnerID()
    local playerOwner = hero:GetPlayerOwner()
    local heroIndex = hero:GetEntityIndex()
    local alliance = self:FindByTeam(team)

    alliance.players[playerID] = playerOwner
    alliance.heroes[heroIndex] = hero
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
