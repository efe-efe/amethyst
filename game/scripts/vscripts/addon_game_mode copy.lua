require('util/util')
require('util/modifiers')
require('util/health')
require('util/abilities')
require('util/npc')

require('clases/pickup')
require('clases/amethyst')
require('clases/round')

_G.nMAX_COUNTDOWNTIMER = 60
_G.nCOUNTDOWNTIMER = nMAX_COUNTDOWNTIMER

if GameMode == nil then
    print( '[AMETHYST] creating Dotarite game mode' )
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
	GameRules.GameMode:InitGameMode()
end

require('libraries/timers') -- This library allow for easily delayed/timed actions
require('libraries/projectiles') -- This library allow for easily delayed/timed actions
require('libraries/animations') -- This library allows starting customized animations on units from lua

require('events') -- events.lua is where you can specify the actions to be taken when any event occurs.
require('filters') -- events.lua is where you can specify the actions to be taken when any event occurs.
require('wrappers/abilities')
require('wrappers/modifiers')
require('alliances')

function GameMode:InitGameMode()
    if GameMode._reentrantCheck then
        return
    end
    self:SetupRules()
    self:SetupEventHooks()
    self:SetupFilters()
    self:SetupAlliances()
    self:LinkModifiers()
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
    ListenToGameEvent( "dota_item_picked_up", Dynamic_Wrap(GameMode, "OnItemPickUp"), GameMode )
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnHeroInGame'), GameMode)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), GameMode)
    ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), GameMode)
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), GameMode)
    ListenToGameEvent('entity_hurt', Dynamic_Wrap(GameMode, 'OnEntityHurt'), GameMode)
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
    LinkLuaModifier("modifier_generic_magic_immune", "abilities/generic/modifier_generic_magic_immune", LUA_MODIFIER_MOTION_NONE )
    
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
    
    LinkLuaModifier( "modifier_mount", "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE )

    print('[AMETHYST] Useful modifiers linked')
end

function GameMode:SetupAlliances()
    Alliances:Initialize()
end

--============================================================================================
-- FIRST PLAYER CONNECT SETUP
--============================================================================================
mode = nil
function GameMode:CaptureGameMode()
    if mode == nil then
        mode = GameRules:GetGameModeEntity()

        -------------------------------
        -- Core Variables
        -------------------------------
        self.countdownEnabled = false
        self.lock_round = false
        self.iMaxTreshold = 30
        self.mouse_positions = {}

        -------------------------------
        -- Core Constants
        -------------------------------
        self.FIRST_AMETHYST_SPAWN_TIME = 10.0
        self.PICKUPS_SPAWN_TIME = 20.0

        if GetMapName() == "mad_moon_map" or GetMapName() == "forest_map" then
            self.AMETHYST_SPAWN_TIME = 20.0
            self.WIN_CONDITION = {
                type = "ROUNDS",
                number = 5,
                difference = 3,
            }
            mode:SetFixedRespawnTime( -1 ) 
        elseif GetMapName() == "free_for_all" then
            self.AMETHYST_SPAWN_TIME = 15.0
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
            mode:SetFixedRespawnTime( self.BASE_RESPAWN_TIME ) 
        end

        -------------------------------
        -- Set GameMode parameters
        -------------------------------
        mode:SetBuybackEnabled( false )
        mode:SetDaynightCycleDisabled( true )
        mode:SetCameraDistanceOverride( 1350 )

        -------------------------------
        -- Link Client/Server Events
        -------------------------------
        
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
end

function GameMode:UpdateMousePosition(pos, playerID)
    self.mouse_positions[playerID] = pos
end

function GameMode:OnThink()
	if GameRules:IsGamePaused() == true then
        return 1
    end
    
    if self.countdownEnabled == true then
        CountdownTimer()
        if nCOUNTDOWNTIMER <= 0 then
            self.countdownEnabled = false
            --self:CreateDeathZone()
        end
    end

    local now = Time()
    if GameRules:State_Get() >= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        for _, thinker in ipairs(self.Thinkers) do
            if now >= thinker.next then
                thinker.next = math.max(thinker.next + thinker.period, now)
                thinker.callback()
            end
        end
    end

	return 1
end

function GameMode:RegisterThinker(period, callback)
    local timer = {}
    timer.period = period
    timer.callback = callback
    timer.next = Time() + period

    self.Thinkers = self.Thinkers or {}

    table.insert(self.Thinkers, timer)
end