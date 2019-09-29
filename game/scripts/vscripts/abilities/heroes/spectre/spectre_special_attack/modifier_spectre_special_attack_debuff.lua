modifier_spectre_special_attack_debuff = class({})


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_debuff:OnCreated( kv )
	self.speed_debuff_pct = -self:GetAbility():GetSpecialValueFor("speed_debuff_pct")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_special_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_spectre_special_attack_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_debuff_pct
end


-- Graphics & Animations
function modifier_spectre_special_attack_debuff:GetEffectName()
	return "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"
end

function modifier_spectre_special_attack_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
