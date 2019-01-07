function RunTimeLapse( keys )
    local caster = keys.caster
    local ability = keys.ability
    local mana_cost = ability:GetManaCost(-1)

    if caster then
        local timeLapse = caster:FindAbilityByName("weaver_time_lapse")

        if timeLapse:IsFullyCastable() then
            caster:CastAbilityImmediately(timeLapse, caster:GetPlayerOwnerID())
            Timers:CreateTimer(0.1, function()
                caster:GiveMana(-mana_cost)
            end)
        end
    end   
end