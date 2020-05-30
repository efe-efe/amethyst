modifier_spectre_counter = class({})

function modifier_spectre_counter:OnCreated(params)
	if IsServer() then
		local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
		self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
end

function modifier_spectre_counter:OnDestroy()
	if IsServer() then
		ParticleManager:DestroyParticle(self.effect_cast, true)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
end

function modifier_spectre_counter:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_spectre_counter:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_spectre_counter:GetMaxSlowPercentage()
	return self:GetAbility():GetSpecialValueFor("fading_slow_pct")
end

function modifier_spectre_counter:GetStatusEffectName()
    return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_spectre_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.FadingSlow(modifier_spectre_counter)