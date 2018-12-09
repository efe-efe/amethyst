function RunTheSwarm( keys )
    local weaver =  keys.caster
    if weaver then
        local theSwarm = weaver:FindAbilityByName("weaver_the_swarm")
        if theSwarm:IsFullyCastable() then
            weaver:CastAbilityImmediately(theSwarm, weaver:GetPlayerOwnerID())
        end
    end
end