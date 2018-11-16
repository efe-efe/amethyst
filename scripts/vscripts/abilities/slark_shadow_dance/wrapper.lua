function RunShadowDance()
    local slark = Entities:FindByClassname(nil, "npc_dota_hero_slark")
    if slark then
        local shadowDance = slark:FindAbilityByName("slark_shadow_dance")
        if shadowDance:IsFullyCastable() then
            slark:CastAbilityImmediately(shadowDance, slark:GetPlayerOwnerID())
        end
    end
end