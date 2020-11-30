modifier_puck_ex_mobility_recast = class({})

function modifier_puck_ex_mobility_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("puck_ex_mobility_recast") 
    end
end

function modifier_puck_ex_mobility_recast:GetRecastCharges()
	return 1
end

function modifier_puck_ex_mobility_recast:GetRecastKey()
	return "2"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_puck_ex_mobility_recast)