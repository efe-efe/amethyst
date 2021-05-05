modifier_centaur_charge_knockback_displacement = class({})

function modifier_centaur_charge_knockback_displacement:OnCreated(params)
	if IsServer() then
		self.origin = self:GetParent():GetAbsOrigin()
	end
end

function modifier_centaur_charge_knockback_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_centaur_charge_knockback_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_centaur_charge_knockback_displacement:GetOverrideAnimationRate() 	return 1.0 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_centaur_charge_knockback_displacement)
Modifiers.Animation(modifier_centaur_charge_knockback_displacement)