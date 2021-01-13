modifier_damage_fx = class({})

function modifier_damage_fx:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_damage_fx:GetStatusEffectName()
	return "particles/damage_received_test.vpcf"
end