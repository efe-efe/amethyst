-- Primary Dotarite script
DOTARITE_VERSION = "1.00"
-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
DOTARITE_DEBUG_SPEW = true 

if GameMode == nil then
    DebugPrint( '[DOTARITE] creating Dotarite game mode' )
    _G.GameMode = class({})
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
    if GameMode._reentrantCheck then
        return
    end
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- events.lua is where you can specify the actions to be taken when any event occurs.
require('events')
-- settings.lua is where resides many different properties for Dotarite.
require('settings')

-- Setup rules
GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
GameRules:SetGoldPerTick( GOLD_PER_TICK )
GameRules:SetGoldTickTime( GOLD_TICK_TIME )

-- Event Hooks
  -- All of these events can potentially be fired by the game, though only the uncommented ones have had
  -- Functions supplied for them.  If you are interested in the other events, you can uncomment the
  -- ListenToGameEvent line and add a function to handle the event
  
ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnHeroInGame'), GameMode)