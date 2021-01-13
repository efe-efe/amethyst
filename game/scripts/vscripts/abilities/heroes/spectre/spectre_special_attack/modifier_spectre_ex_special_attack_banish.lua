modifier_spectre_ex_special_attack_banish = class({})

function modifier_spectre_ex_special_attack_banish:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

function modifier_spectre_ex_special_attack_banish:OnCreated(params)
    if IsServer() then
        self.fading_slow_duration = self:GetAbility():GetSpecialValueFor('fading_slow_duration')
        self.fading_slow_pct = self:GetAbility():GetSpecialValueFor('fading_slow_pct')
    end
end

function modifier_spectre_ex_special_attack_banish:OnDestroy()
    if IsServer() then
        local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_death.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(efx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(efx, 3, self:GetParent():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(efx)

        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow", { 
            duration = self.fading_slow_duration,
            max_slow_pct = self.fading_slow_pct 
        })
    end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_spectre_ex_special_attack_banish)