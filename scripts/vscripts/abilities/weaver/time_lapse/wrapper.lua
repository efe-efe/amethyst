function RunTimeLapse( keys )
    local weaver = keys.caster
    if weaver then
        local timeLapse = weaver:FindAbilityByName("weaver_time_lapse")
        if timeLapse:IsFullyCastable() then
            weaver:CastAbilityImmediately(timeLapse, weaver:GetPlayerOwnerID())
            Timers:CreateTimer(.01, function()
                weaver:SetMana(0)
            end)
        end
    end   
end