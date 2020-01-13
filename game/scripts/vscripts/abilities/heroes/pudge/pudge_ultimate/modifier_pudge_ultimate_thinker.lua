modifier_pudge_ultimate_thinker = class({})

function modifier_pudge_ultimate_thinker:OnCreated()
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = 250--self:GetAbility():GetSpecialValueFor("radius")

        self:OnIntervalThink()
        self:StartIntervalThink(1.0)
        self:PlayEffects()
    end
end

function modifier_pudge_ultimate_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_pudge_ultimate_thinker:OnIntervalThink()
    self:PlayEffectsAoe()
end

function modifier_pudge_ultimate_thinker:PlayEffects()
    local particle_cast = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
    --ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.radius,0,0))
    --ParticleManager:SetParticleControl( self.effect_cast, 2, self.origin )
end

function modifier_pudge_ultimate_thinker:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_pudge_ultimate_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end