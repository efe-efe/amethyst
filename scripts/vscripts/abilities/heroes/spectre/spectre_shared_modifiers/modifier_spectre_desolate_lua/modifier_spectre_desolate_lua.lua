modifier_spectre_desolate_lua = class({})

--------------------------------------------------------------------------------
function modifier_spectre_desolate_lua:IsDebuff()
	return true
end

function modifier_spectre_desolate_lua:IsHidden()
	return false
end

function modifier_spectre_desolate_lua:IsPurgable()
	return true
end

-- Graphics & Animations
function modifier_spectre_desolate_lua:GetEffectName()
	return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
end

function modifier_spectre_desolate_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end