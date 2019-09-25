modifier_spectre_special_attack_buff = class({})

--------------------------------------------------------------------------------
function modifier_spectre_special_attack_buff:IsDebuff()
	return false
end

function modifier_spectre_special_attack_buff:IsHidden()
	return false
end

function modifier_spectre_special_attack_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_buff:OnCreated( kv )
	self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_special_attack_buff:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_special_attack_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_spectre_special_attack_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end
