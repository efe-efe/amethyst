modifier_spectre_special_attack_debuff_lua = class({})


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_debuff_lua:OnCreated( kv )
	self.speed_buff = -self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_special_attack_debuff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_spectre_special_attack_debuff_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end


-- Graphics & Animations
function modifier_spectre_special_attack_debuff_lua:GetEffectName()
	return "particles/mod_units/heroes/hero_spectre/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"
end

function modifier_spectre_special_attack_debuff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
