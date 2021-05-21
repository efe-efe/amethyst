modifier_generic_knockback = class({})

function modifier_generic_knockback:IsHidden()
	return true
end

function modifier_generic_knockback:OnCreated(params)
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_generic_phased', { duration = 1.0 })
	end
end

function modifier_generic_knockback:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_generic_knockback:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_generic_knockback:GetOverrideAnimationRate() 	return 1.0 end

function modifier_generic_knockback:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_generic_knockback:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_knockback:GetFindClearSpace()
	return false
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_generic_knockback)
Modifiers.Animation(modifier_generic_knockback)