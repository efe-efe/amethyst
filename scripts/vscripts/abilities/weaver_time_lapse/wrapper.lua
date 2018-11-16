function RunTimeLapse()
    local weaver = Entities:FindByClassname(nil, "npc_dota_hero_weaver")
    if weaver then
        local timeLapse = weaver:FindAbilityByName("weaver_time_lapse")
        if timeLapse:IsFullyCastable() then
            weaver:CastAbilityImmediately(timeLapse, weaver:GetPlayerOwnerID())
        end
    end
end