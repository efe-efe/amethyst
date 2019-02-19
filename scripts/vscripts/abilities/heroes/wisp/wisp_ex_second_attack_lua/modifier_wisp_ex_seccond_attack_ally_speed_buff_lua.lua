modifier_wisp_ex_seccond_attack_ally_speed_buff_lua = class ({})


--------------------------------------------------------------------------------
function modifier_wisp_ex_seccond_attack_ally_speed_buff_lua:IsDebuff()
	return false
end

function modifier_wisp_ex_seccond_attack_ally_speed_buff_lua:IsHidden()
	return false
end

function modifier_wisp_ex_seccond_attack_ally_speed_buff_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_seccond_attack_ally_speed_buff_lua:OnCreated( kv )
    if IsServer() then
        self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
    end
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_ex_seccond_attack_ally_speed_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_wisp_ex_seccond_attack_ally_speed_buff_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end
