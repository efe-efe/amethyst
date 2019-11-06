
modifier_sniper_shrapnel_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_shrapnel_debuff:IsHidden()
	return false
end

function modifier_sniper_shrapnel_debuff:IsDebuff()
	return true
end

function modifier_sniper_shrapnel_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_shrapnel_debuff:OnCreated( kv )
	self.slow_pct = -self:GetAbility():GetSpecialValueFor("slow_pct")

	if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Slow", modifier = self, priority = 2, 
		})
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_shrapnel_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sniper_shrapnel_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.slow_pct
end


-- Graphics & Animations
function modifier_sniper_shrapnel_debuff:GetEffectName()
	--return "particles/mod_units/heroes/hero_spectre/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"
end

function modifier_sniper_shrapnel_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
