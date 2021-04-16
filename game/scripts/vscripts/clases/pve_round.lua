PveRound = PveRound or class({}, nil, GameState)

function PveRound:constructor(tAlliances, fDuration)
    getbase(PveRound).constructor(self, tAlliances, fDuration)
    self.npc = DireZombie(Vector(150, 0, 128))
    --self.boss = Centaur(Vector(150, 0, 128))
end

function PveRound:Update()
    getbase(PveRound).Update(self)
    self.npc:Update()

    if self.boss then
        if self.helper == 0 then
            self.boss:Update()
        else 
            self.helper = self.helper - 1
        end
    end
end

function PveRound:EndPveRound()
    GameRules.GameMode.pve_round = nil
    GameRules.GameMode:SetState(CustomGameState.PVE_POST_ROUND)
end