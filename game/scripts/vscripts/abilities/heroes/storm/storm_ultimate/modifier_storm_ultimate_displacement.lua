modifier_storm_ultimate_displacement = class({})

function modifier_storm_ultimate_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_storm_ultimate_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_storm_ultimate_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_storm_ultimate_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_storm_ultimate_displacement)
Modifiers.Animation(modifier_storm_ultimate_displacement)