modifier_weaver_basic_attack_charges = class({})

function modifier_weaver_basic_attack_charges:GetReplenishType()
	if IsServer() then
		return CHARGES_TYPE_SYNC
	end
end

function modifier_weaver_basic_attack_charges:GetReplenishTime()
	if IsServer() then
		return (1/self:GetParent():GetAttacksPerSecond())
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges( 
	modifier_weaver_basic_attack_charges,
	{ show_icon = 1 }
)