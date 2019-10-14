modifier_phantom_counter = class({})

function modifier_phantom_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_counter:GetStatusEffectName()
	return "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end
