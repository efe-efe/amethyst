Filters = Filters or class({})

function Filters:Activate(GameMode, this)
    function GameMode:ModifyExperienceFilter(tFilter)
        return false
    end
    function GameMode:ExecuteOrderFilter(tFilter)
        local order_type = tFilter["order_type"]

        if  order_type == DOTA_UNIT_ORDER_CAST_POSITION or 
            order_type == DOTA_UNIT_ORDER_CAST_TARGET or 
            order_type == DOTA_UNIT_ORDER_CAST_TARGET_TREE or 
            order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
        then
            local ability = EntIndexToHScript(tFilter.entindex_ability)
            local caster = EntIndexToHScript(tFilter.units["0"])
            local energy_cost = ability:GetEnergyCost()
            local energy = CustomEntities:GetEnergy(caster)

            if energy_cost > energy then 
                CustomGameEventManager:Send_ServerToAllClients("not_enough_energy", {})
                return false
            end

            if order_type == DOTA_UNIT_ORDER_CAST_POSITION then
                local point = Vector(
                    tFilter.position_x,
                    tFilter.position_y,
                    tFilter.position_z
               )
                local current_range = (point - caster:GetAbsOrigin()):Length2D()
                local direction = (point - caster:GetAbsOrigin()):Normalized()
                local max_range = ability:GetCastRange(Vector(0,0,0), nil)
    
                if not ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_IMMEDIATE) then
                    CustomEntities:FullyFaceTowards(caster, direction)
                end
    
                if current_range > max_range then
                    local new_point = caster:GetAbsOrigin() + direction * (max_range - 10)
    
                    tFilter.position_x = new_point.x
                    tFilter.position_y = new_point.y
                end
    
                return true
            end
        end


        if order_type == DOTA_UNIT_ORDER_STOP or order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
            local caster = EntIndexToHScript(tFilter.units["0"])
            local ability = caster:GetCurrentActiveAbility()
            if ability then
                if ability:GetAbilityType() == 1 then
                    return false
                end
            end
        end
        if order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
            print("YOU ARE HOLDING POSITION; PROBABLY YOU WANT TO STOP INSTEAD")
        end
        if order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET then
            return false
        end
       
        return true
    end

    function GameMode:GoldFilter(tFilter)
        return false
    end

    function GameMode:HealingFilter(tFilter)
        local healing_target_index = tFilter.entindex_target_const
        local healing_target = EntIndexToHScript(healing_target_index)
        local healing_reduction_pct = 0

        if healing_target.healing_reduction_pct then
            healing_reduction_pct = healing_target.healing_reduction_pct 
        end

        -- Reduce incoming heal
        local reduction =  1 - healing_reduction_pct/100
        if reduction <= 0 then reduction = 0.1 end
        tFilter.heal = math.floor(tFilter.heal * reduction)

        local healer_index
        if tFilter.entindex_healer_const then
            healer_index = tFilter.entindex_healer_const
        end

        local healing_ability_index
        if tFilter.entindex_inflictor_const then
            healing_ability_index = tFilter.entindex_inflictor_const
        end

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
            local new_treshold = CustomEntities:GetTreshold(healing_target) + tFilter.heal
            if new_treshold > this.max_treshold then
                tFilter.heal = this.max_treshold - CustomEntities:GetTreshold(healing_target)
                CustomEntities:SetTreshold(healing_target, this.max_treshold)
            else
                CustomEntities:SetTreshold(healing_target, new_treshold)
            end
            
            SendOverheadHealMessage(healing_target, tFilter.heal)
            Timers:CreateTimer(0.05, function()
                CustomEntities:SendDataToClient(healing_target)
            end)
            
            local healing_team = healing_target:GetTeam()
            local healing_alliance = GameRules.GameMode:FindAllianceByTeam(healing_team)

            Timers:CreateTimer(0.05, function()
                healing_alliance:SendDataToClient()
            end)
        end
        return true
    end

    function GameMode:DamageFilter(tFilter)
        local attacker
        local victim
        if tFilter.entindex_attacker_const and tFilter.entindex_victim_const then
            attacker = EntIndexToHScript(tFilter.entindex_attacker_const)
            victim = EntIndexToHScript(tFilter.entindex_victim_const)
        else
            return false
        end

        local damage_type = tFilter.damagetype_const
        local inflictor = tFilter.entindex_inflictor_const	-- tFilter.entindex_inflictor_const is nil if damage is not caused by an ability
        local damage_after_reductions = math.floor(tFilter.damage) 	-- tFilter.damage is damage after reductions without spell amplifications

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
            CustomEntities:SetTreshold(victim, CustomEntities:GetTreshold(victim) - damage_after_reductions)
            if CustomEntities:GetTreshold(victim) < 0 then
                CustomEntities:SetTreshold(victim, 0)
            end

            victim:AddNewModifier(victim, nil, "modifier_damage_fx", { duration = 0.1 })
            Timers:CreateTimer(0.05, function()
                CustomEntities:SendDataToClient(victim)
            end)
            
            
            local victim_team = victim:GetTeam()
            local victim_alliance = GameRules.GameMode:FindAllianceByTeam(victim_team)
            Timers:CreateTimer(0.05, function()
                victim_alliance:SendDataToClient()
            end)
        end
        
        if CustomEntities:IsAmethyst(victim) then 
            Timers:CreateTimer(0.1, function()
                this:UpdateUnitHealthBar(victim)
            end)
        end
        return true
    end
end