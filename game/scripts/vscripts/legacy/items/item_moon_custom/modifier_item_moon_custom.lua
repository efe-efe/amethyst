modifier_item_moon_custom = class({})

function modifier_item_moon_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_item_moon_custom:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("aspd")
end


function modifier_item_moon_custom:GetEffectName()
	return "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf"
end

function modifier_item_moon_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_moon_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_troll_warlord_battletrance.vpcf"
end


