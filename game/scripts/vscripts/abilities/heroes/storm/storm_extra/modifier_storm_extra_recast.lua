modifier_storm_extra_recast = class({})

function modifier_storm_extra_recast:IsHidden() return true end

function modifier_storm_extra_recast:OnDestroy()
	if IsServer() then
		if self:GetRemainingTime() < 0.05 then
			self:GetParent():RemoveModifierByName('modifier_storm_extra_recast_used')
		end
	end
end

function modifier_storm_extra_recast:GetRecastAbility()
	if IsServer() then
		return self:GetParent():FindAbilityByName("storm_extra")
	end
end

function modifier_storm_extra_recast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_storm_extra_recast:GetRecastCharges()
	return 1
end

function modifier_storm_extra_recast:GetRecastKey()
	if self:GetRecastAbility():GetAbilityIndex() == 6 then
		return "R"
	end
	return "F"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_storm_extra_recast)