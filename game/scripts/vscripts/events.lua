
require('alliances')

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

    CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.WIN_CONDITION.number } );
    
    self.health_orbs_ent = Entities:FindAllByName("health_orb")
    self.mana_orbs_ent = Entities:FindAllByName("mana_orb")
    self.shield_orbs_ent = Entities:FindAllByName("shield_orb")
    self.amethysts_ent = Entities:FindAllByName("orb_spawn")
    self.walls_ents = Entities:FindAllByName("wall_spawn")
    self.pickups = {} -- Created orbs on the map
    self.amethysts_timers_ent = {}
    self.effect_cast_arrows = {}
    self.walls = {} -- Created walls on the map

    for i = 1, 5 do
        local timer_name = "orb_timer" .. tostring(i)
        self.amethysts_timers_ent[i] = Entities:FindAllByName(timer_name)
    end
    
    self.amethyst_timers = {}
    self:CreateWalls()

    self.round = Round()

    self.scheduled_amethyst_index = self:GetFirstAmethyst()
    self.round:Start()
    
    self:StartRound()
end


function GameMode:StartRound()
    --self.scheduled_amethyst_index = self:GetFirstAmethyst()
    --self:CreatePickups()

    --self.amethyst = Amethyst(self.scheduled_amethyst_index, self.FIRST_AMETHYST_SPAWN_TIME)
    --self:CreateAmethyst( self.scheduled_amethyst_index, self.FIRST_AMETHYST_SPAWN_TIME)
    --self:PlayEffectsArrow()
    self:CalculateNextSpawn()
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
    
    -- Recreate orb
    if killed:IsAmethyst() then     
        local killer = EntIndexToHScript( keys.entindex_attacker )
        self:OnAmethystDestroy(killer)
    end

    if killed:IsRealHero() then
        self:OnHeroKilled(killed)
    end
end

--------------------------------------------------------------------------------
-- Event: OnItemPickUp
--------------------------------------------------------------------------------
function GameMode:OnItemPickUp( event )
	local item = EntIndexToHScript( event.ItemEntityIndex ):GetParentEntity()
    item:OnPickedUp()
end

function GameMode:OnAmethystDestroy(killer)
    self:DestroyAllTimers()

    --self.amethyst = Amethyst(self.next_amethyst_index, self.AMETHYST_SPAWN_TIME)
    self.scheduled_amethyst_index = self.next_amethyst_index

    self:StopEffectsArrow()
    self:PlayEffectsArrow()

    if not self:IsDeathZoneCreated() then
        self:CalculateNextSpawn()
    end

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

function GameMode:GetFirstAmethyst()
    if GetMapName() == "forest_map" or GetMapName() == "free_for_all" then
        return 1 
    else
        return RandomInt(1, 3)
    end
end

--------------------------------------------------------------------------------
-- Restart Round
--------------------------------------------------------------------------------
function GameMode:EndRound( delay )
    Timers:CreateTimer(delay, function()
        self:DestroyMiddleOrb()
        self:DestroyDeathZone()
        self:DestroyAllPickups()
        --self:DestroyAllWalls()
        self.amethyst:Remove()

        self.scheduled_amethyst_index = self:GetFirstAmethyst()
        self.amethyst = Amethyst(self.scheduled_amethyst_index, self.FIRST_AMETHYST_SPAWN_TIME)
        self:PlayEffectsArrow()
        self.next_amethyst_index = RandomInt(1, #self.amethysts_ent)
        
        self:CreatePickups()
        --self:CreateWalls()

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
        self.countdownEnabled = true
        self.lock_round = false
        
        local score = { 
            good_guys = Alliances.alliances["DOTA_ALLIANCE_RADIANT"].wins,
            bad_guys = Alliances.alliances["DOTA_ALLIANCE_DIRE"].wins,
        }

        --Update score
        CustomGameEventManager:Send_ServerToAllClients( "update_score", score )


        
        nCOUNTDOWNTIMER = nMAX_COUNTDOWNTIMER
    end)
end

--------------------------------------------------------------------------------
-- Death zone spawner
--------------------------------------------------------------------------------
function GameMode:CreateDeathZone()
    print("[AMETHYST] Creating Death Zone")

    local index = self:IsAmethystCreated() and self.scheduled_amethyst_index or self.next_amethyst_index
    self.next_amethyst_index = self.scheduled_amethyst_index
    
    local origin = self.amethysts_ent[index]:GetOrigin()

    CustomGameEventManager:Send_ServerToAllClients( "death_zone_initiated", {} )

    self.modifier_death_zone = CreateModifierThinker(
        nil, --hCaster
        nil, --hAbility
        "modifier_death_zone", --modifierName
        {}, --paramTable
        origin, --vOrigin
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

function GameMode:IsAmethystCreated()
    if self.amethyst_orb_instance ~= nil then
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
    self.walls[ent]:Attribute_SetIntValue("barrel", 1)
    self.walls[ent]:SetHullRadius(65)
    self.walls[ent]:AddNewModifier(self.walls[ent], nil, "wall_base", { fow_blocker = fow_blocker:GetEntityIndex() })
end

--------------------------------------------------------------------------------
-- Middle Orb spawner
--------------------------------------------------------------------------------
function GameMode:CreateAmethyst( index, delay )
    print("[AMETHYST] Creating Middle Orb")
    
    local origin = self.amethysts_ent[index]:GetOrigin()

    self.amethyst_orb_instance = CreateUnitByName(
        "npc_dota_creature_amethyst", --szUnitName
        origin, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    if  self.WIN_CONDITION.type == "AMETHYSTS" then
        self.amethyst_orb_instance:CreatureLevelUp(1)	
        self.amethyst_orb_instance:AddNewModifier(
            self.amethyst_orb_instance,
            nil,
            "modifier_amethyst_base",
            {}
        )
    else
        self.amethyst_orb_instance:AddNewModifier(
            self.amethyst_orb_instance,
            nil,
            "modifier_amethyst_base",
            {
                mana = 40,
                heal = 20,
            }
        )
    end

    self.amethyst_orb_instance:Attribute_SetIntValue("middle_orb", 1)
    self.amethyst_orb_instance:AddNewModifier(
        self.amethyst_orb_instance,
        nil,
        "modifier_amethyst_exiled",
        {}
    )
    self.amethyst_orb_instance:SetHullRadius(10)
    
    local counter = 0.0
    local counter_sum = delay / 5
    
    for _,orb_timer_ent in pairs(self.amethysts_timers_ent) do
        counter = counter + counter_sum

        local timer_origin = orb_timer_ent[index]:GetOrigin()
        local name = "SpawnTimer_" .. orb_timer_ent[index]:GetEntityIndex() 

        self.amethyst_orb_instance:SetContextThink( name , function()
            self.amethyst_timers[_] = CreateUnitByName(
                "npc_dota_creature_amethyst_timer", --szUnitName
                timer_origin, --vLocation
                true, --bFindClearSpace
                nil, --hNPCOwner
                nil, --hUnitOwner
                DOTA_TEAM_NOTEAM
            )
            
            local particle_cast = "particles/mod_units/units/middle_orb/rune_arcane.vpcf"
            ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.amethyst_timers[_] )
        end, counter)
    end

    GameRules:SendCustomMessage("The <b><font color='purple'>Amethyst</font></b> will spawn in <b>" .. delay .. "</b> seconds", 0, 0)
    self.amethyst_orb_instance:SetContextThink("SpawnMiddleOrb", function()
        GameRules:SendCustomMessage("The <b><font color='purple'>Amethyst</font></b> has spawned", 0, 0)
        SafeDestroyModifier("modifier_amethyst_exiled", self.amethyst_orb_instance, self.amethyst_orb_instance)
        
        EmitSoundOn( "Hero_Oracle.FortunesEnd.Target", self.amethyst_orb_instance )

        -- Orb Spawn Effects
        local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
        local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
        local particle_cast_c = "particles/generic_gameplay/rune_arcane.vpcf"

        local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self.amethyst_orb_instance )
        local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self.amethyst_orb_instance )
        ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self.amethyst_orb_instance )

        ParticleManager:ReleaseParticleIndex( effect_cast_a )
        ParticleManager:ReleaseParticleIndex( effect_cast_b )

        local data = {
            unitIndex = self.amethyst_orb_instance:GetEntityIndex(),
        }
        CustomGameEventManager:Send_ServerToAllClients( "add_unit", data )    
    end, delay)
end

--------------------------------------------------------------------------------
-- Middle Orb Destroyer
--------------------------------------------------------------------------------
function GameMode:DestroyMiddleOrb()
    if self.amethyst_orb_instance ~= nil then
        UTIL_Remove(self.amethyst_orb_instance)
        self:DestroyAllTimers()
        self:StopEffectsArrow()
    end
end

--------------------------------------------------------------------------------
--Health and mana orbs spawner
--------------------------------------------------------------------------------
function GameMode:CreatePickups()
    for _,health_orb_ent in pairs(self.health_orbs_ent) do
        self:CreatePickup(health_orb_ent:GetOrigin(), "health", self.PICKUPS_SPAWN_TIME)
    end

    for _,mana_orb_ent in pairs(self.mana_orbs_ent) do
        self:CreatePickup(mana_orb_ent:GetOrigin(), "mana", self.PICKUPS_SPAWN_TIME)
    end

    for _,shield_orb_ent in pairs(self.shield_orbs_ent) do
        self:CreatePickup(shield_orb_ent:GetOrigin(), "shield", self.PICKUPS_SPAWN_TIME)
    end
end

--------------------------------------------------------------------------------
--Health and mana orbs destroyer
--------------------------------------------------------------------------------
function GameMode:DestroyAllPickups()
    for _,orb in pairs(self.pickups) do
        UTIL_Remove( orb.item ) -- otherwise it pollutes the player inventory
        if orb.drop ~= nil and not orb.drop:IsNull() then
            UTIL_Remove( orb.drop )
        end
    end
end

function GameMode:DestroyAllWalls()
    for _,wall in pairs(self.walls) do
        if wall:IsAlive() then
            wall:Kill(nil, wall)
        end
    end
end

function GameMode:DestroyAllTimers()
    for _,timer in pairs(self.amethyst_timers) do
        UTIL_Remove( timer )
    end
end

function GameMode:CreateDeathOrb( hero )
    -- CREATE DEATH ORB
    local current_mana = hero:GetMana()
    local mana_given = NearestValue({ 25, 50, 75, 100 }, current_mana)
    local death_orb_ent = self:CreatePickup(hero:GetOrigin(), "death", 0.0, (mana_given/100) + 0.25 )

    self.pickups[death_orb_ent].item:SetCurrentCharges(mana_given)
    self.pickups[death_orb_ent].item:SetPurchaser(hero)
end

--------------------------------------------------------------------------------
-- Middle Orb spawner
--------------------------------------------------------------------------------
function GameMode:CreatePickup( pos, type, delay, scale )
    local name = "item_" .. type .. "_orb"

    local particle_cast = ""
    if type == "health" then
        particle_cast = "particles/generic_gameplay/rune_regeneration.vpcf"
    elseif type == "mana" then
        particle_cast = "particles/generic_gameplay/rune_doubledamage.vpcf"
    elseif type == "shield" then
        particle_cast = "particles/generic_gameplay/rune_bounty.vpcf"
    elseif type == "death" then
        particle_cast = "particles/generic_gameplay/rune_haste.vpcf"
    end

    local item = CreateItem( name, nil, nil )
    item:LaunchLootInitialHeight( false, 0, 50, 0.5, pos )
    
    local item_index = item:GetEntityIndex()

    self.pickups[item_index] = {}
    self.pickups[item_index].item = item
    self.pickups[item_index].drop = nil
    self.pickups[item_index].pos = pos

    item:SetContextThink("SpawnItem", function() 
        local drop = CreateItemOnPositionForLaunch( pos, item )
        ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, drop )
        
        if scale ~= nil then
            drop:SetModelScale( scale )	
        end

        self.pickups[item_index].drop = drop
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

    for _, middle_orb_ent in pairs(self.amethysts_ent) do
        local next_orb_ent = self.amethysts_ent[self.scheduled_amethyst_index]
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
        return Alliances.alliances["DOTA_ALLIANCE_DIRE"]
    else
        return Alliances.alliances["DOTA_ALLIANCE_RADIANT"]
    end
end

function GameMode:CalculateNextSpawn()
    self.next_amethyst_index = RandomInt(1, #self.amethysts_ent)

    --If spawn is the same than the actual one, pick the next spawn
    if self.next_amethyst_index == self.scheduled_amethyst_index then

        self.next_amethyst_index = self.next_amethyst_index + 1

        -- If the spawn is higher than the possible ones, use the first one
        if self.next_amethyst_index > #self.amethysts_ent then
            self.next_amethyst_index = 1
        end
    end
end