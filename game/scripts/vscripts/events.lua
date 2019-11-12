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
-- GAME OFFICIALY BEGINS (00:00)
--============================================================================================
function GameMode:OnGameInProgress()
	print("[AMETHYST] The game has officially begun")

    self.countdownEnabled = true
    GameRules:GetGameModeEntity():SetThink( "OnThink", self, 1 ) 

    CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.ROUNDS_TO_WIN } );

    GameRules:SendCustomMessage("Welcome to <b><font color='purple'>Amethyst</font></b>. If you have any doubts click on the 'i' at the left top corner of your screen.", 0, 0)
    GameRules:SendCustomMessage("Hotkeys are: <b>[ Q, W, E, D, SPACEBAR ]</b> for basic abilities. <b>[ R ]</b> For the ultimate. <b>[ 1, 2 ]</b> for the Ex-Abilities</b>", 0, 0)
    
    self.health_orbs_ent = Entities:FindAllByName("health_orb")
    self.mana_orbs_ent = Entities:FindAllByName("mana_orb")
    self.middle_orbs_ent = Entities:FindAllByName("orb_spawn")
    self.walls_ents = Entities:FindAllByName("wall_spawn")
    self.orbs = {} -- Created orbs on the map
    self.orb_timers_ent = {}
    self.effect_cast_arrows = {}
    self.walls = {} -- Created walls on the map

    for i = 1, 5 do
        local orb_name = "orb_timer" .. tostring(i)
        self.orb_timers_ent[i] = Entities:FindAllByName(orb_name)
    end
    
    self.orb_timers = {}
    self:CreateAllOrbs()
    self:CreateWalls()
    
    self.scheduled_middle_orb_index = RandomInt(1, 3)
    self:CreateMiddleOrb( self.scheduled_middle_orb_index, self.FIRST_MIDDLE_ORB_SPAWN_TIME)
    self:PlayEffectsArrow()
    self.next_middle_orb_index = RandomInt(1, #self.middle_orbs_ent)
end

--============================================================================================
-- HERO SPAWNS
--============================================================================================
function GameMode:OnHeroInGame(keys)
    local npc = EntIndexToHScript(keys.entindex)

    -------------------------------
    -- Timer to prevent illusions from passing
    -------------------------------
    Timers:CreateTimer(0.1, function()
        -------------------------------
        -- Filter unwanted units
        -------------------------------
        if npc:IsNull() then return end
        if not npc:IsRealHero() then return end

        -------------------------------
        -- Initialize variables
        -------------------------------
        local team = npc:GetTeamNumber()
        local playerID = npc:GetPlayerOwnerID()
        local playerOwner = npc:GetPlayerOwner()

        -------------------------------
        -- First time spawning
        -------------------------------
        if npc.bFirstSpawnedPG == nil then
            npc.bFirstSpawnedPG = true

            npc.direction = {}
            npc.direction.x = 0
            npc.direction.y = 0
            npc.direction.z = 0

            npc.first_left = false
            npc.first_right = false
            npc.first_up = false
            npc.first_down = false

            npc.last_spell = nil

            npc.healing_reduction_pct = 0

            self.mouse_positions[npc:GetPlayerID()] = Vector(0,0,0)

            -- Basic modifiers
            npc:AddNewModifier( npc,  nil, "modifier_disable_right_click", { } )
            npc:AddNewModifier( npc,  nil, "modifier_generic_movement", { } )
            npc:AddNewModifier( npc,  nil, "modifier_treshold", { max_treshold = self.iMaxTreshold })
            
            -- Level up 1 point to all spells
            for i = 0, 23 do
                local ability = npc:GetAbilityByIndex(i)
                if ability then
                    if ability:GetAbilityType() ~= 2 then -- To not level up the talents
                        ability:SetLevel(1)
                    end
                end
            end

            -- Initialize team if not initialized yet
            --[[
            if self.teams[team] == nil then
                self.teams[team] = {
                    wins = 0,
                    looser = false,
                    players = {},
                    heroes = {},
                    teamId = team,
                }
            end

            self.teams[team].players[playerID] = playerOwner
            self.teams[team].heroes[keys.entindex] = npc -- Save the heroe, in case the player is not connected
            ]]

            self:UpdateAlliance(keys.entindex)

            local data = {
                teamID = team,
                playerID = playerID,
                heroIndex = keys.entindex,
                heroName = npc:GetName()
            }
            CustomGameEventManager:Send_ServerToAllClients( "add_player", data )
        end
    
        -------------------------------
        -- Always
        -------------------------------
        SafeDestroyModifier("modifier_generic_provides_vision", npc, nil)
        npc:SetMana(0)
		npc:FindModifierByName("modifier_treshold"):SetStackCount(self.iMaxTreshold)

        npc:SetHealth(npc:GetMaxHealth())
        npc.iTreshold = self.iMaxTreshold
        self:UpdateHeroHealthBar( npc )
        self:UpdateHeroManaBar( npc )
        --local health_bar = "(" .. npc.iTreshold .. "/" .. self.iMaxTreshold ..")"
        --npc:SetCustomHealthLabel(health_bar, 255, 255, 255)
    end)
end

--============================================================================================
-- ENTITY DIED
--============================================================================================
function GameMode:OnEntityKilled( keys )
    local killed = EntIndexToHScript( keys.entindex_killed )
    
    -- Recreate orb
    if killed:IsMiddleOrb() then     

        self:DestroyAllTimers()

        self:CreateMiddleOrb( self.next_middle_orb_index, self.MIDDLE_ORB_SPAWN_TIME)
        self.scheduled_middle_orb_index = self.next_middle_orb_index

        self:StopEffectsArrow()
        self:PlayEffectsArrow()

        if not self:IsDeathZoneCreated() then
            self.next_middle_orb_index = RandomInt(1, #self.middle_orbs_ent)
            while self.next_middle_orb_index == self.scheduled_middle_orb_index do
                self.next_middle_orb_index = RandomInt(1, #self.middle_orbs_ent)
            end
        end

        if keys.entindex_attacker ~= nil then
            local killer = EntIndexToHScript( keys.entindex_attacker )
            local killer_team = killer:GetTeamNumber()
            local killer_alliance = self:FindAllianceByTeam(killer_team)

            killer_alliance.amethysts = killer_alliance.amethysts + 1
            
            local data = {
                good_guys = self.alliances["DOTA_ALLIANCE_RADIANT"].amethysts,
                bad_guys = self.alliances["DOTA_ALLIANCE_DIRE"].amethysts
            }

            CustomGameEventManager:Send_ServerToAllClients( "update_amethysts", data )

        end
    end

    if killed:IsRealHero() then
        local killed_team = killed:GetTeamNumber()
        local killed_alliance = self:FindAllianceByTeam(killed_team)

        if not self.lock_round then
            self:CreateDeathOrb(killed)
            if self:GetAliveHeroes(killed_alliance) <= 0 then
                print("[ROUNDS] Alliance " .. killed_alliance.name .. " loses this round")

                killed_alliance.looser = true
                local winner = self:FindWinner()
                if winner ~= false then 
                    winner.wins = winner.wins + 1
                    self:EndRound(3.0)
                end
            end
        end
    end

    self:UpdateCameras()
end

--------------------------------------------------------------------------------
-- Event: OnItemPickUp
--------------------------------------------------------------------------------
function GameMode:OnItemPickUp( event )
	local item = EntIndexToHScript( event.ItemEntityIndex )
    local owner = EntIndexToHScript( event.HeroEntityIndex )
    
    if  event.itemname == "item_health_orb" or 
        event.itemname == "item_mana_orb" or 
        event.itemname == "item_death_orb" 
    then
        if event.itemname == "item_health_orb" or event.itemname == "item_mana_orb" then
            local name 
            if event.itemname == "item_health_orb" then
                name = "health"
            elseif event.itemname == "item_mana_orb" then
                name = "mana" 
            end

            self:CreateOrb(self.orbs[event.ItemEntityIndex].pos, name, self.ORBS_SPAWN_TIME)
        end

        UTIL_Remove( item ) -- otherwise it pollutes the player inventory
    end
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
    local alliances_with_alive_players = 0
    local winner = nil

    for _,alliance in pairs(self.alliances) do
        if not alliance.looser then 
            winner = alliance
            alliances_with_alive_players = alliances_with_alive_players + 1
        end
    end

    -- If there are only 1 not looser, lock the round
    if alliances_with_alive_players == 1 then
        self.lock_round = true
        return winner
    else
        return false
    end
end

function GameMode:FindNextAliveAlly( alliance )
    for _,hero in pairs(alliance.heroes) do
        if hero:IsAlive() then
            return hero
        end
    end

    return nil
end

function GameMode:FindNextAliveHero()
    for _,alliance in pairs(self.alliances) do
        for _,hero in pairs(alliance.heroes) do
            if hero:IsAlive() then
                return hero
            end
        end
    end

    return nil
end

function GameMode:GetAliveHeroes( alliance )
    local alive_heroes = 0
    
    for _,hero in pairs(alliance.heroes) do
        if hero:IsAlive() then
            alive_heroes = alive_heroes + 1
        end
    end

    return alive_heroes
end

function GameMode:UpdateCameras()
    for _,alliance in pairs(self.alliances) do
        for _,hero in pairs(alliance.heroes) do
            if not hero:IsAlive() then
                local alive_ally = self:FindNextAliveAlly( alliance )

                if alive_ally ~= nil then
                    PlayerResource:SetCameraTarget(hero:GetPlayerID(), alive_ally)
                    alive_ally:AddNewModifier(
                        hero,
                        nil,
                        "modifier_generic_provides_vision",
                        {}
                    )
                else 
                    local alive_hero = self:FindNextAliveHero()
                    if alive_hero ~= nil then
                        PlayerResource:SetCameraTarget(hero:GetPlayerID(), alive_hero)
                        alive_hero:AddNewModifier(
                            hero,
                            nil,
                            "modifier_generic_provides_vision",
                            {}
                        )
                    end
                end
            end
        end
    end
end

--------------------------------------------------------------------------------
-- Restart Round
--------------------------------------------------------------------------------
function GameMode:EndRound( delay )
    Timers:CreateTimer(delay, function()
        self:DestroyMiddleOrb()
        self:DestroyDeathZone()
        self:DestroyAllOrbs()
        --self:DestroyAllWalls()

        self.scheduled_middle_orb_index = RandomInt(1, 3)
        self:CreateMiddleOrb(self.scheduled_middle_orb_index, self.FIRST_MIDDLE_ORB_SPAWN_TIME)
        self:PlayEffectsArrow()
        self.next_middle_orb_index = RandomInt(1, #self.middle_orbs_ent)
        
        self:CreateAllOrbs()
        --self:CreateWalls()

        for _,alliance in pairs(self.alliances) do
            if 
                alliance.wins >= self.ROUNDS_TO_WIN or 
                ( alliance.wins - self:GetOppositeAlliance(alliance).wins ) >= self.DIFFERNECE_TO_WIN
            then
                self:EndGame(alliance.teams[1]) 
                break
            end

            for _,hero in pairs(alliance.heroes) do
                hero:Kill(nil, hero)	
            end
            
            alliance.looser = false
            alliance.amethysts = 0

            for heroIndex, hero in pairs(alliance.heroes) do
                hero:SetRespawnsDisabled(false)
                hero:RespawnHero(false, false)
                hero:SetRespawnsDisabled(true)
                PlayerResource:SetCameraTarget(hero:GetPlayerID(), hero)
                Timers:CreateTimer(0.5, function()	
                    PlayerResource:SetCameraTarget(hero:GetPlayerID(), nil)
                end)
            end
        end
        self.countdownEnabled = true
        self.lock_round = false
        
        local score = { 
            good_guys = self.alliances["DOTA_ALLIANCE_RADIANT"].wins,
            bad_guys = self.alliances["DOTA_ALLIANCE_DIRE"].wins,
        }

        --Update score
        CustomGameEventManager:Send_ServerToAllClients( "update_score", score )

        local data = {
            good_guys = self.alliances["DOTA_ALLIANCE_RADIANT"].amethysts,
            bad_guys = self.alliances["DOTA_ALLIANCE_DIRE"].amethysts
        }
        CustomGameEventManager:Send_ServerToAllClients( "update_amethysts", data )
        
        nCOUNTDOWNTIMER = nMAX_COUNTDOWNTIMER
    end)
end

--------------------------------------------------------------------------------
-- Death zone spawner
--------------------------------------------------------------------------------
function GameMode:CreateDeathZone()
    print("[AMETHYST] Creating Death Zone")

    local index = self:IsMiddleOrbCreated() and self.scheduled_middle_orb_index or self.next_middle_orb_index
    self.next_middle_orb_index = self.scheduled_middle_orb_index
    
    local orb_position = self.middle_orbs_ent[index]:GetOrigin()

    CustomGameEventManager:Send_ServerToAllClients( "death_zone_initiated", {} )

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

function GameMode:IsDeathZoneCreated()
    if self.modifier_death_zone ~= nil then
        if not self.modifier_death_zone:IsNull() then
            return true
        end
    end
    return false
end

function GameMode:IsMiddleOrbCreated()
    if self.middle_orb_instance ~= nil then
        return true
    end
    return false
end

--------------------------------------------------------------------------------
-- Death zone destroyer
--------------------------------------------------------------------------------
function GameMode:DestroyDeathZone()
    print("[AMETHYST] Destroying Death Zone")
    -- Safe destroying
    if self.modifier_death_zone ~= nil then
        if not self.modifier_death_zone:IsNull() then
            self.modifier_death_zone:Destroy()
        end
    end
end

--------------------------------------------------------------------------------
-- Walls Orb spawner
--------------------------------------------------------------------------------
function GameMode:CreateWalls()
    print("[AMETHYST] Creating Walls")
    for _,wall_ent in pairs(self.walls_ents) do
        self:CreateWall(wall_ent)
    end
end

function GameMode:CreateWall( ent )
    local fow_blocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = ent:GetOrigin(), block_fow = true})
    self.walls[ent] = CreateUnitByName(
        "npc_dota_creature_wall", --szUnitName
        ent:GetOrigin(), --vLocation
        false, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    self.walls[ent]:Attribute_SetIntValue("wall", 1)
    self.walls[ent]:SetHullRadius(70)
    self.walls[ent]:AddNewModifier(self.walls[ent], nil, "wall_base", { fow_blocker = fow_blocker:GetEntityIndex() })
end

--------------------------------------------------------------------------------
-- Middle Orb spawner
--------------------------------------------------------------------------------
function GameMode:CreateMiddleOrb( index, delay )
    print("[AMETHYST] Creating Middle Orb")
    
    local orb_position = self.middle_orbs_ent[index]:GetOrigin()

    self.middle_orb_instance = CreateUnitByName(
        "npc_dota_creature_middle_orb", --szUnitName
        orb_position, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    self.middle_orb_instance:Attribute_SetIntValue("middle_orb", 1)
    self.middle_orb_instance:AddNewModifier(
        self.middle_orb_instance,
        nil,
        "modifier_middle_orb_exiled",
        {}
    )
    self.middle_orb_instance:SetHullRadius(10)
    
    local counter = 0.0
    local counter_sum = delay / 5
    
    for _,orb_timer_ent in pairs(self.orb_timers_ent) do
        counter = counter + counter_sum

        local timer_origin = orb_timer_ent[index]:GetOrigin()
        local name = "SpawnTimer_" .. orb_timer_ent[index]:GetEntityIndex() 

        self.middle_orb_instance:SetContextThink( name , function()
            self.orb_timers[_] = CreateUnitByName(
                "npc_dota_creature_middle_orb_timer", --szUnitName
                timer_origin, --vLocation
                true, --bFindClearSpace
                nil, --hNPCOwner
                nil, --hUnitOwner
                DOTA_TEAM_NOTEAM
            )
            
            local particle_cast = "particles/mod_units/units/middle_orb/rune_arcane.vpcf"
            ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.orb_timers[_] )
        end, counter)
    end

    GameRules:SendCustomMessage("The <b><font color='purple'>Amethyst</font></b> will spawn in <b>" .. delay .. "</b> seconds", 0, 0)
    self.middle_orb_instance:SetContextThink("SpawnMiddleOrb", function()
        GameRules:SendCustomMessage("The <b><font color='purple'>Amethyst</font></b> has spawned", 0, 0)
        SafeDestroyModifier("modifier_middle_orb_exiled", self.middle_orb_instance, self.middle_orb_instance)
        
        EmitSoundOn( "Hero_Oracle.FortunesEnd.Target", self.middle_orb_instance )

        -- Orb Spawn Effects
        local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
        local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
        local particle_cast_c = "particles/generic_gameplay/rune_arcane.vpcf"

        local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self.middle_orb_instance )
        local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self.middle_orb_instance )
        ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self.middle_orb_instance )

        ParticleManager:ReleaseParticleIndex( effect_cast_a )
        ParticleManager:ReleaseParticleIndex( effect_cast_b )
    end, delay)
end

--------------------------------------------------------------------------------
-- Middle Orb Destroyer
--------------------------------------------------------------------------------
function GameMode:DestroyMiddleOrb()
    if self.middle_orb_instance ~= nil then
        UTIL_Remove(self.middle_orb_instance)
        self:DestroyAllTimers()
        self:StopEffectsArrow()
    end
end

--------------------------------------------------------------------------------
--Health and mana orbs spawner
--------------------------------------------------------------------------------
function GameMode:CreateAllOrbs()
    for _,health_orb_ent in pairs(self.health_orbs_ent) do
        self:CreateOrb(health_orb_ent:GetOrigin(), "health", self.ORBS_SPAWN_TIME)
    end

    for _,mana_orb_ent in pairs(self.mana_orbs_ent) do
        self:CreateOrb(mana_orb_ent:GetOrigin(), "mana", self.ORBS_SPAWN_TIME)
    end
end

--------------------------------------------------------------------------------
--Health and mana orbs destroyer
--------------------------------------------------------------------------------
function GameMode:DestroyAllOrbs()
    for _,orb in pairs(self.orbs) do
        UTIL_Remove( orb.item ) -- otherwise it pollutes the player inventory
        if orb.drop ~= nil and not orb.drop:IsNull() then
            UTIL_Remove( orb.drop )
        end
    end
end

function GameMode:DestroyAllWalls()
    for _,wall in pairs(self.walls) do
        PrintTable(wall)
        if wall:IsAlive() then
            wall:Kill(nil, wall)
        end
    end
end

function GameMode:DestroyAllTimers()
    for _,timer in pairs(self.orb_timers) do
        UTIL_Remove( timer )
    end
end

function GameMode:CreateDeathOrb( hero )
    -- CREATE DEATH ORB
    local current_mana = hero:GetMana()
    local mana_given = NearestValue({ 25, 50, 75, 100 }, current_mana)
    local death_orb_ent = self:CreateOrb(hero:GetOrigin(), "death", 0.0, (mana_given/100) + 0.25 )

    self.orbs[death_orb_ent].item:SetCurrentCharges(mana_given)
    self.orbs[death_orb_ent].item:SetPurchaser(hero)
end

--------------------------------------------------------------------------------
-- Middle Orb spawner
--------------------------------------------------------------------------------
function GameMode:CreateOrb( pos, type, delay, scale )
    local name = "item_" .. type .. "_orb"

    local particle_cast = ""
    if type == "health" then
        particle_cast = "particles/generic_gameplay/rune_regeneration.vpcf"
    elseif type == "mana" then
        particle_cast = "particles/generic_gameplay/rune_doubledamage.vpcf"
    elseif type == "death" then
        particle_cast = "particles/generic_gameplay/rune_haste.vpcf"
    end

    local item = CreateItem( name, nil, nil )
    item:LaunchLootInitialHeight( false, 0, 50, 0.5, pos )
    
    local item_index = item:GetEntityIndex()

    self.orbs[item_index] = {}
    self.orbs[item_index].item = item
    self.orbs[item_index].drop = nil
    self.orbs[item_index].pos = pos

    item:SetContextThink("SpawnItem", function() 
        local drop = CreateItemOnPositionForLaunch( pos, item )
        ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, drop )
        
        if scale ~= nil then
            drop:SetModelScale( scale )	
        end

        self.orbs[item_index].drop = drop
    end, delay)

    return item_index
end

--------------------------------------------------------------------------------
-- End Game
--------------------------------------------------------------------------------
function GameMode:EndGame( victoryTeam )
	GameRules:SetGameWinner( victoryTeam )
end

function GameMode:StopEffectsArrow()
    for _,effect in pairs(self.effect_cast_arrows) do
        ParticleManager:DestroyParticle(effect, false)
        ParticleManager:ReleaseParticleIndex(effect)
    end
end

function GameMode:PlayEffectsArrow()
    local offset = 128
    local particle_cast = "particles/ui_mouseactions/range_finder_directional.vpcf"

    for _, middle_orb_ent in pairs(self.middle_orbs_ent) do
        local next_orb_ent = self.middle_orbs_ent[self.scheduled_middle_orb_index]
        if middle_orb_ent ~= next_orb_ent then 
            local next_origin = next_orb_ent:GetOrigin()
            local origin = middle_orb_ent:GetOrigin()
            local direction = (next_origin - origin):Normalized()
            local second_arrow_origin = origin + direction * Vector(offset, offset, 0)
        
            self.effect_cast_arrows[middle_orb_ent] = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
            ParticleManager:SetParticleControl( self.effect_cast_arrows[middle_orb_ent], 0, origin )
            ParticleManager:SetParticleControl( self.effect_cast_arrows[middle_orb_ent], 2, second_arrow_origin )
        end
    end
end


function GameMode:GetOppositeAlliance( alliance )
    if alliance.name == "DOTA_ALLIANCE_RADIANT" then
        return self.alliances["DOTA_ALLIANCE_DIRE"]
    else
        return self.alliances["DOTA_ALLIANCE_RADIANT"]
    end
end