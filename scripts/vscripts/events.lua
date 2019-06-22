
--============================================================================================
-- GAME PHASES
--============================================================================================
function GameMode:OnGameRulesStateChange(keys)
    if GameMode._reentrantCheck then
        return
    end

    local newState = GameRules:State_Get()
    
    -------------------------------
    -- Setup Rules
    -------------------------------
    if newState == DOTA_GAMERULES_STATE_PRE_GAME then
        CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.ROUNDS_TO_WIN } );
    -------------------------------
    -- Setup Rules
    -------------------------------
    elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:OnGameInProgress()
    end
end

--============================================================================================
-- HERO SPAWNS
--============================================================================================
function GameMode:OnHeroInGame(keys)
    local npc = EntIndexToHScript(keys.entindex)

    -------------------------------
    -- Timer to prevent illusions from passing
    -------------------------------
    Timers:CreateTimer(.05, function()
        
        -------------------------------
        -- Filter unwanted units
        -------------------------------

        if npc:IsNull() then return end
        if not npc:IsRealHero() then return end
        
        -------------------------------
        -- Initialize variables
        -------------------------------
        local hero = npc

        -------------------------------
        -- First time spawning
        -------------------------------
        if hero.bFirstSpawnedPG == nil then
            hero.bFirstSpawnedPG = true
            
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

        -------------------------------
        -- Always
        -------------------------------
        self.lock_round = false
        hero:SetMana(0)
        local team = hero:GetTeamNumber()
        local playerID = hero:GetPlayerOwnerID()
        local playerOwner = hero:GetPlayerOwner()

        -- Initialization
        if self.teams[team] == nil then
            self.teams[team] = {
                alive_heroes = 0,
                wins = 0,
                looser = false,
                players = {}
            }
        end
        
        self.teams[team].alive_heroes = self.teams[team].alive_heroes + 1
        self.teams[team].players[playerID] = playerOwner

        print("Team " .. team .. " heroes = " ..self.teams[team].alive_heroes)
    end)
end

--============================================================================================
-- ENTITY DIED
--============================================================================================
function GameMode:OnEntityKilled( keys )
    -- The Killed
    local killed = EntIndexToHScript( keys.entindex_killed )
    local isMiddleOrb = killed:Attribute_GetIntValue("middle_orb", 0)

    -- The Killer
    local killerEntity = nil
    if keys.entindex_attacker ~= nil then
        killerEntity = EntIndexToHScript( keys.entindex_attacker )
    end
    
    -- Recreate orb
    if isMiddleOrb == 1 then
        MiddleOrb:Create()
    end

    -- Manage game state
    if killed:IsRealHero() and Convars:GetInt('test_mode') == 0 then
        print("DIED = " .. killed:GetName() .. " | self.lock_round is = " .. string.format("%s", self.lock_round))

        local team = killed:GetTeamNumber()
        local not_loosers = 0
        local shouldEnd = false
        local winner = nil
        local winner_id = nil

        -- If the killed unit's team have no more heroes
        if not self.lock_round then
            self.teams[team].alive_heroes = self.teams[team].alive_heroes - 1

            -- One team Has Lost
            if self.teams[team].alive_heroes <= 0 then

                -- Set the victory state
                self.teams[team].looser = true
                print("Team " .. team .. " loses this round")
                                
                -- Find if a team have won
                for _,it_team in pairs(self.teams) do
                    if not it_team.looser then 
                        winner = it_team
                        winner_id = _
                        not_loosers = not_loosers + 1
                    end
                end

                -- If there are only 1 not looser, lock the round
                if not_loosers == 1 then
                    self.lock_round = true

                    winner.wins = winner.wins + 1
                    if winner.wins >= self.ROUNDS_TO_WIN then
                        shouldEnd = true
                    end

                    local broadcast_win_round_event =
                    {
                        team_id = winner_id,
                        team_wins = winner.wins,
                        --[[killer_id = event.killer_userid,
                        kills_remaining = nKillsRemaining,
                        victory = 0,
                        close_to_victory = 0,
                        very_close_to_victory = 0,]]
                    }
                
                    CustomGameEventManager:Send_ServerToAllClients( "win_round_event", broadcast_win_round_event )
                end
                
                Timers:CreateTimer(3.0, function()
                    MiddleOrb:Destroy()
                    for _,it_team in pairs(self.teams) do
                        
                        if (_ ~= team) and shouldEnd == true then 
                            self:EndGame(_) 
                            break
                        end

                        for _,player in pairs(it_team.players) do
                            local heroe = player:GetAssignedHero()
                            heroe:Kill(nil, heroe)	
                        end
                        
                        it_team.alive_heroes = 0
                        it_team.looser = false

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

-- Called whenever an ability begins its PhaseStart phase, but before it is actually cast
function GameMode:OnAbilityCastBegins(keys)
    local player = PlayerResource:GetPlayer(keys.PlayerID)
    local abilityName = keys.abilityname
end

--============================================================================================
-- GAME OFFICIALY BEGINS (00:00)
--============================================================================================
function GameMode:OnGameInProgress()
	DebugPrint("[RITE] The game has officially begun")
    
    -------------------------------
    -- Core Variables
    -------------------------------
	self.allSpawned = false
    self.lock_round = false
    self.teams = {}
    self.ROUNDS_TO_WIN = 5

    CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.ROUNDS_TO_WIN } );

    MiddleOrb:Create()
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