modifier_skywrath_mage_ex_second_attack_debuff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_skywrath_mage_ex_second_attack_debuff_lua:IsHidden()
	return false
end

function modifier_skywrath_mage_ex_second_attack_debuff_lua:IsDebuff()
	return false
end

function modifier_skywrath_mage_ex_second_attack_debuff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_ex_second_attack_debuff_lua:OnCreated( kv )
	if IsServer() then
        ----modifier variables
        self.speed_buff = -self:GetAbility():GetSpecialValueFor("speed_buff")
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_skywrath_mage_ex_second_attack_debuff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_skywrath_mage_ex_second_attack_debuff_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end
