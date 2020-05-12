modifier_item_energy_custom = class({})

function modifier_item_energy_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_MANA_BONUS,
	}

	return funcs
end

function modifier_item_energy_custom:GetModifierExtraManaBonus()
	return self:GetAbility():GetSpecialValueFor("extra_mana")
end


function modifier_item_energy_custom:GetEffectName()
	return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf"
end

function modifier_item_energy_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
