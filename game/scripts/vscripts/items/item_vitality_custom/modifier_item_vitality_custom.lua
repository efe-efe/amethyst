modifier_item_vitality_custom = class({})

function modifier_item_vitality_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
	}

	return funcs
end

function modifier_item_vitality_custom:GetModifierExtraHealthBonus()
	return self:GetAbility():GetSpecialValueFor("extra_health")
end


function modifier_item_vitality_custom:GetEffectName()
	return "particles/vitality_effect/omniknight_repel_buff_ti8_glyph.vpcf"
end

function modifier_item_vitality_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
