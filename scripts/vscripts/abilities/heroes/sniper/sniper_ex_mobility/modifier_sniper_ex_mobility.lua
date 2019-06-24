modifier_sniper_ex_mobility = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_ex_mobility:OnCreated( kv )
	self.speed_buff = -100 --self:GetAbility():GetSpecialValueFor("speed_buff")
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
    return self.speed_buff
end


-- Graphics & Animations
function modifier_sniper_ex_mobility:GetEffectName()
	return "particles/generic_gameplay/rune_arcane_owner.vpcf"
end

function modifier_sniper_ex_mobility:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
