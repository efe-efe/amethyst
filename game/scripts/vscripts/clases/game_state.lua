GameState = GameState or class({})

function GameState:constructor(tAlliances, fDuration)
    self.alliances = tAlliances
    self.time_remaining = fDuration * 30
    self.max_duration = fDuration
end

function GameState:Update()
    if self.time_remaining > 0 then
        self.time_remaining = self.time_remaining - 1
    end
end

function GameState:GetAllPlayers()
    local players = {}
    if self.alliances then
        for key, alliance in pairs(self.alliances) do
            for _key, player in pairs(alliance:GetPlayers()) do
                table.insert(players, player)
            end
        end
    end

    return players
end

function GameState:GetDuration()
    return math.floor(self.time_remaining/30)
end

function GameState:SetDuration(fDuration)
    self.time_remaining = fDuration * 30
end

function GameState:UpdateGameTimer(time)
    local minutes = math.floor(time / 60)
    local seconds = time - (minutes * 60)
    local m10 = math.floor(minutes / 10)
    local m01 = minutes - (m10 * 10)
    local s10 = math.floor(seconds / 10)
    local s01 = seconds - (s10 * 10)
    local broadcast_gametimer = 
        {
            timer_minute_10 = m10,
            timer_minute_01 = m01,
            timer_second_10 = s10,
            timer_second_01 = s01,
        }
  
    CustomGameEventManager:Send_ServerToAllClients("countdown", broadcast_gametimer)
end