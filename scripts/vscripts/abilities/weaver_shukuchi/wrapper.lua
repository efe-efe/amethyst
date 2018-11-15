function RunShukuchi()
    local weaver = Entities:FindByClassname(nil, "npc_dota_hero_weaver")
    if weaver then
        local shukuchi = weaver:FindAbilityByName("weaver_shukuchi")
        if shukuchi:IsFullyCastable() then
            weaver:CastAbilityImmediately(shukuchi, weaver:GetPlayerOwnerID())
        end
    end
end