function RunTheSwarm()
    local weaver = Entities:FindByClassname(nil, "npc_dota_hero_weaver")
    if weaver then
        local theSwarm = weaver:FindAbilityByName("weaver_the_swarm")
        if theSwarm:IsFullyCastable() then
            weaver:CastAbilityImmediately(theSwarm, weaver:GetPlayerOwnerID())
        end
    end
end