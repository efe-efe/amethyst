
require('settings')

require('util/util')

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
_G.STATE_WARMUP = 2 

local Custom_ActionTypes = {
    MOVEMENT = 0,
    ABILITY = 1,
} 

local Custom_ActionModes = {
    START = 0,
    STOP = 1,
}

if GameMode == nil then
    GameMode = class({})
end

function Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)

    PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", context)
	PrecacheResource("particle", "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf", context)
	PrecacheResource("particle", "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf", context)
    
	PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", context)

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
    GameRules:SetSameHeroSelectionEnabled(true)
    GameRules:SetPreGameTime(0.0)
    GameRules:SetGoldPerTick(0)
    GameRules:SetGoldTickTime(0)
    GameRules:SetStartingGold(0)
    GameRules:SetCustomGameSetupAutoLaunchDelay(10)
    GameRules:SetStrategyTime(0.0)
    GameRules:SetShowcaseTime(0.0)
    GameRules:SetUseBaseGoldBountyOnHeroes(false)
    GameRules:GetGameModeEntity():SetFixedRespawnTime(-1) 
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
    GameRules:SetTimeOfDay(0.5)

    if GetMapName() == "mad_moon_map" or GetMapName() == "forest_map" then
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 1)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 1)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 1)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 1)
        GameRules:SetHeroRespawnEnabled(false)
    elseif GetMapName() == "free_for_all" then
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 1)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 1)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 1)
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_5, 1)
        GameRules:SetHeroRespawnEnabled(true)
    end
    print('[AMETHYST] GameRules set')
end

function GameMode:SetupEventHooks()
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(self, 'OnHeroInGame'), self)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(self, 'OnEntityKilled'), self)
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(self, 'OnGameRulesStateChange'), self)
    ListenToGameEvent('entity_hurt', Dynamic_Wrap(self, 'OnEntityHurt'), self)
    ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(self, 'OnLearnedAbilityEvent'), self)
    print('[AMETHYST] Event hooks set')
end

function GameMode:SetupFilters()
    Filters:Activate(GameMode, self)

    local mode = GameRules:GetGameModeEntity()
    mode:SetModifyGoldFilter(Dynamic_Wrap(GameMode, 'GoldFilter'), GameMode)
    mode:SetHealingFilter(Dynamic_Wrap(GameMode, 'HealingFilter'), GameMode)
    mode:SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), GameMode)
    mode:SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "ExecuteOrderFilter"), GameMode)
    mode:SetModifyExperienceFilter(Dynamic_Wrap(GameMode, "ModifyExperienceFilter"), GameMode)
    print('[AMETHYST] Filters set')
end

function GameMode:LinkModifiers()
    LinkLuaModifier("modifier_death_zone",                      "modifiers/modifier_death_zone.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("wall_base",                                "modifiers/wall_base.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_adrenaline",                      "modifiers/modifier_adrenaline.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("radius_marker_thinker",                    "modifiers/radius_marker_thinker.lua", LUA_MODIFIER_MOTION_NONE)
    
    LinkLuaModifier("modifier_generic_silence",                 "abilities/generic/modifier_generic_silence", LUA_MODIFIER_MOTION_NONE) -- Should Delete
    LinkLuaModifier("modifier_generic_fading_slow",             "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_haste",            "abilities/generic/modifier_generic_fading_haste", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_stunned",                 "abilities/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE) -- Should Delete
    LinkLuaModifier("modifier_generic_provides_vision",         "abilities/generic/modifier_generic_provides_vision", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_knockback",               "abilities/generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH)
    LinkLuaModifier("modifier_generic_root",                    "abilities/generic/modifier_generic_root", LUA_MODIFIER_MOTION_NONE) -- Should Delete
    LinkLuaModifier("modifier_generic_invencible",              "abilities/generic/modifier_generic_invencible", LUA_MODIFIER_MOTION_NONE) -- Should Delete
    LinkLuaModifier("modifier_generic_confuse",                 "abilities/generic/modifier_generic_confuse", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_sleep",                   "abilities/generic/modifier_generic_sleep", LUA_MODIFIER_MOTION_NONE)
    
    LinkLuaModifier("modifier_visible",                         "abilities/base/modifier_visible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_casting",                         "abilities/base/modifier_casting", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_damage_fx",                       "abilities/base/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_base",                       "abilities/base/modifier_hero_base", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_shield",                          "abilities/base/modifier_shield", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_channeling",                      "abilities/base/modifier_channeling", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar",                        "abilities/base/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden",                          "abilities/base/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish",                          "abilities/base/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    
    LinkLuaModifier("modifier_mount",                          "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE)

    print('[AMETHYST] Useful modifiers linked')
end

function GameMode:SetupPanoramaEventHooks()
    CustomGameEventManager:RegisterListener('update_mouse_position', function(eventSourceIndex, args)
        local position = Vector(args.x, args.y, args.z)
        local playerId = args.playerId

        if self.players and self.players[playerId] then
            self.players[playerId]:UpdateCursorPosition(position)
        end
    end)
        
    CustomGameEventManager:RegisterListener('key_released', function(eventSourceIndex, args)
        local unit = EntIndexToHScript(args.entityIndex)

        if modifier ~= nil then
            if not modifier:IsNull() then
                modifier:OnKeyReleased(args.key)
            end
        end
    end)

    CustomGameEventManager:RegisterListener('custom_action', function(eventSourceIndex, event)
        local playerId = event.playerID

        if self.players and self.players[playerId] then
            local player = self.players[playerId]
            local hero = player.hero

            local type = event.payload.type;
            local mode = event.payload.mode;
            
            if(type == Custom_ActionTypes.MOVEMENT) then
                local currentDirection = hero:GetRawDirection()
                local incomingDirection = event.payload.direction;
                local vector = Vector(incomingDirection['0'], incomingDirection['1'], 0);

                if(mode == Custom_ActionModes.STOP) then
                    vector = vector * (-1);
                end

                local newDirection = currentDirection + (vector);
                newDirection.z = hero:GetForwardVector().z;
                hero:SetDirection(newDirection.x, newDirection.y);
            end
        end
    end)
    
    CustomGameEventManager:RegisterListener('refund_points', function(eventSourceIndex, event)
        local playerId = event.playerID

        if self.players and self.players[playerId] then
            local player = self.players[playerId]
            local hero = player.hero

            for i = 0, 23 do
                local ability = hero:GetAbilityByIndex(i)
                if ability then
                    if ability:GetAbilityType() ~= 2 then -- To not level up the talents
                        ability:SetLevel(1)
                    end
                end
            end

            hero:SetAbilityPoints(ABILITY_POINTS)
            hero:SendDataToClient()
        end
    end)

    
    
    CustomGameEventManager:RegisterListener('swap_r_f', function(eventSourceIndex, event)
        
        local playerId = event.playerID

        if self.players and self.players[playerId] then
            local player = self.players[playerId]
            local hero = player.hero

            local ability_name_one = hero:GetAbilityByIndex(5):GetName()
            local ability_name_two = hero:GetAbilityByIndex(6):GetName()
            hero:SwapAbilities(ability_name_one, ability_name_two, true, true)
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
    mode:SetBuybackEnabled(false)
    mode:SetDaynightCycleDisabled(true)
    mode:SetCameraDistanceOverride(1350)
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
        CustomGameEventManager:Send_ServerToAllClients("get_mouse_position", {})
    end)

    CustomNetTables:SetTableValue("main", "maxScore", { max_score = ROUNDS_DIFFERENCE_TO_WIN })
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

    CustomNetTables:SetTableValue("main", "gameState", { gameState = state })
end 

function GameMode:OnGameRulesStateChange(event)
    local state = GameRules:State_Get()
    
    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        self:OnGameInProgress()
    end
end

function GameMode:OnLearnedAbilityEvent(event)
    local playerId = event.PlayerID
    local player = self.players[playerId]
    local hero = player.hero
    
    player.hero:SendDataToClient()
end

function GameMode:OnWarmupEnd(context)
    local warmup = context
    
    self.warmup = nil
    for _,alliance in pairs(self.alliances) do
        alliance:SetAmethysts(0)
    end

    self:SetState(STATE_ROUND_IN_PROGRESS)
    CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = "Round Start!" })
end

function GameMode:OnRoundEnd(context)
    local round = context
    local max_score = ROUNDS_DIFFERENCE_TO_WIN
    local allinaces_with_one_point = 0
    local allinaces_with_two_points = 0

    round:DestroyAllPickups() -- Remove death orbs

    if round.winner then
        local new_score = round.winner:GetScore() + 1
        round.winner:SetScore(new_score)

        if  round.winner:GetScore() >= ROUNDS_TO_WIN or self:GetHighestWinsDifference(round.winner) >= ROUNDS_DIFFERENCE_TO_WIN then
            self:EndGame(round.winner.teams[1]) 
            return
        end
    else
        CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = "DRAW!" })
    end

    for _,alliance in pairs(self.alliances) do
        if alliance:GetScore() == 1 then
            allinaces_with_one_point = allinaces_with_one_point + 1
        elseif alliance:GetScore() > 1 then
            allinaces_with_one_point = allinaces_with_one_point + 1
            allinaces_with_two_points = allinaces_with_two_points + 1
        end
    end

    if allinaces_with_two_points >= 2 then
        max_score = 5
    elseif allinaces_with_one_point >= 2 then
        max_score = 4
    end
    
    CustomNetTables:SetTableValue("main", "maxScore", { max_score = max_score })

    self.round = nil

    for _,player in pairs(self.players) do
        local hero = player.hero
        local playerId = player:GetId()
        hero:SafeDestroyModifier("modifier_generic_provides_vision")
        PlayerResource:SetCameraTarget(playerId, nil)
    end

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
end

function GameMode:OnEntityKilled(keys)
    local killed = EntIndexToHScript(keys.entindex_killed)

    if killed.GetParentEntity then
        local entity = killed:GetParentEntity()

        if instanceof(entity, Amethyst) then     
            entity:OnDeath({ killer = EntIndexToHScript(keys.entindex_attacker) })
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
            damagingAbility = EntIndexToHScript(keys.entindex_inflictor)
        end

        SendOverheadDamageMessage(entVictim, keys.damage)
    end
end

function GameMode:GetHighestWinsDifference(alliance)
    local difference = 0

    for _,m_alliance in pairs(self.alliances) do
        if m_alliance ~= alliance then
            if next(m_alliance.players) ~= nil then
                local m_difference = alliance.wins - m_alliance.wins

                if m_difference > difference then
                    difference = m_difference 
                end
            end
        end
    end 

    return difference
end

function GameMode:FindNextAliveAlly(alliance)
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
            local alive_ally = self:FindNextAliveAlly(player.alliance)

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

function GameMode:CreateBarrel(ent)
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

function GameMode:CreateDeathOrb(hero)
    local current_mana = hero:GetMana()
    local mana_given = NearestValue({ 25, 50, 75, 100 }, current_mana)
    local entity = Pickup(PickupTypes.DEATH, hero:GetOrigin(), (mana_given/100) + 0.25)

    table.insert(self.round.pickups, {
        origin = hero:GetOrigin(),
        type = PickupTypes.DEATH,
        timer = -1,
        entity = entity
    })
    entity:GetItem():SetCurrentCharges(mana_given)
    entity:GetItem():SetPurchaser(hero)
end

function GameMode:EndGame(victoryTeam)
	GameRules:SetGameWinner(victoryTeam)
end

function GameMode:UpdateUnitHealthBar(unit)
    local data = {
        unitIndex = unit:GetEntityIndex(),
        current_health = unit:GetHealth(),
        max_health = unit:GetMaxHealth()
    }

    CustomGameEventManager:Send_ServerToAllClients("update_unit_health_bar", data)
end