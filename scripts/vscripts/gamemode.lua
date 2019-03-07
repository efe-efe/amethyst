-- Primary Dotarite script
RITE_VERSION = "1.00"
RITE_DEBUG_SPEW = true -- Complete Debug?

--============================================================================================
-- INSTANTIATE GAME MODE
--============================================================================================
if GameMode == nil then
    DebugPrint( '[RITE] creating Dotarite game mode' )
    _G.GameMode = class({})
end

--============================================================================================
-- LOAD LIBRARIES
--============================================================================================
require('libraries/timers') -- This library allow for easily delayed/timed actions
require('libraries/projectiles') -- This library allow for easily delayed/timed actions
require('events') -- events.lua is where you can specify the actions to be taken when any event occurs.
require('settings') -- settings.lua is where resides many different properties for Dotarite.
require('modules/middle_orb_module')

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
    DebugPrint('[RITE] GameRules set')

    -------------------------------
    -- Setup Event Hooks
    -------------------------------
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnHeroInGame'), GameMode)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), GameMode)
    ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), GameMode)
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), GameMode)
    ListenToGameEvent('entity_hurt', Dynamic_Wrap(GameMode, 'OnEntityHurt'), GameMode)

    -------------------------------
    -- Link Useful Lua Modifiers
    -------------------------------
    LinkLuaModifier( "modifier_charges", "modifiers/general/modifier_charges.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_stack", "modifiers/general/modifier_stack.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_set_attack_range", "modifiers/general/modifier_set_attack_range.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_mana_on_attack", "modifiers/general/modifier_mana_on_attack.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier( "modifier_disable_right_click", "modifiers/general/modifier_disable_right_click.lua", LUA_MODIFIER_MOTION_NONE )
end

--============================================================================================
-- FIRST PLAYER CONNECT SETUP
--============================================================================================
mode = nil
function GameMode:CaptureGameMode()
    if mode == nil then
        -------------------------------
        -- Set GameMode parameters
        -------------------------------
        mode = GameRules:GetGameModeEntity()
        mode:SetBuybackEnabled( BUYBACK_ENABLED )
        mode:SetFixedRespawnTime( FIXED_RESPAWN_TIME ) 

        mode:SetDaynightCycleDisabled( DISABLE_DAY_NIGHT_CYCLE )
        self:OnFirstPlayerLoaded()
    end 
end