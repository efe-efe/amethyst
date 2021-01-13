GameState = GameState or class({})

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