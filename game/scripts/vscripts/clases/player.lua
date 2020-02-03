Player = class({
    id = 0,
    userid = 0,
    hero = nil,
    team = 0,
    alliance = nil,
})

function Player:constructor(id, userid)
    self.id = id
    self.userid = userid
end

function Player:SetHero(hero)
    self.hero = hero
end

function Player:SetTeam(i)
    self.team = i
end

function Player:SetAlliance( alliance )
    self.alliance = alliance
end