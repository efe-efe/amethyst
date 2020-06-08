modifier_phantom_mobility = class({})

--------------------------------------------------------------------------------
function modifier_phantom_mobility:IsDebuff() return false
end

function modifier_phantom_mobility:IsHidden() return false
end

function modifier_phantom_mobility:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_mobility:OnCreated(kv)
	self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_mobility:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_mobility:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end
