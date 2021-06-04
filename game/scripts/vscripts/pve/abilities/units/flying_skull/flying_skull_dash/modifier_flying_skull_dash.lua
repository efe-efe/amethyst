modifier_flying_skull_dash = class({})

function modifier_flying_skull_dash:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_flying_skull_dash:OnCreated(params)
	if IsServer() then
		local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
		self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
end

function modifier_flying_skull_dash:OnDestroy()
	if IsServer() then
		ParticleManager:DestroyParticle(self.effect_cast, true)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
end

function modifier_flying_skull_dash:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_flying_skull_dash:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_flying_skull_dash:GetMaxSlowPercentage()
	return self:GetAbility():GetSpecialValueFor("fading_slow_pct")
end

function modifier_flying_skull_dash:GetStatusEffectName()
    return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_flying_skull_dash:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end