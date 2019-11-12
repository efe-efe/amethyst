
modifier_ancient_mobility_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_ancient_mobility_debuff:IsHidden()
	return false
end

function modifier_ancient_mobility_debuff:IsDebuff()
	return false
end

function modifier_ancient_mobility_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_ancient_mobility_debuff:OnCreated( kv )
	self.ms_swing_pct = -self:GetAbility():GetSpecialValueFor("ms_swing_pct")
    
	if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Slow", modifier = self, priority = 2, 
		})
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_ancient_mobility_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_ancient_mobility_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_swing_pct
end


-- Graphics & Animations
function modifier_ancient_mobility_debuff:GetEffectName()
	--return "particles/mod_units/heroes/hero_spectre/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"
end

function modifier_ancient_mobility_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
