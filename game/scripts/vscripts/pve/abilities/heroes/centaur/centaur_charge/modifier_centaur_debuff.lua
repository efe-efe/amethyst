modifier_centaur_debuff = class({})

function modifier_centaur_debuff:OnCreated(params)
	if IsServer() then
		local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
		self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		self.max_slow_pct = params.max_slow_pct
	end
end

function modifier_centaur_debuff:OnDestroy()
	if IsServer() then
		ParticleManager:DestroyParticle(self.effect_cast, true)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
end

function modifier_centaur_debuff:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_centaur_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_centaur_debuff:GetMaxSlowPercentage()
	return self:GetAbility():GetSpecialValueFor("fading_slow_pct")
end

function modifier_centaur_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_centaur_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_centaur_debuff:GetMaxSlowPercentage()
	if IsServer() then
		return self.max_slow_pct
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.FadingSlow(modifier_centaur_debuff)