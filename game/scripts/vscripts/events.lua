
require('alliances')

--============================================================================================
-- GAME PHASES
--============================================================================================
function GameMode:OnGameRulesStateChange(keys)
    local state = GameRules:State_Get()

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:OnGameInProgress()
    end
end

--============================================================================================
-- GAME OFFICIALY BEGINS (00:00)
--============================================================================================
function GameMode:OnGameInProgress()
    self:Start()

    CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.WIN_CONDITION.number } );
    
    self.walls_ents = Entities:FindAllByName("wall_spawn")
    self.walls = {} -- Created walls on the map

    self:CreateWalls()
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
            
            npc:Initialize({ max_lifes = self.MAX_LIFES })
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

            Alliances:Update(npc)

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
        
        if npc:FindAbilityByName("mount") then
            npc:AddNewModifier(npc, npc:FindAbilityByName("mount"), "modifier_mount", {})
        else
            print("ERROR: UNIT DOESN'T HAS 'MOUNT' SPELL")
        end
        npc:SetHealth(npc:GetMaxHealth())
        npc.iTreshold = self.iMaxTreshold
        self:UpdateHeroHealthBar( npc )
        self:UpdateHeroManaBar( npc )
    end)
end

--============================================================================================
-- ENTITY DIED
--============================================================================================
function GameMode:OnEntityKilled( keys )
    local killed = EntIndexToHScript( keys.entindex_killed )

    -- TODO: DELETE THIS WRAP
    if killed.GetParentEntity then
        local entity = killed:GetParentEntity()

        if instanceof(entity, Amethyst) then     
            entity:OnDeath({ killer = EntIndexToHScript( keys.entindex_attacker ) })
        end
    else

        if killed:IsRealHero() then
            self.round.hero_died = true
            self:OnHeroKilled(killed)
        end
    end
end

--------------------------------------------------------------------------------
-- Event: OnItemPickUp
--------------------------------------------------------------------------------
function GameMode:OnItemPickUp( event )
	local entity = EntIndexToHScript( event.ItemEntityIndex ):GetParentEntity()
    entity:OnPickedUp()
end

function GameMode:OnAmethystDestroy(killer)
    if killer ~= nil then
        local killer_alliance = killer:GetAlliance()

        killer_alliance.amethysts = killer_alliance.amethysts + 1
        
        local data = {
            alliance = killer_alliance.name,
            amethysts = killer_alliance.amethysts
        }
        CustomGameEventManager:Send_ServerToAllClients( "update_amethysts", data )

        if self.WIN_CONDITION.type == "AMETHYSTS" then
            CustomGameEventManager:Send_ServerToAllClients( "update_score", data )
            if killer_alliance.amethysts >= self.WIN_CONDITION.number then
                self:EndGame(killer_alliance.teams[1]) 
            end
        end
    end
end

function GameMode:OnHeroKilled(killed)
    local killed_alliance = killed:GetAlliance()

    if self.WIN_CONDITION.type == "ROUNDS" then
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
        self:UpdateCameras()
    elseif self.WIN_CONDITION.type == "AMETHYSTS" then
        killed.lifes = killed.lifes - 1 

        local new_respawn_time = nil

        if killed.lifes <= 0 then
            new_respawn_time = 999
        else
            new_respawn_time = self.BASE_RESPAWN_TIME + self.RESPAWN_TIME_PER_DEATH * (PlayerResource:GetDeaths(killed:GetPlayerID()) - 1)
            if new_respawn_time > self.MAX_RESPAWN_TIME then 
                new_respawn_time = self.MAX_RESPAWN_TIME 
            end
        end

        killed:SetTimeUntilRespawn(new_respawn_time)
    end
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
    end
end
	
--============================================================================================
-- HELPERS
--============================================================================================
function GameMode:FindWinner()
    local alliances_with_alive_players = 0
    local winner = nil

    for _,alliance in pairs(Alliances.alliances) do
        if alliance.initialized and not alliance.looser then 
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
    for _,alliance in pairs(Alliances.alliances) do
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
    for _,alliance in pairs(Alliances.alliances) do
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
        for _,alliance in pairs(Alliances.alliances) do
            if 
                alliance.wins >= self.WIN_CONDITION.number or 
                ( alliance.wins - self:GetOppositeAlliance(alliance).wins ) >= self.WIN_CONDITION.difference
            then
                self:EndGame(alliance.teams[1]) 
                break
            end

            for _,hero in pairs(alliance.heroes) do
                hero:Kill(nil, hero)	
            end
            
            alliance.looser = false
            alliance.amethysts = 0

            local data = {
                alliance = alliance.name,
                amethysts = alliance.amethysts
            }
            CustomGameEventManager:Send_ServerToAllClients( "update_amethysts", data )

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
        self.lock_round = false
        
        local score = { 
            good_guys = Alliances.alliances["DOTA_ALLIANCE_RADIANT"].wins,
            bad_guys = Alliances.alliances["DOTA_ALLIANCE_DIRE"].wins,
        }

        --Update score
        CustomGameEventManager:Send_ServerToAllClients( "update_score", score )
    end)
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
    self.walls[ent]:Attribute_SetIntValue("barrel", 1)
    self.walls[ent]:SetHullRadius(65)
    self.walls[ent]:AddNewModifier(self.walls[ent], nil, "wall_base", { fow_blocker = fow_blocker:GetEntityIndex() })
end

function GameMode:DestroyAllWalls()
    for _,wall in pairs(self.walls) do
        if wall:IsAlive() then
            wall:Kill(nil, wall)
        end
    end
end

function GameMode:CreateDeathOrb( hero )
    local current_mana = hero:GetMana()
    local mana_given = NearestValue({ 25, 50, 75, 100 }, current_mana)
    local entity = Pickup(PickupTypes.DEATH, hero:GetOrigin(), (mana_given/100) + 0.25)

    self.round.pickups[hero:GetEntityIndex()] = {
        origin = hero:GetOrigin(),
        type = PickupTypes.DEATH,
        timer = 0,
        entity = entity
    }

    entity:GetItem():SetCurrentCharges(mana_given)
    entity:GetItem():SetPurchaser(hero)
end

--------------------------------------------------------------------------------
-- End Game
--------------------------------------------------------------------------------
function GameMode:EndGame( victoryTeam )
	GameRules:SetGameWinner( victoryTeam )
end

function GameMode:GetOppositeAlliance( alliance )
    if alliance.name == "DOTA_ALLIANCE_RADIANT" then
        return Alliances.alliances["DOTA_ALLIANCE_DIRE"]
    else
        return Alliances.alliances["DOTA_ALLIANCE_RADIANT"]
    end
end
