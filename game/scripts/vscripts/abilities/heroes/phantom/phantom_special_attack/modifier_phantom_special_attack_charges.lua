modifier_phantom_special_attack_charges = class({})

function modifier_phantom_special_attack_charges:GetMaxCharges()
	if self:GetCaster():HasModifier("modifier_upgrade_phantom_fast_daggers") then 
		return 1
	else 
		return self:GetAbility():GetSpecialValueFor("max_charges")
	end
end

function modifier_phantom_special_attack_charges:GetReplenishType() return CHARGES_TYPE_ASYNC end
function modifier_phantom_special_attack_charges:GetReplenishTime()
	if IsServer() then
		self:GetAbility():GetCooldown(self:GetAbility():GetLevel())
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges(modifier_phantom_special_attack_charges)