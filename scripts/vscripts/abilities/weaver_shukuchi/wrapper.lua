function RunShukuchi( keys )
    local weaver = keys.caster
    if weaver then
        local shukuchi = weaver:FindAbilityByName("weaver_shukuchi")
        if shukuchi:IsFullyCastable() then
            weaver:CastAbilityImmediately(shukuchi, weaver:GetPlayerOwnerID())
        end
    end
end