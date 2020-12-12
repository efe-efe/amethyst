modifier_juggernaut_extra_recast = class({})

function modifier_juggernaut_extra_recast:IsHidden() return true end

function modifier_juggernaut_extra_recast:GetRecastAbility()
	if IsServer() then
		return self:GetParent():FindAbilityByName("juggernaut_extra_recast") 
	end
end

function modifier_juggernaut_extra_recast:GetRecastKey()
	if self:GetRecastAbility():GetAbilityIndex() == 6 then
		return "R"
	end
	return "F"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_juggernaut_extra_recast)