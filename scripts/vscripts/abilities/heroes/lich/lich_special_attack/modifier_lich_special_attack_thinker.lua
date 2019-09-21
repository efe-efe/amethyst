modifier_lich_special_attack_thinker = class({})

--------------------------------------------------------------------------------
function modifier_lich_special_attack_thinker:OnCreated( kv )
    if IsServer() then
        self.knockback = kv.extra_one and true or false
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.damage = self:GetAbility():GetAbilityDamage()
        local delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )

        -- Start Interval
        self:StartIntervalThink( delay_time )
        self:PlayEffectsOnCreated()
    end
end

--------------------------------------------------------------------------------
function modifier_lich_special_attack_thinker:OnIntervalThink()
    if IsServer() then
        self:GetAbility():ConsumeDebuffs( self.damage, self:GetParent():GetOrigin(), self.radius, self.knockback )
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_lich_special_attack_thinker:PlayEffectsOnCreated()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn( "Hero_Lich.IceAge", thinker )
    
    -- Create particles
	local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector(1, self.radius, 1) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end