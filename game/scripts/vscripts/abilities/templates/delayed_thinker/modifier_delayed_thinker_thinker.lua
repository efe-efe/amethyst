modifier_ability_name_thinker = class({})

function modifier_ability_name_thinker:OnCreated()
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self:StartIntervalThink(self.delay_time)
        self:PlayEffects()
    end
end

function modifier_ability_name_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_ability_name_thinker:OnIntervalThink()
	self:Destroy()
end

function modifier_ability_name_thinker:PlayEffects()
    local particle_cast = "PARTICLE_NAME"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, self.origin)
    --ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius,0,0))
    --ParticleManager:SetParticleControl(self.effect_cast, 2, self.origin)
end

function modifier_ability_name_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end