modifier_vengeful_mobility_displacement = class({})

function modifier_vengeful_mobility_displacement:OnCreated(params)
	if IsServer() then
		self.original_scale = self:GetParent():GetModelScale()
		self:GetParent():SetModelScale(self.original_scale/1.5)
		EFX("particles/econ/events/ti10/blink_dagger_start_ti10.vpcf", PATTACH_WORLDORIGIN, self:GetParent(), {
			cp0 = self:GetParent():GetAbsOrigin(),
			release = true,
		})
	end
end

function modifier_vengeful_mobility_displacement:OnDestroy()
	if IsServer() then
		self:GetParent():SetModelScale(self.original_scale)
		EFX("particles/econ/events/ti10/blink_dagger_end_ti10.vpcf", PATTACH_WORLDORIGIN, self:GetParent(), {
			cp0 = self:GetParent():GetAbsOrigin(),
			release = true,
		})
	end
end

function modifier_vengeful_mobility_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_vengeful_mobility_displacement:GetOverrideAnimation() 		return ACT_DOTA_SPAWN end
function modifier_vengeful_mobility_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_vengeful_mobility_displacement:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_vengeful_mobility_displacement)
Modifiers.Animation(modifier_vengeful_mobility_displacement)