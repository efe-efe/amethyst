

-- Gold filter, can be used to modify how much gold player gains/loses
function GameMode:GoldFilter(keys)
	local gold = keys.gold
	local playerID = keys.player_id_const
	local reason = keys.reason_const

	-- Reasons:
        -- DOTA_ModifyGold_Unspecified = 0
        -- DOTA_ModifyGold_Death = 1
        -- DOTA_ModifyGold_Buyback = 2
        -- DOTA_ModifyGold_PurchaseConsumable = 3
        -- DOTA_ModifyGold_PurchaseItem = 4
        -- DOTA_ModifyGold_AbandonedRedistribute = 5
        -- DOTA_ModifyGold_SellItem = 6
        -- DOTA_ModifyGold_AbilityCost = 7
        -- DOTA_ModifyGold_CheatCommand = 8
        -- DOTA_ModifyGold_SelectionPenalty = 9
        -- DOTA_ModifyGold_GameTick = 10
        -- DOTA_ModifyGold_Building = 11
        -- DOTA_ModifyGold_HeroKill = 12
        -- DOTA_ModifyGold_CreepKill = 13
        -- DOTA_ModifyGold_RoshanKill = 14
        -- DOTA_ModifyGold_CourierKill = 15
        -- DOTA_ModifyGold_SharedGold = 16

    
    -- Disable all hero kill gold
	if DISABLE_ALL_GOLD_FROM_HERO_KILLS then
        if reason == DOTA_ModifyGold_HeroKill then
			return false
		end
	end

	return true
end

-- Healing Filter, can be used to modify how much hp regen and healing a unit is gaining
-- Triggers every time a unit gains health
function GameMode:HealingFilter(keys)
	--PrintTable(keys)

    local healing_target_index = keys.entindex_target_const
    local healing_target = EntIndexToHScript(healing_target_index)

    -- Reduce incoming heal
    local reduction =  1 - healing_target.healing_reduction_pct/100
    if reduction <= 0 then reduction = 0.1 end
    keys.heal = math.floor(keys.heal * reduction)
    --print(reduction .. " | " .. keys.heal)

	local healer_index
	if keys.entindex_healer_const then
		healer_index = keys.entindex_healer_const
	end

	local healing_ability_index
	if keys.entindex_inflictor_const then
		healing_ability_index = keys.entindex_inflictor_const
	end


	-- Find the source of the heal - the healer
	local healer
	if healer_index then
		healer = EntIndexToHScript(healer_index)
	else
		healer = healing_target -- hp regen
	end

	-- Find healing ability
	-- Abilities that give bonus hp regen don't count as healing abilities!!!
	local healing_ability
	if healing_ability_index then
		healing_ability = EntIndexToHScript(healing_ability_index)
	else
		healing_ability = nil -- hp regen
    end

    
    -- Check if is able to heal
    if healing_target:IsRealHero() then
        local new_treshold = healing_target.iTreshold + keys.heal
        if new_treshold > self.iMaxTreshold then
            keys.heal = self.iMaxTreshold - healing_target.iTreshold
            healing_target.iTreshold = self.iMaxTreshold
        else
            healing_target.iTreshold = new_treshold
        end
        --print("[HEAL] " .. healing_target:GetName() .. " = " .. healing_target.iTreshold)
    	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, healing_target, keys.heal, nil )
        
        for i = 0, keys.heal - 1 do
            healing_target:FindModifierByName("modifier_treshold"):IncrementStackCount()
        end

        --local health_bar = "(" .. healing_target.iTreshold .. "/" .. self.iMaxTreshold ..")"
        --healing_target:SetCustomHealthLabel(health_bar, 255, 255, 255)
    end

    
    Timers:CreateTimer(0.1, function()
        self:UpdateHealthBars()
        self:UpdateHeroHealthBar( healing_target )
    end)

	return true
end


-- Damage filter function
function GameMode:DamageFilter(keys)
    --PrintTable(keys)

	local attacker
	local victim
	if keys.entindex_attacker_const and keys.entindex_victim_const then
		attacker = EntIndexToHScript(keys.entindex_attacker_const)
		victim = EntIndexToHScript(keys.entindex_victim_const)
	else
		return false
	end

	local damage_type = keys.damagetype_const
	local inflictor = keys.entindex_inflictor_const	-- keys.entindex_inflictor_const is nil if damage is not caused by an ability
	local damage_after_reductions = math.floor(keys.damage) 	-- keys.damage is damage after reductions without spell amplifications

	-- Damage types:
        -- DAMAGE_TYPE_NONE = 0
        -- DAMAGE_TYPE_PHYSICAL = 1
        -- DAMAGE_TYPE_MAGICAL = 2
        -- DAMAGE_TYPE_PURE = 4
        -- DAMAGE_TYPE_ALL = 7
        -- DAMAGE_TYPE_HP_REMOVAL = 8

	local damaging_ability
	if inflictor then
		damaging_ability = EntIndexToHScript(inflictor)
	else
		damaging_ability = nil
	end

	-- Lack of entities handling (illusions error fix)
	if attacker:IsNull() or victim:IsNull() then
		return false
    end
    
    if victim:IsRealHero() then
        victim.iTreshold = victim.iTreshold - damage_after_reductions
        if victim.iTreshold < 0 then
            victim.iTreshold = 0
        end

        for i = 0, damage_after_reductions - 1 do
            victim:FindModifierByName("modifier_treshold"):DecrementStackCount()
        end
        
        Timers:CreateTimer(0.1, function()
            self:UpdateHealthBars()
            self:UpdateHeroHealthBar( victim )
        end)
        --local health_bar = "(" .. victim.iTreshold .. "/" .. self.iMaxTreshold ..")"
        --victim:SetCustomHealthLabel(health_bar, 255, 255, 255)
    end

    --print("[DAMAGE] " .. victim:GetName() .. " = " .. victim.iTreshold)
	
	--[[ Update the gold bounty of the hero before he dies
        if USE_CUSTOM_HERO_GOLD_BOUNTY then
            if attacker:IsControllableByAnyPlayer() and victim:IsRealHero() and damage_after_reductions >= victim:GetHealth() then
                -- Get his killing streak
                local hero_streak = victim:GetStreak()
                -- Get his level
                local hero_level = victim:GetLevel()
                -- Adjust Gold bounty
                local gold_bounty
                if hero_streak > 2 then
                    gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL + (hero_streak-2)*HERO_KILL_GOLD_PER_STREAK
                else
                    gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL
                end

                victim:SetMinimumGoldBounty(gold_bounty)
                victim:SetMaximumGoldBounty(gold_bounty)
            end
        end
        ]]
	return true
end

function GameMode:UpdateHealthBars()
    local total_max_health = {}
    local total_actual_health = {}

    total_max_health[DOTA_TEAM_GOODGUYS] = 0
    total_max_health[DOTA_TEAM_BADGUYS] = 0

    total_actual_health[DOTA_TEAM_GOODGUYS] = 0
    total_actual_health[DOTA_TEAM_BADGUYS] = 0

    for team_number, team in pairs(self.teams) do
        for hero_index, hero in pairs(team.heroes) do
            total_max_health[team_number] = total_max_health[team_number] + hero:GetMaxHealth()
            total_actual_health[team_number] = total_actual_health[team_number] + hero:GetHealth()
        end
    end

    local good_guys = 100 * total_actual_health[DOTA_TEAM_GOODGUYS]/total_max_health[DOTA_TEAM_GOODGUYS]
    local bad_guys = 100 * total_actual_health[DOTA_TEAM_BADGUYS]/total_max_health[DOTA_TEAM_BADGUYS]

    if good_guys ~= good_guys then
        good_guys = 0
    end

    if bad_guys ~= bad_guys then
        bad_guys = 0
    end

    local data = {
        good_guys = good_guys,
        bad_guys = bad_guys
    }
    CustomGameEventManager:Send_ServerToAllClients( "update_team_health_bars", data )
end

function GameMode:UpdateHeroHealthBar( hero )
    local potential_health = hero:GetHealth() + (self.iMaxTreshold - hero.iTreshold)
    local treshold = 100 * potential_health/hero:GetMaxHealth()
    local percentage = 100 * hero:GetHealth()/potential_health
    
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        percentage = percentage,
        treshold = treshold,
    }

    CustomGameEventManager:Send_ServerToAllClients( "update_hero_health_bar", data )
end


function GameMode:UpdateHeroManaBar( hero )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        percentage = hero:GetManaPercent()
    }
    CustomGameEventManager:Send_ServerToAllClients( "update_hero_mana_bar", data )
end

function GameMode:UpdateHeroStacks( hero, stacks )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        stacks = stacks
    }
    CustomGameEventManager:Send_ServerToAllClients( "update_hero_stacks", data )
end

function GameMode:UpdateHeroCharges( hero, charges )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        charges = charges
    }
    CustomGameEventManager:Send_ServerToAllClients( "update_hero_charges", data )
end


function GameMode:InitializeHeroCharges( hero, charges )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        charges = charges
    }
    CustomGameEventManager:Send_ServerToAllClients( "initialize_hero_charges", data )
end

function GameMode:InitializeCastPoint( hero, duration )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        duration = duration,
    }
    CustomGameEventManager:Send_ServerToAllClients( "initialize_cast_point", data )
end

function GameMode:InitializeCooldown( hero, modifierName )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        modifierName = modifierName,
    }
    CustomGameEventManager:Send_ServerToAllClients( "initialize_hero_cooldown", data )
end

function GameMode:StopCastPoint( hero )
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex()
    }
    CustomGameEventManager:Send_ServerToAllClients( "stop_cast_point", data )
end
