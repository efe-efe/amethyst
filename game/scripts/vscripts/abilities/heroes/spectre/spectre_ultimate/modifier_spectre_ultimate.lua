modifier_spectre_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ultimate:IsHidden()
	return false
end

function modifier_spectre_ultimate:IsDebuff()
	return true
end

function modifier_spectre_ultimate:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_ultimate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE,
	}

	return funcs
end

function modifier_spectre_ultimate:GetBonusVisionPercentage()
    return -85
end

--------------------------------------------------------------------------------
function modifier_spectre_ultimate:CheckState()
	local state = {
	    [MODIFIER_STATE_PROVIDES_VISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics and animations
function modifier_spectre_ultimate:GetEffectName()
	return "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_overhead_vision_model.vpcf"
end

function modifier_spectre_ultimate:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end




