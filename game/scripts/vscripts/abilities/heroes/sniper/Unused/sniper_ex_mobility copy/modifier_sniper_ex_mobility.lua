modifier_sniper_ex_mobility = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_ex_mobility:OnCreated(kv)
	self.speed_debuff_pct = -self:GetAbility():GetSpecialValueFor("speed_debuff_pct")

	if IsServer() then 
		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Generic",
			text = "slow",
			progressBarType = "duration",
			priority = 3,
		})
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_ex_mobility:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sniper_ex_mobility:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_debuff_pct
end


-- Graphics & Animations
function modifier_sniper_ex_mobility:GetEffectName()
	return "particles/generic_gameplay/rune_arcane_owner.vpcf"
end

function modifier_sniper_ex_mobility:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
