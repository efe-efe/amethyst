modifier_pango_roll_end_animation = class({})

function modifier_pango_roll_end_animation:IsHidden()   return true end

function modifier_pango_roll_end_animation:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_pango_roll_end_animation:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_4_END end
function modifier_pango_roll_end_animation:GetOverrideAnimationRate() 	return 1.5 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Animation(modifier_pango_roll_end_animation)
