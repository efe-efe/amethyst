modifier_treant_mobility_knockback = class({}) 

function modifier_treant_mobility_knockback:OnCreated()
    if IsServer() then

        EmitSoundOn("Hero_Spirit_Breaker.Charge.Impact", self:GetCaster())
        self:PlayEffectsRoot()
    end
end

function modifier_treant_mobility_knockback:OnDestroy()
    if IsServer() then
        self:StopEffectsRoot()
    end
end

function modifier_treant_mobility_knockback:PlayEffectsRoot()
    local caster = self:GetCaster()
    local particle_cast = "particles/econ/items/dark_willow/dark_willow_chakram_immortal/dark_willow_chakram_immortal_bramble_root.vpcf"
   
	-- Create Particles
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
end

function modifier_treant_mobility_knockback:StopEffectsRoot()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end