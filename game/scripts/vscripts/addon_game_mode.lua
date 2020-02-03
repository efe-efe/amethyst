require('util/util')
require('util/modifiers')
require('util/health')
require('util/abilities')
require('util/npc')

require('clases/pickup')
require('clases/amethyst')
require('clases/round')
require('clases/alliance')
require('clases/player')

THINK_PERIOD = 0.01
_G.STATE_NONE = 0
_G.STATE_ROUND_IN_PROGRESS = 1 

if _G.GameMode == nil then
    _G.GameMode = class({})
end

function Precache( context )
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", context )
	PrecacheResource("particle", "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf", context )
	PrecacheResource("particle", "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf", context )
    
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context )
	PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", context )

    local heroes = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
    local mounts = LoadKeyValues("scripts/npc/mounts.txt")

    for _, data in pairs(heroes) do
        PrecacheUnitByNameSync(data.override_hero, context)
    end

    for _, data in pairs(mounts) do
        PrecacheResource("model", data.model, context)
    end
end

function Activate()
	GameRules.GameMode = GameMode()
    GameRules.GameMode:SetupMode()
end

require('libraries/timers') -- This library allow for easily delayed/timed actions
require('libraries/projectiles') -- This library allow for easily delayed/timed actions
require('libraries/animations') -- This library allows starting customized animations on units from lua

require('events') -- events.lua is where you can specify the actions to be taken when any event occurs.
require('filters') -- events.lua is where you can specify the actions to be taken when any event occurs.
require('wrappers/abilities')
require('wrappers/modifiers')
require('alliances')

function GameMode:OnThink()
	if GameRules:IsGamePaused() == true then
        return THINK_PERIOD
    end
    local now = Time()
    if GameRules:State_Get() >= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        for _, thinker in ipairs(self.thinkers) do
            if now >= thinker.next then
                thinker.next = math.max(thinker.next + thinker.period, now)
                thinker.callback()
            end
        end
    end

	return THINK_PERIOD
end

function GameMode:SetupRules()
    GameRules:SetSameHeroSelectionEnabled( true )
    GameRules:SetPreGameTime( 0.0 )
    GameRules:SetGoldPerTick( 0 )
    GameRules:SetGoldTickTime( 0 )
    GameRules:SetStartingGold( 0 )
    GameRules:SetCustomGameSetupAutoLaunchDelay( 10 )
    GameRules:SetStrategyTime( 0.0 )
    GameRules:SetShowcaseTime( 0.0 )
    GameRules:SetUseBaseGoldBountyOnHeroes(false)

    if GetMapName() == "mad_moon_map" or GetMapName() == "forest_map" then
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 1 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 1 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 1 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_2, 1 )
        GameRules:SetHeroRespawnEnabled( false )
    elseif GetMapName() == "free_for_all" then
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 1 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 1 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_3, 1 )
        GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_5, 1 )
        GameRules:SetHeroRespawnEnabled( true )
    end
    print('[AMETHYST] GameRules set')
end

function GameMode:SetupEventHooks()
    ListenToGameEvent( "dota_item_picked_up", Dynamic_Wrap(self, "OnItemPickUp"), self )
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(self, 'OnHeroInGame'), self)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(self, 'OnEntityKilled'), self)
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(self, 'OnGameRulesStateChange'), self)
    ListenToGameEvent('entity_hurt', Dynamic_Wrap(self, 'OnEntityHurt'), self)
    --ListenToGameEvent('player_connect_full', Dynamic_Wrap(self, 'EventPlayerConnectFull'), self)
    --ListenToGameEvent('player_connect', Dynamic_Wrap(self, 'EventPlayerConnect'), self)
    --ListenToGameEvent('player_team', Dynamic_Wrap(self, 'EventPlayerTeam'), self)

    print('[AMETHYST] Event hooks set')
end

function GameMode:SetupFilters()
    local mode = GameRules:GetGameModeEntity()
    mode:SetModifyGoldFilter(Dynamic_Wrap(GameMode, 'GoldFilter'), GameMode)
    mode:SetHealingFilter(Dynamic_Wrap(GameMode, 'HealingFilter'), GameMode)
    mode:SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), GameMode)
    print('[AMETHYST] Filters set')
end

function GameMode:LinkModifiers()
    LinkLuaModifier("modifier_charges", "modifiers/general/modifier_charges.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_stack", "modifiers/general/modifier_stack.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_set_attack_range", "modifiers/general/modifier_set_attack_range.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_mana_on_attack", "modifiers/general/modifier_mana_on_attack.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_disable_right_click", "modifiers/general/modifier_disable_right_click.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_death_zone", "modifiers/general/modifier_death_zone.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_amethyst_exiled", "abilities/units/amethyst/modifier_amethyst_exiled", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("wall_base", "modifiers/general/wall_base.lua", LUA_MODIFIER_MOTION_NONE )

    LinkLuaModifier("modifier_amethyst_base", "abilities/units/amethyst/modifier_amethyst_base.lua", LUA_MODIFIER_MOTION_NONE )
    
    LinkLuaModifier("modifier_generic_fear", "abilities/generic/modifier_generic_fear", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_silenced", "abilities/generic/modifier_generic_silenced", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_projectile_reflector_lua", "abilities/generic/modifier_generic_projectile_reflector_lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_fading_slow_new", "abilities/generic/modifier_generic_fading_slow_new", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_fading_haste", "abilities/generic/modifier_generic_fading_haste", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_stunned", "abilities/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_provides_vision", "abilities/generic/modifier_generic_provides_vision", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_knockback", "abilities/generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH )
    LinkLuaModifier("modifier_generic_rooted_lua", "abilities/generic/modifier_generic_rooted_lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_invencible", "abilities/generic/modifier_generic_invencible", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_displacement", "abilities/generic/modifier_generic_displacement", LUA_MODIFIER_MOTION_BOTH )
    LinkLuaModifier("modifier_generic_confused", "abilities/generic/modifier_generic_confused", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_hypnotize", "abilities/generic/modifier_generic_hypnotize", LUA_MODIFIER_MOTION_NONE )
    
    LinkLuaModifier("modifier_damage_fx", "abilities/base/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_movement", "abilities/base/modifier_generic_movement", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_shield", "abilities/base/modifier_shield", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_channeling", "abilities/base/modifier_channeling", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_treshold", "abilities/base/modifier_treshold", LUA_MODIFIER_MOTION_NONE ) -- Delete after
    LinkLuaModifier("modifier_cast_point", "abilities/base/modifier_cast_point", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_thinker_indicator", "abilities/base/modifier_thinker_indicator", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_counter", "abilities/base/modifier_counter", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_following_aoe_indicator", "abilities/base/modifier_following_aoe_indicator", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_target_indicator", "abilities/base/modifier_target_indicator", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_target_indicator_permanent", "abilities/base/modifier_target_indicator", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar", "abilities/base/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden", "abilities/base/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish", "abilities/base/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    
    LinkLuaModifier( "modifier_mount", "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE )

    print('[AMETHYST] Useful modifiers linked')
end

function GameMode:SetupAlliances()
    Alliances:Initialize()
end

function GameMode:SetupPanoramaEventHooks()
    CustomGameEventManager:RegisterListener('execute_ability', function(eventSourceIndex, args)
        local caster = EntIndexToHScript(args.entityIndex)
        local ability = EntIndexToHScript(args.abilityIndex)

        if caster.bFirstSpawnedPG ~= true then return end

        if  ability:IsCooldownReady() and
            ability:IsActivated() and
            ability:IsOwnersManaEnough() and
            not ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_PASSIVE) and
            not ability:IsInAbilityPhase() and
            not caster:IsSilenced() and
            not caster:HasFear() and
            not caster:IsCommandRestricted() and
            not caster:IsNightmared() and
            not caster:IsStunned()
        then
            caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
        end
    end)

    CustomGameEventManager:RegisterListener('swap_abilities', function(eventSourceIndex, args)
        local caster = EntIndexToHScript(args.entityIndex)
        local mode = args.mode

        for i = 0, 6 do
            local ability = caster:GetAbilityByIndex(i)
            if ability then
                if ability:GetAbilityType() ~= 2 then -- ignore talents
                    local ex_name =  ability:GetAlternateName()
                    local alternate_version = caster:FindAbilityByName(ex_name)

                    if alternate_version ~= nil then
                        local swapeable_ability = alternate_version

                        if swapeable_ability:GetAbilityIndex() ~= swapeable_ability:GetAbilityOriginalIndex() then
                            if swapeable_ability:GetAbilityIndex() ~= ability:GetAbilityOriginalIndex() then
                                swapeable_ability = swapeable_ability:GetRelatedAbility()
                            end
                        end

                        if swapeable_ability == nil then
                            print("[SWAP] ERROR: ability " .. ability:GetAbilityName() .. " related bug!")
                            print("[SWAP] Possible reasons: The abilities are in the wrong order on the hero layout")
                            return
                        end

                        if mode == "press" then
                            caster:SwapAbilities( 
                                ability:GetAbilityName(),
                                swapeable_ability:GetAbilityName(),
                                false,
                                true
                            )
                        elseif mode == "release" then
                            if not swapeable_ability:IsEx() then
                                caster:SwapAbilities( 
                                    swapeable_ability:GetAbilityName(),
                                    ability:GetAbilityName(),
                                    true,
                                    false
                                )
                            end
                        end
                    end
                end
            end
        end
    end)

    CustomGameEventManager:RegisterListener('updateMousePosition', function(eventSourceIndex, args)
        local mouse_position = Vector(args.x, args.y, args.z)
        self:UpdateMousePosition(mouse_position, args.playerID)
    end)
        
    CustomGameEventManager:RegisterListener('key_released', function(eventSourceIndex, args)
        local unit = EntIndexToHScript(args.entityIndex)
        local modifier = unit:FindModifierByName("modifier_cast_point")

        if modifier ~= nil then
            if not modifier:IsNull() then
                modifier:OnKeyReleased( args.key )
            end
        end
    end)

    CustomGameEventManager:RegisterListener('moveUnit', function(eventSourceIndex, args)
        local direction = args.direction
        local unit = EntIndexToHScript(args.entityIndex)

        --Not initialized yet
        if unit == nil then return end
        if unit.direction == nil then return end

        if args.direction == "right" then 
            if unit.first_right == false then unit.first_right = true end
            unit.direction.x = unit.direction.x + 1 
        end

        if args.direction == "left" then 
            if unit.first_left == false then unit.first_left = true end
            unit.direction.x = unit.direction.x - 1 
        end
        if args.direction == "up" then 
            if unit.first_up == false then unit.first_up = true end
            unit.direction.y = unit.direction.y + 1 
        end
        if args.direction == "down" then 
            if unit.first_down == false then unit.first_down = true end
            unit.direction.y = unit.direction.y - 1 
        end
    end)

    CustomGameEventManager:RegisterListener('stopUnit', function(eventSourceIndex, args)
        local direction = args.direction
        local unit = EntIndexToHScript(args.entityIndex)
        
        --Not initialized yet
        if unit == nil then return end
        if unit.direction == nil then return end

        if args.direction == "right" then 
            if unit.first_right == false then return end
            unit.direction.x = unit.direction.x - 1
        end
        if args.direction == "left" then 
            if unit.first_left == false then return end
            unit.direction.x = unit.direction.x + 1 
        end
        if args.direction == "up" then 
            if unit.first_up == false then return end
            unit.direction.y = unit.direction.y - 1 
        end
        if args.direction == "down" then 
            if unit.first_down == false then return end
            unit.direction.y = unit.direction.y + 1 
        end
    end)
end

function GameMode:SetupMode()
    GameRules:GetGameModeEntity():SetThink("OnThink", self, THINK_PERIOD)

    self:SetupRules()
    self:SetupEventHooks()
    self:SetupPanoramaEventHooks()
    self:SetupFilters()
    self:LinkModifiers()

    local mode = GameRules:GetGameModeEntity()
    mode:SetBuybackEnabled( false )
    mode:SetDaynightCycleDisabled( true )
    mode:SetCameraDistanceOverride( 1350 )
end

function GameMode:Start()
    self.players = {}
    self.alliances = {}
    self.mouse_positions = {}

    self.state = STATE_NONE
    self.iMaxTreshold = 30

    self.alliances[DOTA_ALLIANCE_RADIANT] = Alliance(DOTA_ALLIANCE_RADIANT, { DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS })
    self.alliances[DOTA_ALLIANCE_DIRE] = Alliance(DOTA_ALLIANCE_DIRE, { DOTA_TEAM_CUSTOM_1, DOTA_TEAM_CUSTOM_2 })
    self.alliances[DOTA_ALLIANCE_LEGION] = Alliance(DOTA_ALLIANCE_LEGION, { DOTA_TEAM_CUSTOM_3, DOTA_TEAM_CUSTOM_4 })
    self.alliances[DOTA_ALLIANCE_VOID] = Alliance(DOTA_ALLIANCE_VOID, { DOTA_TEAM_CUSTOM_5, DOTA_TEAM_CUSTOM_6 })

    self:SetState(STATE_ROUND_IN_PROGRESS)

    self.round = Round(
        self.players,
        function(context) 
            self:OnRoundEnd(context)
        end
    )

    self:RegisterThinker(1.0, function()
        self.round:Update()
    end)

    self.walls_ents = Entities:FindAllByName("wall_spawn")
    self.walls = {} -- Created walls on the map

    self:CreateWalls()

    if GetMapName() == "mad_moon_map" or GetMapName() == "forest_map" then
        self.WIN_CONDITION = {
            type = "ROUNDS",
            number = 5,
            difference = 3,
        }
        GameRules:GetGameModeEntity():SetFixedRespawnTime( -1 ) 
    elseif GetMapName() == "free_for_all" then
        nCOUNTDOWNTIMER = 99999
        self.WIN_CONDITION = {
            type = "AMETHYSTS",
            number = 5,
            difference = 3,
        }

        self.MAX_RESPAWN_TIME = 15.0 
        self.RESPAWN_TIME_PER_DEATH = 3.0
        self.BASE_RESPAWN_TIME = 9.0
        self.MAX_LIFES = 3

        GameRules:GetGameModeEntity():SetFixedRespawnTime( self.BASE_RESPAWN_TIME ) 
    end

    CustomNetTables:SetTableValue( "game_state", "victory_condition", { rounds_to_win = self.WIN_CONDITION.number } );
end

function GameMode:OnRoundEnd(context)
    local round = context

    for _,player in pairs(self.players) do
        player.hero:Kill(nil, player.hero)	
        player.hero:RespawnHero(false, false)
    end

    if round.winner then
        self.alliances[round.winner.number].wins = self.alliances[round.winner.number].wins + 1

        local score = { 
            good_guys = self.alliances[DOTA_ALLIANCE_RADIANT].wins,
            bad_guys = self.alliances[DOTA_ALLIANCE_DIRE].wins,
        }
    
        CustomGameEventManager:Send_ServerToAllClients( "update_score", score )
    else
        print("DRAW!!!!")
    end

    self.round = nil
    self.round = Round(
        self.players,
        function(context) 
            self:OnRoundEnd(context)
        end
    )
end

function GameMode:UpdateMousePosition(pos, playerID)
    self.mouse_positions[playerID] = pos
end

function GameMode:RegisterThinker(period, callback)
    local timer = {}
    timer.period = period
    timer.callback = callback
    timer.next = Time() + period

    self.thinkers = self.thinkers or {}

    table.insert(self.thinkers, timer)
end

function GameMode:FindAllianceByTeam(team)
    for _,alliance in pairs(self.alliances) do
        for _,m_team in pairs(alliance.teams) do
            if m_team == team then
                return alliance
            end
        end
    end
end

function GameMode:RegisterPlayer(hero)
    local team = hero:GetTeamNumber()
    local playerID = hero:GetPlayerOwnerID()
    local userID = playerID + 1

    if playerID == -1 then
        hero:Destroy()
        print("ERROR: TRYING TO CREATE AN UNIT ON AN INVALID PLAYER")
        return false
    else
        if not self.players[playerID] then
            local player = Player(playerID, userID)
            self.players[playerID] = player

            local alliance = self:FindAllianceByTeam(team)

            if alliance == nil then 
                print("ERROR: THE PLAYER TEAM IS NOT PART OF ANY ALLIANCE!")
                return
            end

            player:SetTeam(team)
            player:SetAlliance(alliance)
            player:SetHero(hero)

            alliance:AddPlayer(player)
        end

        return true
    end
end

function GameMode:SetState(state)
    self.state = state
end 

--============================================================================================
-- GAME PHASES
--============================================================================================
function GameMode:OnGameRulesStateChange(keys)
    local state = GameRules:State_Get()

    if state == DOTA_GAMERULES_STATE_HERO_SELECTION then

    end

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:OnGameInProgress()
    end
end

--============================================================================================
-- GAME OFFICIALY BEGINS (00:00)
--============================================================================================
function GameMode:OnGameInProgress()
    self:Start()
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

            if not self:RegisterPlayer(npc) then
                return false
            end
            
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
            --self:OnHeroKilled(killed)
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
        local killer_alliance = killer.alliance

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
    local killed_alliance = killed.alliance

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
