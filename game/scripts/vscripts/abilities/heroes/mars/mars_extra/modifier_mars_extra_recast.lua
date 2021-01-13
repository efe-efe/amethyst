modifier_mars_extra_recast = class({})

function modifier_mars_extra_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("mars_extra_recast") 
    end
end

function modifier_mars_extra_recast:GetRecastCharges()
	return 1
end

function modifier_mars_extra_recast:GetRecastKey()
    if self:GetRecastAbility():GetAbilityIndex() == 6 then
		return "R"
	end
	return "F"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_mars_extra_recast)