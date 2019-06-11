


--[[Called when player first spawn into the game, or if the player's hero is replaced with a new hero for any reason]]
function GameMode:OnHeroInGame(keys)
    local npc = EntIndexToHScript(keys.entindex)
    Timers:CreateTimer(.2, function()
        if not npc:IsNull() and npc:IsRealHero() and npc.bFirstSpawnedPG == nil then
            npc.bFirstSpawnedPG = true
            local hero = npc
            
            -- Disable right click
            hero:AddNewModifier( hero,  nil, "modifier_disable_right_click", { } )
        
            -- Level up 1 point to all spells
            for i = 0, 23 do
                local ability = hero:GetAbilityByIndex(i)
                if ability then
                    if ability:GetAbilityType() ~= 2 then -- To not level up the talents
                        ability:SetLevel(1)
                    end
                end
            end
        end

        if not npc:IsNull() and npc:IsRealHero() and npc:IsHero() and npc:IsConsideredHero() then
            -- Set mana as 0
            npc:SetMana(0)
            local team = npc:GetTeamNumber()
            -- Initialization
            if self.team_state == nil then
                self.team_state = {}
            end
            
            if self.team_state[team] == nil then
                self.team_state[team] = {
                    alive = 0,
                    loses = 0,
                    players = {}
                }
            end
            
            self.team_state[team].alive = self.team_state[team].alive + 1
            self.team_state[team].players[npc:GetPlayerOwnerID()] = npc:GetPlayerOwner()

            print("Team " .. team .. " heroes = " ..self.team_state[team].alive)
        end
    end)
end

-- An entity died
function GameMode:OnEntityKilled( keys )
    -- The Killed
    local killed = EntIndexToHScript( keys.entindex_killed )
    local isMiddleOrb = killed:Attribute_GetIntValue("middle_orb", 0)

    -- The Killer
    local killerEntity = nil
    if keys.entindex_attacker ~= nil then
        killerEntity = EntIndexToHScript( keys.entindex_attacker )
    end
    
    -- Put code here to handle when an entity gets killed
    if isMiddleOrb == 1 then
        MiddleOrb:CreateMiddleOrb()
    end

    if killed:IsRealHero() then
        if Convars:GetInt('test_mode') == 0 then -- should be 0
            if killed:IsHero() then
                local team = killed:GetTeamNumber()
                self.team_state[team].alive = self.team_state[team].alive - 1

                if self.team_state[team].alive <= 0 then
                    self.team_state[team].loses = self.team_state[team].loses + 1
                    print("Team " .. team .. " loses his round number " .. self.team_state[team].loses)
                    
                    local shouldEnd = false

                    if self.team_state[team].loses >= 3 then
                        shouldEnd = true
                    end
                    
                    Timers:CreateTimer(3.0, function()
                        for _,it_team in pairs(self.team_state) do
                            
                            if (_ ~= team) and shouldEnd == true then 
                                self:EndGame(_) 
                                break
                            end

                            it_team.alive = 0
                            for _,player in pairs(it_team.players) do
                                local heroe = player:GetAssignedHero()
                                heroe:SetRespawnsDisabled(false)
                                heroe:RespawnHero(false, false)
                                heroe:SetRespawnsDisabled(true)
                            end
                        end
                    end)
                end
            end
        end
    end


end

-- Called whenever an ability begins its PhaseStart phase, but before it is actually cast
function GameMode:OnAbilityCastBegins(keys)
    local player = PlayerResource:GetPlayer(keys.PlayerID)
    local abilityName = keys.abilityname
end

--Called once and only once when the game completely begins (0:00 on the clock).
function GameMode:OnGameInProgress()
	DebugPrint("[RITE] The game has officially begun")

	MiddleOrb:CreateMiddleOrb()
end

-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
    if GameMode._reentrantCheck then
        return
    end

    local newState = GameRules:State_Get()
    if newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
        self.bSeenWaitForPlayers = true
    elseif newState == DOTA_GAMERULES_STATE_INIT then
        --Timers:RemoveTimer("alljointimer")
    elseif newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
        GameMode:PostLoadPrecache()
        GameMode:OnAllPlayersLoaded()

    elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:OnGameInProgress()
    end
end

-- This function is called once when a player fully connects ("Ready" during Loading)
function GameMode:OnConnectFull(keys)
    if GameMode._reentrantCheck then
        return
    end
    GameMode:CaptureGameMode()
    
   
    local ply = EntIndexToHScript(keys.index + 1)  -- The Player entity of the joining user
    local playerID = ply:GetPlayerID() -- The Player ID of the joining player
    local userID = keys.userid
end

--Used to initialize before everyone loads in
function GameMode:OnFirstPlayerLoaded()
    DebugPrint("[RITE] First Player has loaded")
end

--Called right as the hero selection time begins.
function GameMode:OnAllPlayersLoaded()
    DebugPrint("[RITE] All Players have loaded into the game")
end

function GameMode:PostLoadPrecache()
    DebugPrint("[RITE] Performing Post-Load precache")    
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
    --DebugPrintTable(keys)

    local damagebits = keys.damagebits -- This might always be 0 and therefore useless
    if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
        local entCause = EntIndexToHScript(keys.entindex_attacker)
        local entVictim = EntIndexToHScript(keys.entindex_killed)

        -- The ability/item used to damage, or nil if not damaged by an item/ability
        local damagingAbility = nil

        if keys.entindex_inflictor ~= nil then
        damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
        end

        local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf"
        local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            nil
        )

        ParticleManager:SetParticleControlEnt( 
            effect_cast, 
            0, 
            entVictim, 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            entVictim:GetOrigin(), 
            true 
        );
        
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end

function GameMode:EndGame( victoryTeam )
	GameRules:SetGameWinner( victoryTeam )
end