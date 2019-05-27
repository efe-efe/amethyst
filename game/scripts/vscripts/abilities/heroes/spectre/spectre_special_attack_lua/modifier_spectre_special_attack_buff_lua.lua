modifier_spectre_special_attack_buff_lua = class({})

--------------------------------------------------------------------------------
function modifier_spectre_special_attack_buff_lua:IsDebuff()
	return false
end

function modifier_spectre_special_attack_buff_lua:IsHidden()
	return false
end

function modifier_spectre_special_attack_buff_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_buff_lua:OnCreated( kv )
    if IsServer() then
        self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
    end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_special_attack_buff_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_special_attack_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_spectre_special_attack_buff_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end
