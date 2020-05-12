Player = class({
    id = 0,
    userid = 0,
    hero = nil,
    team = 0,
    alliance = nil,
    cursor_position = Vector(0,0,0),
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

function Player:SetAlliance(alliance)
    self.alliance = alliance
end

function Player:UpdateCursorPosition(position)
    self.cursor_position = position
end