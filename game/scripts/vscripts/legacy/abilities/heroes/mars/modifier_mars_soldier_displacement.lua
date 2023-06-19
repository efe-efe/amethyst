modifier_mars_soldier_displacement = class({})

function modifier_mars_soldier_displacement:OnCreated(params)
	if IsServer() then
	end
end

function modifier_mars_soldier_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_mars_soldier_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_mars_soldier_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_mars_soldier_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_mars_soldier_displacement)
Modifiers.Animation(modifier_mars_soldier_displacement)