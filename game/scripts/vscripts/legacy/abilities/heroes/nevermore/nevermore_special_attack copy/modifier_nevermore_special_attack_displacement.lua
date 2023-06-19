modifier_nevermore_special_attack_displacement = class({})

function modifier_nevermore_special_attack_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_nevermore_special_attack_displacement:GetOverrideAnimation() 		        return ACT_DOTA_FLAIL end

function modifier_nevermore_special_attack_displacement:CheckState()
	return {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_nevermore_special_attack_displacement)
Modifiers.Animation(modifier_nevermore_special_attack_displacement)