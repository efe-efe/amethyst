modifier_sky_ex_second_attack_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_ex_second_attack_debuff:IsHidden()
	return false
end

function modifier_sky_ex_second_attack_debuff:IsDebuff()
	return false
end

function modifier_sky_ex_second_attack_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sky_ex_second_attack_debuff:OnCreated( kv )
	self.speed_buff = -self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sky_ex_second_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sky_ex_second_attack_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

