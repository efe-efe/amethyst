modifier_invoker_blast_custom_displacement = class({})

function modifier_invoker_blast_custom_displacement:OnCreated(params)
    if IsServer() then
        self.efx = EFX("particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_knockback_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {})
    end
end

function modifier_invoker_blast_custom_displacement:OnDestroy()
    if IsServer() then
        local fading_slow_duration = 0.5
        local fading_slow_pct = 100

        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow", { 
            duration = fading_slow_duration,
            max_slow_pct = fading_slow_pct 
        })

        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
end

function modifier_invoker_blast_custom_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_invoker_blast_custom_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_invoker_blast_custom_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_invoker_blast_custom_displacement:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_invoker_blast_custom_displacement)
Modifiers.Animation(modifier_invoker_blast_custom_displacement)