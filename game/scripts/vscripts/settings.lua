-- In this file resides all the properties and settings for Dotarite

ALLOW_SAME_HERO_SELECTION = true        -- Should we let people select the same hero as each other

PRE_GAME_TIME = 0.0                     -- How long after people select their heroes should the horn blow and the game start?

CAMERA_DISTANCE_OVERRIDE = 1350           -- How far out should we allow the camera to go?  Use -1 for the default (1134) while still allowing for panorama camera distance changes

USE_CUSTOM_HERO_GOLD_BOUNTY = true			-- Should the gold for hero kills be modified (true) or same as in default Dota (false)?
DISABLE_ALL_GOLD_FROM_HERO_KILLS = true	-- Should we remove gold gain from hero kills? USE_CUSTOM_HERO_GOLD_BOUNTY needs to be true.

if Convars:GetInt('test_mode') == 0 then
    ENABLE_HERO_RESPAWN = false         -- Should the heroes automatically respawn on a timer or stay dead until manually respawned
end

GOLD_PER_TICK = 0                       -- How much gold should players get per tick?
GOLD_TICK_TIME = 0                      -- How long should we wait in seconds between gold ticks?

BUYBACK_ENABLED = false                 -- Should we allow people to buyback when they die?

STARTING_GOLD = 0                       -- How much starting gold should we give to each player?
AUTO_LAUNCH_DELAY = 10                  -- How long should the default team selection launch timer be?  The default for custom games is 30.  Setting to 0 will skip team selection.

DISABLE_DAY_NIGHT_CYCLE = true         -- Should we disable the day night cycle from naturally occurring? (Manual adjustment still possible)
