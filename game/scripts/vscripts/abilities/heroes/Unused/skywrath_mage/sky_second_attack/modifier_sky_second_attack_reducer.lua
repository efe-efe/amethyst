modifier_sky_second_attack_reducer = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_second_attack_reducer:IsHidden() return false
end

function modifier_sky_second_attack_reducer:IsDebuff() return false
end

function modifier_sky_second_attack_reducer:IsPurgable()
	return true
end

function modifier_sky_second_attack_reducer:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--Graphics
function modifier_sky_second_attack_reducer:GetTexture()
	return "sky_second_attack_stack"
end