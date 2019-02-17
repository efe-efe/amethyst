function RunShadowDance( keys )
    local slark = keys.caster
    if slark then
        local shadowDance = slark:FindAbilityByName("slark_shadow_dance")
        if shadowDance:IsFullyCastable() then
            slark:CastAbilityImmediately(shadowDance, slark:GetPlayerOwnerID())
        end
    end
end