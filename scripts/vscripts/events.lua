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
    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
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
    Timers:CreateTimer(0.5, function()
        
        -------------------------------
        -- Filter unwanted units
        -------------------------------

        if npc:IsNull() then return end
        if not npc:IsRealHero() then return end
        
        -------------------------------
        -- First time spawning
        -------------------------------
        if npc.bFirstSpawnedPG == nil then
            npc.bFirstSpawnedPG = true

            -- Disable right click
            npc:AddNewModifier( npc,  nil, "modifier_disable_right_click", { } )
        
            -- Level up 1 point to all spells
            for i = 0, 23 do
                local ability = npc:GetAbilityByIndex(i)
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
        npc:SetMana(0)
        npc:SetHealth(npc:GetMaxHealth())
        npc.iTreshold = 40
        local health_bar = "(" .. npc.iTreshold .. "/" .. self.iMaxTreshold ..")"
        npc:SetCustomHealthLabel(health_bar, 255, 255, 255)
        
        local team = npc:GetTeamNumber()
        local playerID = npc:GetPlayerOwnerID()
        local playerOwner = npc:GetPlayerOwner()
      
        self.teams[team].alive_heroes = self.teams[team].alive_heroes + 1
        self.teams[team].players[playerID] = playerOwner
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
        self:CreateMiddleOrb()
    end

    -- Manage game state
    if killed:IsRealHero() and Convars:GetInt('test_mode') == 0 then
        local killed_team = killed:GetTeamNumber()

        if not self.lock_round then
            self.teams[killed_team].alive_heroes = self.teams[killed_team].alive_heroes - 1

            -- If the killed unit's team have no more heroes
            if self.teams[killed_team].alive_heroes <= 0 then

                -- Set the victory state
                self.teams[killed_team].looser = true
                print("Team " .. killed_team .. " loses this round")
                
                local winner = self:FindWinner()
                if winner ~= false then 
                    winner.wins = winner.wins + 1

                    --Update score
                    CustomGameEventManager:Send_ServerToAllClients( "update_score", { 
                        dire = self.teams[DOTA_TEAM_BADGUYS].wins,
                        radiant = self.teams[DOTA_TEAM_GOODGUYS].wins,
                    })

                    self:EndRound(3.0)
                end
            end
        end
    end
end

--============================================================================================
-- GAME OFFICIALY BEGINS (00:00)
--============================================================================================
function GameMode:OnGameInProgress()
	DebugPrint("[RITE] The game has officially begun")

    self.countdownEnabled = true
    GameRules:GetGameModeEntity():SetThink( "OnThink", self, 1 ) 

    CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.ROUNDS_TO_WIN } );
    CustomGameEventManager:Send_ServerToAllClients( "update_score", { 
        dire = 0,
        radiant = 0,
    })

    GameRules:SendCustomMessage("Welcome to <b><font color='purple'>Amethyst</font></b>. If you have any doubts click on the 'i' at the left top corner of your screen.", 0, 0)
    GameRules:SendCustomMessage("Hotkeys are: <b>[ Q, W, E, D, SPACEBAR ]</b> for basic abilities. <b>[ R ]</b> For the ultimate. <b>[ 1, 2 ]</b> for the Ex-Abilities</b>", 0, 0)
    
    self:CreateMiddleOrb()
end

--============================================================================================
-- AT LEAST ONE PLAYERS IS FULLY CONNECTED
--============================================================================================
function GameMode:OnConnectFull(keys)
    if GameMode._reentrantCheck then
        return
    end
    GameMode:CaptureGameMode()
end

--============================================================================================
-- UNIT HAS BEEN DAMAGED
--============================================================================================
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
	
--============================================================================================
-- HELPERS
--============================================================================================
function GameMode:FindWinner()
    local teams_with_alive_players = 0
    local winner = nil

    for _,actual_team in pairs(self.teams) do
        if not actual_team.looser then 
            winner = actual_team
            teams_with_alive_players = teams_with_alive_players + 1
        end
    end

    -- If there are only 1 not looser, lock the round
    if teams_with_alive_players == 1 then
        self.lock_round = true
        return winner
    else
        return false
    end
end

--------------------------------------------------------------------------------
-- Restart Round
--------------------------------------------------------------------------------
function GameMode:EndRound( delay )
    Timers:CreateTimer(delay, function()
        self:DestroyMiddleOrb()
        self:DestroyDeathZone()

        for _,actual_team in pairs(self.teams) do
            
            if actual_team.wins >= self.ROUNDS_TO_WIN then
                self:EndGame(_) 
                break
            end

            for _,player in pairs(actual_team.players) do
                local hero = player:GetAssignedHero()
                hero:Kill(nil, hero)	
            end
            
            actual_team.alive_heroes = 0
            actual_team.looser = false

            for _,player in pairs(actual_team.players) do
                local hero = player:GetAssignedHero()
                hero:SetRespawnsDisabled(false)
                hero:RespawnHero(false, false)
                hero:SetRespawnsDisabled(true)
            end
        end
        self.countdownEnabled = true
        self.lock_round = false
        nCOUNTDOWNTIMER = 120
    end)
end

--------------------------------------------------------------------------------
-- Death zone spawner
--------------------------------------------------------------------------------
function GameMode:CreateDeathZone()
    DebugPrint("[RITE] Creating Death Zone")
    local orb_spawn = Entities:FindByName(nil, "orb_spawn")
    local orb_position = orb_spawn:GetOrigin()

    self.modifier_death_zone = CreateModifierThinker(
        nil, --hCaster
        nil, --hAbility
        "modifier_death_zone", --modifierName
        {}, --paramTable
        orb_position, --vOrigin
        DOTA_TEAM_NOTEAM, --nTeamNumber
        false --bPhantomBlocker
	)
end

--------------------------------------------------------------------------------
-- Death zone spawner
--------------------------------------------------------------------------------
function GameMode:DestroyDeathZone()
    DebugPrint("[RITE] Destroying Death Zone")
    -- Safe destroying
    if self.modifier_death_zone~=nil then
        if not self.modifier_death_zone:IsNull() then
            self.modifier_death_zone:Destroy()
        end
    end
end

--------------------------------------------------------------------------------
-- Middle Orb spawner
--------------------------------------------------------------------------------
function GameMode:CreateMiddleOrb()
    DebugPrint("[RITE] Creating Middle Orb")

	local orb_spawn = Entities:FindByName(nil, "orb_spawn")
    local orb_position = orb_spawn:GetOrigin()

    self.middle_orb_instance = CreateUnitByName(
        "npc_dota_creature_middle_orb", --szUnitName
        orb_position, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    self.middle_orb_instance:Attribute_SetIntValue("middle_orb", 1)

    -- Orb Spawn Effects
    local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
    
    local sound_cast = "Hero_Oracle.FortunesEnd.Target"
    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, middle_orb )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, middle_orb )
    
    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
    EmitSoundOn( sound_cast, middle_orb )
end

--------------------------------------------------------------------------------
-- Middle Orb Destroyer
--------------------------------------------------------------------------------
function GameMode:DestroyMiddleOrb()
    if self.middle_orb_instance ~= nil then
        self.middle_orb_instance:Kill(nil, self.middle_orb_instance)
    end
end

--------------------------------------------------------------------------------
-- End Game
--------------------------------------------------------------------------------
function GameMode:EndGame( victoryTeam )
	GameRules:SetGameWinner( victoryTeam )
end
