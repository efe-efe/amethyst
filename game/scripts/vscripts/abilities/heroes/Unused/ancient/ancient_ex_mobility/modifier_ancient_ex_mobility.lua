modifier_ancient_ex_mobility = class({})

function modifier_ancient_ex_mobility:OnCreated(params)
    if IsServer() then
        self:PlayEffectsOnCast()
    end
end

function modifier_ancient_ex_mobility:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_ancient_ex_mobility:PlayEffectsOnCast()
    local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet.vpcf"

    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
end

function modifier_ancient_ex_mobility:StopEffects()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle(self.effect_cast, false) 
        ParticleManager:ReleaseParticleIndex(self.effect_cast)    
    end
end