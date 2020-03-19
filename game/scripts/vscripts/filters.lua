Filters = Filters or class({})

function Filters:Activate(GameMode, inst)
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
            if new_treshold > inst.iMaxTreshold then
                keys.heal = inst.iMaxTreshold - healing_target.iTreshold
                healing_target.iTreshold = inst.iMaxTreshold
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
            inst:UpdateHealthBar( healing_target:GetAlliance() )
            inst:UpdateHeroHealthBar( healing_target )
        end)

        return true
    end

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
                inst:UpdateHealthBar( victim:GetAlliance() )
                inst:UpdateHeroHealthBar( victim )
            end)

        elseif victim:IsAmethyst() then
            Timers:CreateTimer(0.1, function()
                inst:UpdateUnitHealthBar( victim )
            end)
        end
        return true
    end
end