modifier_phantom_mobility_charges = class({})

function modifier_phantom_mobility_charges:GetMaxCharges()
	return self:GetAbility():GetSpecialValueFor("max_charges")
end

function modifier_phantom_mobility_charges:GetReplenishType() return CHARGES_TYPE_ASYNC end
function modifier_phantom_mobility_charges:GetReplenishTime()
	if IsServer() then
		self:GetAbility():GetCooldown(self:GetAbility():GetLevel())
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges(modifier_phantom_mobility_charges)
