modifier_tinker_ex_second_attack_buff_lua = class({})

--------------------------------------------------------------------------------
function modifier_tinker_ex_second_attack_buff_lua:IsDebuff()
	return false
end

function modifier_tinker_ex_second_attack_buff_lua:IsHidden()
	return false
end

function modifier_tinker_ex_second_attack_buff_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_ex_second_attack_buff_lua:OnCreated( kv )
	self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tinker_ex_second_attack_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_tinker_ex_second_attack_buff_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

-- Graphics & Animations
function modifier_tinker_ex_second_attack_buff_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_repel.vpcf"
end
