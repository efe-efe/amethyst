


--[[Called when player first spawn into the game, or if the player's hero is replaced with a new hero for any reason]]
function GameMode:OnHeroInGame(keys)
    local npc = EntIndexToHScript(keys.entindex)

    if npc:IsRealHero() and npc.bFirstSpawnedPG == nil then
        npc.bFirstSpawnedPG = true
        local hero = npc

        -- Set mana as 0
        Timers:CreateTimer(.01, function() hero:SetMana(0) end)
        
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
end

-- An entity died
function GameMode:OnEntityKilled( keys )
    -- The Killed
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    local isMiddleOrb = killedUnit:Attribute_GetIntValue("middle_orb", 0)
    local totalHeroes = PlayerResource:GetPlayerCount()

    -- The Killer
    local killerEntity = nil
    if keys.entindex_attacker ~= nil then
        killerEntity = EntIndexToHScript( keys.entindex_attacker )
    end
    
    -- Put code here to handle when an entity gets killed
    if isMiddleOrb == 1 then
        MiddleOrb:CreateMiddleOrb(30.0)
    end

    if killedUnit:IsRealHero() then
        if killedUnit:GetTeamNumber() == 2 then
            self.team_a_actual_units = self.team_a_actual_units - 1
        end
        if killedUnit:GetTeamNumber() == 3 then
            self.team_b_actual_units = self.team_b_actual_units - 1
        end
    
        DebugPrint("Actual units on Team A " .. self.team_a_actual_units)
        DebugPrint("Actual units on Team B " .. self.team_b_actual_units)
    end
end

-- Called whenever an ability begins its PhaseStart phase, but before it is actually cast
function GameMode:OnAbilityCastBegins(keys)
    DebugPrint('[BAREBONES] OnAbilityCastBegins')
    DebugPrintTable(keys)

    local player = PlayerResource:GetPlayer(keys.PlayerID)
    local abilityName = keys.abilityname
end

--Called once and only once when the game completely begins (0:00 on the clock).
function GameMode:OnGameInProgress()
	DebugPrint("[RITE] The game has officially begun")

	MiddleOrb:CreateMiddleOrb(30.0)
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

    local entIndex = keys.index + 1

    -- The Player entity of the joining user
    local ply = EntIndexToHScript(entIndex)
    -- The Player ID of the joining player
    local playerID = ply:GetPlayerID()
    local userID = keys.userid
            
    -- Initialization
    if not self.team_a_actual_units then
        self.team_a_actual_units = 0
        self.team_a_total_units = 0
    end

    if not self.team_b_actual_units then
        self.team_b_actual_units = 0
        self.team_b_total_units = 0
    end

    DebugPrint("PlayerResource:GetTeam(playerID)" .. PlayerResource:GetTeam(playerID))

    if PlayerResource:GetTeam(playerID) == 5 then
        self.team_a_actual_units = self.team_a_actual_units + 1
        self.team_a_total_units = self.team_a_total_units + 1
    end
    if PlayerResource:GetTeam(playerID) == 6 then
        self.team_b_actual_units = self.team_b_actual_units + 1
        self.team_b_total_units = self.team_b_total_units + 1
    end
    
    DebugPrint("Total units on team A " .. self.team_a_total_units)
    DebugPrint("Total units on team B " .. self.team_b_total_units)

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