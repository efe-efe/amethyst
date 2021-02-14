Warmup = Warmup or class({}, nil, GameState)

local DUMMY_TARGET_RESPAWN = 5.0
local ADRENALINE_DURATION = 25.0

function Warmup:constructor(tAlliances, fDuration)
    getbase(Warmup).constructor(self, tAlliances, fDuration)

    self.dummy_targets_ents = Entities:FindAllByName("dummy_target")
    self.dummy_targets = {}

    for _,entity in pairs(self.dummy_targets_ents) do
        table.insert(self.dummy_targets, {
            origin = entity:GetOrigin(),
            timer = 0,
            entity = DummyTarget(entity:GetOrigin()),
        })
    end
end

function Warmup:Update()
    getbase(Warmup).Update(self)
    if self.time_remaining > 0 then
        self:UpdateGameTimer(math.floor(self.time_remaining/30))

        if self.time_remaining <= 30 and self.time_remaining > 0 then
            CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = tostring(self.time_remaining/30) })
        end

        for _,dummy_target in ipairs(self.dummy_targets) do
            if not dummy_target.entity then
                dummy_target.timer = dummy_target.timer - 1
                if dummy_target.timer <= 0 then
                    dummy_target.entity = DummyTarget(dummy_target.origin)
                end
            else
                if not dummy_target.entity:Alive() then
                    dummy_target.timer = DUMMY_TARGET_RESPAWN * 30
                    dummy_target.entity = nil
                end
            end
        end
    else
        if self.max_duration ~= -1 then
            self:EndWarmup()
        end
    end
end

function Warmup:EndWarmup()
    self:DestroyAllDummyTargets()

    for _,alliance in pairs(self.alliances) do
        alliance:SetAmethysts(0)
    end

    GameRules.GameMode.warmup = nil
    GameRules.GameMode.pre_round = PreRound(self.alliances, PRE_ROUND_DURATION)
    GameRules.GameMode:SetState(CustomGameState.PRE_ROUND)
end

function Warmup:DestroyAllDummyTargets()
    for _,dummy_target in pairs(self.dummy_targets) do
        if dummy_target.entity then
            dummy_target.entity:Destroy(true)
        end

        dummy_target = nil
    end
end
