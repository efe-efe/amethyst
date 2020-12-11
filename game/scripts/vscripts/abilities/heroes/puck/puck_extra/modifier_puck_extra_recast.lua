modifier_puck_extra_recast = class({})

function modifier_puck_extra_recast:IsHidden() return true end

function modifier_puck_extra_recast:OnDestroy()
	if IsServer() then
		if self:GetRemainingTime() < 0.05 then
			self:GetParent():RemoveModifierByName("modifier_puck_extra_recast_used")
		end
	end
end

function modifier_puck_extra_recast:GetRecastAbility()
	if IsServer() then
		return self:GetParent():FindAbilityByName("puck_extra")
	end
end	

function modifier_puck_extra_recast:GetRecastCharges()
	return 1
end

function modifier_puck_extra_recast:GetRecastKey()
	return "F"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_puck_extra_recast)