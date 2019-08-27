modifier_sniper_ultimate_timer = class({})

function modifier_sniper_ultimate_timer:OnCreated()
    if IsServer() then
        -- Can't move
        self:OnIntervalThink()
        self:StartIntervalThink( 0.45 )
    end
end

function modifier_sniper_ultimate_timer:OnDestroy()
    if IsServer() then
        --Can move again
        self:PlayEffects()
    end
end

-- Status Effects
function modifier_sniper_ultimate_timer:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

function modifier_sniper_ultimate_timer:OnIntervalThink()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("sniper_ultimate_projectile")
    
    caster:CastAbilityOnPosition(Vector(0,0,0), ability, caster:GetPlayerID())
end

function modifier_sniper_ultimate_timer:PlayEffects()
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


