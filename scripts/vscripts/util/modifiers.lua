function SafeDestroyModifier(modifier_name, unit, caster)
    -- Find and destroy modifier
    local modifier = unit:FindModifierByNameAndCaster( modifier_name, caster )
    
    -- Safe destroying
    if modifier~=nil then
        if not modifier:IsNull() then
            modifier:Destroy()
        end
    end
end

function SafeGetModifierStacks(modifier_name, unit, caster)
    -- Find and destroy modifier
    local modifier = unit:FindModifierByNameAndCaster( modifier_name, caster )
    local stacks = 0

    -- Safe Get stack count
    if modifier~=nil then
        if not modifier:IsNull() then
            stacks = modifier:GetStackCount()
        end
    end

    return stacks
end

function SafeGetModifierCaster(modifier_name, unit)
    -- Find and destroy modifier
    local modifier = unit:FindModifierByName( modifier_name)
    local caster = nil

    -- Safe destroying
    if modifier~=nil then
        if not modifier:IsNull() then
            caster = modifier:GetCaster()
        end
    end

    return caster
end


function CreateRadiusMarker(caster, origin, params)
    local effect_cast

    local particle_cast_enemy = "particles/mod_units/instant_aoe_marker.vpcf"
    local particle_cast_ally = "particles/mod_units/heroes/hero_dark_willow/dw_ti8_immortal_cursed_crown_marker.vpcf"
    
    if params.show_all == 1 then
        for _,actual_team in pairs(GameMode.teams) do
            if caster:GetTeam() == _ then
                effect_cast = ParticleManager:CreateParticleForTeam( particle_cast_ally, PATTACH_WORLDORIGIN, nil, _ )
            else
                effect_cast = ParticleManager:CreateParticleForTeam( particle_cast_enemy, PATTACH_WORLDORIGIN, nil, _ )
            end
                ParticleManager:SetParticleControl( effect_cast, 0, origin )
                ParticleManager:SetParticleControl( effect_cast, 2, Vector( params.radius, params.radius , params.radius ) )
                ParticleManager:SetParticleControl( effect_cast, 4, origin)
                ParticleManager:ReleaseParticleIndex( effect_cast )
        end
    else
        effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast_ally, PATTACH_WORLDORIGIN, nil, caster:GetPlayerOwner() )
        ParticleManager:SetParticleControl( effect_cast, 0, origin )
        ParticleManager:SetParticleControl( effect_cast, 2, Vector( params.radius, params.radius , params.radius ) )
        ParticleManager:SetParticleControl( effect_cast, 4, origin)
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end