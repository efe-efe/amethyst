modifier_vengeful_mobility_displacement = class({})

function modifier_vengeful_mobility_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_vengeful_mobility_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_vengeful_mobility_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_vengeful_mobility_displacement:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_vengeful_mobility_displacement)
Modifiers.Animation(modifier_vengeful_mobility_displacement)