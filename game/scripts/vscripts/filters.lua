function GameMode:GoldFilter(keys)
	local gold = keys.gold
	local playerID = keys.player_id_const
	local reason = keys.reason_const

    if reason == DOTA_ModifyGold_HeroKill then
        return false
    end

	return true
end

function GameMode:HealingFilter(keys)
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
        
        local treshold_modifier = healing_target:FindModifierByName("modifier_treshold")
        treshold_modifier:SetStackCount(treshold_modifier:GetStackCount() + keys.heal)

        --local health_bar = "(" .. healing_target.iTreshold .. "/" .. self.iMaxTreshold ..")"
        --healing_target:SetCustomHealthLabel(health_bar, 255, 255, 255)
    end

    
    Timers:CreateTimer(0.1, function()
        self:UpdateHealthBar( healing_target:GetAlliance() )
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
        victim:AddNewModifier(victim, nil, "modifier_damage_fx", { duration = 0.1 })
        
        Timers:CreateTimer(0.1, function()
            self:UpdateHealthBar( victim:GetAlliance() )
            self:UpdateHeroHealthBar( victim )
        end)

    elseif victim:IsAmethyst() then
        Timers:CreateTimer(0.1, function()
            self:UpdateUnitHealthBar( victim )
        end)
    end
	return true
end

function GameMode:UpdateHealthBar( alliance )
    local health_pct = 100 * alliance:GetCurrentHealth()/alliance:GetMaxHealth()

    local data = {
        health_pct = health_pct,
        alliance = alliance.name
    }
    CustomGameEventManager:Send_ServerToAllClients( "update_alliance_health_bar", data )
end

function GameMode:UpdateHeroHealthBar( hero )
    local potential_health = hero:GetHealth() + (self.iMaxTreshold - hero.iTreshold)
    local shield_modifier = hero:FindModifierByName("modifier_shield")
    local shield = 0

    if shield_modifier~=nil then
        if not shield_modifier:IsNull() then
            shield = shield_modifier:GetStackCount()
        end
    end
    
    local data = {
        teamID = hero:GetTeamNumber(),
        heroIndex = hero:GetEntityIndex(),
        shield = shield,
        current_health = hero:GetHealth(),
        max_health = hero:GetMaxHealth(),
        potential_health = potential_health,
    }

    CustomGameEventManager:Send_ServerToAllClients( "update_hero_health_bar", data )
end

function GameMode:UpdateUnitHealthBar( unit )
    local data = {
        unitIndex = unit:GetEntityIndex(),
        current_health = unit:GetHealth(),
        max_health = unit:GetMaxHealth()
    }

    CustomGameEventManager:Send_ServerToAllClients( "update_unit_health_bar", data )
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