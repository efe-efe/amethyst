PreRound = PreRound or class({}, nil, GameState)

function PreRound:constructor(tAlliances, fDuration)
    getbase(PreRound).constructor(self, tAlliances, fDuration)
    self.radiant_spawn = Entities:FindByName(nil, "radiant_spawn")
    self.dire_spawn = Entities:FindByName(nil, "dire_spawn")

    
    for _,player in pairs(self:GetAllPlayers()) do
        local hero = player.hero
        hero:AddNewModifier(hero, nil, 'modifier_restricted', {})
    end
end

function PreRound:Update()
    getbase(PreRound).Update(self)
    if self.time_remaining >= 0 then
        self:UpdateGameTimer(math.floor(self.time_remaining/30))
    end
    if self.time_remaining == 0 then
        self:EndPreRound()
    end
end

function PreRound:EndPreRound()
    for _,player in pairs(self:GetAllPlayers()) do
        local target = nil

        if player.alliance.name == "DOTA_ALLIANCE_RADIANT" then
            target = self.radiant_spawn
        end
        if player.alliance.name == "DOTA_ALLIANCE_DIRE" then
            target = self.dire_spawn
        end

        local hero = player.hero

        FindClearSpaceForUnit(hero, target:GetAbsOrigin(), true)
        CustomEntities:Reset(hero)
        CustomEntities:AutoUpgradeAbilities(hero)
        hero:RemoveModifierByName('modifier_restricted')
        hero:AddNewModifier(hero, nil, "modifier_adrenaline", { duration = ADRENALINE_DURATION })
    end

    GameRules.GameMode.pre_round = nil
    GameRules.GameMode.round = Round(self.alliances, ROUND_DURATION)
    GameRules.GameMode:SetState(CustomGameState.ROUND_IN_PROGRESS)
end