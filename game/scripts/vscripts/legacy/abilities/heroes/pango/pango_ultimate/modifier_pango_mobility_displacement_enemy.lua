modifier_pango_mobility_displacement_enemy = class({})

function modifier_pango_mobility_displacement_enemy:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_pango_mobility_displacement_enemy:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_pango_mobility_displacement_enemy:GetOverrideAnimationRate() 	return 1.0 end

function modifier_pango_mobility_displacement_enemy:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_pango_mobility_displacement_enemy)
Modifiers.Animation(modifier_pango_mobility_displacement_enemy)