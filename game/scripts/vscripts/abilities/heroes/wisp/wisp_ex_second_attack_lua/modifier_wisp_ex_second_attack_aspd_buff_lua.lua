modifier_wisp_ex_second_attack_aspd_buff_lua = class({})

--------------------------------------------------------------------------------
function modifier_wisp_ex_second_attack_aspd_buff_lua:IsDebuff()
	return false
end

function modifier_wisp_ex_second_attack_aspd_buff_lua:IsHidden()
	return false
end

function modifier_wisp_ex_second_attack_aspd_buff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_second_attack_aspd_buff_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_ex_second_attack_aspd_buff_lua:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_ex_second_attack_aspd_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

