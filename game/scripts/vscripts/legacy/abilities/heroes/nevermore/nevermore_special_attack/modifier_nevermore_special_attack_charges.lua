modifier_nevermore_special_attack_charges = class({})

function modifier_nevermore_special_attack_charges:GetMaxCharges()
	return self:GetAbility():GetSpecialValueFor("max_charges")
end

function modifier_nevermore_special_attack_charges:GetReplenishType() return CHARGES_TYPE_ASYNC end
function modifier_nevermore_special_attack_charges:GetReplenishTime()
	if IsServer() then
		self:GetAbility():GetCooldown(self:GetAbility():GetLevel())
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges(modifier_nevermore_special_attack_charges)