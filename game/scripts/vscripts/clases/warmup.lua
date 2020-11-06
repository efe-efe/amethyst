Warmup = Warmup or class({}, nil, GameState)

local WARMUP_TIME = WARMUP_DURATION
local DUMMY_TARGET_RESPAWN = 5.0
local ADRENALINE_DURATION = 25.0

function Warmup:constructor(players, callback)
    self.time_remaining = WARMUP_TIME * 10
    self.callback = callback
    self.players = players
    
    self.dummy_targets_ents = Entities:FindAllByName("dummy_target")
    self.dummy_targets = {}
    
    self.radiant_spawn = Entities:FindByName(nil, "radiant_spawn")
    self.dire_spawn = Entities:FindByName(nil, "dire_spawn")

    for _,entity in pairs(self.dummy_targets_ents) do
        table.insert(self.dummy_targets, {
            origin = entity:GetOrigin(),
            timer = 0,
            entity = DummyTarget(entity:GetOrigin()),
        })
    end
end

function Warmup:Update()
    if self.time_remaining > 0 then
        self.time_remaining = self.time_remaining - 1
        self:UpdateGameTimer(math.floor(self.time_remaining/10))

        if self.time_remaining <= 30 and self.time_remaining > 0 then
            CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = tostring(self.time_remaining/10) })
        end

        for _,dummy_target in ipairs(self.dummy_targets) do
            if not dummy_target.entity then
                dummy_target.timer = dummy_target.timer - 1
                if dummy_target.timer <= 0 then
                    dummy_target.entity = DummyTarget(dummy_target.origin)
                end
            else
                if not dummy_target.entity:Alive() then
                    dummy_target.timer = DUMMY_TARGET_RESPAWN * 10
                    dummy_target.entity = nil
                end
            end
        end
    else
        if WARMUP_TIME ~= -1 then
            self:EndWarmup()
        end
    end
end

function Warmup:EndWarmup()
    self:DestroyAllDummyTargets()

    for _,player in pairs(self.players) do
        local target = nil

        if player.alliance.name == "DOTA_ALLIANCE_RADIANT" then
            target = self.radiant_spawn
        end
        if player.alliance.name == "DOTA_ALLIANCE_DIRE" then
            target = self.dire_spawn
        end

        FindClearSpaceForUnit(player.hero, target:GetAbsOrigin(), true)
        player.hero:Reset()
        player.hero:AddNewModifier(player.hero, nil, "modifier_adrenaline", { duration = ADRENALINE_DURATION })
    end

    self:callback()
end

function Warmup:DestroyAllDummyTargets()
    for _,dummy_target in pairs(self.dummy_targets) do
        if dummy_target.entity then
            dummy_target.entity:Destroy(true)
        end

        dummy_target = nil
    end
end
