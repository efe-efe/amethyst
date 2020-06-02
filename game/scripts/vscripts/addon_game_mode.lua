
require('settings')

require('util/util')
require('util/health')
require('util/modifiers')

require('overrides/npc')
require('overrides/abilities')

require('clases/unit_entity')
require('clases/game_state')
require('clases/dummy_target')
require('clases/pickup')
require('clases/amethyst')
require('clases/round')
require('clases/alliance')
require('clases/player')
require('clases/warmup')

require('libraries/timers') 
require('libraries/projectiles') 
require('libraries/animations') 

require('wrappers/abilities')
require('wrappers/modifiers')

require('constructors')

require('filters')
require('targeting_indicator')

THINK_PERIOD = 0.01
ROUNDS_TO_WIN = 5
ROUNDS_DIFFERENCE_TO_WIN = 3

_G.STATE_NONE = 0
_G.STATE_ROUND_IN_PROGRESS = 1 

if GameMode == nil then
    GameMode = class({})
end

function Precache( context )
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context )
    
	PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", context )
	PrecacheResource("particle", "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf", context )
	PrecacheResource("particle", "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf", context )
    
	PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", context )
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", context )

    local heroes = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
    --local mounts = LoadKeyValues("scripts/npc/mounts.txt")

    for _, data in pairs(heroes) do
        PrecacheUnitByNameSync(data.override_hero, context)
    end

    --[[
    for _, data in pairs(mounts) do
        PrecacheResource("model", data.model, context)
    end
    ]]
end

function Activate()
	GameRules.GameMode = GameMode()
    GameRules.GameMode:SetupMode()
end

function GameMode:OnThink()
	if GameRules:IsGamePaused() == true then
        return THINK_PERIOD
    end
    local now = Time()

    if GameRules:State_Get() >= DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
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
    GameRules:SetStartingGold( 4 )
    GameRules:SetCustomGameSetupAutoLaunchDelay( 10 )
    GameRules:SetStrategyTime( 0.0 )
    GameRules:SetShowcaseTime( 0.0 )
    GameRules:SetUseBaseGoldBountyOnHeroes(false)
    GameRules:GetGameModeEntity():SetFixedRespawnTime( -1 ) 
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath( false )

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
    print('[AMETHYST] Event hooks set')
end

function GameMode:SetupFilters()
    Filters:Activate(GameMode, self)

    local mode = GameRules:GetGameModeEntity()
    mode:SetModifyGoldFilter(Dynamic_Wrap(GameMode, 'GoldFilter'), GameMode)
    mode:SetHealingFilter(Dynamic_Wrap(GameMode, 'HealingFilter'), GameMode)
    mode:SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), GameMode)
    mode:SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "ExecuteOrderFilter" ), GameMode)
    print('[AMETHYST] Filters set')
end

function GameMode:LinkModifiers()
    LinkLuaModifier("modifier_death_zone",                      "modifiers/modifier_death_zone.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("wall_base",                                "modifiers/wall_base.lua", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_adrenaline",                      "modifiers/modifier_adrenaline.lua", LUA_MODIFIER_MOTION_NONE )
    
    LinkLuaModifier("modifier_generic_fear",                    "abilities/generic/modifier_generic_fear", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_silence",                 "abilities/generic/modifier_generic_silence", LUA_MODIFIER_MOTION_NONE ) -- Should Delete
    LinkLuaModifier("modifier_generic_projectile_reflector",    "abilities/generic/modifier_generic_projectile_reflector", LUA_MODIFIER_MOTION_NONE ) -- Should Delete
    LinkLuaModifier("modifier_generic_fading_slow",             "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_fading_haste",            "abilities/generic/modifier_generic_fading_haste", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_stunned",                 "abilities/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE ) -- Should Delete
    LinkLuaModifier("modifier_generic_provides_vision",         "abilities/generic/modifier_generic_provides_vision", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_knockback",               "abilities/generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH )
    LinkLuaModifier("modifier_generic_root",                    "abilities/generic/modifier_generic_root", LUA_MODIFIER_MOTION_NONE ) -- Should Delete
    LinkLuaModifier("modifier_generic_invencible",              "abilities/generic/modifier_generic_invencible", LUA_MODIFIER_MOTION_NONE ) -- Should Delete
    LinkLuaModifier("modifier_generic_displacement",            "abilities/generic/modifier_generic_displacement", LUA_MODIFIER_MOTION_BOTH ) -- Should Delete
    LinkLuaModifier("modifier_generic_confuse",                 "abilities/generic/modifier_generic_confuse", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_generic_hypnotize",               "abilities/generic/modifier_generic_hypnotize", LUA_MODIFIER_MOTION_NONE )
    
    LinkLuaModifier("modifier_visible",                         "abilities/base/modifier_visible", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_casting",                         "abilities/base/modifier_casting", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_damage_fx",                       "abilities/base/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_hero_base",                       "abilities/base/modifier_hero_base", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_shield",                          "abilities/base/modifier_shield", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_channeling",                      "abilities/base/modifier_channeling", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_cast_point",                      "abilities/base/modifier_cast_point", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_thinker_indicator",               "abilities/base/modifier_thinker_indicator", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_counter",                         "abilities/base/modifier_counter", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_following_aoe_indicator",         "abilities/base/modifier_following_aoe_indicator", LUA_MODIFIER_MOTION_NONE )
    LinkLuaModifier("modifier_target_indicator",                "abilities/base/modifier_target_indicator", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_target_indicator_permanent",      "abilities/base/modifier_target_indicator", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar",                        "abilities/base/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden",                          "abilities/base/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish",                          "abilities/base/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    
    LinkLuaModifier( "modifier_mount",                          "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE )

    print('[AMETHYST] Useful modifiers linked')
end

function GameMode:SetupPanoramaEventHooks()
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

    CustomGameEventManager:RegisterListener('update_mouse_position', function(eventSourceIndex, args)
        local position = Vector(args.x, args.y, args.z)

        if self.players and self.players[args.playerID] then
            self.players[args.playerID]:UpdateCursorPosition(position)
        end
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

    CustomGameEventManager:RegisterListener('move_unit', function(eventSourceIndex, args)
        local direction = args.direction

        local unit = EntIndexToHScript(args.entityIndex)

        --Not initialized yet
        if unit == nil then return end
        if unit.direction == nil then return end

        local current_direction = unit:GetRawDirection()

        if args.direction == "right" then 
            if unit.first_right == false then unit.first_right = true end
            unit:SetDirection(current_direction.x + 1, nil)
        end

        if args.direction == "left" then 
            if unit.first_left == false then unit.first_left = true end
            unit:SetDirection(current_direction.x - 1, nil)
        end
        if args.direction == "up" then 
            if unit.first_up == false then unit.first_up = true end
            unit:SetDirection(nil, current_direction.y + 1)
        end
        if args.direction == "down" then 
            if unit.first_down == false then unit.first_down = true end
            unit:SetDirection(nil, current_direction.y - 1)
        end
    end)

    CustomGameEventManager:RegisterListener('stop_unit', function(eventSourceIndex, args)
        local direction = args.direction
        local unit = EntIndexToHScript(args.entityIndex)
        
        --Not initialized yet
        if unit == nil then return end
        if unit.direction == nil then return end

        local current_direction = unit:GetRawDirection()

        if args.direction == "right" then 
            if unit.first_right == false then return end
            unit:SetDirection(current_direction.x - 1, nil)
        end
        if args.direction == "left" then 
            if unit.first_left == false then return end
            unit:SetDirection(current_direction.x + 1, nil)
        end
        if args.direction == "up" then 
            if unit.first_up == false then return end
            unit:SetDirection(nil, current_direction.y - 1)
        end
        if args.direction == "down" then 
            if unit.first_down == false then return end
            unit:SetDirection(nil, current_direction.y + 1)
        end
    end)
end

function GameMode:SetupMode()
    self.thinkers = {}
    self.players = {}
    self.units = {}
    self.alliances = {}
    self.round = nil

    GameRules:GetGameModeEntity():SetThink("OnThink", self, THINK_PERIOD)

    self:SetupRules()
    self:SetupEventHooks()
    self:SetupPanoramaEventHooks()
    self:SetupFilters()
    self:SetupProjectiles()
    self:LinkModifiers()


    local mode = GameRules:GetGameModeEntity()
    mode:SetBuybackEnabled( false )
    mode:SetDaynightCycleDisabled( true )
    mode:SetCameraDistanceOverride( 1350 )
    mode:SetRecommendedItemsDisabled(true) -- Doesn't works :'(
    --mode:SetStashPurchasingDisabled(true)	
end

function GameMode:SetupProjectiles()
    Projectiles:Initialize()
end

function GameMode:Start()
    self.mouse_positions = {}

    self.state = STATE_NONE
    self.max_treshold = 30

    self.alliances[DOTA_ALLIANCE_RADIANT] = Alliance(DOTA_ALLIANCE_RADIANT, { DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS })
    self.alliances[DOTA_ALLIANCE_DIRE] = Alliance(DOTA_ALLIANCE_DIRE, { DOTA_TEAM_CUSTOM_1, DOTA_TEAM_CUSTOM_2 })
    self.alliances[DOTA_ALLIANCE_LEGION] = Alliance(DOTA_ALLIANCE_LEGION, { DOTA_TEAM_CUSTOM_3, DOTA_TEAM_CUSTOM_4 })
    self.alliances[DOTA_ALLIANCE_VOID] = Alliance(DOTA_ALLIANCE_VOID, { DOTA_TEAM_CUSTOM_5, DOTA_TEAM_CUSTOM_6 })

    self.barrel_ents = Entities:FindAllByName("wall_spawn")
    self.barrels = {} -- Created walls on the map
    self:CreateBarrels()

    self:SetState(STATE_WARMUP)

    self.warmup = Warmup(
        self.players,
        function(context) -- sent automatically if using self:Method() notation
            self:OnWarmupEnd(context)
        end
    )

    self.round = Round(
        self.players,
        function(context) -- sent automatically if using self:Method() notation
            self:OnRoundEnd(context)
        end
    )
    
    self:RegisterThinker(0.1, function()
        if self.state == STATE_WARMUP and self.warmup then
            self.warmup:Update()
        end
    end)

    self:RegisterThinker(0.01, function()
        if self.state == STATE_ROUND_IN_PROGRESS and self.round then
            self.round:Update()
        end
    end)

    self:RegisterThinker(0.01, function()
        for _,alliance in pairs(self.alliances) do
            if next(alliance.players) ~= nil then
                local data = {
                    health = alliance:GetCurrentHealth(),
                    max_health = alliance:GetMaxHealth(),
                    shield = alliance:GetShield(),
                    name = alliance:GetName(),
                    amethysts = alliance:GetAmethyst(),
                    score = alliance:GetScore(),
                }
                CustomNetTables:SetTableValue("alliances", alliance.name, data)
            end
        end
    end)

    self:RegisterThinker(0.01, function()
        for _,player in pairs(self.players) do
            local data = {
                entity_index = player.hero:GetEntityIndex(),
                teamID = player.hero:GetTeam(),
                playerID = player.hero:GetPlayerOwnerID(),
                alliance_name = player.hero:GetAlliance():GetName(),
                name = player.hero:GetName(),
                health = player.hero:GetHealth(),
                max_health = player.hero:GetMaxHealth(),
                treshold = player.hero:GetTreshold(),
                shield = player.hero:GetShield(),
                mana = player.hero:GetMana(),
                max_mana = player.hero:GetMaxMana(),
                status = player.hero:GetStatus(),
                recast = player.hero:GetRecast(),
                stackbars = player.hero:GetStackbars(),
                charges = player.hero:GetCharges(),
                cooldown = player.hero:GetCooldown(),
            }
            CustomNetTables:SetTableValue("heroes", "index_" .. data.entity_index, data)
        end

        --[[
        print("============================================================")
        for _,unit in pairs(self.units) do
            print(unit:GetEntityIndex(), unit:IsAlive() and "ALIVE" or "DEATH")
            local data = {
                unit_index = unit:GetEntityIndex(),
                teamID = DOTA_TEAM_GOODGUYS,--unit:GetTeam(),
                playerID = 0,--unit:GetPlayerOwnerID(),
                name = unit:GetName(),
                health = unit:GetHealth(),
                max_health = unit:GetMaxHealth(),
                treshold = unit:GetTreshold(),
                mana = unit:GetMana(),
                max_mana = unit:GetMaxMana(),
                status = unit:GetStatus(),
                recast = unit:GetRecast(),
                stackbars = unit:GetStackbars(),
                charges = unit:GetCharges(),
                cooldown = unit:GetCooldown(),
            }
            CustomNetTables:SetTableValue("units", "index_" .. data.unit_index, data)
        end
        ]]

        CustomGameEventManager:Send_ServerToAllClients("get_mouse_position", {})
    end)
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

function GameMode:RegisterUnit(unit)
    table.insert(self.units, unit)
end


function GameMode:SetState(state)
    self.state = state

    CustomNetTables:SetTableValue("game_state", "state", { state = state })
end 

function GameMode:OnGameRulesStateChange(keys)
    local state = GameRules:State_Get()
    
    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        self:OnGameInProgress()
    end
end

function GameMode:OnWarmupEnd(context)
    local warmup = context
    
    self.warmup = nil
    for _,alliance in pairs(self.alliances) do
        alliance:SetAmethysts(0)
    end

    self:SetState(STATE_ROUND_IN_PROGRESS)
    CustomGameEventManager:Send_ServerToAllClients( "custom_message", { text = "Round Start!" } )
end

function GameMode:OnRoundEnd(context)
    local round = context

    round:DestroyAllPickups() -- Remove death orbs

    if round.winner then
        round.winner.wins = round.winner.wins + 1

        if  round.winner.wins >= ROUNDS_TO_WIN or self:GetHighestWinsDifference(round.winner) >= ROUNDS_DIFFERENCE_TO_WIN then
            self:EndGame(round.winner.teams[1]) 
            return
        end
    else
        CustomGameEventManager:Send_ServerToAllClients( "custom_message", { text = "DRAW!" } )
    end

    self.round = nil

    self:SetState(STATE_WARMUP)
    self.warmup = Warmup(
        self.players,
        function(context) 
            self:OnWarmupEnd(context)
        end
    )
    self.round = Round(
        self.players,
        function(context) 
            self:OnRoundEnd(context)
        end
    )
end

function GameMode:OnGameInProgress()
    self:Start()
end

function GameMode:OnHeroInGame(keys)
    local npc = EntIndexToHScript(keys.entindex)
    if npc:IsNull() then return end

    -- First time spawning
    if not npc:IsInitialized() then
        npc:Initialize()

        if npc:IsRealHero() then
            if not self:RegisterPlayer(npc) then
                return false
            end
        end
    end

    -- Always
    if npc:IsRealHero() then
        local playerID = npc:GetPlayerOwnerID()
        SafeDestroyModifier("modifier_generic_provides_vision", npc, nil)
        PlayerResource:SetCameraTarget(playerID, nil)
    end
end

function GameMode:OnEntityKilled( keys )
    local killed = EntIndexToHScript( keys.entindex_killed )

    if killed.GetParentEntity then
        local entity = killed:GetParentEntity()

        if instanceof(entity, Amethyst) then     
            entity:OnDeath({ killer = EntIndexToHScript( keys.entindex_attacker ) })
        end
        if instanceof(entity, DummyTarget) then     
            entity:OnDeath()
        end
    else
        if killed:IsRealHero() then
            self.round.hero_died = true
            self:CreateDeathOrb(killed)
            self:UpdateCameras()
        end
    end
end

function GameMode:OnItemPickUp( event )
	local entity = EntIndexToHScript( event.ItemEntityIndex ):GetParentEntity()
    entity:OnPickedUp()
end

function GameMode:OnAmethystDestroy(killer)
    if killer ~= nil then
        local killer_alliance = killer.alliance

        killer_alliance.amethysts:SetAmethyst(killer_alliance:GetAmethyst() + 1)
        
        if self.WIN_CONDITION.type == "AMETHYSTS" then
            if killer_alliance:GetAmethyst() >= self.WIN_CONDITION.number then
                self:EndGame(killer_alliance.teams[1]) 
            end
        end
    end
end

function GameMode:OnHeroKilled(killed)
    if self.WIN_CONDITION.type == "AMETHYSTS" then
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

        local word_length = string.len(tostring(math.floor(keys.damage)))

        local color =  Vector(250, 70, 70)
        local effect_cast = ParticleManager:CreateParticle("particles/msg_damage.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl( effect_cast, 0, entVictim:GetOrigin() )
        ParticleManager:SetParticleControl( effect_cast, 1, Vector(0, keys.damage, 0) )
        ParticleManager:SetParticleControl( effect_cast, 2, Vector(math.max(1, keys.damage / 10), word_length, 0) )
        ParticleManager:SetParticleControl( effect_cast, 3, color )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end

function GameMode:GetHighestWinsDifference(alliance)
    local difference = 0

    for _,m_alliance in pairs(self.alliances) do
        if m_alliance ~= alliance then
            local m_difference = alliance.wins - m_alliance.wins

            if m_difference > difference then
                difference = m_difference 
            end
        end
    end 

    return difference
end

function GameMode:FindNextAliveAlly( alliance )
    for _,player in pairs(alliance.players) do
        if player.hero:IsAlive() then
            return player.hero
        end
    end

    return nil
end

function GameMode:FindNextAliveHero()
    for _,player in pairs(self.players) do
        if player.hero:IsAlive() then
            return player.hero
        end
    end

    return nil
end

function GameMode:UpdateCameras()
    for _,player in pairs(self.players) do
        local hero = player.hero
        if not hero:IsAlive() then
            local alive_ally = self:FindNextAliveAlly( player.alliance )

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

function GameMode:CreateBarrels()
    print("[AMETHYST] Creating walls")
    for _,wall_ent in pairs(self.barrel_ents) do
        self:CreateBarrel(wall_ent)
    end
end

function GameMode:CreateBarrel( ent )
    local fow_blocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = ent:GetOrigin(), block_fow = true})
    self.barrels[ent] = CreateUnitByName(
        "npc_dota_creature_wall", --szUnitName
        ent:GetOrigin(), --vLocation
        false, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    self.barrels[ent]:Attribute_SetIntValue("barrel", 1)
    self.barrels[ent]:SetHullRadius(65)
    self.barrels[ent]:AddNewModifier(self.barrels[ent], nil, "wall_base", { fow_blocker = fow_blocker:GetEntityIndex() })
end

function GameMode:CreateDeathOrb( hero )
    local current_mana = hero:GetMana()
    local mana_given = NearestValue({ 25, 50, 75, 100 }, current_mana)
    local entity = Pickup(PickupTypes.DEATH, hero:GetOrigin(), (mana_given/100) + 0.25)

    table.insert(self.round.pickups, {
        origin = hero:GetOrigin(),
        type = PickupTypes.DEATH,
        timer = 0,
        entity = entity
    })
    entity:GetItem():SetCurrentCharges(mana_given)
    entity:GetItem():SetPurchaser(hero)
end

function GameMode:EndGame( victoryTeam )
	GameRules:SetGameWinner( victoryTeam )
end

function GameMode:UpdateUnitHealthBar( unit )
    local data = {
        unitIndex = unit:GetEntityIndex(),
        current_health = unit:GetHealth(),
        max_health = unit:GetMaxHealth()
    }

    CustomGameEventManager:Send_ServerToAllClients( "update_unit_health_bar", data )
end