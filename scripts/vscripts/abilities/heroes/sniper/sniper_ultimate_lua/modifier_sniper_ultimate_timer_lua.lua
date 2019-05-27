modifier_sniper_ultimate_timer_lua = class({})

function modifier_sniper_ultimate_timer_lua:OnCreated()
    if IsServer() then
        local parent = self:GetParent()

        --Quits the animation
        local order = 
        {
            OrderType = DOTA_UNIT_ORDER_STOP,
            UnitIndex = parent:entindex()
        }

        ExecuteOrderFromTable(order)
    end
end

function modifier_sniper_ultimate_timer_lua:OnDestroy()
    if IsServer() then
        local parent = self:GetParent()

        parent:SwapAbilities( 
            "sniper_ultimate_projectile_lua",
            "sniper_ultimate_lua",
            false,
            true
        )
        self:PlayEffects()
        
    end
end

function modifier_sniper_ultimate_timer_lua:PlayEffects()
    local origin = self:GetParent():GetOrigin()

    -- Cast Particlres
    local particle_cast_a = "particles/mod_units/heroes/hero_sniper/techies_base_attack_smokeburst.vpcf"
    local particle_cast_b  = "particles/mod_units/heroes/hero_sniper/techies_base_attack_explosion.vpcf"
    
    
    local effect_cast_a = ParticleManager:CreateParticle( 
        particle_cast_a, 
        PATTACH_CUSTOMORIGIN, 
        nil
    )

    local effect_cast_b = ParticleManager:CreateParticle( 
        particle_cast_b, 
        PATTACH_CUSTOMORIGIN, 
        nil
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast_a, 
        7, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        origin + Vector( 0, 0, 96 ), 
        true 
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast_b, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        origin + Vector( 0, 0, 96 ), 
        true 
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast_b, 
        3, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        origin + Vector( 0, 0, 96 ), 
        true 
    )
    
    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

end


