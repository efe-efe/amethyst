modifier_sniper_basic_attack_charges = class({})

function modifier_sniper_basic_attack_charges:GetMaxCharges()
	return self:GetAbility():GetSpecialValueFor("max_charges")
end

function modifier_sniper_basic_attack_charges:GetReplenishType() return CHARGES_TYPE_SYNC end
function modifier_sniper_basic_attack_charges:GetReplenishTime()
	if IsServer() then
		return (1/self:GetParent():GetAttacksPerSecond())
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges(modifier_sniper_basic_attack_charges)
