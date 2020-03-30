modifier_item_nullifier_custom_slow = class({})

function modifier_item_nullifier_custom_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_item_nullifier_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return -self:GetAbility():GetSpecialValueFor("slow_pct")
end

function modifier_item_nullifier_custom_slow:GetEffectName()
	return "particles/items4_fx/nullifier_slow.vpcf"
end

function modifier_item_nullifier_custom_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

