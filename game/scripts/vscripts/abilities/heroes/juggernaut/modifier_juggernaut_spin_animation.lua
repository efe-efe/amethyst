modifier_juggernaut_spin_animation = class({})

function modifier_juggernaut_spin_animation:IsHidden()   return true end

function modifier_juggernaut_spin_animation:OnCreated( params )
    if IsServer() then
        EmitSoundOn("Hero_Juggernaut.BladeFuryStart", self:GetParent())
	
		local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"
		self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(self.effect_cast, 5, Vector( 200, 1, 1 ))
		ParticleManager:SetParticleControl(self.effect_cast, 2, self:GetParent():GetOrigin())
    end
end
	
function modifier_juggernaut_spin_animation:OnDestroy( kv )
    if IsServer() then
		StopSoundOn("Hero_Juggernaut.BladeFuryStart", self:GetParent())
        EmitSoundOn("Hero_Juggernaut.BladeFuryStop", self:GetParent())
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

function modifier_juggernaut_spin_animation:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_juggernaut_spin_animation:GetOverrideAnimation() 		return ACT_DOTA_OVERRIDE_ABILITY_1 end
function modifier_juggernaut_spin_animation:GetOverrideAnimationRate() 	return 1.5 end
