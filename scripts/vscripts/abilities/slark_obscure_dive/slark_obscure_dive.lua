--[[Author: Pizzalol
	Date: 26.09.2015.
	Clears current caster commands and disjoints projectiles while setting up everything required for movement]]
    function Leap( keys )
        local caster = keys.caster
        local ability = keys.ability
        local ability_level = ability:GetLevel() - 1	
    
        -- Clears any current command and disjoints projectiles
        caster:Stop()
        ProjectileManager:ProjectileDodge(caster)
    
        -- Ability variables
        ability.leap_direction = caster:GetForwardVector()
        ability.leap_distance = ability:GetLevelSpecialValueFor("leap_distance", ability_level)
        ability.leap_speed = ability:GetLevelSpecialValueFor("leap_speed", ability_level) * 1/30
        ability.leap_traveled = 0
        ability.leap_z = 0
    end
    
    --[[Moves the caster on the horizontal axis until it has traveled the distance]]
    function LeapHorizonal( keys )
        local caster = keys.target
        local ability = keys.ability
    
        if ability.leap_traveled < ability.leap_distance then
            caster:SetAbsOrigin(caster:GetAbsOrigin() + ability.leap_direction * ability.leap_speed)
            ability.leap_traveled = ability.leap_traveled + ability.leap_speed
        else
            caster:InterruptMotionControllers(true)
        end
    end