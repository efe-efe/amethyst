modifier_sky_ex_second_attack_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_ex_second_attack_buff:IsHidden() return false
end

function modifier_sky_ex_second_attack_buff:IsDebuff() return false
end

function modifier_sky_ex_second_attack_buff:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_sky_ex_second_attack_buff:OnCreated( kv )
	self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sky_ex_second_attack_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sky_ex_second_attack_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

