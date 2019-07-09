-- Primary Dotarite script
RITE_VERSION = "1.00"
RITE_DEBUG_SPEW = true -- Complete Debug?
Convars:RegisterConvar('test_mode', '0', 'Set to 1 to start test mode.  Set to 0 to disable.', 0)

_G.nCOUNTDOWNTIMER = 120

--============================================================================================
-- INSTANTIATE GAME MODE
--============================================================================================
if GameMode == nil then
    DebugPrint( '[RITE] creating Dotarite game mode' )
    _G.GameMode = class({})
end

--============================================================================================
-- LOAD RESOURCES
--============================================================================================
require('libraries/timers') -- This library allow for easily delayed/timed actions
require('libraries/projectiles') -- This library allow for easily delayed/timed actions
require('libraries/animations') -- This library allows starting customized animations on units from lua
require('settings') -- settings.lua is where resides many different properties for Dotarite.
require('events') -- events.lua is where you can specify the actions to be taken when any event occurs.
require('filters') -- events.lua is where you can specify the actions to be taken when any event occurs.

--============================================================================================
-- INITIAL GAME SETUP
--============================================================================================
function GameMode:InitGameMode()
    if GameMode._reentrantCheck then
        return
    end
      
    -------------------------------
    -- Setup Rules
    -------------------------------
    GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
    GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
    GameRules:SetPreGameTime( PRE_GAME_TIME)
    GameRules:SetGoldPerTick( GOLD_PER_TICK )
    GameRules:SetGoldTickTime( GOLD_TICK_TIME )
    GameRules:SetStartingGold( STARTING_GOLD )
    GameRules:SetCustomGameSetupAutoLaunchDelay( AUTO_LAUNCH_DELAY )
	GameRules:SetStrategyTime( 0.0 )
    GameRules:SetShowcaseTime( 0.0 )
    if USE_CUSTOM_HERO_GOLD_BOUNTY then
		GameRules:SetUseBaseGoldBountyOnHeroes(false)
	end
    DebugPrint('[RITE] GameRules set')
    

    -------------------------------
    -- Setup Event Hooks
    -------------------------------
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnHeroInGame'), GameMode)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), GameMode)
    ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), GameMode)
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), GameMode)
    ListenToGameEvent('entity_hurt', Dynamic_Wrap(GameMode, 'OnEntityHurt'), GameMode)
    DebugPrint('[RITE] Event hooks set')

    -------------------------------
    -- Setup Filters
    -------------------------------
    local mode = GameRules:GetGameModeEntity()
	mode:SetModifyGoldFilter(Dynamic_Wrap(GameMode, 'GoldFilter'), GameMode)
    mode:SetHealingFilter(Dynamic_Wrap(GameMode, 'HealingFilter'), GameMode)
	mode:SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), GameMode)

    -------------------------------
    -- Link Useful Lua Modifiers
    -------------------------------
    LinkLuaModifier( "modifier_charges", "modifiers/general/modifier_charges.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_stack", "modifiers/general/modifier_stack.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_set_attack_range", "modifiers/general/modifier_set_attack_range.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_mana_on_attack", "modifiers/general/modifier_mana_on_attack.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_disable_right_click", "modifiers/general/modifier_disable_right_click.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_death_zone", "modifiers/general/modifier_death_zone.lua", LUA_MODIFIER_MOTION_NONE )
    
    DebugPrint('[RITE] Useful modifiers linked')
end

--============================================================================================
-- FIRST PLAYER CONNECT SETUP
--============================================================================================
mode = nil
function GameMode:CaptureGameMode()
    if mode == nil then
        -------------------------------
        -- Core Variables
        -------------------------------
        self.countdownEnabled = false
        self.lock_round = false
        self.teams = {}
        self.teams[DOTA_TEAM_GOODGUYS] = {
            alive_heroes = 0,
            wins = 0,
            looser = false,
            players = {}
        }
        self.teams[DOTA_TEAM_BADGUYS] = {
            alive_heroes = 0,
            wins = 0,
            looser = false,
            players = {}
        }
        self.ROUNDS_TO_WIN = 3
        self.iMaxTreshold = 40

        -------------------------------
        -- Set GameMode parameters
        -------------------------------
        mode = GameRules:GetGameModeEntity()
        mode:SetBuybackEnabled( BUYBACK_ENABLED )
        mode:SetFixedRespawnTime( FIXED_RESPAWN_TIME ) 
        mode:SetDaynightCycleDisabled( DISABLE_DAY_NIGHT_CYCLE )

    end 
end

---------------------------------------------------------------------------
-- Update player labels and the scoreboard
---------------------------------------------------------------------------
function GameMode:OnThink()
	if GameRules:IsGamePaused() == true then
        return 1
    end
    
	if self.countdownEnabled == true then
        CountdownTimer()
        if nCOUNTDOWNTIMER <= 0 then
            self.countdownEnabled = false
            self:CreateDeathZone()
        end
    end
	return 1
end